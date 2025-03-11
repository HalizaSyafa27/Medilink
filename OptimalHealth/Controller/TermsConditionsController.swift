//
//  TermsConditionsController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/3/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class TermsConditionsController: BaseViewController , WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesigns()
    }
    
    func initDesigns() {
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        
        self.webView.isHidden = true
        if (AppConstant.isSlidingMenu == true) {
            backBtn?.setImage(UIImage(named : "menu") , for: .normal)
        }
        else {
            backBtn?.setImage(UIImage(named : "left_arrow") , for: .normal)
        }
        
        serviceCallToShowTermsConditions()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WebView Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        AppConstant.hideHUD()
    }
    
    func loadInWebView(url: String){
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Service Call
    func serviceCallToShowTermsConditions() {
        if (AppConstant.hasConnectivity()) {//true connected
            webView.isHidden = true
            AppConstant.showHUD()
            
            print("url===\(AppConstant.termsUrl)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.termsUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        // debugPrint(dict)
                        
                        if let status = dict?["Status"] as? String {
                            if (status == "0") {
                                AppConstant.hideHUD()
                                let msg = dict?["Message"] as? String
                                self.displayAlert(message: msg ?? "")
                            } else {//success
                                if let fullPath = dict?["FullPath"] as? String {
                                    self.webView.isHidden = false
                                    self.loadInWebView(url: fullPath)
                                }
                            }
                        } else {
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.termsUrl)
                        }
                        break
                    case .failure(_):
                        AppConstant.hideHUD()
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.termsUrl)
                        break
                    }
            }
        } else {
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
}

