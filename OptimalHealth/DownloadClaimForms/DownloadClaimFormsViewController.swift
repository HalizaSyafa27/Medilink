//
//  DownloadClaimFormsViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 08/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class DownloadClaimFormsViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate{
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    var webView: WKWebView!
    
    var pageTitle = ""
    var strPath: String = ""
    var className:String = ""
    var fileName:String = ""
    var url: URL? = nil
    var urlToOpen = ""
    var strPdfBase64: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initDesign()
        if className == StringConstant.downloadClaimForms{
            serviceCallToGetClaimsFormFile()
        }else{
            serviceCallToShowDownloadClaimForms()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }
    
    func initDesign(){
        lblPageHeader.text = pageTitle
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppConstant.hideHUD()
        self.webView.isHidden = false
    }
    
    func loadInWebView(url: String){
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
    }
    
    func showPdf(strData:String, filename: String) {
        
        self.url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        if let data = NSData(base64Encoded: strData, options: NSData.Base64DecodingOptions(rawValue: 0)){
            do {
                try data.write(to: url!, options: .atomic)
            } catch {
                print(error)
            }
            webView.isHidden = false
            webView.load(URLRequest(url: url!))
            self.urlToOpen = url!.absoluteString
        }else{
            AppConstant.hideHUD()
            webView.isHidden = false
        }
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnDownloadAction(_ sender: Any) {
        if className == StringConstant.downloadClaimForms{
            downloadFile()
        }else{
            guard let url = URL(string: strPath) else{
                self.displayAlert(message: "File path not found")
                return
            }
            FileDownloader.loadFileAsync(url: url) { (path, error) in
                if error != nil{
                    self.displayAlert(message: error!.localizedDescription)
                }else{
                    self.displayAlert(message: "Downloaded Successfully\nFile saved to: On My iPhone/Optimal Health/\(url.lastPathComponent)")
                }
                print("PDF File downloaded to : \(path!)")
            }
        }
    }
    
    func downloadFile() {

        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(self.fileName)
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if let data = NSData(base64Encoded: self.strPdfBase64, options: NSData.Base64DecodingOptions(rawValue: 0)){
            do {
                try data.write(to: destinationUrl, options: .atomic)
            } catch {
                self.displayAlert(message: error.localizedDescription)
                print(error)
            }
            self.displayAlert(message: "Downloaded Successfully\nFile saved to: On My iPhone/Optimal Health/\(url.lastPathComponent)")
        }else{
            self.displayAlert(message: "Error Downloading...")
        }
        
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Alert Method
    func downloadAlert() {
        let alertController = UIAlertController(title: "Title", message: "Loading...", preferredStyle: .alert)

        let progressDownload : UIProgressView = UIProgressView(progressViewStyle: .default)

            progressDownload.setProgress(5.0/10.0, animated: true)
            progressDownload.frame = CGRect(x: 10, y: 70, width: 250, height: 0)

        alertController.view.addSubview(progressDownload)
        
        alertController.view.tintColor = AppConstant.themeRedColor
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Service call
    func serviceCallToShowDownloadClaimForms(){
        if(AppConstant.hasConnectivity()) {//true connected
            webView.isHidden = true
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            print("url===\(AppConstant.downloadClaimFormsUrl)")
            AFManager.request( AppConstant.downloadClaimFormsUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToShowDownloadClaimForms()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    if let arrRes = dict?["DownloadList"] as? [[String: Any]]{
                                        if arrRes.count > 0{
                                            let dictRes = arrRes[0]
                                            if let fullPath = dictRes["FileName"] as? String{
                                                self.strPath = fullPath
                                                self.webView.isHidden = false
                                                self.loadInWebView(url: fullPath)
                                            }
                                        }
                                    }
                                }else{
                                    AppConstant.hideHUD()
                                    let msg = dict?["Message"] as? String
                                    self.displayAlert(message: msg ?? "")
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.downloadClaimFormsUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.hideHUD()
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.downloadClaimFormsUrl)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetClaimsFormFile(){
        if(AppConstant.hasConnectivity()) {//true connected
            webView.isHidden = true
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params = [
                "lstFile": self.fileName,
                "lstType": "FORM"
            ]
            print("Headers--- \(headers)")
            print("url===\(AppConstant.getClaimFormFileUrl)")
            AFManager.request(AppConstant.getClaimFormFileUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetClaimsFormFile()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    
                                    if let output = dict?["File"] as? String{
                                        if output != ""{
                                            self.strPdfBase64 =  output
                                            self.showPdf(strData: output, filename: self.fileName)
                                        }
                                    }
                                }else{
                                    AppConstant.hideHUD()
                                    let msg = dict?["Message"] as? String
                                    self.displayAlert(message: msg ?? "")
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getClaimFormFileUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.hideHUD()
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getClaimFormFileUrl)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
