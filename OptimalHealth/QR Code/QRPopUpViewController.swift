//
//  QRPopUpViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 23/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class QRPopUpViewController: BaseViewController, OkDelegate {
    
    @IBOutlet var viewPopup: UIView!
    @IBOutlet var btnOk: UIButton!
    @IBOutlet var btnYes: UIButton!
    @IBOutlet var btnNo: UIButton!
    @IBOutlet var txtViewMsg: UITextView!
    
    @IBOutlet var lblProceedHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblProceed: UILabel!
    
    @IBOutlet var btnYesBottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var btnNoBottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var popupViewHeightConstraint: NSLayoutConstraint!
    
    var coverageCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initDesign()
        
    }
    
    func initDesign(){
        
        self.txtViewMsg.attributedText = AppConstant.strQRPopupValue.htmlToAttributedString
        self.popupViewHeightConstraint.constant = (AppConstant.strQRPopupValue.htmlToAttributedString?.height(withConstrainedWidth: self.txtViewMsg.frame.size.width))! + 68 + 98
        self.txtViewMsg.textAlignment = NSTextAlignment.center
        print("QR Popup tag: \(AppConstant.intPopupTag)")
        if AppConstant.intPopupTag == 101 {//Show Yes/No button
            lblProceed.isHidden = false
            btnYes.isHidden = false
            btnNo.isHidden = false
            btnOk.isHidden = true
            btnOk.isUserInteractionEnabled = false
            btnYes!.addTopBorder(AppConstant.themeRedColor, height: 1.0)
            btnNo!.addRightBorder(AppConstant.themeRedColor, width: 1.0)
            btnNo!.addTopBorder(AppConstant.themeRedColor, height: 1.0)
            btnYesBottomSpaceConstraint.constant = 0
            btnNoBottomSpaceConstraint.constant = 0
        }else {
            
            //Hide Yes/No button
            lblProceed.isHidden = true
            lblProceedHeightConstraint.constant =  0
            
            btnYes.isHidden = true
            btnNo.isHidden = true
            btnOk.isHidden = false
            btnOk.isUserInteractionEnabled = true
        }
    }
    
    func showPopupForRegSuccess(){
        
        viewPopup.isHidden = true
        self.view.backgroundColor = UIColor.clear
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MobileRegSuccessPopupViewController") as! MobileRegSuccessPopupViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        vc.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        vc.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            vc.view.alpha = 1.0
            vc.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        return
    }
    
    // MARK: - Button Action
    @IBAction func btnNoAction(_ sender: Any) {
//        _ = navigationController?.popToRootViewController(animated: true)
        
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
        
    }
    
    @IBAction func btnYesAction(_ sender: Any) {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.serviceCallToRegisterMobile()
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
//        _ = navigationController?.popToRootViewController(animated: true)
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    //MARK: Delegates method to choose data
    func selectedOk(action: String) {
        if (action == StringConstant.YES) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(message:String, action: String){
        AppConstant.saveInDefaults(key: StringConstant.messageAlert, value: message)
        let slideVC = OverlayView()
        slideVC.actionString = action
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.delegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    //MARK: Service Call Method
    func serviceCallToRegisterMobile(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstProviderCode": AppConstant.strQRPopupProviderCode,
                "pstCoverageCode": self.coverageCode,
                "pstCardNo": AppConstant.strQRPopupCardNo
            ]
            print("params===\(params)")
            print("url===\(AppConstant.QRMobileRegistrationUrl)")
            AFManager.request( AppConstant.QRMobileRegistrationUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToRegisterMobile()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    if let msg = dict?["Message"] as? String {
                                        AppConstant.strQRPopupValue = msg
//                                        self.showPopupForRegSuccess()
                                        self.showAlert(message: msg , action: StringConstant.dependentStoryboard)
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.QRMobileRegistrationUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.QRMobileRegistrationUrl)
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
    
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIView {
    
    func addTopBorder(_ color: UIColor, height: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: height))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
    }
    func addBottomBorder(_ color: UIColor, height: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: height))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
    }
    func addLeftBorder(_ color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                multiplier: 1, constant: width))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
    }
    func addRightBorder(_ color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                multiplier: 1, constant: width))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
    }
}


