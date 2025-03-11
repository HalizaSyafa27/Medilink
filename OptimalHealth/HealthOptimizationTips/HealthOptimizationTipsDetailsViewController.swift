//
//  HealthOptimizationTipsDetailsViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 11/22/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import WebKit

class HealthOptimizationTipsDetailsViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var btnHomeBack: UIButton!
    var webView: WKWebView!

    var selectedHealthTips = HealthTipsBo()
    var isFromHealthTips : Bool = false
    var pageHeader = ""
    var imgHeader = ""

    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        
        if selectedHealthTips.htmlPath! != ""{
            AppConstant.showHUD()
            loadInWebView(url: selectedHealthTips.htmlPath!)
        }else{
            self.displayAlert(message: "Page could not be loaded.")
        }
        
        if  isFromHealthTips == true {
             btnHomeBack.setImage(UIImage(named: "left_arrow"), for: UIControl.State.normal)
        }else{
             btnHomeBack.setImage(UIImage(named: "home"), for: UIControl.State.normal)
        }
        
        webView.scrollView.delegate = self
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
    @IBAction func backBtnAction (_ sender: UIButton) {
        if  isFromHealthTips == true {
            _ = self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        AppConstant.hideHUD()
    }
    
    func loadInWebView(url: String){
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
    }
    
    //MARK: Disable zooming in webView
    func viewForZooming(in: UIScrollView) -> UIView? {
        return nil
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollView.setZoomScale(1.0, animated: false)
    }

}
