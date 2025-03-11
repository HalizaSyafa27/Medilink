//
//  SendOTPViewController.swift
//  OptimalHealth
//
//  Created by cuscsoftware on 10/6/21.
//  Copyright © 2021 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class SendOTPViewController: BaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var viewPhoneNumber: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backAction(_:)))
        self.backView.addGestureRecognizer(tap)
        self.backView.isUserInteractionEnabled = true
        btnSendOTP.layer.cornerRadius = btnSendOTP.frame.size.height/2
        btnSendOTP.clipsToBounds = true
        txtPhoneNumber.tintColor = AppConstant.themeRedColor
        self.btnSendOTP.layer.borderWidth = AppConstant.borderButton
        self.btnSendOTP.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.viewPhoneNumber.layer.borderWidth = 1.5
        self.viewPhoneNumber.layer.cornerRadius = 25
        self.viewPhoneNumber.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.viewPhoneNumber.clipsToBounds = true
        setplaceHolderColor(txtFld: txtPhoneNumber, placeholder: "Please enter your mobile number")
    }
    
    override func setplaceHolderColor(txtFld: UITextField, placeholder: String){
        
        txtFld.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor: AppConstant.themeRedColor])
    }
    
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9]{10,12}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    @IBAction func sendOTPAction(_ sender: UIButton) {
        if txtPhoneNumber.text == ""{
            self.displayAlert(message: "Mobile Number is required.")
        }else if(!isValidPhone(phone: txtPhoneNumber.text!)){
            self.displayAlert(message: "Invalid mobile number.")
        }else{
          self.serviceCallToGetOTP()
        }
    }
    
    @objc func backAction(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToConfirmOTP(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmOTP") as! ConfirmOTPViewController
        vc.strNumber = self.txtPhoneNumber.text?.trim() ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func serviceCallToGetOTP(){
        if(AppConstant.hasConnectivity()) {//true connected
//            let headers: HTTPHeaders = [
//                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
//                "Accept": "application/json"
//            ]
            let appToken = AppConstant.retrievFromDefaults(key: StringConstant.appToken)
            let appTokenType = AppConstant.retrievFromDefaults(key: StringConstant.appTokenType)
            
            let headers: HTTPHeaders = [
                "Authorization": appTokenType + " " + appToken,
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AppConstant.showHUD()
            var params: Parameters!
            var url : String = ""
            params = [
                "pstUsrid": txtPhoneNumber.text?.trim() ?? ""
            ]
            url = AppConstant.postMemberVerifyForgotPasswordUrl
            print("Url===\(url)")
            print("params===\(String(describing: params))")
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = response.result.value! as! [String: Any]
                        if let status = dict["Status"] as? String {
                            if(status == "OK"){//Success
                                self.goToConfirmOTP()
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: url + ".")
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

}
