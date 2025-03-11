//
//  LogoutPopupViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 10/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class LogoutPopupViewController: BaseViewController {
    
    @IBOutlet var btnRadioLogout: UIButton!
    @IBOutlet var btnRadioKeepSession: UIButton!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    
    @IBOutlet weak var viewRadioGroup: UIView!
    
    var landingViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initDesign()
        //@ade: start
        let uid = AppConstant.retrievFromDefaults(key: StringConstant.email)
        if (AppConstant.isExternalUser(userId: uid)) {
            viewRadioGroup.frame.size.height = 0
            viewRadioGroup.isHidden = true
        }
        //@ade: end
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will apper called")
    }
    
    func initDesign() {
        viewContainer.layer.cornerRadius = 3
        viewContainer.clipsToBounds = true
        btnRadioLogout.isSelected = true
        self.btnOk.layer.cornerRadius = 4
        self.btnCancel.layer.cornerRadius = 4
    }
    
    //MARK: Button Action
    @IBAction func btnCancelAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
        if btnRadioLogout.isSelected == true {
            self.willMove(toParent: nil)
            self.removeFromParent()
            self.view.removeFromSuperview()
            AppConstant.isSlidingMenu = false
            self.logOut()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.hideLogoutPopupNotification), object: nil)
            self.willMove(toParent: nil)
            self.removeFromParent()
            self.view.removeFromSuperview()
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
    }
    
    @IBAction func btnExitAndLogoutAction(_ sender: Any) {
        btnRadioLogout.isSelected = true
        btnRadioKeepSession.isSelected = false
    }
    
    @IBAction func btnExitAndKeepSessionAction(_ sender: Any) {
        btnRadioLogout.isSelected = false
        btnRadioKeepSession.isSelected = true
    }
    
    //MARK: Service call
//    func serviceCallToLogout(){
//        if(AppConstant.hasConnectivity()) {//true connected
//
//            AppConstant.showHUD()
//            let userName = AppConstant.retrievFromDefaults(key: StringConstant.email)
//
//            let params: Parameters = [
//                "UserID": userName
//            ]
//
//            print("params===\(params)")
//            print("url===\(AppConstant.logOutUrl)")
//
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
//            AFManager.request( AppConstant.logOutUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
//                .responseString { response in
//                    AppConstant.hideHUD()
//                    debugPrint(response)
//
//                    switch(response.result) {
//                    case .success(_):
//
//                        let headerStatusCode : Int = (response.response?.statusCode)!
//                        print("Status Code: \(headerStatusCode)")
//
//                        if(headerStatusCode == 401){//Session expired
//                            self.isTokenVerified(completion: { (Bool) in
//                                if Bool{
//                                    self.serviceCallToLogout()
//                                }
//                            })
//                        }else{
//                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
//                            //  debugPrint(dict)
//
//                            if dict!["message"] as! String == "success"{
//                                AppConstant.isSlidingMenu = false
//                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.hideLogoutPopupNotification), object: nil)
//                                AppConstant.logOut()
//                                //self.logout()
//                            }else{
//                                self.displayAlert(message: StringConstant.tryAgainLaterMsg)
//                            }
//                        }
//
//                        break
//
//                    case .failure(_):
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.logOutUrl)
//                        break
//
//                    }
//            }
//
//        }else{
//            self.displayAlert(message: "Please check your internet connection.")
//        }
//    }
    
    func logout() {
        AppConstant.isSlidingMenu = false
        //Remove Data
        AppConstant.removeFromDefaults(key: StringConstant.isLoggedIn)
        AppConstant.removeFromDefaults(key: StringConstant.policyBackUpData)
        AppConstant.removeFromDefaults(key: StringConstant.email)
        AppConstant.removeFromDefaults(key: StringConstant.password)
        AppConstant.removeFromDefaults(key: StringConstant.roleDesc)
        AppConstant.removeFromDefaults(key: StringConstant.profileImageUrl)
        AppConstant.removeFromDefaults(key: StringConstant.name)
        AppConstant.removeFromDefaults(key: StringConstant.lastVisited)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
