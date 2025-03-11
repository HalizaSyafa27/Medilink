//
//  BaseViewController.swift
//  OptimalHealth
//
//  Created by cuscsoftware on 10/12/21.
//  Copyright © 2021 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication
import PushKit
import WebKit

class BaseViewController: UIViewController, UIViewControllerTransitioningDelegate, UIPopoverPresentationControllerDelegate {
    
    var pageNumber:Int = 1
    var pageZise:Int = 10
    var totalPage:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the trust policy manager
        let pathToCert = Bundle.main.path(forResource: "certificate", ofType: "der")
        let localCertificate = NSData(contentsOfFile: pathToCert!)!
        let certificates = [SecCertificateCreateWithData(nil, localCertificate)!]
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            )
        print("server === \(AppConstant.server)")
        let serverTrustPolicies = [AppConstant.server: serverTrustPolicy]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
        AFManager = SessionManager(
            configuration: configuration
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        //Check when app enter background mode
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print(countryCode)
            AppConstant.saveInDefaults(key: StringConstant.countryCodeByLocation, value: countryCode)
        }
    }

    @objc func appMovedToBackground() {
        print("The application has exited background mode")
//        exit(-1)
    }
    
    public func setViewSettingWithBgShade(view: UIView)
    {
        //MARK:- Shade a view
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
    }
    
    func displayAlert(message:String){
        AppConstant.saveInDefaults(key: StringConstant.messageAlert, value: message)
        self.showMiracle()
    }
    
    func displayAlert(title:String, message:String){
        AppConstant.saveInDefaults(key: StringConstant.messageAlert, value: message)
        self.showMiracle()
    }
    
    @objc func showAlert(message:String) {
        AppConstant.saveInDefaults(key: StringConstant.messageAlert, value: message)
        self.showMiracle()
    }
    
    @objc func showMiracle() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func setplaceHolderColor(txtFld: UITextField, placeholder: String){
        txtFld.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
    }
    
    func setTextRequireForForm(lblName: UILabel, strName: String){
        let lenght:Int = strName.count - 1
        let strNameRequire = NSMutableAttributedString(string: strName)
        strNameRequire.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lenght, length: 1))
        lblName.attributedText = strNameRequire
    }
    
    func setFirstTextRequireForForm(lblName: UILabel, strName: String){
        let lenght:Int = 0
        let strNameRequire = NSMutableAttributedString(string: strName)
        strNameRequire.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lenght, length: 1))
        lblName.attributedText = strNameRequire
    }
    
    func setPositionTextRequireForForm(lblName: UILabel, strName: String, start:Int, length:Int){
        let strNameRequire = NSMutableAttributedString(string: strName)
        strNameRequire.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: start, length: length))
        lblName.attributedText = strNameRequire
    }
    
    //MARK: Service Call
    func isTokenVerified(completion: @escaping (_ isTknVerified : Bool) -> ()) {
        var appTokenType: String = ""
        var appToken: String = ""
        if AppConstant.hasConnectivity() {
            AppConstant.showHUD()
            let params: Parameters = [
                "pstToken": AppConstant.retrievFromDefaults(key: StringConstant.appToken),
                "pstAppID": StringConstant.appID,
                "pstSignature": AppConstant.GetSignature(),
            ]
            print("params===\(params)")
            AFManager.request( AppConstant.validateTokenUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if let dict = response.result.value as? [String: Any] {
                            if let status = dict["status"] as? String {
                                if (status == "1") {//success
                                    if let tokenArray = dict["Token"] as?
                                        [[String:AnyObject]] {
                                        if let token = tokenArray[0]["Token"] as? String {
                                            AppConstant.saveInDefaults(key: StringConstant.appToken, value: token)
                                            appToken = token
                                        }
                                        if let tokenType = tokenArray[0]["Token_type"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.appTokenType, value: tokenType)
                                            appTokenType = tokenType
                                        }
                                        AppConstant.saveInDefaults(key: StringConstant.authorization, value: appTokenType + " " + appToken)
                                        AppConstant.saveInDefaults(key: StringConstant.isTokenVerified, value: StringConstant.YES)
                                        completion(true)
                                    }
                                } else {
                                    completion(false)
                                    if let msg = dict["Message"] as? String {
                                        AppConstant.showAlertAppConstant(strTitle: "Error", strDescription: msg, delegate: nil)
                                    }
                                }
                            } else {
                                completion(false)
                                if let msg = dict["Message"] as? String {
                                    AppConstant.showAlertAppConstant(strTitle: "Error", strDescription: msg, delegate: nil)
                                    if msg == StringConstant.autoLogoutMsg {
                                        //Logout
                                        AppConstant.removeSavedDataAndNavigateToLoginPage()
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        completion(false)
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.validateTokenUrl)
                        break
                    }
            }
        } else {
            self.displayAlert(message: "Please check your internet connection.")
            completion(false)
        }
    }
    
    func serviceCallToLogout() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.postInvalidateTokenUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Header === \(headers)")

            AFManager.request( AppConstant.postInvalidateTokenUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if (headerStatusCode == 401) {//Session expired
                            //Logout
                            AppConstant.removeSavedDataAndNavigateToLoginPage()
                        } else {
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            if let status = dict?["status"] as? String {
                                if (status == "1") {//Success
                                    AppConstant.removeSavedDataAndNavigateToLandingPage()
                                } else {//Failure
                                    if let msg = dict?["Message"] as? String {
                                        self.displayAlert(message: msg)
                                    }
                                }
                            } else {
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postInvalidateTokenUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postInvalidateTokenUrl)
                        break  
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func logOut() {
        self.serviceCallToLogout()
    }

    //@ade: start
    func serviceCallToLogoutWithCompletion(completion: @escaping (Bool) -> ()) {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.postInvalidateTokenUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Header === \(headers)")

            AFManager.request( AppConstant.postInvalidateTokenUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if (headerStatusCode == 401) {//Session expired
                            //Logout
                            AppConstant.removeSavedDataAndNavigateToLoginPage()
                            completion(false)
                        } else {
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            if let status = dict?["status"] as? String {
                                if (status == "1") {//Success
                                    AppConstant.removeSavedDataAndNavigateToLandingPage()
                                    completion(true)
                                } else {//Failure
                                    if let msg = dict?["Message"] as? String {
                                        self.displayAlert(message: msg)
                                    }
                                    completion(false)
                                }
                            } else {
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postInvalidateTokenUrl)
                                completion(false)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postInvalidateTokenUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func logOutAndSwitchUser(completion: @escaping (Bool) -> ()) {
        self.serviceCallToLogoutWithCompletion(completion: completion)
    }
    //@ade: end

    //MARK: Touch Id Authentication
    func isTouchIdSupportedOnDevice()-> Bool{
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            // Biometry is available on the device
            if #available(iOS 11.0, *) {
                if context.biometryType == LABiometryType.touchID {
                    // Device supports Touch ID
                    return true
                }
                else {
                    // Device has no biometric support
                    self.displayAlert(message: StringConstant.touchIDValidationMsg)
                    return false
                }
            }
            return true
        } else {
            // Biometry is not available on the device
            // No hardware support or user has not set up biometric auth
            if let err = error {
                print(err.code)
                print(err.description)
                if #available(iOS 11.0, *) {
                    switch err.code{
                    case LAError.Code.biometryNotEnrolled.rawValue:
                        self.displayAlert(message: StringConstant.userNotEnrolledMsg)
                    case LAError.Code.passcodeNotSet.rawValue:
                        self.displayAlert(message: StringConstant.passcodeNotSetMsg)
                    case LAError.Code.biometryNotAvailable.rawValue:
                        self.displayAlert(message: StringConstant.touchIDValidationMsg)
                    default://Unknown error
                        //AppConstant.showAlert(strTitle: err.description, delegate: self)
                        let reason:String = "TouchID has been locked out due to too many fail attempt. Enter iPhone passcode to enable TouchID again.";
                        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason,
                                               reply: { (success, error) in
                                                if success{
                                                    self.displayAlert(message: "TouchID is now available to use.")
                                                }
                        })
                        return true
                    }
                } else {
                    // Fallback on earlier versions
                    self.displayAlert(message: StringConstant.touchIDValidationMsg)
                }
            }
            return false
        }
    }
    
    func registerDeviceToken(completion: @escaping (_ isResult : Bool) -> ()) {
            let apnsId = AppConstant.retrievFromDefaults(key: StringConstant.deviceToken)
            let voipId = AppConstant.retrievFromDefaults(key: StringConstant.voip_Token)
            let json = "{\"pstDeviceId\":\"\(apnsId)\",\"pstDeviceName\":\"\(StringConstant.iOS)\",\"pstVoipToken\":\"\(voipId)\"}"
            let url = URL(string: AppConstant.update_device_token_url)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            if apnsId != "" {
                Alamofire.request(request).responseJSON {
                    (response) in
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.registerDeviceToken(completion: { (Bool) in })
                                }
                            })
                        }else{
                            let dict = response.result.value as! [String : AnyObject]
                            if let status = dict["Status"] as? String {
                                if(status == "1"){//success
                                    //Save in Defaults
                                    AppConstant.saveInDefaults(key: StringConstant.isVOIPTokenUpdated, value: StringConstant.YES)
                                    print("Device token saved in server")
                                    completion(true)
                                }else {
                                    print("Failed to save device token in server")
                                    self.displayAlert(message: "Failed to save device token in server")
                                    completion(false)
                                }
                            }
                        }
                        break
                    case .failure(_):
                        self.displayAlert(message: "Failed to save device token in server")
                        completion(false)
                        break
                    }
                }
            }
            completion(false)
        }
    
    func isNotNullOrNil(_ string:String)->Bool{
        return string != "" && string != nil && string != "null" && string != "NULL" ? true : false
    }
    
}

extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension UIAlertController {

  //Set background color of UIAlertController
  func setBackgroudColor(color: UIColor) {
    if let bgView = self.view.subviews.first,
      let groupView = bgView.subviews.first,
      let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  //Set title font and title color
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
          attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
            range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
          attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
            range: NSMakeRange(0, title.utf8.count))
        }
        let textRange = NSRange(location: 0, length: title.utf8.count)
        attributeString.addAttribute(.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: textRange)
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }

  //Set message font and message color
    func setMessageTitle(font: UIFont?, color: UIColor?, titleString:String, fontTitle: UIFont?, colorTitle: UIColor?) {
        guard let title = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        
        let range = (title as NSString).range(of: titleString)
        if let titleFont = fontTitle {
            attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: range)
        }
        if let titleColor = colorTitle {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: range)
        }
        self.setValue(attributedString, forKey: "attributedMessage")
    }
    
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let title = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributedString, forKey: "attributedMessage")//4
    }

  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}
