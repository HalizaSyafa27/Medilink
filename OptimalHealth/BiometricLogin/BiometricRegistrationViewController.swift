//
//  BiometricRegistrationViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 17/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication

class BiometricRegistrationViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet var lblTouchIdTopConstraint: NSLayoutConstraint!
    @IBOutlet var viewtopHeightconstraint: NSLayoutConstraint!
    @IBOutlet var viewback: UIView!
    @IBOutlet var viewAcceptTerms: UIView!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnShowPassword: UIButton!
    @IBOutlet var btnShowPin: UIButton!
    @IBOutlet var btnShowConfirmPin: UIButton!
    @IBOutlet var imgViewCheckBox: UIImageView!
    @IBOutlet var txtFldUserName: UITextField!
    @IBOutlet var txtFldPassword: UITextField!
    @IBOutlet var txtFldPin: UITextField!
    @IBOutlet var txtFldcnfPin: UITextField!
    @IBOutlet var viewBackTopConstraint: NSLayoutConstraint!
    
    var istermsAndCondtionAccepted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesigns()
    }
    
    func initDesigns(){
        
        if AppConstant.screenSize.width > 320 {
//            viewtopHeightconstraint.constant = 210
//            lblTouchIdTopConstraint.constant = 70
        }
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            viewBackTopConstraint.constant = 42
        }
        
        btnRegister.layer.cornerRadius = 3.0
        btnRegister.clipsToBounds = true
        
        self.viewback.isUserInteractionEnabled = true
        let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(backAction))
        self.viewback.addGestureRecognizer(tap1)
        
        self.viewAcceptTerms.isUserInteractionEnabled = true
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(acceptTermsConditionAction))
        self.viewAcceptTerms.addGestureRecognizer(tap2)
    }
    
    // MARK: - Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField == txtFldPin) || (textField == txtFldcnfPin)) {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == txtFldUserName{
            if string == "" {
                // User presses backspace
                textField.deleteBackward()
            } else {
                // User presses a key or pastes
                textField.insertText(string.uppercased())
            }
            // Do not let specified text range to be changed
            return false
        }else{
            return true
        }
    }
    
    // MARK: - Button Action
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func acceptTermsConditionAction(){
        if istermsAndCondtionAccepted == false {
            imgViewCheckBox.image = UIImage.init(named: "checkbox_active")
            btnRegister.backgroundColor = AppConstant.themeRedColor
        }else{
            imgViewCheckBox.image = UIImage.init(named: "checkbox")
            btnRegister.backgroundColor = UIColor.init(red: 191.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        }
        istermsAndCondtionAccepted = !istermsAndCondtionAccepted
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        serviceCallToRegisterBiometric()
    }
    
    @IBAction func btnTermsCondAction(_ sender: Any) {
        
    }
    
    @IBAction func btnShowPasswordAction(_ sender: Any) {
        btnShowPassword.isSelected = !btnShowPassword.isSelected
        txtFldPassword.isSecureTextEntry = !txtFldPassword.isSecureTextEntry
    }
    
    @IBAction func btnShowPinAction(_ sender: Any) {
        btnShowPin.isSelected = !btnShowPin.isSelected
        txtFldPin.isSecureTextEntry = !txtFldPin.isSecureTextEntry
    }
    
    @IBAction func btnShowConfirmPinAction(_ sender: Any) {
        btnShowConfirmPin.isSelected = !btnShowConfirmPin.isSelected
        txtFldcnfPin.isSecureTextEntry = !txtFldcnfPin.isSecureTextEntry
    }
    
    // MARK: - Service call Method
    func serviceCallToRegisterBiometric(){
        if txtFldUserName?.text?.trim() == "" {
            self.displayAlert(message: StringConstant.userNameBlankValidation)
        }else if txtFldPassword?.text?.trim() == "" {
            self.displayAlert(message: StringConstant.passwordValidation)
        }else if txtFldPin?.text?.trim() == "" {
            self.displayAlert(message: StringConstant.pinValidation)
        }else if (txtFldPin?.text?.trim().count)! < 4 {
            self.displayAlert(message: StringConstant.fourDigitPinValidation)
        }else if txtFldcnfPin?.text?.trim() == "" {
            self.displayAlert(message: StringConstant.cnfPinValidation)
        }else if (txtFldcnfPin?.text?.trim().count)! < 4 {
            self.displayAlert(message: StringConstant.fourDigitPinValidation)
        }else if txtFldPin?.text?.trim() != txtFldcnfPin?.text?.trim() {
            self.displayAlert(message: StringConstant.pinNotMatchValidation)
        }else if istermsAndCondtionAccepted == false {
            self.displayAlert(message: StringConstant.acceptTermsAndConditionMsg)
        }else{
            if(AppConstant.hasConnectivity()) {//true connected
                
                let encryptedUserName = try! txtFldUserName.text!.aesEncrypt()
                print("Enctipted username=== \(String(describing: encryptedUserName))")
                
                let encryptedPassword = try! txtFldPassword.text!.aesEncrypt()
                
                let params: Parameters = [
                    "pstUsrID": encryptedUserName,
                    "pstPassword": encryptedPassword,
                    "pstPin":txtFldPin.text!
                ]
                
                print("params===\(params)")
                print("url===\(AppConstant.touchIdRegistrationUrl)")
                
                AppConstant.showHUD()
//                let configuration = URLSessionConfiguration.default
//                configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//                configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//                AFManager = Alamofire.SessionManager(configuration: configuration)
                AFManager.request( AppConstant.touchIdRegistrationUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
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
                                        self.serviceCallToRegisterBiometric()
                                    }
                                })
                            }else{
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                //  debugPrint(dict)
                                
                                if let status = dict?["Status"] as? String {
                                    if(status == "1"){//success
                                        AppConstant.saveInDefaults(key: StringConstant.encryptedUserId, value: encryptedUserName)
                                        AppConstant.saveInDefaults(key: StringConstant.encryptedPassword, value: encryptedPassword)
                                        AppConstant.saveInDefaults(key: StringConstant.email, value: self.txtFldUserName.text!)
                                        AppConstant.saveInDefaults(key: StringConstant.hasTouchIdRegistered, value: StringConstant.YES)
                                        if let name = dict?["pstUsrID"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.name, value: name)
                                        }
                                        if let password = dict?["pstPassword"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.password, value: password)
                                        }
                                        
                                        self.performSegue(withIdentifier: "biometric_registration_success", sender: self)
                                    }else {
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg ?? "")
                                        }
                                    }
                                }else{
                                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.touchIdRegistrationUrl)
                                }
                            }
                            
                            break
                            
                        case .failure(_):
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.touchIdRegistrationUrl)
                            break
                            
                        }
                }
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
