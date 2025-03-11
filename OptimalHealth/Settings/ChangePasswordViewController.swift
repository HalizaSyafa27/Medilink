//
//  ChangePasswordViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 13/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet var txtFldOldPassword: UITextField!
    @IBOutlet var txtFldNewPassword: UITextField!
    @IBOutlet var txtFldCnfPassword: UITextField!
    @IBOutlet var btnUpdatePassword: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnOdPass: UIButton!
    @IBOutlet weak var btnNewPass: UIButton!
    @IBOutlet weak var btnConfirmPass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
    }
    
    func initDesign(){
        self.txtFldOldPassword.becomeFirstResponder()
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        txtFldOldPassword.setplaceHolderColor(placeholder: "Old Password")
        txtFldNewPassword.setplaceHolderColor(placeholder: "New Password")
        txtFldCnfPassword.setplaceHolderColor(placeholder: "Confirm Password")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Action
    @IBAction func btnUpdatePasswordAction(_ sender: Any) {
        if self.txtFldOldPassword?.text == "" {
            self.displayAlert(message: StringConstant.enterOldPwdMsg)
        }else if self.txtFldNewPassword?.text == "" {
            self.displayAlert(message: StringConstant.enterNewPwdMsg)
        }else if self.txtFldCnfPassword?.text == "" {
            self.displayAlert(message: StringConstant.enterCnfPwdMsg)
        }else if self.txtFldCnfPassword?.text != self.txtFldNewPassword?.text {
            self.displayAlert(message: StringConstant.passwordNotMatchValidation)
        }else{
            //Api call to Update Password
            servicecallToUpdatePassword()
        }
    }
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnOldPass(_ sender: UIButton) {
        self.txtFldOldPassword.isSecureTextEntry = !self.txtFldOldPassword.isSecureTextEntry
        if !txtFldOldPassword.isSecureTextEntry {
            self.btnOdPass.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnOdPass.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    @IBAction func btnNewPass(_ sender: UIButton) {
        self.txtFldNewPassword.isSecureTextEntry = !self.txtFldNewPassword.isSecureTextEntry
        if !txtFldNewPassword.isSecureTextEntry {
            self.btnNewPass.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnNewPass.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    @IBAction func btnConfirmPass(_ sender: UIButton) {
        self.txtFldCnfPassword.isSecureTextEntry = !self.txtFldCnfPassword.isSecureTextEntry
        if !txtFldCnfPassword.isSecureTextEntry {
            self.btnConfirmPass.setImage(UIImage(named: "show_pass_gray.png"), for: .normal)
        }else{
            btnConfirmPass.setImage(UIImage(named: "hide_pass_gray.png"), for: .normal)
        }
    }
    
    // MARK: - Service call Method
    func servicecallToUpdatePassword(){
        if(AppConstant.hasConnectivity()) {//true connected
            
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            let params: Parameters = [
                "OldPassword": (self.txtFldOldPassword?.text)!,
                "NewPassword": (self.txtFldNewPassword?.text)!,
                //"UpdBy": userName,
                //"Email": "",
                //"MobileNo": "",
                //"Message":"",
                //"Status":""
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.changePasswordUrl)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.changePasswordUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.servicecallToUpdatePassword()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    let msg = dict?["Message"] as? String
                                    let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        AppConstant.removeSavedDataAndNavigateToLoginPage()
                                    }))
                                    alert.view.tintColor = AppConstant.themeRedColor
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.changePasswordUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.changePasswordUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }

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
