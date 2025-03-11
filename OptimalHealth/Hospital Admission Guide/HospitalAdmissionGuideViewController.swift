//
//  HospitalAdmissionGuideViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 9/3/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import WebKit

class HospitalAdmissionGuideViewController: BaseViewController , WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var videoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoViewHide: UIView!
    
    var webView: WKWebView!
    var strAdmissionUrl : String! = ""
    var strDischargeUrl : String! = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesigns()
    }
    
    func initDesigns() {
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.videoViewHeightConstraint.constant = 0
        self.videoViewHide.isHidden = true
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        
        //showHospitalGuideData()
        serviceCallToGetHospitalGuide()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }

    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        AppConstant.hideHUD()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        AppConstant.hideHUD()
    }
    
    func loadInWebView(url: String){
        if url != ""{
            AppConstant.showHUD()
            let url = URL(string: url)
            webView.isHidden = false
            webView.load(URLRequest(url: url!))
        }
    }
    
    func showHospitalGuideData() {
        do {
            guard let filePath = Bundle.main.path(forResource: "index", ofType: "html")
                else {
                    // File Error
                    print ("File reading error")
                    return
            }
            
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.isHidden = false
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func watchVideoAdmissionProcessBtnAction (_ sender: UIButton) {
    }
    
    @IBAction func watchVideoDischargeProcessBtnAction (_ sender: UIButton) {
    }
    
    //MARK: Service Call
    func serviceCallToGetHospitalGuide() {
        
        if(AppConstant.hasConnectivity()) {//true connected
            
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            print("URL===\(AppConstant.getHospitalGuideUrl)")
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.getHospitalGuideUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetHospitalGuide()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "0"){
                                    if let msg = dict?["Message"] as? String{
                                        self.videoViewHeightConstraint.constant = 0
                                    }
                                    
                                }else  if(status == "1"){//success
                                    
                                    if let path = dict?["FullPath"] as? String{
                                        self.loadInWebView(url: path)
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getHospitalGuideUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getHospitalGuideUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

}
