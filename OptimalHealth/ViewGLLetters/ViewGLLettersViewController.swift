//
//  ViewGLLettersViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 17/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import ImageScrollView
import WebKit

class ViewGLLettersViewController: BaseViewController,WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate  {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var imageScrollView: ImageScrollView!
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet weak var btnDownlod: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    var webView: WKWebView!
    var cardNo = ""
    var claimId = ""
    var className = ""
    var strHeaderImageName = ""
    var isFromStatusDetailsPage: Bool = false
    var strHeader = "View GL Letters"
    var pageTitle: String = ""
    var urlToOpen = ""
    var strPdfBase64: String = ""
    var teleReqId = ""
    var url: URL? = nil
    var type:String = ""
    var fileName:String = ""
    
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
        btnDownlod.isHidden = true
        btnShare.isHidden = true
        print("TeleReqID === \(teleReqId)")
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.viewContainer.addSubview(webView)
        
        imageScrollView.imageContentMode = .aspectFit
        imageScrollView.initialOffset = .center
        imageScrollView.backgroundColor = UIColor.clear
        self.view.layoutIfNeeded()
        
        webView.isHidden = true
        imageScrollView.isHidden = true
        lblHeader.text = "View GL Letters"
        lblPageTitle.text = pageTitle
        if className == StringConstant.HealthRiskAssessment {
            if self.strPdfBase64 != ""{
                lblHeader.text = "View Health Risk Assessment"
                self.showPdf(strData: self.strPdfBase64, filename: "HealthRiskAssessment.pdf")
                self.btnDownlod.isHidden = false
                self.btnShare.isHidden = false
            }
        }
        else if className == StringConstant.HEALTHSCREENING {
            if self.strPdfBase64 != ""{
                lblHeader.text = "View Health Screening"
                self.showPdf(strData: self.strPdfBase64, filename: "HealthScreening.pdf")
                self.btnDownlod.isHidden = false
                self.btnShare.isHidden = false
            }
        }
        else if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)) {
            if teleReqId == ""{
                self.displayAlert(message: "No Letter to Print")
            }else{
                //Show download button
                btnDownlod.isHidden = false
                btnShare.isHidden = false
                serviceCallToShowGl()
            }
        }else if ((isFromStatusDetailsPage == true) && ((claimId == "")))  {
            self.displayAlert(message: "No Letter to Print")
        }else if (className == StringConstant.uploadMedicalChit){
            
            lblHeader.text = strHeader
            if claimId == ""{
                self.displayAlert(message: "No Medical chit to Print")
            }else{
                serviceCallToMedicalChit()
            }
        }else if (className == StringConstant.WebMDHealthMagazine){ 
            AppConstant.showHUD()
            webView.isHidden = false
            lblHeader.text = strHeader
            lblPageTitle.text = pageTitle
            imgViewHeader.image = UIImage.init(named: strHeaderImageName)
            
            var request: URLRequest? = nil
            if let url = URL(string: urlToOpen) {
                request = URLRequest(url: url)
            }

            request?.timeoutInterval = 180

            if let request = request {
                webView.load(request)
            }
            //self.loadInWebView(url: urlToOpen)
        }else {
            //Show download button
            serviceCallToShowGl()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDownloadAction(_ sender: Any) {
        self.downloadFile()
    }
    
    @IBAction func btnShareAction(_ sender: UIButton) {
        self.shareAction()
    }
    
    //MARK: WKWebView Delegate Methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppConstant.hideHUD()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.displayAlert(message: error.localizedDescription)
        AppConstant.hideHUD()
    }
    
    func loadInWebView(url: String){
        if let url = URL(string: url){
            print("url === \(url)")
            webView.load(URLRequest(url: url))
        }
        
    }
    
    func showimageInImageView(imgData: String){
        AppConstant.hideHUD()
        imageScrollView.isHidden = false
        
        if imgData != ""{
            if let data = Data(base64Encoded: imgData) {
                if let image = UIImage(data: data){
                    self.imageScrollView.display(image: image)
                }
            }
        }
    }
    
    func serviceCallToShowGl(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            var json = ""
            var strUrl = ""
            if claimId != ""{
                strUrl = AppConstant.getGlDocumentOnClaimsIdUrl
                json = "{\"pstClaimsid\":\"\(claimId)\"}"
            }else if teleReqId != ""{
                strUrl = AppConstant.teleDocumentbyIclaimidUrl
                json = "{\"pstClaimsid\":\"\(teleReqId)\"}"
            }else{
                strUrl = AppConstant.getGlDocumentUrl
                json = "{\"pstCardNo\":\"\(cardNo)\"}"
            }
            print("url===\(strUrl)")
            print("param===\(json)")
            let url = URL(string: strUrl)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                 debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToShowGl()
                            }
                        })
                    }else{
                        //AppConstant.hideHUD()
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                if let arrOutput = dict["ViewGLList"] as? [String]{
                                    if arrOutput.count > 0{
                                        self.strPdfBase64 =  arrOutput[0]
                                        self.showPdf(strData: arrOutput[0], filename: "letter.pdf")
                                        self.btnDownlod.isHidden = false
                                        self.btnShare.isHidden = false
                                    }
                                }
                            }else{
                                AppConstant.hideHUD()
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg)
                                }
                            }
                        }else{
                            AppConstant.hideHUD()
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    AppConstant.hideHUD()
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postMedicalChitOnClaimIdUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToMedicalChit(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let json = "{\"pstClaimsid\":\"\(claimId)\",\"pstType\":\"\(type)\",\"pstFileName\":\"\(fileName)\"}"
            print("url===\(AppConstant.downloadDocumentByTypeAndFileNameAndClaimsIdUrl)")
            print("param===\(json)")
            let url = URL(string: AppConstant.downloadDocumentByTypeAndFileNameAndClaimsIdUrl)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToMedicalChit()
                            }
                        })
                    }else{
                        AppConstant.hideHUD()
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                if let imageBase64String = dict["ImageBase64String"] as? String{
                                    if imageBase64String != ""{
                                        if let imageType = dict["ImageType"] as? String{
                                            if imageType == "application/pdf"{
                                                self.showPdf(strData: imageBase64String, filename: "letter.pdf")
                                            }else{
                                                self.showimageInImageView(imgData: imageBase64String)
                                            }
                                        }else{
                                            self.showimageInImageView(imgData: imageBase64String)
                                        }
                                    }
                                }
                            }else{
                                AppConstant.hideHUD()
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg)
                                }
                            }
                        }else{
                            AppConstant.hideHUD()
                        }
                    }
                    break
                case .failure(_):
                    AppConstant.hideHUD()
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postMedicalChitOnClaimIdUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func showPdf(strData:String, filename: String) {
        
        let fileName = filename
        self.url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        if let data = NSData(base64Encoded: strData, options: NSData.Base64DecodingOptions(rawValue: 0)){
            do {
                try data.write(to: url!, options: .atomic)
            } catch {
                print(error)
            }
            //AppConstant.hideHUD()
            webView.isHidden = false
            webView.load(URLRequest(url: url!))
            self.urlToOpen = url!.absoluteString
            print("myurl===\(self.urlToOpen)")
            
        }else{
            AppConstant.hideHUD()
            webView.isHidden = false
        }
        
    }
    
    func downloadFile() {
        var fileName = "GLLetter" + self.claimId + ".pdf"
        if className == StringConstant.HealthRiskAssessment {
            fileName = "HealthRiskAssessment.pdf"
        }
        else if className == StringConstant.HEALTHSCREENING {
            fileName = "HealthScreening.pdf"
        }
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
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
    
    func showAlert(strTitle: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: strTitle, message:"", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                                            self.navigationController?.popViewController(animated: true)
                                            
            }))
            alert.view.tintColor = AppConstant.themeRedColor
            self.present(alert, animated: true, completion: nil)
        }
    }

    func shareAction(){
        
        if self.strPdfBase64 == ""{
            return
        }

        // Create the Array which includes the files you want to share
        var filesToShare = [Any]()

        // Add the path of the file to the Array
        filesToShare.append(self.url ?? "")

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {//iPad
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        
        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
        
    }

}
