//
//  ViewWazeMapViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/17/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import WebKit

class ViewWazeMapViewController: UIViewController , WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var webView: WKWebView!
    var latitude = ""
    var longitude = ""

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
        
        latitude = AppConstant.selectedPanelProvider.latitude
        longitude = AppConstant.selectedPanelProvider.longitude
        loadWithWebView()
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
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //AppConstant.showHUD()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppConstant.hideHUD()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        AppConstant.hideHUD()
    }
    
    func loadWithWebView(){
        AppConstant.showHUD()
        
//        let strHtml = "<iframe width=\(AppConstant.screenSize.width - 15) height=\(AppConstant.screenSize.height - 64) src=\"https://embed.waze.com/iframe?zoom=12&lat=\(latitude)&lon=\(longitude)&pin=1\"frameborder=\"0\" allowfullscreen></iframe>"
//        webView.loadHTMLString(strHtml, baseURL: nil)
        
        let url = URLRequest(url: URL(string: "https://embed.waze.com/iframe?zoom=12&lat=\(latitude)&lon=\(longitude)&pin=1")!)
        webView.load(url)
    }
    

}
