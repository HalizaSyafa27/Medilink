//
//  LogInController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/2/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication
import CryptoSwift
import FirebaseCrashlytics

class LogInController: BaseViewController, ForgotPasswordDelegate, UITextFieldDelegate, TouchIdPopupCancelledDelegate {
    
    @IBOutlet weak var userNameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    @IBOutlet weak var lblOrUseTouchId: UILabel!
    @IBOutlet weak var btnTouchId: UIButton!
    @IBOutlet weak var btnDontHaveAccount: UIButton!
    
    
    @IBOutlet var ForgotPasswordToTouchIdVerticalSpacingConstraint: NSLayoutConstraint!
    @IBOutlet var TouchIdToImageVerticalSpacingConstraint: NSLayoutConstraint!
    @IBOutlet var lblSignInToTxtFldUserNameVerticalSpacingConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldPasswordToViewUserNameVerticalSpacingConstraint: NSLayoutConstraint!
    @IBOutlet var btnBackTopConstraint: NSLayoutConstraint!
    
    var forgotPswEmail:String = ""
    var isFromChat: Bool = false
    var isFromLandingPage: Bool = false
    var arrSeqQstn = [SecurityQuestion]()
    //@ade: start
    var isFromJwt: Bool = false
    var url: NSURLComponents? = nil
    var jwt: String = ""
    var extUserLabel = ""
    var isNeedLogoutFirst: Bool = false
    //@ade: end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
        checkFromJwt()
    }
    
    func initDesigns() {
        print("screen size \(AppConstant.screenSize.width) * \(AppConstant.screenSize.height)")
        self.navigationController?.isNavigationBarHidden = true
        
//        userNameTf?.text = "bhavyaapps99@gmail.com"
//        passwordTf?.text = "Abcd123$%^"
        self.signInBtn.layer.borderWidth = AppConstant.borderButton
        self.signInBtn.layer.borderColor = AppConstant.themeRedColor.cgColor
        signInBtn.layer.cornerRadius = 3
        signInBtn.clipsToBounds = true
        userNameTf.delegate = self
        
        userNameTf.tintColor = AppConstant.themeRedColor
        passwordTf.tintColor = AppConstant.themeRedColor
        
        setplaceHolderColor(txtFld: userNameTf, placeholder: "Enter Phone Number")
        setplaceHolderColor(txtFld: passwordTf, placeholder: "Password")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        if AppConstant.screenSize.width > 320 {
//            ForgotPasswordToTouchIdVerticalSpacingConstraint.constant = 20
//            TouchIdToImageVerticalSpacingConstraint.constant = 35
        }
        
        if AppConstant.screenSize.width >= 414.0 {
            //lblSignInToTxtFldUserNameVerticalSpacingConstraint.constant = 10
//            txtFldPasswordToViewUserNameVerticalSpacingConstraint.constant = 42.0
        }
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
//            btnBackTopConstraint.constant = 42
        }
        
        self.viewUserName.layer.borderWidth = 1.5
        self.viewUserName.layer.cornerRadius = 25
        self.viewUserName.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.viewUserName.clipsToBounds = true
               
        self.viewPassword.layer.borderWidth = 1.5
        self.viewPassword.layer.cornerRadius = 25
        self.viewPassword.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.viewPassword.clipsToBounds = true
               
        self.signInBtn.layer.cornerRadius = self.signInBtn.frame.height/2
        self.signInBtn.clipsToBounds = true
    }
    
    //@ade: start
    override func viewWillAppear(_ animated: Bool) {
        if (isFromJwt) {
            hideAll(value: true)
        }
    }
    
    func hideAll(value: Bool) {
        userNameTf.isHidden = value
        passwordTf.isHidden = value
        passwordBtn.isHidden = value
        signInBtn.isHidden = value
        btnBack.isHidden = value
        btnForgotPassword.isHidden = value
        viewUserName.isHidden = value
        viewPassword.isHidden = value
        lblOrUseTouchId.isHidden = value
        btnTouchId.isHidden = value
        btnDontHaveAccount.isHidden = value
    }
    
    func invalidAuthentication() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoLandingScreen()
        AppConstant.showAlertWithOkAction(strTitle: "Message", strDescription: "INVALID AUTHENTICATION!", delegate: self, completion: {})
    }
    
    func invalidAuthorization(for message: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoLandingScreen()
        AppConstant.showAlertWithOkAction(strTitle: "Message", strDescription: message, delegate: self, completion: {})
    }
    
    func checkFromJwt() {
        if (isFromJwt) {
            guard let params = url?.queryItems else {
                //INVALID AUTHENTICATION
                invalidAuthentication()
                return
            }
            if let token = params.first(where: { $0.name == "token" })?.value {
                jwt = token
                extUserLabel = ""
                isNeedLogoutFirst = false
                let payload = AppConstant.decodePayload(token: token)
                if let data = payload.data(using: .utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let iss = json?["iss"] as? String ?? ""
                        if (iss == "") {
                            //INVALID AUTHENTICATION
                            invalidAuthentication()
                            return
                        }
                        let sub = json?["sub"] as? String ?? ""
                        if (sub == "") {
                            //INVALID AUTHENTICATION
                            invalidAuthentication()
                            return
                        }
                        let cardNoFromStorage = AppConstant
                            .retrievFromDefaults(key: "CardNo")
                        if cardNoFromStorage == "" {
                            isNeedLogoutFirst = false
                        }
                        else if sub != cardNoFromStorage {
                            isNeedLogoutFirst = true
                        }
                        let ulab = json?["ulab"] as? String ?? ""
                        extUserLabel = ulab
                    } catch {
                        //INVALID AUTHENTICATION
                        invalidAuthentication()
                        return
                    }
                }
                if (isNeedLogoutFirst) {
                    //Login by deeplink with different card no
                    self.logOutAndSwitchUser(completion: {(success) in
                        //if (success) {
                            self.apiCallToGetTokenByJwt()
                        //}
                    })
                } else {
                    self.apiCallToGetTokenByJwt()
                }
            } else {
                invalidAuthentication()
            }
        }
    }
    //@ade: end
    
    func showTouchidUnSuccessPopup() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "TouchIdUnSuccessfulPopupViewController") as! TouchIdUnSuccessfulPopupViewController
        popupVC.delegate = self
        addChild(popupVC)

        //make sure that the child view controller's view is the right size
        popupVC.view.frame = self.view.bounds
        self.view.addSubview(popupVC.view)

        //you must call this at the end per Apple's documentation
        popupVC.didMove(toParent: self)
    }
    
    override func setplaceHolderColor(txtFld: UITextField, placeholder: String) {
        txtFld.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: AppConstant.themeRedColor
            ]
        )
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.dismissKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameTf {
            if string == "" {
                // User presses backspace
                textField.deleteBackward()
            } else {
                // User presses a key or pastes
                textField.insertText(string.uppercased())
            }
            // Do not let specified text range to be changed
            return false
        }
        
        return true
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        
        var back = self.navigationController?.popViewController(animated: true)
        if back == nil {
           let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditionController") as! TermsAndConditionController
           self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register_vc") as! RegisterViewController
                      self.navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func togglePasswordBtnAction(_ sender: Any) {
        self.passwordBtn.isSelected = !self.passwordBtn.isSelected
        self.passwordTf.isSecureTextEntry = !self.passwordTf.isSecureTextEntry
        
        if let textRange = self.passwordTf.textRange(from: passwordTf.beginningOfDocument, to: passwordTf.endOfDocument) {
            self.passwordTf.replace(textRange, withText: passwordTf.text!)
        }
    }
    
    @IBAction func btnLoginWithPinAction (_ sender: UIButton) {
        //self.authenticateUserUsingTouchId()
    }
    
    @IBAction func touchIdButtonAction (_ sender: UIButton) {
        let touchId = AppConstant.retrievFromDefaults(key: StringConstant.hasTouchIdRegistered)
        if self.isTouchIdSupportedOnDevice() == true{
            //Touch Id supported
            if touchId == StringConstant.YES {//Already Registered Touch Id with server
                //Promt User to login with pin
                self.authenticateUserUsingTouchId()
            }else{
                //Touch Id not Registered
                self.performSegue(withIdentifier: "biometric_login_option", sender: self)
            }
        }
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: UIButton) {
        self.goToSendOTP()
//        let controller:ForgotPasswordViewController = self.storyboard!.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
//        controller.view.frame = self.view.bounds;
//        controller.willMove(toParent: self)
//        controller.delegate = self
//        self.view.addSubview(controller.view)
//        self.addChild(controller)
//        controller.didMove(toParent: self)
        
    }
    
    func goToSendOTP(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendOTP") as! SendOTPViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        if(AppConstant.hasConnectivity()) {//true connected
            var errMessage : String?
            let userName = self.userNameTf?.text?.trim()
            let password = self.passwordTf?.text?.trim()
            
            let encryptedUserName = try! userName?.aesEncrypt()
            print("Enctipted username=== \(String(describing: encryptedUserName))")
            
            let encryptedPassword = try! password?.aesEncrypt()
            print("Enctipted password=== \(String(describing: encryptedPassword))")
            
            if(userName == ""){
                errMessage = StringConstant.phoneBlankValidation
            }else if(password == ""){
                errMessage = StringConstant.passwordBlankValidation
            }
            
            if(errMessage != nil){
                self.displayAlert(message: errMessage ?? "")
                
            } else{
                self.apiCallToGetToken(userId: encryptedUserName!, password: encryptedPassword!)
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
        
    }
        
    //MARK: Forgot Password Delegate
    func forgotPasswordDelegateMethod(arrQuestions: [SecurityQuestion], email: String){
        let seqVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecurityQAViewController") as! SecurityQAViewController
        seqVC.arrSeqQstn = arrQuestions
        seqVC.isQuestionsPreviouslyDefined = arrQuestions.count == 0 ? false : true
        seqVC.email = email
        self.navigationController?.pushViewController(seqVC, animated: true)
    }
    
    //MARK: Touch Id Methods
    fileprivate func authenticateUserUsingTouchId() {
        let context = LAContext()
        context.localizedFallbackTitle = "Enter Pincode"
        //context.maxBiometryFailures = 1
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            self.evaulateTocuhIdAuthenticity(context: context)
        }
    }
    
    func evaulateTocuhIdAuthenticity(context: LAContext) {
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Scan your fingerprint now to Login") { (authSuccessful, authError) in
            if authSuccessful {
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    
                    self.apiCallToGetToken(userId: AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId), password: AppConstant.retrievFromDefaults(key:  StringConstant.encryptedPassword))
                }
            } else {
                //self.showError(error: (authError as? LAError)!)
                 print("Error===\(authError.debugDescription)===code===\(authError?.localizedDescription)")
                if let err = authError as? LAError{
                    if err.code == LAError.authenticationFailed{
                        DispatchQueue.main.async {
                            self.showTouchidUnSuccessPopup()
                        }
                    }else if err.code == LAError.userCancel{
                        //Nothing to do
                    }else if err.code == LAError.userFallback{
                        //Enter Pincode btn Action
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "biometeri_login", sender: self)
                        }
                    }else{
                       DispatchQueue.main.async {
                            self.showTouchidUnSuccessPopup()
                        }
                    }
                }
            }
        }
    }
    
    func showError(error: LAError) {
        var message: String = ""
        switch error.code {
        case LAError.authenticationFailed:
            //message = "Authentication was unsuccessful. Please enter pin to login."
            DispatchQueue.main.async {
                self.showTouchidUnSuccessPopup()
            }
            //return
            
            break
        case LAError.userCancel:
            //message = "Authentication was cancelled by the user"
            //return
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
        self.displayAlert(message: message )
    }
    
    //MARK: TouchId Cancelled Popup Delegate
    func popupOkAction(){
        //Move to Enter Pin Page
        self.performSegue(withIdentifier: "biometeri_login", sender: self)
    }
    
    //MARK: Service call
    func apiCallToGetToken(userId: String, password: String){
        let apnsId = AppConstant.retrievFromDefaults(key: StringConstant.deviceToken)
        let params: Parameters = [
            "pstUsrID": userId,
            "pstPassword": password,
            "pstDeviceID": apnsId,
            "pstAppID": StringConstant.appID
        ]
        print("params===\(params)")
        print("url===\(AppConstant.getTokenUrl)")
        var appTokenType: String = ""
        var appToken: String = ""
        AppConstant.showHUD()
        Alamofire.request( AppConstant.getTokenUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                AppConstant.hideHUD()
                debugPrint(response)
                
                switch(response.result) {
                case .success(_):
                    let dict = response.result.value as! [String : AnyObject]
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    if (headerStatusCode == 200){//Success
                        if let status = dict["status"] as? String {
                            if(status == "OK"){//success
                                //Save userId and Password in User Defaults
                                if AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId) != userId{
                                    //User loggedin with another userid
                                    AppConstant.removeFromDefaults(key: StringConstant.hasTouchIdRegistered)
                                }
                                AppConstant.saveInDefaults(key: StringConstant.encryptedUserId, value: userId)
                                AppConstant.saveInDefaults(key: StringConstant.encryptedPassword, value: password)
                                if let tokenAray = dict["Token"] as? [[String : AnyObject]]{
                                    if let token = tokenAray[0]["Token"] as? String{
                                        AppConstant.saveInDefaults(key: StringConstant.appToken, value: token)
                                        appToken = token
                                    }
                                    if let tokenType = tokenAray[0]["Token_type"] as? String{
                                        AppConstant.saveInDefaults(key: StringConstant.appTokenType, value: tokenType)
                                        appTokenType = tokenType
                                    }
                                    AppConstant.saveInDefaults(key: StringConstant.authorization, value: appTokenType + " " + appToken)
                                    if let authUserDetails = dict["AuthUserDetails"] as? [[String : AnyObject]]{
                                        let dictUser = authUserDetails[0]
                                        if let currencySymbol = dictUser["CurrencySymbol"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.currencySymbol, value: currencySymbol)
                                        }
                                        if let emergencyNo = dictUser["EmergencyNo"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.emergencyNo, value: emergencyNo)
                                        }
                                        if let email = dictUser["UserID"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.email, value: email)
                                        }
                                        if let password = dictUser["Password"] as? String{
                                            let newStr = String(utf8String: password.cString(using: .utf8)!)
                                            AppConstant.saveInDefaults(key: StringConstant.password, value: newStr!)
                                        }
                                        if let emailAddress = dictUser["Email"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.emailAddress, value: emailAddress)
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
                                            AppConstant.saveInDefaults(key: StringConstant.cardNo, value: cardNo)
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
                                        }else{
                                           AppConstant.saveInDefaults(key: StringConstant.state, value: "")
                                        }
                                        if let postCode = dictUser["PostCode"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.postCode, value: postCode)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.postCode, value: "")
                                        }
                                        if let memberSince = dictUser["MemberSince"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.memberSince, value: memberSince)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.memberSince, value: "")
                                        }
                                        if let mobileNo = dictUser["MobileNo"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.mobileNo, value: mobileNo)
                                        }else{
                                           AppConstant.saveInDefaults(key: StringConstant.mobileNo, value: "")
                                        }
                                        if let policyNo = dictUser["PolicyNo"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.policyNo, value: policyNo)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.policyNo, value: "")
                                        }
                                        if let payorCode = dictUser["PayorCode"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.payorCode, value: payorCode)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.payorCode, value: "")
                                        }
                                        if let corpCode = dictUser["CorpCode"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: corpCode)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: "")
                                        }
                                        if let role = dictUser["Role"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.role, value: role)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.role, value: "")
                                        }
                                        if let roleDesc = dictUser["RoleDesc"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: roleDesc)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: "")
                                        }
                                        if let memId = dictUser["MemId"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.memId, value: memId)
                                        }else{
                                            AppConstant.saveInDefaults(key: StringConstant.lastVisited, value: "")
                                        }
                                        if let memType = dictUser["MemberType"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.memberType, value: memType)
                                            if(memType == "3"){
                                                if let agentId = dictUser["KeyId"] as? String{
                                                    AppConstant.saveInDefaults(key: StringConstant.agentId, value: agentId)
                                                }
                                            }
                                        }
                                        if let uType = dictUser["UserType"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.userType, value: uType)
                                        }
                                    }
                                    AppConstant.saveInDefaults(key: StringConstant.isLoggedIn, value: StringConstant.YES)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        self.apiCallToRegisterDeviceToken()
                                    }
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    appDelegate.gotoHomeScreen()
                                }
                            }else {
                                if let msg = dict["message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getTokenUrl)
                        }
                    }else{
                        if let msg = dict["message"] as? String{
                            self.displayAlert(message: msg )
                        }
                    }
                    break
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.getTokenUrl)
                    break
                    
                }
        }
    }

    //@ade:start
    func apiCallToGetTokenByJwt() {
        let apnsId = AppConstant.retrievFromDefaults(key: StringConstant.deviceToken)
        let params: Parameters = [
            "pstToken": jwt,
            "pstDeviceID": apnsId,
            "pstDeviceName": "iOS",
            "pstAppID": StringConstant.appID
        ]
        print("params===\(params)")
        print("url===\(AppConstant.getTokenByJWTUrl)")
        var appTokenType: String = ""
        var appToken: String = ""
        AppConstant.showHUD()
        Alamofire.request( AppConstant.getTokenByJWTUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                AppConstant.hideHUD()
                debugPrint(response)
    
                switch(response.result) {
                case .success(_):
                    let dict = response.result.value as! [String : AnyObject]
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    if (headerStatusCode == 200){//Success
                        if let status = dict["status"] as? String {
                            if (status == "OK") {//success
                                //Remove touch id
                                AppConstant.removeFromDefaults(key: StringConstant.hasTouchIdRegistered)
                                AppConstant.saveInDefaults(key: StringConstant.externalUserLabel, value: self.extUserLabel)
                                if let tokenAray = dict["Token"] as? [[String : AnyObject]] {
                                    if let token = tokenAray[0]["Token"] as? String{
                                        AppConstant.saveInDefaults(key: StringConstant.appToken, value: token)
                                        appToken = token
                                    }
                                    if let tokenType = tokenAray[0]["Token_type"] as? String {
                                        AppConstant.saveInDefaults(key: StringConstant.appTokenType, value: tokenType)
                                        appTokenType = tokenType
                                    }
                                    AppConstant.saveInDefaults(key: StringConstant.authorization, value: appTokenType + " " + appToken)
                                    if let authUserDetails = dict["AuthUserDetails"] as? [[String : AnyObject]] {
                                        let dictUser = authUserDetails[0]
                                        if let currencySymbol = dictUser["CurrencySymbol"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.currencySymbol, value: currencySymbol)
                                        }
                                        if let emergencyNo = dictUser["EmergencyNo"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.emergencyNo, value: emergencyNo)
                                        }
                                        if let email = dictUser["UserID"] as? String {
                                            //Save userId and Password in User Defaults
                                            let encryptedUserId = try! email.aesEncrypt()
                                            print("Encrypted userid=== \(String(describing: encryptedUserId))")
//                                            if AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId) != encryptedUserId {
//                                                //User loggedin with another userid
//                                                AppConstant.removeFromDefaults(key: StringConstant.hasTouchIdRegistered)
//                                            }
                                            AppConstant.saveInDefaults(key: StringConstant.encryptedUserId, value: encryptedUserId)
                                            AppConstant.saveInDefaults(key: StringConstant.email, value: email)
                                        }
                                        
                                        if let password = dictUser["Password"] as? String {
                                            let newStr = String(utf8String: password.cString(using: .utf8)!)
                                            AppConstant.saveInDefaults(key: StringConstant.password, value: newStr!)
                                        }
                                        if let emailAddress = dictUser["Email"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.emailAddress, value: emailAddress)
                                        }
                                        if let nationalId = dictUser["NationalID"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.nationalId, value: nationalId)
                                        }
                                        if let name = dictUser["Name"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.name, value: name)
                                        }
                                        if let dname = dictUser["DisplayName"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.displayName, value: dname)
                                        }
                                        if let cardNo = dictUser["CardNo"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.cardNo, value: cardNo)
                                        }
                                        if let profileImgURl = dictUser["ProfileImageUrl"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: profileImgURl)
                                        }
                                        if let lastVisited = dictUser["LastVisited"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.lastVisited, value: lastVisited)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.lastVisited, value: "")
                                        }
                                        if let state = dictUser["State"] as? String {
                                           AppConstant.saveInDefaults(key: StringConstant.state, value: state)
                                        } else {
                                           AppConstant.saveInDefaults(key: StringConstant.state, value: "")
                                        }
                                        if let postCode = dictUser["PostCode"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.postCode, value: postCode)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.postCode, value: "")
                                        }
                                        if let memberSince = dictUser["MemberSince"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.memberSince, value: memberSince)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.memberSince, value: "")
                                        }
                                        if let mobileNo = dictUser["MobileNo"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.mobileNo, value: mobileNo)
                                        } else {
                                           AppConstant.saveInDefaults(key: StringConstant.mobileNo, value: "")
                                        }
                                        if let policyNo = dictUser["PolicyNo"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.policyNo, value: policyNo)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.policyNo, value: "")
                                        }
                                        if let payorCode = dictUser["PayorCode"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.payorCode, value: payorCode)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.payorCode, value: "")
                                        }
                                        if let corpCode = dictUser["CorpCode"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: corpCode)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: "")
                                        }
                                        if let role = dictUser["Role"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.role, value: role)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.role, value: "")
                                        }
                                        if let roleDesc = dictUser["RoleDesc"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: roleDesc)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: "")
                                        }
                                        if let memId = dictUser["MemId"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.memId, value: memId)
                                        } else {
                                            AppConstant.saveInDefaults(key: StringConstant.lastVisited, value: "")
                                        }
                                        if let memType = dictUser["MemberType"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.memberType, value: memType)
                                            if(memType == "3"){
                                                if let agentId = dictUser["KeyId"] as? String {
                                                    AppConstant.saveInDefaults(key: StringConstant.agentId, value: agentId)
                                                }
                                            }
                                        }
                                        if let uType = dictUser["UserType"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.userType, value: uType)
                                        }
                                    }
                                    AppConstant.saveInDefaults(key: StringConstant.isLoggedIn, value: StringConstant.YES)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        self.apiCallToRegisterDeviceToken()
                                    }
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    appDelegate.gotoHomeScreen()
                                    self.hideAll(value: false)
                                }
                            } else {
                                if let msg = dict["message"] as? String {
                                    self.displayAlert(message: msg )
                                }
                            }
                        } else {
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getTokenByJWTUrl)
                        }
                    } else {
                        if let msg = dict["message"] as? String {
                            //displayAlert(message: msg )
                            self.invalidAuthorization(for: msg)
                        }
                    }
                    break
                case .failure(_):
                    
                    AppConstant.showNetworkAlertMessage(apiName:
                        AppConstant.getTokenByJWTUrl)
                    break
                }
        }
    }
    //@ade: end
    
    func apiCallToRegisterDeviceToken() {
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
                    
                    if (headerStatusCode == 401) {//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool {
                                self.apiCallToRegisterDeviceToken()
                            }
                        })
                    } else {
                        let dict = response.result.value as! [String : AnyObject]
                        //  debugPrint(dict)
                        
                        if let status = dict["Status"] as? String {
                            if (status == "1") {//Success
                                //Save in Defaults
                                AppConstant.saveInDefaults(key: StringConstant.isVOIPTokenUpdated, value: StringConstant.YES)
                                print("Device token saved in server")
                            } else {
                                print("Failed to save device token in server")
                            }
                        } else {
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
    
    func apiCallForForgotPassword(){
        let headers: HTTPHeaders = [
            "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
            "Accept": "application/json"
        ]
        
        print("Headers--- \(headers)")
        
        let params: Parameters = [
            "pstEmailId": forgotPswEmail
        ]
        print("params===\(params)")
        print("url===\(AppConstant.verifyForgotPasswordUrl)")
        
        AppConstant.showHUD()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
        AFManager = Alamofire.SessionManager(configuration: configuration)
        AFManager.request( AppConstant.verifyForgotPasswordUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
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
                                self.apiCallForForgotPassword()
                            }
                        })
                    }else{
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        //  debugPrint(dict)
                        self.arrSeqQstn.removeAll()
                        
                        if let status = dict?["Status"] as? String {
                            if(status == "1"){//success
                                if let arrSeqQuestions = dict?["SecurityquestionList"] as? [[String: Any]]{
                                    if arrSeqQuestions.count > 0{
                                        let dictQstn = arrSeqQuestions[0]
                                        if let q1 = dictQstn["Question1"] as? String{
                                            let qstnBo = SecurityQuestion()
                                            qstnBo.name = q1
                                            self.arrSeqQstn.append(qstnBo)
                                        }
                                        if let q2 = dictQstn["Question2"] as? String{
                                            let qstnBo = SecurityQuestion()
                                            qstnBo.name = q2
                                            self.arrSeqQstn.append(qstnBo)
                                        }
                                        if let q3 = dictQstn["Question3"] as? String{
                                            let qstnBo = SecurityQuestion()
                                            qstnBo.name = q3
                                            self.arrSeqQstn.append(qstnBo)
                                        }
                                    }
                                }
                                
                                let seqVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecurityQAViewController") as! SecurityQAViewController
                                seqVC.arrSeqQstn = self.arrSeqQstn
                                seqVC.isQuestionsPreviouslyDefined = self.arrSeqQstn.count == 0 ? false : true
                                seqVC.email = self.forgotPswEmail
                                self.navigationController?.pushViewController(seqVC, animated: true)
                                
                            }else {
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.verifyForgotPasswordUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.verifyForgotPasswordUrl)
                    break
                    
                }
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "home") {
            _ = segue.destination as! HomeViewController
            return
        }
    }
    
    func encryptMessage(message: String, encryptionKey: String, iv: String) -> String? {
        if let aes = try? AES(key: encryptionKey, iv: iv),
            let encrypted = try? aes.encrypt(Array<UInt8>(message.utf8)) {
            return encrypted.toHexString()
        }
        return nil
    }
    
    func decryptMessage(encryptedMessage: String, encryptionKey: String, iv: String) -> String? {
        if let aes = try? AES(key: encryptionKey, iv: iv),
            let decrypted = try? aes.decrypt(Array<UInt8>(hex: encryptedMessage)) {
            return String(data: Data(bytes: decrypted), encoding: .utf8)
        }
        return nil
    }
    
    
}
extension String {
    func aesEncrypt() throws -> String {
        let encrypted = try AES(key: StringConstant.secretKey, iv: StringConstant.iv, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!))
        return Data(encrypted).base64EncodedString()
    }
    
    func aesDecrypt() throws -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
        let decrypted = try AES(key: StringConstant.secretKey, iv: StringConstant.iv, padding: .pkcs7).decrypt([UInt8](data))
        return String(bytes: decrypted, encoding: .utf8) ?? self
    }
}
