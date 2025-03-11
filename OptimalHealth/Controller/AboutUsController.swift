//
//  AboutUsController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/3/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class AboutUsController: BaseViewController , WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var aboutUsBtn: UIButton!
    @IBOutlet weak var servicesSolutionsBtn: UIButton!
    @IBOutlet weak var aboutUsUnderView: UIView!
    @IBOutlet weak var servicesSolutionsUnderView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var verticalSpacingWebWithTitle: NSLayoutConstraint!
    @IBOutlet weak var aboutUsServicesSectionView: UIView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var webView: WKWebView!
    
    var selectedBtnTag: Int! = 0
    var isAboutUsBtnSelected = false
    var isFromHomePage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        verticalSpacingWebWithTitle.constant = 0
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        
        loadInWebView(url: "https://medilink.co.id/profile/")
        aboutUsServicesSectionView.isHidden = false
        verticalSpacingWebWithTitle.constant = 47
        lblPageHeader?.text = "Optimal Health Info."
        imgViewHeader.image = UIImage.init(named: "aboutus_icon_gray")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func aboutUsServicesBtnAction (_ sender: UIButton) {
        let senderBtnTag = sender.tag
        selectedBtnTag = senderBtnTag
        if (selectedBtnTag == 0) {
            aboutUsUnderView.backgroundColor = AppConstant.themeRedColor
            servicesSolutionsUnderView.backgroundColor = UIColor.clear
            isAboutUsBtnSelected = true
            loadInWebView(url: "https://medilink.co.id/profile/")
        }
        else if (selectedBtnTag == 1) {
            servicesSolutionsUnderView.backgroundColor = AppConstant.themeRedColor
            aboutUsUnderView.backgroundColor = UIColor.clear
            isAboutUsBtnSelected = false
            loadInWebView(url: AppConstant.productAndSericesUrl)
            
        }
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        AppConstant.hideHUD()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStart")
        AppConstant.showHUD()
    }
    
    func loadInWebView(url: String){
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
        self.webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         AppConstant.hideHUD()
    }
    
    //MARK: Service Call
//    func serviceCallToShowAboutUs(){
//        if(AppConstant.hasConnectivity()) {//true connected
//            webView.isHidden = true
//            AppConstant.showHUD()
//            print("url===\(AppConstant.aboutUsUrl)")
//            AFManager.request( AppConstant.aboutUsUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil)
//                .responseString { response in
//                    //AppConstant.hideHUD()
//                    debugPrint(response)
//                    switch(response.result) {
//                    case .success(_):
//                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
//                        if let status = dict?["Status"] as? String {
//                            if(status == "0"){
//                                AppConstant.hideHUD()
//                                let msg = dict?["Message"] as? String
//                                self.displayAlert(message: msg ?? "")
//                            }else{//success
//                                if let fullPath = dict?["FullPath"] as? String{
//                                    self.webView.isHidden = false
//                                    self.loadInWebView(url: fullPath)
//                                }
//                            }
//                        }else{
//                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.aboutUsUrl)
//                        }
//
//                        break
//
//                    case .failure(_):
//                        AppConstant.hideHUD()
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.aboutUsUrl)
//                        break
//
//                    }
//            }
//
//        }else{
//            self.displayAlert(message: "Please check your internet connection.")
//        }
//    }

}
