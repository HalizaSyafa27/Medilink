//
//  RatingFileListViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 27/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class RatingFileListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewPageHeader: UIImageView!
    @IBOutlet weak var lblTitlePage: UILabel!
    @IBOutlet weak var lblProviderName: UILabel!
    @IBOutlet weak var tbvRatingFileList: UITableView!
    
    var className:String = ""
    var pageHeaderImage:String = ""
    var pageHeader:String = ""
    var providerType:String = ""
    var ratingFileList = [PanelProvidersBo]()
    var product = PanelProvidersBo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.imgViewPageHeader.image = UIImage.init(named: pageHeaderImage)
        self.lblPageHeader.text = pageHeader
        self.lblTitlePage.text = product.providerTypeDesc
        self.lblProviderName.text = product.providerName
        if ratingFileList.count < 1{
            postViewRatingDocbyProviderService()
        }else{
            self.tbvRatingFileList.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingFileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvRatingFileList.dequeueReusableCell(withIdentifier: "RatingFileListTableViewCell", for: indexPath) as! RatingFileListTableViewCell
        let data = self.ratingFileList[indexPath.row]
        let imgStr = data.fileData 
        if self.isNotNullOrNil(imgStr){
            if let data = Data(base64Encoded: imgStr) {
                let image = UIImage(data: data)
                if image != nil{
                    cell.imgView.image = image
                }
            }
        }
        return cell
    }
    
    //Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func postViewRatingDocbyProviderService(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params = [
                "pstProviderCode": product.providerCode.trimmingCharacters(in: .whitespacesAndNewlines),
                "pstRatingID": product.ratingID
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.postViewRatingDocbyProvider, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postViewRatingDocbyProviderService()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.ratingFileList.removeAll()
                                    var arrPanelProviders = [PanelProvidersBo]()
                                    if let dict_array = dict?["ViewRatingPostedFiles"] as? [[String: Any]] {
//                                        print(dict_array)
                                        if dict_array.count > 0{
                                            for item in dict_array {
                                                let panelProviders = PanelProvidersBo()
                                                if let ratingID = item["RatingID"] as? String {
                                                    panelProviders.ratingID = ratingID
                                                }
                                                if let fileName = item["FileName"] as? String {
                                                    panelProviders.fileName = fileName
                                                }
                                                if let fileData = item["FileData"] as? String {
                                                    panelProviders.fileData = fileData
                                                }
                                                arrPanelProviders.append(panelProviders)
                                            }
                                        }
                                    }
                                    self.ratingFileList = arrPanelProviders
                                    self.tbvRatingFileList.reloadData()
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName:AppConstant.postViewRatingDocbyProvider)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postViewRatingDocbyProvider)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

}
