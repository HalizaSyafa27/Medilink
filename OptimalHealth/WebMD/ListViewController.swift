//
//  ListViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 27/07/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tblViewMagazine: UITableView!
    @IBOutlet var lblNoDataAvailable: UILabel!
    
    var arrMagazine = [MagazineBo]()
    var pageHeader = ""
    var strHeaderImageName = ""
    var className = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
        serviceCallToGetHealthList()
    }
    
    func initDesign(){
        lblPageHeader.text = pageHeader
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
    }
    
    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.arrMagazine.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuTableViewCell", for: indexPath as IndexPath) as! SubMenuTableViewCell
           
           let mainMenu = self.arrMagazine[indexPath.row]
           
           //cell.imgViewMenu.image = UIImage(named: "")
           cell.lblMenuTitle.text = mainMenu.desc
           
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pdfVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewGLLettersViewController") as! ViewGLLettersViewController
        pdfVC.className =  self.className
        pdfVC.strHeaderImageName =  self.strHeaderImageName
        pdfVC.strHeader =  self.pageHeader
        pdfVC.urlToOpen =  self.arrMagazine[indexPath.row].filename
        pdfVC.pageTitle = self.arrMagazine[indexPath.row].desc
        self.navigationController?.pushViewController(pdfVC, animated: true)
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: Service call
    func serviceCallToGetHealthList(){
            if(AppConstant.hasConnectivity()) {
                if(AppConstant.hasConnectivity()) {//true connected
                    AppConstant.showHUD()
                    
                    let headers: HTTPHeaders = [
                        "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                        "Accept": "application/json"
                    ]
                    
                    print("url===\(AppConstant.webmdHealthMagazineUrl)")
                    
                    Alamofire.request( AppConstant.webmdHealthMagazineUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                        .responseString { response in
                            AppConstant.hideHUD()
                            debugPrint(response)
                            
                            switch(response.result) {
                            case .success(_):
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                // debugPrint(dict)
                                
                                let headerStatusCode : Int = (response.response?.statusCode)!
                                print("Status Code: \(headerStatusCode)")
                                
                                if(headerStatusCode == 401){//Session expired
                                    AppConstant.hideHUD()
                                    self.isTokenVerified(completion: { (Bool) in
                                        if Bool{
                                            self.serviceCallToGetHealthList()
                                        }
                                    })
                                }else{
                                    if let status = dict?["Status"] as? String {
                                        if(status == "1"){//Success
                                            self.arrMagazine.removeAll()
                                            
                                            let arrQstn = dict?["DownloadList"] as! [[String: Any]]
                                            if (arrQstn.count > 0){
                                                for dict in arrQstn {
                                                    let qstnBo = MagazineBo()
                                                    if let qstnId = dict["FileName"] as? String{
                                                        qstnBo.filename = qstnId
                                                    }
                                                    if let qstnName = dict["Desc"] as? String{
                                                        qstnBo.desc = qstnName
                                                    }
                                                    
                                                    self.arrMagazine.append(qstnBo)
                                                }
                                                
                                                self.tblViewMagazine.reloadData()
                                                self.lblNoDataAvailable.isHidden = true
                                            }else{
                                                self.lblNoDataAvailable.isHidden = false
                                                self.tblViewMagazine.isHidden = true
                                            }
                                        }else{
                                            self.lblNoDataAvailable.isHidden = false
                                            if let msg = dict?["Message"] as? String{
                                                self.displayAlert(message: msg ?? "")
                                            }
                                        }
                                    }else{
                                        self.lblNoDataAvailable.isHidden = false
                                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.webmdHealthMagazineUrl)
                                    }
                                }
                                
                                break
                                
                            case .failure(_):
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.webmdHealthMagazineUrl)
                                break
                                
                            }
                    }
                    
                }else{
                    self.displayAlert(message: "Please check your internet connection.")
                }
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
