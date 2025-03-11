//
//  CovidViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/05/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import WebKit

class CovidViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {

    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    
    var webView: WKWebView!
    var classname = ""
    var myUrl = ""
    var headerImage = ""
    var headerTitle = ""
    
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
        
        if classname == StringConstant.covid19{
            imgViewHeader.image = UIImage.init(named: "covid")
            lblHeader.text = "Covid-19"
            myUrl = AppConstant.covid19Url
        }else if classname == StringConstant.WebMDSymptomChecker{
            imgViewHeader.image = UIImage.init(named: "webmdsymptomchecker_white")//headerImage
            lblHeader.text = headerTitle
            myUrl = AppConstant.webmdSymptomCheckerUrl
        }else if classname == StringConstant.E_marketplace{//E_Marketplace
            imgViewHeader.image = UIImage.init(named: "webmdsymptomchecker_white")
            lblHeader.text = headerTitle
            myUrl = AppConstant.e_marketPlaceUrl
        }
//        else if classname == StringConstant.selfDoctor{//Self Doctor
//            imgViewHeader.image = UIImage.init(named: "self_doctor")
//            lblHeader.text = "Self Doctor"
//            myUrl = AppConstant.selfDoctorUrl
//        }
        
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
//            if classname == StringConstant.selfDoctor{
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                     AppConstant.hideHUD()
//                }
//            }
            
            self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

            webView.uiDelegate = self
            webView.navigationDelegate = self
            self.viewContainer.addSubview(webView)
            loadInWebView(url: myUrl)
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
        
        webView.scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }
    
    //MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("load started")
        print("URL === \(webView.url)")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
