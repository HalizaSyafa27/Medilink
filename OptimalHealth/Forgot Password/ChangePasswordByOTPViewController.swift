//
//  ChangePasswordByOTPViewController.swift
//  OptimalHealth
//
//  Created by cuscsoftware on 10/6/21.
//  Copyright © 2021 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordByOTPViewController: BaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnConfirmPassword: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var strNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backAction(_:)))
        self.backView.addGestureRecognizer(tap)
        self.backView.isUserInteractionEnabled = true
        btnUpdate.layer.cornerRadius = btnUpdate.frame.size.height/2
        btnUpdate.clipsToBounds = true
    }
    
    @objc func backAction(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePasswordAction(_ sender: UIButton) {
        if txtPassword.text == ""{
            self.displayAlert(message: StringConstant.passwordValidation)
        }else if txtConfirmPassword.text == ""{
            self.displayAlert(message: StringConstant.cnfPasswordValidation)
        }else if txtConfirmPassword.text != txtPassword.text{
            self.displayAlert(message: StringConstant.passwordNotMatchValidation)
        }else{
            self.serviceCallToSubmitOTP()
        }
    }
    
    @IBAction func passwordAction(_ sender: UIButton) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        if !txtPassword.isSecureTextEntry {
            btnPassword.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnPassword.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    @IBAction func confirmPasswordAction(_ sender: UIButton) {
        txtConfirmPassword.isSecureTextEntry = !txtConfirmPassword.isSecureTextEntry
        if !txtConfirmPassword.isSecureTextEntry {
            btnConfirmPassword.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnConfirmPassword.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    func goToLogin(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInController") as! LogInController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func serviceCallToSubmitOTP(){
        if(AppConstant.hasConnectivity()) {//true connected
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AppConstant.showHUD()
            var params: Parameters!
            var url : String = ""
            params = [
                "pstUsrid": strNumber,
                "pstNewPassword": txtPassword.text!.trim(),
                "pstNewVerifypass": txtConfirmPassword.text!.trim(),
            ]
            url = AppConstant.postForgotPasswordUrl
            print("Url===\(url)")
            print("params===\(String(describing: params))")
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = response.result.value! as! [String: Any]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                self.goToLogin()
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                                
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg )
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

