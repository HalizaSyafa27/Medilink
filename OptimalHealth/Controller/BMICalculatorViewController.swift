//
//  BMICalculatorViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 13/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class BMICalculatorViewController: BaseViewController {
    
    @IBOutlet weak var lblTitlePage: UILabel!
    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTopBar: NSLayoutConstraint!
    @IBOutlet weak var imgCalculate: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var btnCalculate: UIButton!
    @IBOutlet weak var lblUnder: UILabel!
    @IBOutlet weak var lblUnderTitle: UILabel!
    @IBOutlet weak var lblNormal: UILabel!
    @IBOutlet weak var lblNormalTitle: UILabel!
    @IBOutlet weak var lblOverweight: UILabel!
    @IBOutlet weak var lblOverweightTitle: UILabel!
    @IBOutlet weak var lblObese: UILabel!
    @IBOutlet weak var lblObeseTitle: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var lblBMICategory: UILabel!
    @IBOutlet weak var lblHealthyWeight: UILabel!
    
    var cardNo:String = ""
    var className:String = ""
    var subMenuItem = MainMenuBo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitlePage.text = subMenuItem.FDESC
        lblTitle.text = subMenuItem.FDESC
        self.btnCalculate.layer.cornerRadius = self.btnCalculate.frame.size.height/2
        self.infoView.layer.cornerRadius = 6
        self.infoView.layer.masksToBounds = true
        self.infoView.layer.borderColor = UIColor.lightGray.cgColor
        self.infoView.layer.borderWidth = 1.0
        self.getBMIIndexService()
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
            heightConstraintTopBar.constant = AppConstant.navBarHeight
        }
    }
    
    @IBAction func calculateAction(_ sender: UIButton) {
        if txtHeight.text == ""{
            self.displayAlert(message: "Height is required.")
        }else if txtWeight.text == ""{
            self.displayAlert(message: "Weight is required.")
        }else{
            postCalculateBmiIndexService()
        }
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Call Services
    func postCalculateBmiIndexService(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let height = txtHeight.text!.replacingOccurrences(of: ",", with: ".")
            let weight = txtWeight.text!.replacingOccurrences(of: ",", with: ".")
            let memId : String = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            let params: Parameters = [
                "pstMemId":  memId,
                "pstHeight":  height,
                "pstWeight":  weight,
            ]
            print("params===\(params)")
            print("url===\(AppConstant.postCalculateBmiIndexUrl)")
            AFManager.request( AppConstant.postCalculateBmiIndexUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postCalculateBmiIndexService()
                                }
                            })
                        }else{
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let BMIIndexData = dict!["BMIIndexData"] as? [String:Any]{
                                        if let imageFullPath = BMIIndexData["ImageFullPath"] as? String{
                                            self.imgCalculate.downloaded(from:imageFullPath)
                                        }
                                        if let BMIValue = BMIIndexData["BMIValue"] as? Double{
                                            self.lblNumber.text = "\(BMIValue)"
                                        }
                                        if let BMICategory = BMIIndexData["BMICategory"] as? String{
                                            self.lblBMICategory.text = BMICategory
                                        }
                                        if let HealthyWeight = BMIIndexData["HealthyWeight"] as? String{
                                            self.lblHealthyWeight.text = HealthyWeight
                                        }
                                    }
                                }else{
                                    if let message = dict!["Message"] as? String{
                                        self.displayAlert(message: message )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postCalculateBmiIndexUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postCalculateBmiIndexUrl)
                        break
                    }
                }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func getBMIIndexService(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            print("url===\(AppConstant.getBMIIndexUrl)")
            AFManager.request( AppConstant.getBMIIndexUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    debugPrint("Health tips response===\(response)")
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode != 200){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.getBMIIndexService()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let modelList = dict!["BMIDefaultIndexData"] as? [[String:Any]]{
                                        self.lblUnderTitle.text = ""
                                        self.lblUnder.text = ""
                                        self.lblNormalTitle.text = ""
                                        self.lblNormal.text = ""
                                        self.lblOverweightTitle.text = ""
                                        self.lblOverweight.text = ""
                                        self.lblObeseTitle.text = ""
                                        self.lblObese.text = ""
                                        if modelList.count > 0 {
                                            if let imageFullPath = modelList[0]["ImageFullPath"] as? String {
                                                if let url = URL(string: imageFullPath) {
                                                    self.imgCalculate.downloaded(from: url)
                                                }
                                            }
                                            if let BMICategory = modelList[0]["BMICategory"] as? String {
                                                self.lblUnderTitle.text = BMICategory
                                            }
                                            if let BMIRange = modelList[0]["BMIRange"]  as? String{
                                                self.lblUnder.text = ":  " + BMIRange
                                            }
                                            
                                            if modelList.count > 1{
                                                if let BMICategory = modelList[1]["BMICategory"]  as? String{
                                                    self.lblNormalTitle.text = BMICategory
                                                }
                                                if let BMIRange = modelList[1]["BMIRange"]  as? String{
                                                    self.lblNormal.text = ":  " + BMIRange
                                                }
                                            }
                                            if modelList.count > 2{
                                                if let BMICategory = modelList[2]["BMICategory"]  as? String{
                                                    self.lblOverweightTitle.text = BMICategory
                                                }
                                                if let BMIRange = modelList[2]["BMIRange"]  as? String{
                                                    self.lblOverweight.text = ":  " + BMIRange
                                                }
                                            }
                                            if modelList.count > 3{
                                                if let BMICategory = modelList[3]["BMICategory"]  as? String{
                                                    self.lblObeseTitle.text = BMICategory
                                                }
                                                if let BMIRange = modelList[3]["BMIRange"]  as? String{
                                                    self.lblObese.text = ":  " + BMIRange
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    if let msg = dict!["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                        
                    }
                }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
}
