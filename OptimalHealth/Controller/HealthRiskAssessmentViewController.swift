//
//  HealthRiskAssessmentViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 03/07/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class HealthRiskAssessmentViewController: BaseViewController {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var heightConstraintTopBar: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var stepTitle: UIView!
    @IBOutlet weak var heightConstraintStepImage: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintContentView: NSLayoutConstraint!
    @IBOutlet weak var btnBeginAssessment: UIButton!
    @IBOutlet weak var contentStepImage: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var lblIReadAndAgree: UILabel!
    
    var healthRiskAssessmentBo = HealthRiskAssessmentBo()
    var healthRiskAssessmentModel = HealthRiskAssessmentModel()
    var stepNumber: Int = 0
    var stepNumberDisplay: Int = 0
    var headerImageStr: String = ""
    var pageTitle: String = ""
    var isAgreeToTerms:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
    }
    
    func initDesign(){
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
            heightConstraintTopBar.constant = AppConstant.navBarHeight
        }
        //dashboard_white
        self.headerImage.image = UIImage.init(named: self.headerImageStr)
        self.headerTitle.text = pageTitle
        btnBeginAssessment.layer.cornerRadius = btnBeginAssessment.frame.size.height / 2
        btnBeginAssessment.clipsToBounds = true
        controlStep()
    }
    
    func controlStep(){
        if(stepNumber == 0){
            self.heightConstraintStepImage.constant = 0
            self.stepImage.isHidden = true
        }else{
            self.heightConstraintStepImage.constant = 140
        }
    }
    
    // MARK: - Navigation
     @IBAction func btnHomeViewAction(_ sender: Any) {
         self.navigationController?.popToRootViewController(animated: true)
     }
     
    @IBAction func actionAgree(_ sender: UIButton) {
        isAgreeToTerms = !isAgreeToTerms
        checkImageView.image = isAgreeToTerms == true ? UIImage.init(named: "checkbox_active")  : UIImage.init(named: "checkbox")
        
    }
    
    @IBAction func actionAgreeBox(_ sender: UIButton) {
        isAgreeToTerms = !isAgreeToTerms
        checkImageView.image = isAgreeToTerms == true ? UIImage.init(named: "checkbox_active")  : UIImage.init(named: "checkbox")
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
         _ = self.navigationController?.popViewController(animated: true)
     }
    
    @IBAction func actionToBegin(_ sender: UIButton){
        if isAgreeToTerms {
            GetHealthRiskAssessmentByCardNo()
//            self.performSegue(withIdentifier: "health_risk_assessment_step", sender: self)
        }else{
            self.displayAlert(message: "Please checked \"Saya telah membaca dan menyetui Syarat dan Ketentuan\" ")
        }
    }
    
    //MARK: Service Call
    func GetHealthRiskAssessmentByCardNo(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstCardNo": healthRiskAssessmentBo.cardNo!
            ]
            print("params===\(params)")
            print("url===\(AppConstant.postHealthRiskAssessmentByCardNoUrl)")
            AFManager.request( AppConstant.postHealthRiskAssessmentByCardNoUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.GetHealthRiskAssessmentByCardNo()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    //success
                                    let data = HealthRiskAssessmentModel()
                                    if let response = dict!["Data"] as? [String: AnyObject]{
                                        debugPrint(response)
                                        
                                        if let strValue = response["HRAID"] as? String
                                        {
                                            data.HRAID = strValue
                                            if let strValue = response["INSBY"] as? String{
                                                data.INSBY = strValue
                                            }
                                            if let strValue = response["INSDT"] as? String{
                                                data.INSDT = strValue
                                            }
                                            if let strValue = response["UPDBY"] as? String{
                                                data.UPDBY = strValue
                                            }
                                            if let strValue = response["UPDDT"] as? String{
                                                data.UPDDT = strValue
                                            }
                                            if let strValue = response["MEMID"] as? String{
                                                data.MEMID = strValue
                                            }
                                            if let strValue = response["EMPID"] as? String{
                                                data.EMPID = strValue
                                            }
                                            if let strValue = response["DEPID"] as? String{
                                                data.DEPID = strValue
                                            }
                                            if let strValue = response["MEMCTLNO"] as? String{
                                                data.MEMCTLNO = strValue
                                            }
                                            if let strValue = response["CARDNO"] as? String{
                                                data.CARDNO = strValue
                                            }
                                            if let strValue = response["PAYORCD"] as? String{
                                                data.PAYORCD = strValue
                                            }
                                            if let strValue = response["CORPCD"] as? String{
                                                data.CORPCD = strValue
                                            }
                                            if let strValue = response["CLAIMSTS"] as? String{
                                                data.CLAIMSTS = strValue
                                            }
                                            if let strValue = response["ICNO"] as? String{
                                                data.ICNO = strValue
                                            }
                                            if let strValue = response["PATIENTNM"] as? String{
                                                data.PATIENTNM = strValue
                                            }
                                            if let strValue = response["GENDER"] as? String{
                                                data.GENDER = strValue
                                            }
                                            if let strValue = response["DOB"] as? String{
                                                data.DOB = strValue
                                            }
                                            if let strValue = response["AGE"] as? String{
                                                data.AGE = strValue
                                            }
                                            if let strValue = response["MARITALSTS"] as? String{
                                                data.MARITALSTS = strValue
                                            }
                                            if let strValue = response["NOOFCHILDREN"] as? String{
                                                data.NOOFCHILDREN = strValue
                                            }
                                            if let strValue = response["NOOFCHILDRENLWY"] as? String{
                                                data.NOOFCHILDRENLWY = strValue
                                            }
                                            if let strValue = response["OCCUPATIONCUR"] as? String{
                                                data.OCCUPATIONCUR = strValue
                                            }
                                            if let strValue = response["OCCUPATIONPRV"] as? String{
                                                data.OCCUPATIONPRV = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_MEASLES"] as? String{
                                                data.CHILDHDILLNESS_MEASLES = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_MUMPS"] as? String{
                                                data.CHILDHDILLNESS_MUMPS = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_RUB"] as? String{
                                                data.CHILDHDILLNESS_RUB = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_CHKPOX"] as? String{
                                                data.CHILDHDILLNESS_CHKPOX = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_RTFEVER"] as? String{
                                                data.CHILDHDILLNESS_RTFEVER = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_POLIO"] as? String{
                                                data.CHILDHDILLNESS_POLIO = strValue
                                            }
                                            if let strValue = response["CHILDHDILLNESS_NONE"] as? String{
                                                data.CHILDHDILLNESS_NONE = strValue
                                            }
                                            if let strValue = response["IMM_TETANUS"] as? String{
                                                data.IMM_TETANUS = strValue
                                            }
                                            if let strValue = response["IMM_TETANUSDT"] as? String{
                                                data.IMM_TETANUSDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_PNEUMONIA"] as? String{
                                                data.IMM_PNEUMONIA = strValue
                                            }
                                            if let strValue = response["IMM_PNEUMONIADT"] as? String{
                                                data.IMM_PNEUMONIADT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_HEPATITISA"] as? String{
                                                data.IMM_HEPATITISA = strValue
                                            }
                                            if let strValue = response["IMM_HEPATITISADT"] as? String{
                                                data.IMM_HEPATITISADT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_HEPATITISB"] as? String{
                                                data.IMM_HEPATITISB = strValue
                                            }
                                            if let strValue = response["IMM_HEPATITISBDT"] as? String{
                                                data.IMM_HEPATITISBDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_CHICKENPOX"] as? String{
                                                data.IMM_CHICKENPOX = strValue
                                            }
                                            if let strValue = response["IMM_CHICKENPOXDT"] as? String{
                                                data.IMM_CHICKENPOXDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_INFLUENZA"] as? String{
                                                data.IMM_INFLUENZA = strValue
                                            }
                                            if let strValue = response["IMM_INFLUENZADT"] as? String{
                                                data.IMM_INFLUENZADT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_MUMPS"] as? String{
                                                data.IMM_MUMPS = strValue
                                            }
                                            if let strValue = response["IMM_MUMPSDT"] as? String{
                                                data.IMM_MUMPSDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_RUBELLA"] as? String{
                                                data.IMM_RUBELLA = strValue
                                            }
                                            if let strValue = response["IMM_RUBELLADT"] as? String{
                                                data.IMM_RUBELLADT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_MENINGOCOCCAL"] as? String{
                                                data.IMM_MENINGOCOCCAL = strValue
                                            }
                                            if let strValue = response["IMM_MENINGOCOCCALDT"] as? String{
                                                data.IMM_MENINGOCOCCALDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["IMM_NONE"] as? String{
                                                data.IMM_NONE = strValue
                                            }
                                            if let strValue = response["SCR_EYEEXAM"] as? String{
                                                data.SCR_EYEEXAM = strValue
                                            }
                                            if let strValue = response["SCR_EYEEXAMDT"] as? String{
                                                data.SCR_EYEEXAMDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["SCR_COLONOSCOPY"] as? String{
                                                data.SCR_COLONOSCOPY = strValue
                                            }
                                            if let strValue = response["SCR_COLONOSCOPYDT"] as? String{
                                                data.SCR_COLONOSCOPYDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["SCR_DEXA_SCAN"] as? String{
                                                data.SCR_DEXA_SCAN = strValue
                                            }
                                            if let strValue = response["SCR_DEXA_SCANDT"] as? String{
                                                data.SCR_DEXA_SCANDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["SCR_NONE"] as? String{
                                                data.SCR_NONE = strValue
                                            }
                                            if let strValue = response["SURGERY1"] as? String{
                                                data.SURGERY1 = strValue
                                            }
                                            if let strValue = response["SURGERY1_YEAR"] as? String{
                                                data.SURGERY1_YEAR = strValue
                                            }
                                            if let strValue = response["SURGERY1_REASON"] as? String{
                                                data.SURGERY1_REASON = strValue
                                            }
                                            if let strValue = response["SURGERY1_PROV"] as? String{
                                                data.SURGERY1_PROV = strValue
                                            }
                                            if let strValue = response["SURGERY2"] as? String{
                                                data.SURGERY2 = strValue
                                            }
                                            if let strValue = response["SURGERY2_YEAR"] as? String{
                                                data.SURGERY2_YEAR = strValue
                                            }
                                            if let strValue = response["SURGERY2_REASON"] as? String{
                                                data.SURGERY2_REASON = strValue
                                            }
                                            if let strValue = response["SURGERY2_PROV"] as? String{
                                                data.SURGERY2_PROV = strValue
                                            }
                                            if let strValue = response["SURGERY3"] as? String{
                                                data.SURGERY3 = strValue
                                            }
                                            if let strValue = response["SURGERY3_YEAR"] as? String{
                                                data.SURGERY3_YEAR = strValue
                                            }
                                            if let strValue = response["SURGERY3_REASON"] as? String{
                                                data.SURGERY3_REASON = strValue
                                            }
                                            if let strValue = response["SURGERY3_PROV"] as? String{
                                                data.SURGERY3_PROV = strValue
                                            }
                                            if let strValue = response["SURGERY4"] as? String{
                                                data.SURGERY4 = strValue
                                            }
                                            if let strValue = response["SURGERY4_YEAR"] as? String{
                                                data.SURGERY4_YEAR = strValue
                                            }
                                            if let strValue = response["SURGERY4_REASON"] as? String{
                                                data.SURGERY4_REASON = strValue
                                            }
                                            if let strValue = response["SURGERY4_PROV"] as? String{
                                                data.SURGERY4_PROV = strValue
                                            }
                                            if let strValue = response["SURGERY5"] as? String{
                                                data.SURGERY5 = strValue
                                            }
                                            if let strValue = response["SURGERY5_YEAR"] as? String{
                                                data.SURGERY5_YEAR = strValue
                                            }
                                            if let strValue = response["SURGERY5_REASON"] as? String{
                                                data.SURGERY5_REASON = strValue
                                            }
                                            if let strValue = response["SURGERY5_PROV"] as? String{
                                                data.SURGERY5_PROV = strValue
                                            }
                                            if let strValue = response["SURGERY_DONEBF"] as? String{
                                                data.SURGERY_DONEBF = strValue
                                            }
                                            if let strValue = response["HOSP1"] as? String{
                                                data.HOSP1 = strValue
                                            }
                                            if let strValue = response["HOSP1_YEAR"] as? String{
                                                data.HOSP1_YEAR = strValue
                                            }
                                            if let strValue = response["HOSP1_REASON"] as? String{
                                                data.HOSP1_REASON = strValue
                                            }
                                            if let strValue = response["HOSP1_PROV"] as? String{
                                                data.HOSP1_PROV = strValue
                                            }
                                            if let strValue = response["HOSP2"] as? String{
                                                data.HOSP2 = strValue
                                            }
                                            if let strValue = response["HOSP2_YEAR"] as? String{
                                                data.HOSP2_YEAR = strValue
                                            }
                                            if let strValue = response["HOSP2_REASON"] as? String{
                                                data.HOSP2_REASON = strValue
                                            }
                                            if let strValue = response["HOSP2_PROV"] as? String{
                                                data.HOSP2_PROV = strValue
                                            }
                                            if let strValue = response["HOSP3"] as? String{
                                                data.HOSP3 = strValue
                                            }
                                            if let strValue = response["HOSP3_YEAR"] as? String{
                                                data.HOSP3_YEAR = strValue
                                            }
                                            if let strValue = response["HOSP3_REASON"] as? String{
                                                data.HOSP3_REASON = strValue
                                            }
                                            if let strValue = response["HOSPY3_PROV"] as? String{
                                                data.HOSPY3_PROV = strValue
                                            }
                                            if let strValue = response["HOSP4"] as? String{
                                                data.HOSP4 = strValue
                                            }
                                            if let strValue = response["HOSP4_YEAR"] as? String{
                                                data.HOSP4_YEAR = strValue
                                            }
                                            if let strValue = response["HOSP4_REASON"] as? String{
                                                data.HOSP4_REASON = strValue
                                            }
                                            if let strValue = response["HOSP4_PROV"] as? String{
                                                data.HOSP4_PROV = strValue
                                            }
                                            if let strValue = response["HOSP5"] as? String{
                                                data.HOSP5 = strValue
                                            }
                                            if let strValue = response["HOSP5_YEAR"] as? String{
                                                data.HOSP5_YEAR = strValue
                                            }
                                            if let strValue = response["HOSP5_REASON"] as? String{
                                                data.HOSP5_REASON = strValue
                                            }
                                            if let strValue = response["HOSP5_PROV"] as? String{
                                                data.HOSP5_PROV = strValue
                                            }
                                            if let strValue = response["HOSPY_DONEBF"] as? String{
                                                data.HOSPY_DONEBF = strValue
                                            }
                                            if let strValue = response["DOCVST1"] as? String{
                                                data.DOCVST1 = strValue
                                            }
                                            if let strValue = response["DOCVST1_YEAR"] as? String{
                                                data.DOCVST1_YEAR = strValue
                                            }
                                            if let strValue = response["DOCVST1_REASON"] as? String{
                                                data.DOCVST1_REASON = strValue
                                            }
                                            if let strValue = response["DOCVST1_PROV"] as? String{
                                                data.DOCVST1_PROV = strValue
                                            }
                                            if let strValue = response["DOCVST2"] as? String{
                                                data.DOCVST2 = strValue
                                            }
                                            if let strValue = response["DOCVST2_YEAR"] as? String{
                                                data.DOCVST2_YEAR = strValue
                                            }
                                            if let strValue = response["DOCVST2_REASON"] as? String{
                                                data.DOCVST2_REASON = strValue
                                            }
                                            if let strValue = response["DOCVST2_PROV"] as? String{
                                                data.DOCVST2_PROV = strValue
                                            }
                                            if let strValue = response["DOCVST3"] as? String{
                                                data.DOCVST3 = strValue
                                            }
                                            if let strValue = response["DOCVST3_YEAR"] as? String{
                                                data.DOCVST3_YEAR = strValue
                                            }
                                            if let strValue = response["DOCVST3_REASON"] as? String{
                                                data.DOCVST3_REASON = strValue
                                            }
                                            if let strValue = response["DOCVST3_PROV"] as? String{
                                                data.DOCVST3_PROV = strValue
                                            }
                                            if let strValue = response["DOCVST4"] as? String{
                                                data.DOCVST4 = strValue
                                            }
                                            if let strValue = response["DOCVST4_YEAR"] as? String{
                                                data.DOCVST4_YEAR = strValue
                                            }
                                            if let strValue = response["DOCVST4_REASON"] as? String{
                                                data.DOCVST4_REASON = strValue
                                            }
                                            if let strValue = response["DOCVST4_PROV"] as? String{
                                                data.DOCVST4_PROV = strValue
                                            }
                                            if let strValue = response["DOCVST5"] as? String{
                                                data.DOCVST5 = strValue
                                            }
                                            if let strValue = response["DOCVST5_YEAR"] as? String{
                                                data.DOCVST5_YEAR = strValue
                                            }
                                            if let strValue = response["DOCVST5_REASON"] as? String{
                                                data.DOCVST5_REASON = strValue
                                            }
                                            if let strValue = response["DOCVST5_PROV"] as? String{
                                                data.DOCVST5_PROV = strValue
                                            }
                                            if let strValue = response["DOCVST_DONEBF"] as? String{
                                                data.DOCVST_DONEBF = strValue
                                            }
                                            if let strValue = response["MEDICALHISTORYCD"] as? String{
                                                data.MEDICALHISTORYCD = strValue
                                            }
                                            if let strValue = response["PASTMEDHIST"] as? String{
                                                data.PASTMEDHIST = strValue
                                            }
                                            if let strValue = response["PREVREFDOC"] as? String{
                                                data.PREVREFDOC = strValue
                                            }
                                            if let strValue = response["PHYSICALEXAMDT"] as? String{
                                                data.PHYSICALEXAMDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["BLOODTRANSFUSION"] as? String{
                                                data.BLOODTRANSFUSION = strValue
                                            }
                                            if let strValue = response["MEDICATION1_DRUG"] as? String{
                                                data.MEDICATION1_DRUG = strValue
                                            }
                                            if let strValue = response["MEDICATION1_NAME"] as? String{
                                                data.MEDICATION1_NAME = strValue
                                            }
                                            if let strValue = response["MEDICATION1_DOSAGE"] as? String{
                                                data.MEDICATION1_DOSAGE = strValue
                                            }
                                            if let strValue = response["MEDICATION2_DRUG"] as? String{
                                                data.MEDICATION2_DRUG = strValue
                                            }
                                            if let strValue = response["MEDICATION2_NAME"] as? String{
                                                data.MEDICATION2_NAME = strValue
                                            }
                                            if let strValue = response["MEDICATION2_DOSAGE"] as? String{
                                                data.MEDICATION2_DOSAGE = strValue
                                            }
                                            if let strValue = response["MEDICATION3_DRUG"] as? String{
                                                data.MEDICATION3_DRUG = strValue
                                            }
                                            if let strValue = response["MEDICATION3_NAME"] as? String{
                                                data.MEDICATION3_NAME = strValue
                                            }
                                            if let strValue = response["MEDICATION3_DOSAGE"] as? String{
                                                data.MEDICATION3_DOSAGE = strValue
                                            }
                                            if let strValue = response["MEDICATION4_DRUG"] as? String{
                                                data.MEDICATION4_DRUG = strValue
                                            }
                                            if let strValue = response["MEDICATION4_NAME"] as? String{
                                                data.MEDICATION4_NAME = strValue
                                            }
                                            if let strValue = response["MEDICATION4_DOSAGE"] as? String{
                                                data.MEDICATION4_DOSAGE = strValue
                                            }
                                            if let strValue = response["MEDICATION5_DRUG"] as? String{
                                                data.MEDICATION5_DRUG = strValue
                                            }
                                            if let strValue = response["MEDICATION5_NAME"] as? String{
                                                data.MEDICATION5_NAME = strValue
                                            }
                                            if let strValue = response["MEDICATION5_DOSAGE"] as? String{
                                                data.MEDICATION5_DOSAGE = strValue
                                            }
                                            if let strValue = response["MEDICATION_NONE"] as? String{
                                                data.MEDICATION_NONE = strValue
                                            }
                                            if let strValue = response["ALERGY1"] as? String{
                                                data.ALERGY1 = strValue
                                            }
                                            if let strValue = response["ALERGY1_NAME"] as? String{
                                                data.ALERGY1_NAME = strValue
                                            }
                                            if let strValue = response["ALERGY1_REACTION"] as? String{
                                                data.ALERGY1_REACTION = strValue
                                            }
                                            if let strValue = response["ALERGY2"] as? String{
                                                data.ALERGY2 = strValue
                                            }
                                            if let strValue = response["ALERGY2_NAME"] as? String{
                                                data.ALERGY2_NAME = strValue
                                            }
                                            if let strValue = response["ALERGY2_REACTION"] as? String{
                                                data.ALERGY2_REACTION = strValue
                                            }
                                            if let strValue = response["ALERGY3"] as? String{
                                                data.ALERGY3 = strValue
                                            }
                                            if let strValue = response["ALERGY3_NAME"] as? String{
                                                data.ALERGY3_NAME = strValue
                                            }
                                            if let strValue = response["ALERGY3_REACTION"] as? String{
                                                data.ALERGY3_REACTION = strValue
                                            }
                                            if let strValue = response["ALERGY_NONE"] as? String{
                                                data.ALERGY_NONE = strValue
                                            }
                                            if let strValue = response["FMEDICALHISTORYCD"] as? String{
                                                data.FMEDICALHISTORYCD = strValue
                                            }
                                            if let strValue = response["SC_EXERCISE"] as? String{
                                                data.SC_EXERCISE = strValue
                                            }
                                            if let strValue = response["SC_EXERCISEDUR"] as? String{
                                                data.SC_EXERCISEDUR = strValue
                                            }
                                            if let strValue = response["SC_DIET"] as? String{
                                                data.SC_DIET = strValue
                                            }
                                            if let strValue = response["SC_DIETPHY"] as? String{
                                                data.SC_DIETPHY = strValue
                                            }
                                            if let strValue = response["SC_MEALPRDAY"] as? String{
                                                data.SC_MEALPRDAY = strValue
                                            }
                                            if let strValue = response["SC_SALTINTAKE"] as? String{
                                                data.SC_SALTINTAKE = strValue
                                            }
                                            if let strValue = response["SC_FATINTAKE"] as? String{
                                                data.SC_FATINTAKE = strValue
                                            }
                                            if let strValue = response["SC_CAFFINE"] as? String{
                                                data.SC_CAFFINE = strValue
                                            }
                                            if let strValue = response["SC_CAFFINEINTAKE"] as? String{
                                                data.SC_CAFFINEINTAKE = strValue
                                            }
                                            if let strValue = response["SC_RANKFATINTAKE"] as? String{
                                                data.SC_RANKFATINTAKE = strValue
                                            }
                                            if let strValue = response["SC_CAFFINEPERDAY"] as? String{
                                                data.SC_CAFFINEPERDAY = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOL"] as? String{
                                                data.SC_ALCOHOL = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLTYP"] as? String{
                                                data.SC_ALCOHOLTYP = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLPWK"] as? String{
                                                data.SC_ALCOHOLPWK = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLCN"] as? String{
                                                data.SC_ALCOHOLCN = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLCN_DES"] as? String{
                                                data.SC_ALCOHOLCN_DES = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLSTOP"] as? String{
                                                data.SC_ALCOHOLSTOP = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLSTOP_DES"] as? String{
                                                data.SC_ALCOHOLSTOP_DES = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLBO"] as? String{
                                                data.SC_ALCOHOLBO = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLBO_DES"] as? String{
                                                data.SC_ALCOHOLBO_DES = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLBG"] as? String{
                                                data.SC_ALCOHOLBG = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLBG_DES"] as? String{
                                                data.SC_ALCOHOLBG_DES = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLDR"] as? String{
                                                data.SC_ALCOHOLDR = strValue
                                            }
                                            if let strValue = response["SC_ALCOHOLDR_DES"] as? String{
                                                data.SC_ALCOHOLDR_DES = strValue
                                            }
                                            if let strValue = response["SC_TOBACCO"] as? String{
                                                data.SC_TOBACCO = strValue
                                            }
                                            if let strValue = response["SC_TOBACCO_DES"] as? String{
                                                data.SC_TOBACCO_DES = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCIG"] as? String{
                                                data.SC_TOBACCOCIG = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOPKSDAY"] as? String{
                                                data.SC_TOBACCOPKSDAY = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOPKSWEEK"] as? String{
                                                data.SC_TOBACCOPKSWEEK = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCHW"] as? String{
                                                data.SC_TOBACCOCHW = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCHW_DES"] as? String{
                                                data.SC_TOBACCOCHW_DES = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCPP"] as? String{
                                                data.SC_TOBACCOCPP = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCPP_DES"] as? String{
                                                data.SC_TOBACCOCPP_DES = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCCG"] as? String{
                                                data.SC_TOBACCOCCG = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOCCG_DES"] as? String{
                                                data.SC_TOBACCOCCG_DES = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOYRS"] as? String{
                                                data.SC_TOBACCOYRS = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOYRS_DES"] as? String{
                                                data.SC_TOBACCOYRS_DES = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOYRSQT"] as? String{
                                                data.SC_TOBACCOYRSQT = strValue
                                            }
                                            if let strValue = response["SC_TOBACCOYRSQT_DES"] as? String{
                                                data.SC_TOBACCOYRSQT_DES = strValue
                                            }
                                            if let strValue = response["SC_DRUGRCST"] as? String{
                                                data.SC_DRUGRCST = strValue
                                            }
                                            if let strValue = response["SC_DRUGRCST_DES"] as? String{
                                                data.SC_DRUGRCST_DES = strValue
                                            }
                                            if let strValue = response["SC_DRUGRCSTNDL"] as? String{
                                                data.SC_DRUGRCSTNDL = strValue
                                            }
                                            if let strValue = response["SC_DRUGRCSTNDL_DES"] as? String{
                                                data.SC_DRUGRCSTNDL_DES = strValue
                                            }
                                            if let strValue = response["SC_DRUGPHY"] as? String{
                                                data.SC_DRUGPHY = strValue
                                            }
                                            if let strValue = response["SC_SEX"] as? String{
                                                data.SC_SEX = strValue
                                            }
                                            if let strValue = response["SC_SEXPREG"] as? String{
                                                data.SC_SEXPREG = strValue
                                            }
                                            if let strValue = response["SC_SEXCONTRA"] as? String{
                                                data.SC_SEXCONTRA = strValue
                                            }
                                            if let strValue = response["SC_SEXDISCOM"] as? String{
                                                data.SC_SEXDISCOM = strValue
                                            }
                                            if let strValue = response["SC_SEXILLNESSPHY"] as? String{
                                                data.SC_SEXILLNESSPHY = strValue
                                            }
                                            if let strValue = response["SC_MENTALSTRESS"] as? String{
                                                data.SC_MENTALSTRESS = strValue
                                            }
                                            if let strValue = response["SC_MENTALDEPRESS"] as? String{
                                                data.SC_MENTALDEPRESS = strValue
                                            }
                                            if let strValue = response["SC_MENTALPANIC"] as? String{
                                                data.SC_MENTALPANIC = strValue
                                            }
                                            if let strValue = response["SC_MENTALEAT"] as? String{
                                                data.SC_MENTALEAT = strValue
                                            }
                                            if let strValue = response["SC_MENTALCRY"] as? String{
                                                data.SC_MENTALCRY = strValue
                                            }
                                            if let strValue = response["SC_MENTALSUICIDE"] as? String{
                                                data.SC_MENTALSUICIDE = strValue
                                            }
                                            if let strValue = response["SC_MENTALSLEEP"] as? String{
                                                data.SC_MENTALSLEEP = strValue
                                            }
                                            if let strValue = response["SC_MENTALCOUNSEL"] as? String{
                                                data.SC_MENTALCOUNSEL = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYALONE"] as? String{
                                                data.SC_PSAFETYALONE = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYFALL"] as? String{
                                                data.SC_PSAFETYFALL = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYVISION"] as? String{
                                                data.SC_PSAFETYVISION = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYABUSE"] as? String{
                                                data.SC_PSAFETYABUSE = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYSUNBURN"] as? String{
                                                data.SC_PSAFETYSUNBURN = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYSUNEXP"] as? String{
                                                data.SC_PSAFETYSUNEXP = strValue
                                            }
                                            if let strValue = response["SC_PSAFETYSEATBLT"] as? String{
                                                data.SC_PSAFETYSEATBLT = strValue
                                            }
                                            if let strValue = response["WH_MENSTAG"] as? String{
                                                data.WH_MENSTAG = strValue
                                            }
                                            if let strValue = response["WH_MENSTLASTDT"] as? String{
                                                data.WH_MENSTLASTDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["WH_MENSTDAYS"] as? String{
                                                data.WH_MENSTDAYS = strValue
                                            }
                                            if let strValue = response["WH_HEAVYPERIODS"] as? String{
                                                data.WH_HEAVYPERIODS = strValue
                                            }
                                            if let strValue = response["WH_PREGCOUNT"] as? String{
                                                data.WH_PREGCOUNT = strValue
                                            }
                                            if let strValue = response["WH_LIVEBIRTH"] as? String{
                                                data.WH_LIVEBIRTH = strValue
                                            }
                                            if let strValue = response["WH_PREGBRFEED"] as? String{
                                                data.WH_PREGBRFEED = strValue
                                            }
                                            if let strValue = response["WH_INFECTION"] as? String{
                                                data.WH_INFECTION = strValue
                                            }
                                            if let strValue = response["WH_CESAREAN"] as? String{
                                                data.WH_CESAREAN = strValue
                                            }
                                            if let strValue = response["WH_PROC"] as? String{
                                                data.WH_PROC = strValue
                                            }
                                            if let strValue = response["WH_URINEBLOOD"] as? String{
                                                data.WH_URINEBLOOD = strValue
                                            }
                                            if let strValue = response["WH_FLASHSWEAT"] as? String{
                                                data.WH_FLASHSWEAT = strValue
                                            }
                                            if let strValue = response["WH_MENSTSYMPTOM"] as? String{
                                                data.WH_MENSTSYMPTOM = strValue
                                            }
                                            if let strValue = response["WH_BREASTSELFEXM"] as? String{
                                                data.WH_BREASTSELFEXM = strValue
                                            }
                                            if let strValue = response["WH_BREASTSYMPTOM"] as? String{
                                                data.WH_BREASTSYMPTOM = strValue
                                            }
                                            if let strValue = response["WH_PELPEPSMEAR"] as? String{
                                                data.WH_PELPEPSMEAR = self.formatDate(strValue)
                                            }
                                            if let strValue = response["MH_URINATE"] as? String{
                                                data.MH_URINATE = strValue
                                            }
                                            if let strValue = response["MH_URINATEBURN"] as? String{
                                                data.MH_URINATEBURN = strValue
                                            }
                                            if let strValue = response["MH_URINATEBLOOD"] as? String{
                                                data.MH_URINATEBLOOD = strValue
                                            }
                                            if let strValue = response["MH_URINATEDISCHARGE"] as? String{
                                                data.MH_URINATEDISCHARGE = strValue
                                            }
                                            if let strValue = response["MH_URINATEFORCE"] as? String{
                                                data.MH_URINATEFORCE = strValue
                                            }
                                            if let strValue = response["MH_KDBLDPROSINF"] as? String{
                                                data.MH_KDBLDPROSINF = strValue
                                            }
                                            if let strValue = response["MH_EMPTYBLADDER"] as? String{
                                                data.MH_EMPTYBLADDER = strValue
                                            }
                                            if let strValue = response["MH_ERECTION"] as? String{
                                                data.MH_ERECTION = strValue
                                            }
                                            if let strValue = response["MH_TESTICLEPN"] as? String{
                                                data.MH_TESTICLEPN = strValue
                                            }
                                            if let strValue = response["MH_PROSRECEXAM"] as? String{
                                                data.MH_PROSRECEXAM = self.formatDate(strValue)
                                            }
                                            if let strValue = response["DIABETES_MELLITUS"] as? String{
                                                data.DIABETES_MELLITUS = strValue
                                            }
                                            if let strValue = response["DIABETES_MED_DET"] as? String{
                                                data.DIABETES_MED_DET = strValue
                                            }
                                            if let strValue = response["DIABETES_SINCE_WHEN"] as? String{
                                                data.DIABETES_SINCE_WHEN = strValue
                                            }
                                            if let strValue = response["HYPERTENSION"] as? String{
                                                data.HYPERTENSION = strValue
                                            }
                                            if let strValue = response["HYPERTENSION_MED_DET"] as? String{
                                                data.HYPERTENSION_MED_DET = strValue
                                            }
                                            if let strValue = response["HYPERTENSION_SINCE_WHEN"] as? String{
                                                data.HYPERTENSION_SINCE_WHEN = strValue
                                            }
                                            if let strValue = response["SC_AD"] as? String{
                                                data.SC_AD = strValue
                                            }
                                            if let strValue = response["SC_ADDETAILS"] as? String{
                                                data.SC_ADDETAILS = strValue
                                            }
                                            if let strValue = response["SC_RELIGIONBELIEF"] as? String{
                                                data.SC_RELIGIONBELIEF = strValue
                                            }
                                            if let strValue = response["SC_RELIGIONBELREM"] as? String{
                                                data.SC_RELIGIONBELREM = strValue
                                            }
                                            if let strValue = response["SC_INFO"] as? String{
                                                data.SC_INFO = strValue
                                            }
                                            if let strValue = response["SC_EDUCATION"] as? String{
                                                data.SC_EDUCATION = strValue
                                            }
                                            if let strValue = response["SC_ENGLISH"] as? String{
                                                data.SC_ENGLISH = strValue
                                            }
                                            if let strValue = response["SC_LANGUAGE"] as? String{
                                                data.SC_LANGUAGE = strValue
                                            }
                                            if let strValue = response["SYMPTOMCD"] as? String{
                                                data.SYMPTOMCD = strValue
                                            }
                                            if let strValue = response["OTHSYMPTOM"] as? String{
                                                data.OTHSYMPTOM = strValue
                                            }
                                            if let strValue = response["HEALTHMGRCD"] as? String{
                                                data.HEALTHMGRCD = strValue
                                            }
                                            if let strValue = response["HEALTHMGRNM"] as? String{
                                                data.HEALTHMGRNM = strValue
                                            }
                                            if let strValue = response["HEALTHMGRUPDDT"] as? String{
                                                data.HEALTHMGRUPDDT = self.formatDate(strValue)
                                            }
                                            if let strValue = response["HEALTHMGRNOTE"] as? String{
                                                data.HEALTHMGRNOTE = strValue
                                            }
                                            if let strValue = response["PATIENTRATING"] as? String{
                                                data.PATIENTRATING = strValue
                                            }
                                            if let strValue = response["ADVISETOPATIENT"] as? String{
                                                data.ADVISETOPATIENT = strValue
                                            }
                                            if let strValue = response["SHOWADVISETOPATIENT"] as? String{
                                                data.SHOWADVISETOPATIENT = strValue
                                            }
                                            if let strValue = response["ADVISETOPATIENTDT"] as? String{
                                                data.ADVISETOPATIENTDT = self.formatDate(strValue)
                                            }
                                        }
                                    }
                                    if(data.HRAID == ""){
                                        data.CARDNO = self.healthRiskAssessmentBo.cardNo!
                                        data.PATIENTNM = self.healthRiskAssessmentBo.name!
                                        data.GENDER = self.healthRiskAssessmentBo.gender!
                                        data.DOB = self.healthRiskAssessmentBo.dateOfBirth!
                                        data.EMPID = self.healthRiskAssessmentBo.employeeId!
                                        data.MEMCTLNO = self.healthRiskAssessmentBo.memberControlNo!
                                        data.PAYORCD = self.healthRiskAssessmentBo.payorCode!
                                        data.CORPCD = self.healthRiskAssessmentBo.corpCode!
                                        data.ICNO = self.healthRiskAssessmentBo.nationalId!
                                        data.DEPID = self.healthRiskAssessmentBo.dependentId!
                                    }
                                    self.healthRiskAssessmentModel = data
                                    self.performSegue(withIdentifier: "health_risk_assessment_step", sender: self)
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postHealthRiskAssessmentByCardNoUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postHealthRiskAssessmentByCardNoUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func formatDate(_ strDate : String) -> String{
        if strDate != ""{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: strDate)
            return (date?.getFormattedDate(format: "dd/MM/yyyy"))!
        }
        return ""
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "health_risk_assessment_step"){
            let vc = segue.destination as! HealthRiskAssessmentStepViewController
            vc.stepNumber = 1
            vc.stepNumberDisplay = 1
            vc.healthRiskAssessmentModel = self.healthRiskAssessmentModel
            vc.headerImageStr = self.headerImageStr
            vc.pageTitle = self.pageTitle
            return
        }
    }

}
