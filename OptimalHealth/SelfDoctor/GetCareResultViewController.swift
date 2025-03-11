//
//  GetCareResultViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 08/12/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import WebKit

class GetCareResultViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imgViewGender: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    var pageTitle = ""
    var strCardNo = ""
    var strPayorMemberId = ""
    
    var triageScore: String = ""
    var symptomHeader = ""
    var gender: String = ""
    var selectedAgeFormat1 = ""
    
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
        
        lblPageTitle.text = pageTitle
        
        if gender == "f" {
            if (selectedAgeFormat1 == "newborn" || selectedAgeFormat1 == "infant") {
                imgViewGender.image = UIImage.init(named: "child_female")
            }else{
                imgViewGender.image = UIImage.init(named: "female")
            }
        }else{
            if (selectedAgeFormat1 == "newborn" || selectedAgeFormat1 == "infant") {
                imgViewGender.image = UIImage.init(named: "child_male")
            }else{
                imgViewGender.image = UIImage.init(named: "male")
            }
        }
        
        lblDesc.text = symptomHeader
        
        webView.navigationDelegate = self
        
//        let htmlPath = Bundle.main.path(forResource: "symptomcheckerscore", ofType: "html")
//        let url = URL(fileURLWithPath: htmlPath!)
//        let request = URLRequest(url: url)
//        webView.load(request)
        webView.isHidden = true
        AppConstant.showHUD()
        showTriageScoreResult()
    }
    
    func showTriageScoreResult() {
        do {
            guard let filePath = Bundle.main.path(forResource: "symptomcheckerscore", ofType: "html")
                else{// File Error
                    print ("File reading error")
                    return
            }
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.isHidden = false
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        }catch{
            print ("File HTML error")
        }
        
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //AppConstant.showHUD()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppConstant.hideHUD()
        
        self.webView.isHidden = false
        print("webview did finish loading called")
        self.updatedataToHTML()
    }
    
    func webView(_ webView: WKWebView,
                     runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.view.tintColor = AppConstant.themeRedColor
        present(alert, animated: true)
        completionHandler()
    }
    
    func updatedataToHTML() {
        let inputPayload = ["value": self.triageScore] as [String : Any]
        print("InputData == \(inputPayload)")
        
        let serializedData = try! JSONSerialization.data(withJSONObject: inputPayload, options: [])
        let encodedData = String(data: serializedData, encoding: String.Encoding.utf8)
        print(inputPayload.description)
        DispatchQueue.main.async{
            self.webView.evaluateJavaScript("showTriagePercentage('\(encodedData!)')", completionHandler: nil)
        }
        
    }
    
    //MARK: Button Actions
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnStartOverAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
