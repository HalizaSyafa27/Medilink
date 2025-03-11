//
//  SecurityQAViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/07/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class SecurityQAViewController: BaseViewController, ChooseDelegate {
    
    @IBOutlet weak var txtFldAns1: UITextField!
    @IBOutlet weak var txtFldAns2: UITextField!
    @IBOutlet weak var txtFldAns3: UITextField!
    @IBOutlet weak var lblQstn1: UILabel!
    @IBOutlet weak var lblQstn2: UILabel!
    @IBOutlet weak var lblQstn3: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var arrow1WidthConstraint: NSLayoutConstraint!
    @IBOutlet var arrow2WidthConstraint: NSLayoutConstraint!
    @IBOutlet var arrow3WidthConstraint: NSLayoutConstraint!
    
    var arrSeqQstn = [SecurityQuestion]()
    var questionType = ""
    var selectedQuestion1Id = ""
    var selectedQuestion2Id = ""
    var selectedQuestion3Id = ""
    var email = ""
    var dataSource = [CustomObject]()
    var isQuestionsPreviouslyDefined : Bool = false

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
        
        //Service call to get questions
        if self.isQuestionsPreviouslyDefined == false{
            lblInstruction.text = ""
            lblHeader.text = "Security Question"
            self.serviceCallToGetSecurityQuestions()
        }else{
            lblInstruction.text = StringConstant.securityQuestionHeader
            lblHeader.text = "Password Recovery"
            arrow1WidthConstraint.constant = 0
            arrow2WidthConstraint.constant = 0
            arrow3WidthConstraint.constant = 0
            
            for index in 0..<arrSeqQstn.count{
                let qstnBo = arrSeqQstn[index]
                if index == 0{
                    self.lblQstn1.text = qstnBo.name
                    selectedQuestion1Id = qstnBo.id
                }else if index == 1{
                    self.lblQstn2.text = qstnBo.name
                    selectedQuestion2Id = qstnBo.id
                }else if index == 2{
                    self.lblQstn3.text = qstnBo.name
                    selectedQuestion3Id = qstnBo.id
                }
            }
        }
    }
    
    //MARK: Set Data
    func setDataSource(type: String) -> [CustomObject]{
        //States
        dataSource.removeAll()
        if type == "securityQuestions" {
            for qstnBo in self.arrSeqQstn{
                let customBo = CustomObject()
                customBo.code = qstnBo.id
                customBo.name = qstnBo.name
                
                dataSource.append(customBo)
            }
        }
        return dataSource
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnQuestionAction (_ sender: UIButton) {
        if self.isQuestionsPreviouslyDefined == false{
            let questionType = "securityQuestion\(sender.tag)"
            
            let seqVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseOptionViewController") as! ChooseOptionViewController
            seqVC.delegate = self
            seqVC.type = questionType
            seqVC.isCustomObj = true
            seqVC.arrData = self.setDataSource(type: "securityQuestions")
            self.navigationController?.pushViewController(seqVC, animated: true)
        }
    }
    
    @IBAction func btnSubmitAction (_ sender: UIButton) {
        self.validatePage()
    }
    
    //MARK: Choose Question Delegate
    func selectedObject(obj: CustomObject,type: String){
        if type == "securityQuestion1"{
            lblQstn1.text = obj.name!
            self.selectedQuestion1Id = obj.code!
        }else if type == "securityQuestion2"{
            lblQstn2.text = obj.name!
            self.selectedQuestion2Id = obj.code!
        }else if type == "securityQuestion3"{
            lblQstn3.text = obj.name!
            self.selectedQuestion3Id = obj.code!
        }
    }
    
    //MARK: Validation Method
    func validatePage(){
        var errorMsg = ""
        if txtFldAns1.text! == "" {
            errorMsg = StringConstant.ans1Validation
        }else if txtFldAns2.text! == "" {
            errorMsg = StringConstant.ans2Validation
        }else if txtFldAns3.text! == "" {
            errorMsg = StringConstant.ans3Validation
        }
        
        if errorMsg != "" {
            self.displayAlert(message: errorMsg ?? "")
        }else{
            if isQuestionsPreviouslyDefined == true{
                self.apiCallTosubmitAnswers()
            }else{
                self.apiCallTosubmitQuestionsAndAnswers()
            }
        }
    }
    
    //MARK: Service Call Methods
    func serviceCallToGetSecurityQuestions(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            print("url===\(AppConstant.getSecurityQuestionUrl)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.getSecurityQuestionUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        // debugPrint(dict)
                        
                        if let status = dict?["Status"] as? String {
                            if(status == "1"){//Success
                                self.arrSeqQstn.removeAll()
                                
                                let arrQstn = dict?["SecurityquestionList"] as! [[String: Any]]
                                if (arrQstn.count > 0){
                                    for dict in arrQstn {
                                        let qstnBo = SecurityQuestion()
                                        if let qstnId = dict["REFCD"] as? String{
                                            qstnBo.id = qstnId
                                        }else{
                                            qstnBo.id = ""
                                        }
                                        if let qstnName = dict["FDESC"] as? String{
                                            qstnBo.name = qstnName
                                        }else{
                                            qstnBo.name = ""
                                        }
                                        
                                        self.arrSeqQstn.append(qstnBo)
                                    }
                                }
                            }else{
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getSecurityQuestionUrl)
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getSecurityQuestionUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func apiCallTosubmitQuestionsAndAnswers(){
        let headers: HTTPHeaders = [
            "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
            "Accept": "application/json"
        ]
        
        print("Headers--- \(headers)")
        
        let params: Parameters = [
            "pstEmailId": email,
            "pstQuestion1": selectedQuestion1Id,
            "pstQuestion2": selectedQuestion2Id,
            "pstQuestion3": selectedQuestion3Id,
            "pstAnswer1": txtFldAns1.text!,
            "pstAnswer2": txtFldAns2.text!,
            "pstAnswer3": txtFldAns3.text!
        ]
        print("params===\(params)")
        print("url===\(AppConstant.postUpdateQAandPasswordRecoveryUrl)")
        
        AppConstant.showHUD()
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//        AFManager = Alamofire.SessionManager(configuration: configuration)
        AFManager.request( AppConstant.postUpdateQAandPasswordRecoveryUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
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
                                self.apiCallTosubmitQuestionsAndAnswers()
                            }
                        })
                    }else{
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        //  debugPrint(dict)
                        
                        if let status = dict?["Status"] as? String {
                            if(status == "1"){//success
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                                
                            }else {
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.postUpdateQAandPasswordRecoveryUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postUpdateQAandPasswordRecoveryUrl)
                    break
                    
                }
        }
    }
    
    func apiCallTosubmitAnswers(){
        let headers: HTTPHeaders = [
            "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
            "Accept": "application/json"
        ]
        
        print("Headers--- \(headers)")
        
        let params: Parameters = [
            "pstEmailId": email,
            "pstAnswer1": txtFldAns1.text!,
            "pstAnswer2": txtFldAns2.text!,
            "pstAnswer3": txtFldAns3.text!
        ]
        print("params===\(params)")
        print("url===\(AppConstant.postPasswordRecoveryUrl)")
        
        AppConstant.showHUD()
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//        AFManager = Alamofire.SessionManager(configuration: configuration)
        AFManager.request( AppConstant.postPasswordRecoveryUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
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
                                self.apiCallTosubmitAnswers()
                            }
                        })
                    }else{
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        //  debugPrint(dict)
                        
                        if let status = dict?["Status"] as? String {
                            if(status == "1"){//success
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }else {
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.postPasswordRecoveryUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postPasswordRecoveryUrl)
                    break
                    
                }
        }
    }
    
    //MARK: Alert Controller Mathod
    func showAlert(title: String, desc: String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.view.tintColor = AppConstant.themeGreenColor
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true)
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
