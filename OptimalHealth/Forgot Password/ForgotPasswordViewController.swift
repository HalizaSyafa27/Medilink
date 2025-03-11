//
//  ForgotPasswordViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/07/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol ForgotPasswordDelegate: class {
    @objc optional func forgotPasswordDelegateMethod(arrQuestions: [SecurityQuestion], email: String)
}

class ForgotPasswordViewController: BaseViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtFldEmail: UITextField!
    
    var arrSeqQstn = [SecurityQuestion]()
    weak var delegate: ForgotPasswordDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        viewEmail.layer.cornerRadius = 5
        viewEmail.layer.borderColor = UIColor.lightGray.cgColor
        viewEmail.layer.borderWidth = 1.0
        viewEmail.clipsToBounds = true
        
        viewContainer.layer.cornerRadius = 5
        viewContainer.clipsToBounds = true
        
        txtFldEmail.setplaceHolderColor(placeholder: "Enter registered email")
    }
    
    //MARK: Button Action
    @IBAction func btnOkAction (_ sender: UIButton) {
        if(self.txtFldEmail.text?.trim() == ""){
            self.displayAlert(message: "Email id can not be blank")
        }else{
            self.apiCallForForgotPassword()
        }
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelAction (_ sender: UIButton) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    //MARK: Service Call
    func apiCallForForgotPassword(){
        let headers: HTTPHeaders = [
            "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
            "Accept": "application/json"
        ]
        
        print("Headers--- \(headers)")
        
        let params: Parameters = [
            "pstEmailId": self.txtFldEmail.text!.trim()
        ]
        print("params===\(params)")
        print("url===\(AppConstant.verifyForgotPasswordUrl)")
        
        AppConstant.showHUD()
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//        AFManager = Alamofire.SessionManager(configuration: configuration)
        AFManager.request( AppConstant.verifyForgotPasswordUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                AppConstant.hideHUD()
                debugPrint(response)
                
                switch(response.result) {
                case .success(_):
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.apiCallForForgotPassword()
                            }
                        })
                    }else{
                        if let dict = response.result.value as? [String: Any]{
                            //  debugPrint(dict)
                            self.arrSeqQstn.removeAll()
                            
                            if let status = dict["Status"] as? String {
                                if(status == "1"){//success
                                    if let arrSeqQuestions = dict["SecurityquestionList"] as? [[String: Any]]{
                                        if arrSeqQuestions.count > 0{
                                            let dictQstn = arrSeqQuestions[0]
                                            if let q1 = dictQstn["Question1"] as? String{
                                                let qstnBo = SecurityQuestion()
                                                qstnBo.name = q1
                                                self.arrSeqQstn.append(qstnBo)
                                            }
                                            if let q2 = dictQstn["Question2"] as? String{
                                                let qstnBo = SecurityQuestion()
                                                qstnBo.name = q2
                                                self.arrSeqQstn.append(qstnBo)
                                            }
                                            if let q3 = dictQstn["Question3"] as? String{
                                                let qstnBo = SecurityQuestion()
                                                qstnBo.name = q3
                                                self.arrSeqQstn.append(qstnBo)
                                            }
                                        }
                                    }
                                    //self.arrSeqQstn.removeAll()
                                    self.delegate?.forgotPasswordDelegateMethod!(arrQuestions: self.arrSeqQstn, email: self.txtFldEmail.text!.trim())
                                    
                                    self.removeFromParent()
                                    self.view.removeFromSuperview()
                                    
                                }else {
                                    if let msg = dict["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.verifyForgotPasswordUrl)
                            }
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.verifyForgotPasswordUrl)
                    break
                    
                }
        }
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
