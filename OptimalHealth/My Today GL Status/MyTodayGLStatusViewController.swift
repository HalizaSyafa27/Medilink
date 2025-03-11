//
//  MyTodayGLStatusViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/25/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class MyTodayGLStatusViewController: BaseViewController {
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var noStatusLbl: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblpageHeader: UILabel!
    @IBOutlet var lblPageTitle: UILabel!
    
    var strCardNo = ""
    var strHeaderImageName = ""
    var pageHeader = ""
    var pageTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        noStatusLbl.isHidden = true
        //statusLbl.isHidden = true
        serviceCallToGetMyTodayGLStatus()
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        lblpageHeader.text = pageHeader
        lblPageTitle.text = pageTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Service Call
    func serviceCallToGetMyTodayGLStatus() {

        if(AppConstant.hasConnectivity()) {//true connected

            AppConstant.showHUD()
            let pstPlancode : String = AppConstant.retrievFromDefaults(key: StringConstant.planCode)

            let params: Parameters = [
                "pstCardNo": strCardNo,
                "pstPlancode": pstPlancode
            ]
            print("params===\(params)")
            print("URL===\(AppConstant.getMyTodayGLStatusUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.getMyTodayGLStatusUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)

                    switch(response.result) {
                    case .success(_):
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetMyTodayGLStatus()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.noStatusLbl.isHidden = true
                                    self.statusLbl.isHidden = false
                                    let dict_array = dict?["ViewGLList"] as? [[String: Any]]
                                    print(dict_array!)
                                    let dict_array_index = dict_array![0]
                                    print(dict_array_index)
                                    if let imageStatus = dict_array_index["GLIMAGESTATUS"] as? String {
                                        if (imageStatus == "RECEIVED-IMAGE") {
                                            self.statusImage.image = UIImage(named: "received")
                                        }else if (imageStatus == "APPROVED-IMAGE") {
                                            self.statusImage.image = UIImage(named: "approved")
                                        }else if (imageStatus == "DECLINED-IMAGE") {
                                            self.statusImage.image = UIImage(named: "declined")
                                        }else if (imageStatus == "PENDING-IMAGE") {
                                            self.statusImage.image = UIImage(named: "pending")
                                        }
                                    }
                                    if let glStatus = dict_array_index["GLSTATUS"] as? String {
                                        self.statusLbl?.text = glStatus
                                    }
                                    
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.noStatusLbl.isHidden = false
                                        self.statusLbl.isHidden = true
                                        self.noStatusLbl?.text = msg
                                        self.displayAlert(message: msg)
                                    }else{
                                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMyTodayGLStatusUrl)
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMyTodayGLStatusUrl)
                            }
                        }

                        break

                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMyTodayGLStatusUrl)
                        break

                    }
            }

        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

}
