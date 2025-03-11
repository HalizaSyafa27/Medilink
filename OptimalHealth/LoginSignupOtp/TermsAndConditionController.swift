//
//  TermsAndConditionController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 07/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class TermsAndConditionController: UIViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
    }
    
    func initDesign(){
        self.navigationController?.isNavigationBarHidden = true
        
        self.btnSignUp.layer.cornerRadius = self.btnSignUp.frame.height/2
        self.btnSignUp.clipsToBounds = true
        self.btnSignUp.layer.borderWidth = AppConstant.borderButton
        self.btnSignUp.layer.borderColor = AppConstant.themeRedColor.cgColor
        
        self.btnLogin.layer.cornerRadius =  self.btnLogin.frame.height/2
        self.btnLogin.clipsToBounds = true
        self.btnLogin.layer.borderWidth = AppConstant.borderButton
        self.btnLogin.layer.borderColor = AppConstant.themeRedColor.cgColor
        
        self.lblVersion?.text = "v" + Bundle.main.releaseVersionNumber! + "(" + Bundle.main.buildVersionNumber! + ")"
        
//        let attributedTxt = NSMutableAttributedString(string: "MediDoc ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.5, weight: .bold)])
//        let attributedText = NSMutableAttributedString(string: "is the Health and Wellness mobile Platform for our Members and General public to access health and wellness information, advise and services", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.5, weight: .bold)])
//               attributedTxt.append(attributedText)
//        lbldesc.attributedText = attributedTxt
        
//        let paragraphStyle = NSMutableParagraphStyle()
//               paragraphStyle.lineSpacing = 3
//               attributedTxt.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedTxt.length))
//        lbldesc.attributedText = attributedTxt
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnAcceptAction(_ sender: Any) {
        AppConstant.saveInDefaults(key: StringConstant.isTandCAcceprted, value: StringConstant.YES)
        performSegue(withIdentifier: "landing_screen", sender: self)
    }
    
    @IBAction func btnRejectAction(_ sender: Any) {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
    @IBAction func btnAboutUsAction(_ sender: UIButton) {
        let aboutUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsController") as! AboutUsController
        self.navigationController?.pushViewController(aboutUsVC, animated: true)
    }
    
    @IBAction func btnContactUsAction(_ sender: UIButton) {
//        let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsController") as! ContactUsController
        let disclaimerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        disclaimerVC.pageType = "ContactUs"
        self.navigationController?.pushViewController(disclaimerVC, animated: true)
    }
    
    @IBAction func btnDisclaimerAction(_ sender: UIButton) {
        let disclaimerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        disclaimerVC.pageType = "Disclaimer"
        self.navigationController?.pushViewController(disclaimerVC, animated: true)
    }
    
    @IBAction func btnTermsAction(_ sender: UIButton) {
        let termsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsConditionsController") as! TermsConditionsController
        self.navigationController?.pushViewController(termsVC, animated: true)
    }
    
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register_vc") as! RegisterViewController
               self.navigationController?.pushViewController(contactUsVC, animated: true)
        
    }
    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "btnLogin_logInPage", sender: self)
    }
    

}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
