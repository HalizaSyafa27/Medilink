//
//  DisclaimerViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 06/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class DisclaimerViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    var webView: WKWebView!
    var pageType:String = ""
    var isFromHomePage: Bool = false
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lblTitlePage: UILabel!
    
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
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        self.webView.isHidden = false
        if(pageType == "Disclaimer"){
            self.iconImage.image = UIImage.init(named: "disclaimer_gray")
            self.lblTitlePage.text = "Disclaimer"
            self.loadInWebView(url: "https://medilink.co.id/disclaimer/")
        }else if(pageType == "ContactUs"){
            self.iconImage.image = UIImage.init(named: "call")
            self.lblTitlePage.text = "Contact Us"
            self.loadInWebView(url: "https://medilink.co.id/contact-us/")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
        webView.contentMode = .scaleToFill
    }
    
//    func loadWithWebView(){
//        let strHtml = "<h3>Disclaimer for Downloading and Accessing Mobile Apps</h3><div align='justify'>Message and data rates may apply for downloading and accessing mobile application features and content. By downloading this mobile application you represent that you are the account holder for the device or have the account holder's permission to download. You shall be responsible for obtaining and maintaining all telephone, computer hardware and other equipment needed for access to and use of the Services and all charges related thereto </div> <div align='justify'>You expressly agree that use of this mobile application (herein referred to as the Service) is at your sole risk. Neither TABC nor any of their respective employees, agents, third party content providers or licensors warrant that the Service will be uninterrupted or error free; nor do they make any warranty as to the results that may be obtained from use of the Service, or from the information contained therein, or as to the accuracy or reliability of any information or service provided through the Service.</div> <div align='justify'>The Service is provided on an “as is” basis without warranties of any kind, either express or implied, including but not limited to, warranties of title or implied warranties of merchantability or fitness for a particular purpose, other than those warranties which are implied by and incapable of exclusion, restriction or modification under applicable law. Additionally, there are no warranties as to the results obtained from the use of the Service.</div>"
//
//        webView.loadHTMLString(strHtml, baseURL: nil)
//    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppConstant.hideHUD()
    }
    
    func loadInWebView(url: String){
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
    }
    
    //MARK: Service Call
//    func serviceCallToShowDisclaimer(){
//        if(AppConstant.hasConnectivity()) {//true connected
//            webView.isHidden = true
//            AppConstant.showHUD()
//            print("url===\(AppConstant.disclaimerUrl)")
//            AFManager.request( AppConstant.disclaimerUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil)
//                .responseString { response in
//                    debugPrint(response)
//
//                    switch(response.result) {
//                    case .success(_):
//                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
//                        // debugPrint(dict)
//
//                        if let status = dict?["Status"] as? String {
//                            if(status == "1"){//success
//                                //https://ssl.e-medilink.com/Medilink/Website/EccsMember17/Forms/aboutus.html
//                                if let fullPath = dict?["FullPath"] as? String{
//                                    self.webView.isHidden = false
//                                    self.loadInWebView(url: fullPath)
//                                }
//                            }else{
//                                AppConstant.hideHUD()
//                                let msg = dict?["Message"] as? String
//                                self.displayAlert(message: msg ?? "")
//                            }
//                        }else{
//                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.disclaimerUrl)
//                        }
//
//                        break
//
//                    case .failure(_):
//                        AppConstant.hideHUD()
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.disclaimerUrl)
//                        break
//
//                    }
//            }
//
//        }else{
//            self.displayAlert(message: "Please check your internet connection.")
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
