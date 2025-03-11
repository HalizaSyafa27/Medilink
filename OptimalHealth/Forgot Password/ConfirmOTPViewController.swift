//
//  ConfirmOTPViewController.swift
//  OptimalHealth
//
//  Created by cuscsoftware on 10/6/21.
//  Copyright © 2021 Oditek. All rights reserved.
//

import UIKit

import Alamofire

class ConfirmOTPViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var txtNumber1: UITextField!
    @IBOutlet weak var txtNumber2: UITextField!
    @IBOutlet weak var txtNumber3: UITextField!
    @IBOutlet weak var txtNumber4: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var strCode = ""
    var strNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backAction(_:)))
        self.backView.addGestureRecognizer(tap)
        self.backView.isUserInteractionEnabled = true
        txtNumber1.delegate = self
        txtNumber2.delegate = self
        txtNumber3.delegate = self
        txtNumber4.delegate = self
        
        txtNumber1.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        txtNumber2.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        txtNumber3.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        txtNumber4.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnSubmit.clipsToBounds = true
        self.btnSubmit.layer.borderWidth = AppConstant.borderButton
        self.btnSubmit.layer.borderColor = AppConstant.themeRedColor.cgColor
    }
    
    @objc func keyboardInputShouldDelete(_ textField: UITextField) -> Bool {
        switch textField{
            case txtNumber4:
                txtNumber3.becomeFirstResponder()
            case txtNumber3:
                txtNumber2.becomeFirstResponder()
            case txtNumber2:
                txtNumber1.becomeFirstResponder()
            case txtNumber1:
                txtNumber1.becomeFirstResponder()
            default:
                txtNumber1.becomeFirstResponder()
        }
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text
        if (text?.utf16.count)! >= 1{
            switch textField{
            case txtNumber1:
                txtNumber2.becomeFirstResponder()
            case txtNumber2:
                txtNumber3.becomeFirstResponder()
            case txtNumber3:
                txtNumber4.becomeFirstResponder()
            case txtNumber4:
                txtNumber4.becomeFirstResponder()
            default:
                txtNumber4.becomeFirstResponder()
            }
        }
        if (text?.utf16.count)! == 0 {
            switch textField{
            case txtNumber4:
                txtNumber3.becomeFirstResponder()
            case txtNumber3:
                txtNumber2.becomeFirstResponder()
            case txtNumber2:
                txtNumber1.becomeFirstResponder()
            case txtNumber1:
                txtNumber1.becomeFirstResponder()
            default:
                txtNumber1.becomeFirstResponder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtNumber1 || textField == txtNumber2 || textField == txtNumber3 || textField == txtNumber4{
            if (range.location > 0 || (textField.text!.count == 1)) && range.length < 1 {
                if textField == txtNumber1{
                    txtNumber2.becomeFirstResponder()
                }
                if textField == txtNumber2{
                    txtNumber3.becomeFirstResponder()
                }
                if textField == txtNumber3{
                    txtNumber4.becomeFirstResponder()
                }
                return false
            }
        }
        return true
    }
    
    @IBAction func submitOTPAction(_ sender: UIButton) {
        if txtNumber1.text == "" || txtNumber2.text == "" || txtNumber3.text == "" || txtNumber4.text == ""{
            self.displayAlert(message: "Verification code is required")
        }else{
            let number1:String = txtNumber1.text ?? ""
            let number2:String = txtNumber2.text ?? ""
            let number3:String = txtNumber3.text ?? ""
            let number4:String = txtNumber4.text ?? ""
            strCode = number1 + "" + number2 + "" + number3 + "" + number4
            self.serviceCallToSubmitOTP()
//            goToChangePasswordByOTP()
        }
    }
    
    
    @objc func backAction(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToChangePasswordByOTP(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordByOTP") as! ChangePasswordByOTPViewController
        vc.strNumber = self.strNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func serviceCallToSubmitOTP(){
        if(AppConstant.hasConnectivity()) {//true connected
//            let headers: HTTPHeaders = [
//                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
//                "Accept": "application/json"
//            ]
//            print("Headers--- \(headers)")
            AppConstant.showHUD()
            var params: Parameters!
            var url : String = ""
            params = [
                "pstUsrid": strNumber,
                "pstOTP": strCode.trim(),
            ]
            url = AppConstant.postVerifyOTPForForgotPasswordUrl
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
                            if(status == "OK"){
                                self.goToChangePasswordByOTP()
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

