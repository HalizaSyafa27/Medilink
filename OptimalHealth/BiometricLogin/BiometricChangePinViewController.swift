//
//  BiometricChangePinViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 18/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class BiometricChangePinViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet var txtFldOldPin: UITextField!
    @IBOutlet var txtFldNewPin: UITextField!
    @IBOutlet var txtFldCnfPin: UITextField!
    @IBOutlet var btnUpdatePin: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnOldPin: UIButton!
    @IBOutlet weak var btnNewPin: UIButton!
    @IBOutlet weak var btnConfirmPin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
    }
    
    func initDesign(){
        self.txtFldOldPin.becomeFirstResponder()
//        btnUpdatePin.layer.cornerRadius = 5.0
//        btnUpdatePin.clipsToBounds = true
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnUpdatePinAction(_ sender: Any) {
        if self.txtFldOldPin?.text == "" {
            self.displayAlert(message: StringConstant.enterOldpinMsg)
        }else if self.txtFldNewPin?.text == "" {
            self.displayAlert(message: StringConstant.enterNewPinMsg)
        }else if self.txtFldCnfPin?.text == "" {
            self.displayAlert(message: StringConstant.enterCnfPinMsg)
        }
        else if self.txtFldNewPin?.text != self.txtFldCnfPin?.text {
            self.displayAlert(message: StringConstant.pinNotMatchValidation)
        }
        else{
            servicecallToUpdatePin()
//            serviceCallToVerifyPin()
        }
    }
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOldPin(_ sender: UIButton) {
        self.txtFldOldPin.isSecureTextEntry = !self.txtFldOldPin.isSecureTextEntry
        if !txtFldOldPin.isSecureTextEntry {
            self.btnOldPin.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnOldPin.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    @IBAction func btnNewPin(_ sender: UIButton) {
        self.txtFldNewPin.isSecureTextEntry = !self.txtFldNewPin.isSecureTextEntry
        if !txtFldNewPin.isSecureTextEntry {
            self.btnNewPin.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnNewPin.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    @IBAction func btnConfirmPin(_ sender: UIButton) {
        self.txtFldCnfPin.isSecureTextEntry = !self.txtFldCnfPin.isSecureTextEntry
        if !txtFldCnfPin.isSecureTextEntry {
            self.btnConfirmPin.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnConfirmPin.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    // MARK: - Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // MARK: - Service call Method
    func servicecallToUpdatePin(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let params: Parameters = [
                "pstoldPin": txtFldOldPin.text!,
                "pstNewPin": txtFldNewPin.text!
            ]
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            print("params===\(params)")
            print("url===\(AppConstant.updateTouchIDUrl)")
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.updateTouchIDUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.servicecallToUpdatePin()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    if let msg = dict?["Message"] as? String{
                                        self.alert(Message:msg)
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.updateTouchIDUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.updateTouchIDUrl)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

    //MARK: Service Call Method
    func serviceCallToVerifyPin(){
        let headers: HTTPHeaders = [
            "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
            "Accept": "application/json"
        ]
        if(AppConstant.hasConnectivity()) {//true connected
            let params: Parameters = [
                "pstPin":txtFldOldPin.text!
            ]
            print("params===\(params)")
            print("url===\(AppConstant.touchIdLoginUrl)")
            AppConstant.showHUD()
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.touchIdLoginUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToVerifyPin()
                                }
                            })
                        }else{
                            let dictRes = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dictRes?["status"] as? String {
                                if(status == "1"){
                                    self.servicecallToUpdatePin()
                                }else{
                                    if let msg = dictRes?["message"] as? String{
                                        self.displayAlert(message: "Old \(msg)")
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
    
    func alert(Message:String) {
        let alert = UIAlertController(title: "Change Pin", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                    AppConstant.removeSavedDataAndNavigateToLandingPage()
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
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
