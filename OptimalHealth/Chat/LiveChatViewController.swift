//
//  LiveChatViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/01/19.
//  Copyright © 2019 Oditek. All rights reserved.
//
import UIKit
import Alamofire
import WebKit
import QiscusMultichannelWidget

class LiveChatViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnStartChat: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var webView: WKWebView!
    var isFromLandingPage: Bool = false
    
    var strPdfBase64: String = ""
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        txtName.text = AppConstant.retrievFromDefaults(key: StringConstant.displayName)
        txtEmail.text = AppConstant.retrievFromDefaults(key: StringConstant.emailAddress)
        self.btnStartChat.layer.cornerRadius = self.btnStartChat.frame.height/2
        self.btnStartChat.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func StartChat(_ sender: UIButton) {
  
        if txtName.text == ""{
            self.displayAlert(message: "Please enter Your Name")
        }else if txtEmail.text == ""{
            self.displayAlert(message: "Please enter Your Email")
        }else{
            AppConstant.saveInDefaults(key: StringConstant.chatUserName, value: AppConstant.retrievFromDefaults(key: StringConstant.email))
            AppConstant.saveInDefaults(key: StringConstant.chatName, value: txtName.text! )
            AppConstant.saveInDefaults(key: StringConstant.chatEmail, value: txtEmail.text!)
            ChatManager.shared.setUser(id: txtEmail.text!, displayName: txtName.text!, avatarUrl: StringConstant.avatarUrl)
            ChatManager.shared.startChat(from: self)
        }
    }
    //    func initDesigns() {
//
//        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())
//
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        self.viewContainer.addSubview(webView)
//        self.webView.isHidden = false
//
//
//        if(AppConstant.hasConnectivity()) {//true connected
//            //load web page in web view
//            AppConstant.showHUD()
//            loadInWebView(url: AppConstant.chat_url)//"https://unsplash.com/images"
//        }else{
//            self.displayAlert(message: "Please check your internet connection.")
//        }
//
//        if isFromLandingPage{
//            btnHome.isHidden = true
//        }
//
//        webView.scrollView.delegate = self
//    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        webView.frame = self.viewContainer.bounds
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
//    func loadInWebView(url: String){
//        let url = URL(string: url)
//        webView.load(URLRequest(url: url!))
//    }
//
//    //MARK: WKWebview Delegates
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("Navigation url called")
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        AppConstant.hideHUD()
//        self.webView.isHidden = false
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        AppConstant.hideHUD()
//        AppConstant.showNetworkAlertMessage(apiName: AppConstant.chat_url)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//        if let url = navigationAction.request.url{
//            print("navigation url===\(url)")
//
//            if (url.pathExtension == "pdf" || url.pathExtension == "doc" || url.pathExtension == "docx" || url.pathExtension == "xls" || url.pathExtension == "xlsx" || url.pathExtension == "ppt" || url.pathExtension == "pptx" || url.pathExtension == "txt"){//pdf file
//
//                downloadFile(url: url)
//                UIApplication.shared.open(url)
//
//                decisionHandler(.cancel)
//            }else if (url.pathExtension == "jpeg" || url.pathExtension == "png" || url.pathExtension == "jpg"){//Image
//                DispatchQueue.main.async {
//                    AppConstant.showHUD()
//                }
//                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//                }
//
//                UIApplication.shared.open(url)
//
//                decisionHandler(.cancel)
//            }else{
//                decisionHandler(.allow)
//            }
//        }
//
//    }
//
//    //MARK: Download File
//    func downloadFile(url downloadUrl : URL) {
//        DispatchQueue.main.async {
//            AppConstant.showHUD()
//        }
//
//        FileDownloader.loadFileAsync(url: downloadUrl) { (path, error) in
//            DispatchQueue.main.async {
//                AppConstant.hideHUD()
//            }
//
//            if error != nil{
//                self.displayAlert(message: error!.localizedDescription)
//            }else{
//                let msg = "Downloaded Successfully\n File saved to: On My iPhone/Optimal Health/\(downloadUrl.lastPathComponent)"
//                self.displayAlert(message: msg)
//            }
//            print("PDF File downloaded to : \(path!)")
//        }
//
//    }
//
//    //MARK: Download Image
//    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        DispatchQueue.main.async {
//            AppConstant.hideHUD()
//        }
//
//        if let error = error {
//            self.displayAlert(message: error.localizedDescription)
//        } else {
//            self.displayAlert(message: "Image has been saved to your photos.")
//        }
//    }
//
//    //MARK: Disable zooming in webView
//    func viewForZooming(in: UIScrollView) -> UIView? {
//        return nil
//    }
//
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        scrollView.setZoomScale(1.0, animated: false)
//    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: Any) {
//        ChatManager.shared.signOut()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoHomeScreen()
     
    }
    
//    @IBAction func btnHomeAction(_ sender: UIButton) {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    
    /*
    // MARK: - Navigation
     
     
     
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension String {
    func getPathExtension() -> String {
        return (self as NSString).pathExtension
    }
}
