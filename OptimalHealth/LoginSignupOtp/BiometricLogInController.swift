//
//  BiometricLogInController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/2/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication

class BiometricLogInController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtFldPin: UITextField!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var viewBackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnPin: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            viewBackTopConstraint.constant = 42
        }
        self.btnOK.layer.borderWidth = AppConstant.borderButton
        self.btnOK.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.btnOK.layer.cornerRadius = self.btnOK.frame.height/2
        self.btnOK.clipsToBounds = true
        
        lblName.text = AppConstant.retrievFromDefaults(key: StringConstant.name)
//        txtFldPin.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtFldPin?.becomeFirstResponder()
        
        self.viewBack.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(backAction))
        self.viewBack.addGestureRecognizer(tap)
        
        txtFldPin.attributedPlaceholder = NSAttributedString(string: "Enter 4 Digit Pin",
                                                             attributes: [NSAttributedString.Key.foregroundColor: AppConstant.themeRedColor.withAlphaComponent(0.6)])
        
    }
    
    @IBAction func btnOK(_ sender: UIButton) {
        let count = txtFldPin.text?.count
        if count == 4{
            if AppConstant.retrievFromDefaults(key: StringConstant.authorization) == "" {
                self.isTokenVerified(completion: { (Bool) in
                    if Bool{
                        self.serviceCallToVerifyPin()
                    }
                })
            }else{
                self.serviceCallToVerifyPin()
            }
        }else{
            self.displayAlert(message: StringConstant.fourDigitPinValidation)
        }
    }
    
    @IBAction func btnPinAction(_ sender: UIButton) {
        self.txtFldPin.isSecureTextEntry = !self.txtFldPin.isSecureTextEntry
        if !txtFldPin.isSecureTextEntry {
            self.btnPin.setImage(UIImage(named: "show_pass.png"), for: .normal)
        }else{
            btnPin.setImage(UIImage(named: "hide_pass.png"), for: .normal)
        }
    }
    
    // MARK: - Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == txtFldPin) {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
    }
    
//    @objc func textFieldDidChange(textField : UITextField){
//        let count = txtFldPin.text?.count
//        if count == 4{
//            if AppConstant.retrievFromDefaults(key: StringConstant.authorization) == "" {
//                self.isTokenVerified(completion: { (Bool) in
//                    if Bool{
//                        self.serviceCallToVerifyPin()
//                    }
//                })
//            }else{
//                self.serviceCallToVerifyPin()
//            }
//            //self.authenticateUserUsingTouchId()
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtnAction (_ sender: UIButton) {
        
    }
    
    //MARK: Touch Id Methods
    fileprivate func authenticateUserUsingTouchId() {
        let context = LAContext()
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) {
            self.evaulateTocuhIdAuthenticity(context: context)
        }
    }
    
    func evaulateTocuhIdAuthenticity(context: LAContext) {
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Use your Touch ID for Login") { (authSuccessful, authError) in
            if authSuccessful {
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    if AppConstant.retrievFromDefaults(key: StringConstant.authorization) == "" {
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToVerifyPin()
                            }
                        })
                    }else{
                        self.serviceCallToVerifyPin()
                    }
                }
            } else {
                if let error = authError as? LAError {
                    self.showError(error: error)
                }
            }
        }
    }
    
    func showError(error: LAError) {
        var message: String = ""
        switch error.code {
        case LAError.authenticationFailed:
            message = "Authentication was not successful because the user failed to provide valid credentials. Please enter password to login."
            break
        case LAError.userCancel:
            message = "Authentication was cancelled by the user"
            break
        case LAError.userFallback:
            message = "Authentication was cancelled because the user tapped the fallback button"
            break
        case LAError.touchIDNotEnrolled:
            message = "Authentication could not start because Touch ID has no enrolled fingers."
            break
        case LAError.passcodeNotSet:
            message = "Passcode is not set on the device."
            break
        case LAError.systemCancel:
            message = "Authentication was cancelled by system"
            break
        default:
            message = error.localizedDescription
            break
        }
        print(message)
        self.displayAlert(message: message )
    }
    
    //MARK: Service Call Method
    func serviceCallToVerifyPin(){
        
        let headers: HTTPHeaders = [
            "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
            "Accept": "application/json"
        ]
        
        print("Headers--- \(headers)")
        
        if txtFldPin?.text?.trim() == "" {
            self.displayAlert(message: StringConstant.pinValidation)
        }else if (txtFldPin?.text?.trim().count)! < 4 {
            self.displayAlert(message: StringConstant.fourDigitPinValidation)
        }else{
            // DjKIOd5XYquKqoQTAsK759XBvdgglzJN - wasim password
            if(AppConstant.hasConnectivity()) {//true connected
                let params: Parameters = [
                    //"pstUsrID": userName,
                    //"pstPassword": password,
                    "pstPin":txtFldPin.text!
                ]
                print("params===\(params)")
                print("url===\(AppConstant.touchIdLoginUrl)")
                
                AppConstant.showHUD()
                
//                let configuration = URLSessionConfiguration.default
//                configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//                configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//                AFManager = Alamofire.SessionManager(configuration: configuration)
                AFManager.request( AppConstant.touchIdLoginUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                        self.serviceCallToVerifyPin()
                                    }
                                })
                            }else{
                                let dictRes = AppConstant.convertToDictionary(text: response.result.value!)
                                //  debugPrint(dict)
                                
                                if let status = dictRes?["status"] as? String {
                                    if(status == "1"){
                                        //Save in Defaults
                                        AppConstant.saveInDefaults(key: StringConstant.isLoggedIn, value: StringConstant.YES)
                                        
                                        if let arrUserDetails = dictRes?["Userdetails"] as? [[String: Any]]{
                                            if arrUserDetails.count > 0{
                                                let dictUser = arrUserDetails[0]
                                                
                                                if let email = dictUser["UserID"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.email, value: email)
                                                }
                                                if let password = dictUser["Password"] as? String{
                                                    let newStr = String(utf8String: password.cString(using: .utf8)!)
                                                    AppConstant.saveInDefaults(key: StringConstant.password, value: newStr!)
                                                }
                                                if let nationalId = dictUser["NationalID"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.nationalId, value: nationalId)
                                                }
                                                if let name = dictUser["Name"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.name, value: name)
                                                }
                                                if let dname = dictUser["DisplayName"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.displayName, value: dname)
                                                }
                                                if let cardNo = dictUser["CardNo"] as? String{
                                                    //AppConstant.saveInDefaults(key: StringConstant.cardNo, value: cardNo)
                                                }
                                                if let profileImgURl = dictUser["ProfileImageUrl"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: profileImgURl)
                                                }
                                                if let lastVisited = dictUser["LastVisited"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.lastVisited, value: lastVisited)
                                                }else{
                                                    AppConstant.saveInDefaults(key: StringConstant.lastVisited, value: "")
                                                }
                                              if let state = dictUser["State"] as? String{
                                                   AppConstant.saveInDefaults(key: StringConstant.state, value: state)
                                               }
                                              if let postCode = dictUser["PostCode"] as? String{
                                                  AppConstant.saveInDefaults(key: StringConstant.postCode, value: postCode)
                                              }else{
                                                  AppConstant.saveInDefaults(key: StringConstant.postCode, value: "")
                                              }
                                              if let memberSince = dictUser["MemberSince"] as? String{
                                                 AppConstant.saveInDefaults(key: StringConstant.memberSince, value: memberSince)
                                             }
                                              if let mobileNo = dictUser["MobileNo"] as? String{
                                                   AppConstant.saveInDefaults(key: StringConstant.mobileNo, value: mobileNo)
                                               }
                                                if let policyNo = dictUser["PolicyNo"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.policyNo, value: policyNo)
                                                }
                                                if let payorCode = dictUser["PayorCode"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.payorCode, value: payorCode)
                                                }
                                                if let corpCode = dictUser["CorpCode"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: corpCode)
                                                }
                                                if let role = dictUser["Role"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.role, value: role)
                                                }
                                                if let roleDesc = dictUser["RoleDesc"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: roleDesc)
                                                }
                                                
                                                if let memId = dictUser["MemId"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.memId, value: memId)
                                                }
                                                if let uType = dictUser["MemberType"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.memberType, value: uType)
                                                    if(uType == "3"){
                                                        if let agentId = dictRes?["KeyId"] as? String{
                                                            AppConstant.saveInDefaults(key: StringConstant.agentId, value: agentId)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                        
                                        self.apiCallToRegisterDeviceToken()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        appDelegate.gotoHomeScreen()
                                    }else{
                                        if let msg = dictRes?["message"] as? String{
                                            self.displayAlert(message: msg)
                                        }
                                    }
                                }else{
                                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.touchIdLoginUrl)
                                }
                            }
                            
                            break
                            
                        case .failure(_):
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.touchIdLoginUrl)
                            break
                            
                        }
                }
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
        }
    }
    
    func apiCallToRegisterDeviceToken(){
            let apnsId = AppConstant.retrievFromDefaults(key: StringConstant.deviceToken)
            let voipId = AppConstant.retrievFromDefaults(key: StringConstant.voip_Token)
            //pstVoipToken
            let json = "{\"pstDeviceId\":\"\(apnsId)\",\"pstDeviceName\":\"\(StringConstant.iOS)\",\"pstVoipToken\":\"\(voipId)\"}"
            print("param===\(json)")
            let url = URL(string: AppConstant.update_device_token_url)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            
            //print("params===\(params)")
            print("url===\(AppConstant.update_device_token_url)")
            
            if apnsId != "" {
                //AppConstant.showHUD()
                Alamofire.request(request).responseJSON {
                    (response) in
                    //AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.apiCallToRegisterDeviceToken()
                                }
                            })
                        }else{
                            let dict = response.result.value as! [String : AnyObject]
                            //  debugPrint(dict)
                            
                            if let status = dict["Status"] as? String {
                                if(status == "1"){//success
                                    //Save in Defaults
                                    AppConstant.saveInDefaults(key: StringConstant.isVOIPTokenUpdated, value: StringConstant.YES)
                                    print("Device token saved in server")
                                    
                                }else {
                                    print("Failed to save device token in server")
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.update_device_token_url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.update_device_token_url)
                        break
                        
                    }
                }
            }
        }
    
}

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

