//
//  DependentViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 13/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class DependentViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, QRScannerDelegate {
    
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var imgViewProfile: UIImageView!
    
    @IBOutlet var tblDependants: UITableView!
    //@IBOutlet var button3: UIButton!
    //@IBOutlet var btnMemberName: UIButton?
    @IBOutlet var viewbuttonContainer: UIView!
    @IBOutlet var viewProfile: UIView!
    @IBOutlet var lblMemberName: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var viewArrow: UIView!
    @IBOutlet var viewButtonContainerHeight: NSLayoutConstraint!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewPrincipalHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewProfileHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblDependentsHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgViewUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMemberSince: UILabel!
    @IBOutlet weak var lblPrinciple: UILabel!
    @IBOutlet weak var lblDependents: UILabel!
    @IBOutlet var imgViewVirtualCard: UIImageView!
    @IBOutlet var imgViewArrowRight: UIImageView!
    @IBOutlet var viewProfile2: UIButton!
    @IBOutlet weak var lblMemberSince1: UILabel!
    @IBOutlet var btnBack: UIButton!
    
    var className = ""
    var pageTitle = ""
    var strCardNo = ""
    var strPolicyNo = ""
    var strName = ""
    var strType: String! = ""
    var strPayorMemberId = ""
    var strGender = ""
    var strDateOfBirth = ""
    var strEmployeeId = ""
    var strMemberControlNo = ""
    var strPayorCode = ""
    var strCorpCode = ""
    var strNationalId = ""
    var strDependentId = ""
    var strPdfBase64 = ""
    var arayCoverageBo = [CoverageBo]()
    var memberBo = MemberBo()
    var selectedPolicy = PolicyDetailsBo()
    var strHeaderImageName = ""
    var isForMedicalChitView = false
    var isFromPrinciple = false
    var arrPlanCode = [PlanCodeBo]()
    var isFromSubmenuScreen = false
    
    var dokterinToken = ""
    var dokterinUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDesign()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.enableAutoToolbar = true
        
//      self.viewbuttonContainer.backgroundColor = UIColor.init(red: 34.0/255.0, green: 69.0/255.0, blue: 75.0/255.0, alpha: 0.5)
        //self.viewProfile.backgroundColor = UIColor.init(red: 34.0/255.0, green: 69.0/255.0, blue: 75.0/255.0, alpha: 0.5)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initDesign(){
       // self.viewProfile.isHidden = true
        self.lblPageHeader?.text = className == StringConstant.virtualCard ? "My Virtual Card" : pageTitle
        let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
        if userType == "D"
        {
            self.lblPrinciple.text = "Dependents"
            self.lblDependents.isHidden = true
            self.viewProfile.isHidden = true
            self.viewProfile2.isHidden = true
            self.button1.isHidden = true
            self.button2.isHidden = true
            self.viewProfileHeightConstraint.constant = 0
            self.viewPrincipalHeightConstraint.constant = 0
            self.lblDependentsHeightConstraint.constant = 0
            self.viewButtonContainerHeight.constant = 0
            self.imgViewProfile.isHidden = true
            self.imgViewUser.isHidden = true
        }else{
            self.lblPrinciple.text = "Principal"
            self.lblDependents.text = "Dependents"
        }
        self.viewProfile2.isHidden = true
        self.btnBack.isHidden = true
        self.btnBack.isHidden = isFromSubmenuScreen == true ? false : true
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        //self.btnMemberName.setTitle(memberBo.name, for: .normal)
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.QRCode) || (className == StringConstant.virtualCard) || (className == StringConstant.uploadMedicalChit) || (className == StringConstant.hospitalAdmissionGLRequest) || (className == StringConstant.teleconsultRequest) || (className == StringConstant.HealthRiskAssessment)) {
            let attributedText = NSMutableAttributedString(string: memberBo.name!, attributes: [NSAttributedString.Key.font: UIFont.init(name: "Poppins-SemiBold", size: 14.0)!])
            self.lblMemberName.attributedText = attributedText
        }else{
            let attributedText = NSMutableAttributedString(string: memberBo.name!, attributes: [NSAttributedString.Key.font: UIFont.init(name: "Poppins-SemiBold", size: 14.0)!])
            attributedText.append(NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 14.0)!]))
            self.lblMemberName.attributedText = attributedText
            self.viewButtonContainerHeight.constant = 0
            self.viewArrow.isHidden = false
        }
        
        imgViewHeader.image = className == StringConstant.selfDoctor ? UIImage.init(named: "self_doctor") : UIImage.init(named: strHeaderImageName)
        
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.size.width / 2
        imgViewProfile.layer.borderColor = UIColor.white.cgColor
        imgViewProfile.layer.borderWidth = 2.0
        self.imgViewProfile.clipsToBounds = true
        self.button1.layer.cornerRadius = 3
        self.button1.clipsToBounds = true
        self.button2.layer.cornerRadius = 3
        self.button2.clipsToBounds = true
//        self.button3.layer.cornerRadius = 3
//        self.button3.clipsToBounds = true
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                imgViewProfile.image = image
                imgViewUser.image = image
            }
        }
        
//        if AppConstant.screenSize.width == 320 {//iPhone 5
//            self.button1.titleLabel?.font = UIFont.systemFont(ofSize: 11)
//            self.button2.titleLabel?.font = UIFont.systemFont(ofSize: 11)
//        }
        
        if (className == StringConstant.outPatientSPGLRequest) {
            self.button1.setTitle("REQUEST", for: .normal)
            self.button2.setTitle("GL STATUS", for: .normal)
            //self.btnMemberName.isUserInteractionEnabled = false
        }else if (className == StringConstant.pharmacyRequest) {
            self.button1.setTitle("REQUEST", for: .normal)
            self.button2.setTitle(" PHARMACY STATUS ", for: .normal)
            //self.btnMemberName.isUserInteractionEnabled = false
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            self.button1.setTitle("SUBMIT", for: .normal)
            self.button2.setTitle(" CLAIM STATUS ", for: .normal)
            //self.btnMemberName.isUserInteractionEnabled = false
        }else if ((className == StringConstant.myEmployeeEntitlementBenefit) || (className == StringConstant.myPolicyEntitlement)) {
            self.button1.setTitle("VIEW", for: .normal)
            self.button2.isHidden = true
            self.viewButtonContainerHeight.constant = 0
            viewbuttonContainer.isHidden = true
        }else if (className == StringConstant.myTodayGLStatus) {
            self.button1.setTitle("VIEW", for: .normal)
            self.button2.isHidden = true
            self.viewButtonContainerHeight.constant = 0
            viewbuttonContainer.isHidden = true
        }else if (className == StringConstant.viewGLLetter) {
            self.button1.setTitle("VIEW GL", for: .normal)
            self.button2.isHidden = true
            self.viewButtonContainerHeight.constant = 0
            viewbuttonContainer.isHidden = true
        }else if ((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.InPatient) || (className == StringConstant.OPSP) || (className == StringConstant.GP)  || (className == StringConstant.Pharmacy)) {
            self.button1.setTitle("VIEW", for: .normal)
            self.button2.isHidden = true
            self.viewButtonContainerHeight.constant = 0
            viewbuttonContainer.isHidden = true
        }else if (className == StringConstant.QRCode) {
            self.button2.setTitle("SCAN", for: .normal)
            self.button1.isHidden = true
        }else if (className == StringConstant.uploadMedicalChit) {
//            self.button2.setTitle("REQUEST", for: .normal)
//            self.button1.isHidden = true
            self.button1.setTitle("  UPLOAD  ", for: .normal)
            self.button2.setTitle("VIEW", for: .normal)
        }else if (className == StringConstant.QRCode) {
            self.button1.isHidden = true
            self.button2.isHidden = true
            //self.viewButtonContainerHeight.constant = 0
            viewbuttonContainer.isHidden = false
//            self.button3.setTitle("SCAN", for: .normal)
//            self.button3.isHidden = false
//            self.button3.isUserInteractionEnabled = true
            //self.btnMemberName.isUserInteractionEnabled = false
        }else if (className == StringConstant.hospitalAdmissionGLRequest) {
            self.button1.setTitle("REQUEST", for: .normal)
            self.button2.setTitle("GL STATUS", for: .normal)
        }else if (className == StringConstant.teleconsultRequest) {
            self.button1.setTitle(" REQUEST ", for: .normal)
            self.button2.setTitle("STATUS", for: .normal)
            //self.btnMemberName.isUserInteractionEnabled = false
        }else if (className == StringConstant.HealthRiskAssessment) {
            self.button1.setTitle("REQUEST", for: .normal)
            self.button2.setTitle("VIEW", for: .normal)
        }else{
            self.button1.isHidden = true
            self.button2.isHidden = true
            
        }
        
        if ((className == StringConstant.myTodayGLStatus) || (className == StringConstant.viewGLLetter) || (className == StringConstant.viewReimbursementClaim) || (className == StringConstant.InPatient) || (className == StringConstant.OPSP)  || (className == StringConstant.GP)  || (className == StringConstant.Pharmacy) || (className == StringConstant.myPolicyEntitlement) || (className == StringConstant.gl) || (className == StringConstant.claim)) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapForView(sender:)))
            viewProfile.addGestureRecognizer(tap)
            
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapForView(sender:)))
            viewbuttonContainer.addGestureRecognizer(tap1)
        }
        
        if ((className == StringConstant.virtualCard) || (className == StringConstant.myEmployeeEntitlementBenefit) || (className == StringConstant.myTodayGLStatus) || (className == StringConstant.viewGLLetter) || (className == StringConstant.gl) || (className == StringConstant.claim) || (className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.selfDoctor) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery) || (className == StringConstant.Dokterin)){
            //Hide Topview1
            //Show TopView2
            viewProfile.isHidden = true
            viewProfile2.isHidden = false
            viewProfileHeightConstraint.constant = 0
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            if userType != "D"
            {
                viewPrincipalHeightConstraint.constant = 92
            }
            lblName.text = memberBo.name!
            imgViewVirtualCard.isHidden = true
            imgViewArrowRight.isHidden = false
            
            if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.selfDoctor) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)){//TeleConsult Icons & SelfDoctor
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapForviewProfile2(sender:)))
                viewProfile2.addGestureRecognizer(tap)
            }
            
            if (className == StringConstant.virtualCard){
                 imgViewVirtualCard.isHidden = false
                imgViewVirtualCard.image = UIImage.init(named: "virtualCard_placeHolder")
                imgViewArrowRight.isHidden = true
            }
        }else{
            //Show Topview1
            //Hide TopView2
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            if userType != "D"
            {
                viewProfileHeightConstraint.constant = 80
            }
            viewPrincipalHeightConstraint.constant = 0
            viewProfile2.isHidden = true
            viewProfile.isHidden = false
            
        }
        
        lblMemberSince.text = ""
        lblMemberSince1.text = ""
        
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.height/2
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.width/2
        self.imgViewUser.layer.borderWidth = 1.5
        self.imgViewUser.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewUser.clipsToBounds = true
        
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.height/2
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.width/2
        self.imgViewProfile.layer.borderWidth = 1.5
        self.imgViewProfile.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewProfile.clipsToBounds = true
        
    }
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnPrincipleViewAction(_ sender: UIButton) {
        self.isFromPrinciple = true
        self.MemberAction()
    }
    
    @objc func handleTapForView(sender: UITapGestureRecognizer? = nil) {
        //Manas
//        self.viewbuttonContainer.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
//        self.viewProfile.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        self.MemberAction()
    }
    
    @objc func handleTapForviewProfile2(sender: UITapGestureRecognizer? = nil) {
        isFromPrinciple = true
        if (className == StringConstant.selfDoctor){
            strCardNo = memberBo.cardNo!
            strPayorMemberId = memberBo.PAYOR_MEMBER_ID!
            self.performSegue(withIdentifier: "selfDoctor", sender: self)
        }else{
            strCardNo = memberBo.cardNo!
            strName = memberBo.name!
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func button1Action(_ sender: Any) {
        strCardNo = memberBo.cardNo!
        strPolicyNo = memberBo.policyNo!
        strName = memberBo.name!
        isFromPrinciple = true
        
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.hospitalAdmissionGLRequest) || (className == StringConstant.teleconsultRequest)) {
            serviceCallToGetPlanCode()
        }else if ((className == StringConstant.myEmployeeEntitlementBenefit) || (className == StringConstant.myPolicyEntitlement)) {
            self.performSegue(withIdentifier: "policy_info", sender: self)
        }else if (className == StringConstant.myTodayGLStatus) {
            self.performSegue(withIdentifier: "my_today_gl_status", sender: self)
        }else if (className == StringConstant.viewGLLetter) {
            //self.performSegue(withIdentifier: "view_gl_letter", sender: self)
            self.performSegue(withIdentifier: "viewGlLetterList", sender: self)
        }else if ((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.InPatient) || (className == StringConstant.OPSP)  || (className == StringConstant.GP)  || (className == StringConstant.Pharmacy) || (className == StringConstant.gl) || (className == StringConstant.claim)){
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if (className == StringConstant.uploadMedicalChit) {
            isForMedicalChitView = false
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if (className == StringConstant.HealthRiskAssessment) {
            strGender = memberBo.gender ?? ""
            strDateOfBirth = memberBo.dateOfBirth ?? ""
            strEmployeeId = memberBo.employeeId ?? ""
            strMemberControlNo = memberBo.memberControlNo ?? ""
            strPayorCode = memberBo.payorCode ?? ""
            strCorpCode = memberBo.corpCode ?? ""
            strNationalId = memberBo.nationalId ?? ""
            strDependentId = memberBo.dependentId ?? ""
            checkHealthRiskAssessmentByCardNo()
        }
    }
    
    @IBAction func button2Action(_ sender: Any) {
        strCardNo = memberBo.cardNo!
        strName = memberBo.name!
        strPolicyNo = memberBo.policyNo!
        isFromPrinciple = true
        
        if (className == StringConstant.outPatientSPGLRequest) {
            strType = "02"
        }else if (className == StringConstant.pharmacyRequest) {
            strType = "03"
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            strType = "01"
        }else if (className == StringConstant.hospitalAdmissionGLRequest) {
            strType = "04"
        }else if (className == StringConstant.teleconsultRequest) {
            strType = "05"
        }
        
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.hospitalAdmissionGLRequest) || (className == StringConstant.teleconsultRequest)) {
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if (className == StringConstant.QRCode) {
            self.performSegue(withIdentifier: "qr_scanner", sender: self)
        }else if (className == StringConstant.virtualCard) {
//            self.lblDependents.text = "Dependants"
            self.performSegue(withIdentifier: "virtual_card_screen", sender: self)
        }else if (className == StringConstant.uploadMedicalChit) {
            isForMedicalChitView = true
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if (className == StringConstant.HealthRiskAssessment) {
            serviceCallToDownloadDocumentHealthHistoryQuestionnaire()
        }
    }
    
    @IBAction func btnMemberNameAction(_ sender: UIButton) {
        self.MemberAction()
    }
    
    @objc func cellButton1Action(_ sender: Any) {
        let dependentBo = memberBo.dependentArray[(sender as AnyObject).tag]
        strCardNo = dependentBo.cardNo!
        strPolicyNo = dependentBo.policyNo!
        strName = dependentBo.name!
        isFromPrinciple = false
        
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.hospitalAdmissionGLRequest) || (className == StringConstant.teleconsultRequest)) {
            serviceCallToGetPlanCode()
        }else if (className == StringConstant.uploadMedicalChit) {
            isForMedicalChitView = false
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if (className == StringConstant.HealthRiskAssessment) {
            strGender = dependentBo.gender ?? ""
            strDateOfBirth = dependentBo.dateOfBirth ?? ""
            strEmployeeId = dependentBo.employeeId ?? ""
            strMemberControlNo = dependentBo.memberControlNo ?? ""
            strPayorCode = dependentBo.payorCode ?? ""
            strCorpCode = dependentBo.corpCode ?? ""
            strNationalId = dependentBo.nationalId ?? ""
            strDependentId = dependentBo.dependentId ?? ""
            checkHealthRiskAssessmentByCardNo()
        }
    }
    @objc func cellButton2Action(_ sender: UIButton) {
        let dependentBo = memberBo.dependentArray[sender.tag]
        strCardNo = dependentBo.cardNo!
        strPolicyNo = dependentBo.policyNo!
        strName = dependentBo.name!
        isFromPrinciple = false
        
        if (className == StringConstant.outPatientSPGLRequest) {
            strType = "02"
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if (className == StringConstant.pharmacyRequest) {
            strType = "03"
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            strType = "01"
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if (className == StringConstant.hospitalAdmissionGLRequest) {
            strType = "04"
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if (className == StringConstant.teleconsultRequest) {
            strType = "05"
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if  ((className == StringConstant.myPolicyEntitlement)) {
            self.performSegue(withIdentifier: "policy_info", sender: self)
        }else if (className == StringConstant.myTodayGLStatus) {
            self.performSegue(withIdentifier: "my_today_gl_status", sender: self)
        }else if (className == StringConstant.viewGLLetter) {
            //self.performSegue(withIdentifier: "view_gl_letter", sender: self)
            self.performSegue(withIdentifier: "viewGlLetterList", sender: self)
        }else if ((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.InPatient) || (className == StringConstant.OPSP)  || (className == StringConstant.GP)  || (className == StringConstant.Pharmacy) || (className == StringConstant.gl) || (className == StringConstant.claim)){
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if (className == StringConstant.QRCode) {
            self.performSegue(withIdentifier: "qr_scanner", sender: self)
        }else if (className == StringConstant.uploadMedicalChit) {
            isForMedicalChitView = true
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if (className == StringConstant.virtualCard) {
            self.performSegue(withIdentifier: "virtual_card_screen", sender: self)
        }else if (className == StringConstant.HealthRiskAssessment) {
            serviceCallToDownloadDocumentHealthHistoryQuestionnaire()
        }
    }
    
    func MemberAction(){
        strCardNo = memberBo.cardNo!
        strPolicyNo = memberBo.policyNo!
        strName = memberBo.name!
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest)) {
            self.performSegue(withIdentifier: "submit_request", sender: self)
            //self.serviceCallToGetPolicyCard()
        }else if ((className == StringConstant.myEmployeeEntitlementBenefit) || (className == StringConstant.myPolicyEntitlement)){
            self.performSegue(withIdentifier: "policy_info", sender: self)
        }else if (className == StringConstant.myTodayGLStatus) {
            self.performSegue(withIdentifier: "my_today_gl_status", sender: self)
        }else if className == StringConstant.viewGLLetter{
            //self.performSegue(withIdentifier: "view_gl_letter", sender: self)
            self.performSegue(withIdentifier: "viewGlLetterList", sender: self)
        }else if ((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.InPatient) || (className == StringConstant.OPSP)  || (className == StringConstant.GP)  || (className == StringConstant.Pharmacy) || (className == StringConstant.gl) || (className == StringConstant.claim)){
            self.performSegue(withIdentifier: "claim_list", sender: self)
        }else if className == StringConstant.QRCode{
            self.performSegue(withIdentifier: "qr_scanner", sender: self)
        }else if className == StringConstant.virtualCard{
            self.performSegue(withIdentifier: "virtual_card_screen", sender: self)
        }else if ((className == StringConstant.Dokterin)){
            self.serviceCallToGetToken3dParty()
        }
    }
    
    // MARK: Tableview Delegates & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return className == StringConstant.virtualCard || (className == StringConstant.myEmployeeEntitlementBenefit) || (className == StringConstant.uploadMedicalChit) ? UITableView.automaticDimension : UITableView.automaticDimension //70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberBo.dependentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (className == StringConstant.virtualCard) || (className == StringConstant.myEmployeeEntitlementBenefit){
            let cell = tableView.dequeueReusableCell(withIdentifier: "VirtualCardTableViewCell", for: indexPath as IndexPath) as! VirtualCardTableViewCell
            let dependentBo = self.memberBo.dependentArray[indexPath.row]
            cell.lblName.text = dependentBo.name
            cell.lblMemberSince.text = ""
            
            if (className == StringConstant.virtualCard){
                cell.imgViewArrowRight.isHidden = true
                cell.imgViewVirtualCard.isHidden = false
            } else if (className == StringConstant.myEmployeeEntitlementBenefit){
                cell.imgViewArrowRight.isHidden = false
                cell.imgViewVirtualCard.isHidden = true
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "dependent_cell", for: indexPath as IndexPath) as! DependentTableViewCell
            cell.viewArrow.isHidden = true
            
            if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.QRCode) || (className == StringConstant.virtualCard) || (className == StringConstant.uploadMedicalChit) || (className == StringConstant.hospitalAdmissionGLRequest)){
                cell.selectionStyle = .none
            }
            
            cell.lblMemberSince.text = ""
            let dependentBo = self.memberBo.dependentArray[indexPath.row]
            cell.lblName.text = dependentBo.name
            
            if (className == StringConstant.outPatientSPGLRequest) {
                cell.button1.setTitle("REQUEST", for: .normal)
                cell.button2.setTitle("GL STATUS", for: .normal)
            }else if (className == StringConstant.pharmacyRequest) {
                cell.button1.setTitle("REQUEST", for: .normal)
                cell.button2.setTitle(" PHARMACY STATUS ", for: .normal)
            }else if (className == StringConstant.reimbersmentClaimRequest) {
                cell.button1.setTitle("SUBMIT", for: .normal)
                cell.button2.setTitle("CLAIM STATUS", for: .normal)
            }else if ((className == StringConstant.myEmployeeEntitlementBenefit) || (className == StringConstant.myPolicyEntitlement)) {
                cell.button2.setTitle("VIEW", for: .normal)
                cell.button1.isHidden = true
                cell.button1widthConstraint.constant = 0
                cell.button2.isHidden = true
                cell.button2widthConstraint.constant = 0
                cell.viewArrow.isHidden = false
            }else if (className == StringConstant.myTodayGLStatus) {
                cell.button2.setTitle("VIEW", for: .normal)
                cell.button1.isHidden = true
                cell.button1widthConstraint.constant = 0
                cell.button2.isHidden = true
                cell.button2widthConstraint.constant = 0
                cell.viewArrow.isHidden = false
            }else if (className == StringConstant.viewGLLetter) {
                cell.button2.setTitle("VIEW GL", for: .normal)
                cell.button1.isHidden = true
                cell.button1widthConstraint.constant = 0
                cell.button2.isHidden = true
                cell.button2widthConstraint.constant = 0
                cell.viewArrow.isHidden = false
            }else if ((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.InPatient) || (className == StringConstant.OPSP)  || (className == StringConstant.GP)  || (className == StringConstant.Pharmacy)) {
                cell.button2.setTitle("VIEW", for: .normal)
                cell.button1.isHidden = true
                cell.button1widthConstraint.constant = 0
                cell.button2.isHidden = true
                cell.button2widthConstraint.constant = 0
                cell.viewArrow.isHidden = false
            }else if (className == StringConstant.QRCode) {
                cell.button2.setTitle("SCAN", for: .normal)
                cell.button1.isHidden = true
                cell.button1widthConstraint.constant = 0
                //cell.button2.isHidden = true
                //cell.button2widthConstraint.constant = 0
            }else if (className == StringConstant.virtualCard) {
                cell.button2.setTitle("VIEW", for: .normal)
                cell.button1.isHidden = true
                cell.button1widthConstraint.constant = 0
                //cell.button2.isHidden = true
                //cell.button2widthConstraint.constant = 0
            }else if (className == StringConstant.uploadMedicalChit) {
//                cell.button2.setTitle("REQUEST", for: .normal)
//                cell.button1.isHidden = true
//                cell.button1widthConstraint.constant = 0
                
                cell.button1.setTitle("  UPLOAD  ", for: .normal)
                cell.button2.setTitle("VIEW", for: .normal)
                
            }else if (className == StringConstant.hospitalAdmissionGLRequest) {
                cell.button1.setTitle("REQUEST", for: .normal)
                cell.button2.setTitle("GL STATUS", for: .normal)
                
            }else if (className == StringConstant.teleconsultRequest) {
                cell.button1.setTitle(" REQUEST ", for: .normal)
                cell.button2.setTitle("STATUS", for: .normal)
            }else if (className == StringConstant.HealthRiskAssessment) {
                cell.button1.setTitle("REQUEST", for: .normal)
                cell.button2.setTitle("VIEW", for: .normal)
            }else{
                cell.button1.isHidden = true
                cell.button2.isHidden = true
                cell.viewArrow.isHidden = false
            }
            
            cell.button1.tag = indexPath.row
            cell.button1.addTarget(self, action: #selector(cellButton1Action(_:)), for: .touchUpInside)
            
            cell.button2.tag = indexPath.row
            cell.button2.addTarget(self, action: #selector(cellButton2Action(_:)), for: .touchUpInside)
            
            return cell
               
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.isFromPrinciple = false
        
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest) || (className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.QRCode) || (className == StringConstant.hospitalAdmissionGLRequest) || (className == StringConstant.uploadMedicalChit)){
            
        }else if (className == StringConstant.virtualCard){
            let dependentBo = memberBo.dependentArray[indexPath.row]
            strCardNo = dependentBo.cardNo!
            strPolicyNo = dependentBo.policyNo!
            strName = dependentBo.name!
            self.performSegue(withIdentifier: "virtual_card_screen", sender: self)
        }else if (className == StringConstant.myEmployeeEntitlementBenefit){
            let dependentBo = memberBo.dependentArray[indexPath.row]
               strCardNo = dependentBo.cardNo!
               strPolicyNo = dependentBo.policyNo!
               strName = dependentBo.name!
           
            self.performSegue(withIdentifier: "policy_info", sender: self)
             
        }else if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)){//Teleconsult Appoinments,Prescription,Lab
            let dependentBo = memberBo.dependentArray[indexPath.row]
            strCardNo = dependentBo.cardNo!
            strName = dependentBo.name!
            self.performSegue(withIdentifier: "status_screen", sender: self)
        }else if (className == StringConstant.selfDoctor){
            let dependentBo = memberBo.dependentArray[indexPath.row]
            strCardNo = dependentBo.cardNo!
            strPayorMemberId = dependentBo.PAYOR_MEMBER_ID!
            self.performSegue(withIdentifier: "selfDoctor", sender: self)
        }else{
            let cell = tableView.cellForRow(at: indexPath) as! DependentTableViewCell
            cellButton2Action(cell.button2)
        }
    }
    
    //MARK: QR Scanner Delegate
    func detectedQRcodeValue(QrValue: String){
        print("detectedQRcodeValue")
        let newQRVal = QrValue.replacingOccurrences(of: "=", with: ":")
        let newQRValFormat = newQRVal.replacingOccurrences(of: "'", with: "\"")
        let dict = AppConstant.convertToDictionary(text: newQRValFormat)
        
        if (dict?["providerCode"]) != nil {
            let strProviderCode: String = dict?["providerCode"] as! String
            print("provider code: \(strProviderCode)")
            self.serviceCallForQRCoveragebyProvider(providerCode: strProviderCode)
            return
        }else{
            self.displayAlert(message: StringConstant.invalidQrCode)
        }
    }
    
    func showPopupForQR(tag: Int, text: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRPopUpViewController") as! QRPopUpViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        AppConstant.intPopupTag = tag
        
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
    
    //MARK: Service Call
    func serviceCallToGetPlanCode(){
            if(AppConstant.hasConnectivity()) {//true connected
                
                AppConstant.showHUD()
                let json = "{\"pstCardNo\":\"\(strCardNo)\"}"
                
                print("Param=== \(json)")
                
                var url = URL(string: AppConstant.postPlanCodeForSPGLRequestUrl)!
                
                if(className == StringConstant.outPatientSPGLRequest){
                    url = URL(string: AppConstant.postPlanCodeForSPGLRequestUrl)!
                }else if(className == StringConstant.hospitalAdmissionGLRequest){
                    url = URL(string: AppConstant.postPlanCodeForHospitalGLRequestUrl)!
                }else if(className == StringConstant.pharmacyRequest){
                    url = URL(string: AppConstant.postPlanCodeForPharmacyRequestUrl)!
                }else if(className == StringConstant.reimbersmentClaimRequest){
                    url = URL(string: AppConstant.postPlanCodeUrl)!
                }
                
                let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
                AFManager.request(request).responseJSON {
                    (response) in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        self.arrPlanCode.removeAll()
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetPlanCode()
                                }
                            })
                        }else{
                            let dict = response.result.value as! [String : AnyObject]
                            
                            if let status = dict["Status"] as? String {
                                if(status == "1"){//success
                                    if let arrPlanList = dict["PlanList"] as? [[String: Any]]{
                                        if(arrPlanList.count > 0){
                                            for dictPlanCode in arrPlanList{
                                                let planBo = PlanCodeBo()
                                                if let planc = dictPlanCode["PLANCODE"] as? String {
                                                    planBo.planCode = planc
                                                }
                                                if let fdesc = dictPlanCode["FDESC"] as? String {
                                                    planBo.FDESC = fdesc
                                                }
                                                self.arrPlanCode.append(planBo)
                                            }
                                        }
                                        //Move to Submit Page
                                        self.performSegue(withIdentifier: "submit_request", sender: self)
                                    }
                                }else{
                                    if let msg = dict["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                    }
                                    
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postPlanCodeForSPGLRequestUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postPlanCodeForSPGLRequestUrl)
                        break
                        
                    }
                }
                
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
    }
    
    func serviceCallToGetPolicyCard(){
        if(AppConstant.hasConnectivity()) {//true connected
            
            AppConstant.showHUD()
            //let json = "{\"pstUserID\":\"\(userName)\",\"pstPassword\":\"\(password)\"}"
            let json = "{\"pstCardNo\":\"\(strCardNo)\"}"
            let url = URL(string: AppConstant.getPolicyUserCafrdUrl)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                AppConstant.hideHUD()
                debugPrint(response)
                
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetPolicyCard()
                            }
                        })
                    }else{
                        let dict = response.result.value as! [String : AnyObject]
                        
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                self.performSegue(withIdentifier: "submit_request", sender: self)
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                                
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getPolicyUserCafrdUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.getPolicyUserCafrdUrl)
                    break
                    
                }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallForQRCoveragebyProvider(providerCode: String){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            AppConstant.strQRPopupProviderCode = providerCode
            AppConstant.strQRPopupCardNo = strCardNo
            let params: Parameters = [
                "pstProviderCode": providerCode,
            ]
            print("params===\(params)")
            print("url===\(AppConstant.postQRCoveragebyProviderUrl)")
            AFManager.request( AppConstant.postQRCoveragebyProviderUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallForQRCoveragebyProvider(providerCode: providerCode)
                                }
                            })
                        }else{
                            self.arayCoverageBo.removeAll()
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let responceArray = dict!["CoverageList"] as? [[String: Any]]{
                                        if responceArray.count > 0 {
                                            for item in responceArray {
                                                let coverageBo = CoverageBo()
                                                if let coverageCode = item["CoverageCode"] as? String {
                                                    coverageBo.coverageCode = coverageCode
                                                }
                                                if let fdesc = item["CoverageDesc"] as? String {
                                                    coverageBo.desc = fdesc
                                                }
                                                self.arayCoverageBo.append(coverageBo)
                                            }
                                        }
                                        self.performSegue(withIdentifier: "list_coverage", sender: self)
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg )
                                        }
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postQRCoveragebyProviderUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallForMobileInquiry(providerCode: String){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            AppConstant.strQRPopupProviderCode = providerCode
            AppConstant.strQRPopupCardNo = strCardNo
            
            let params: Parameters = [
                "pstProviderCode": providerCode,
                "pstCoverageCode": "",
                "pstCardNo": strCardNo
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.QRMobileInquiryUrl)")
            
            var strApprovalCode = ""
            var strPopupCode = ""
            AFManager.request( AppConstant.QRMobileInquiryUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallForMobileInquiry(providerCode: providerCode)
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    //success
                                    let responceArray = dict?["QRMobileInquiryList"] as? [[String: Any]]
                                    if ((responceArray?.count)! > 0){
                                        let dict = responceArray![0]
                                        
                                        if let text = dict["PrintableText"] as? String{
                                            strPopupCode = text
                                            AppConstant.strQRPopupValue = strPopupCode
                                        }
                                        if let approvalCode = dict["ApprovalCode"] as? String{
                                            strApprovalCode = approvalCode
                                            
                                            if(strApprovalCode == StringConstant.approvalCode){
                                                AppConstant.intPopupTag = 101
                                                self.showPopupForQR(tag: 101, text: strPopupCode)
                                            }else{
                                                AppConstant.intPopupTag = 102
                                                self.showPopupForQR(tag: 102, text: strPopupCode)
                                            }
                                        }
                                        
                                    }
                                    
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.QRMobileInquiryUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.QRMobileInquiryUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func checkHealthRiskAssessmentByCardNo(){
        if(AppConstant.hasConnectivity())
        {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstCardNo": self.strCardNo
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
                                    self.checkHealthRiskAssessmentByCardNo()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    //success
                                    self.performSegue(withIdentifier: "health_risk_assessment", sender: self)
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
    
    func serviceCallToDownloadDocumentHealthHistoryQuestionnaire(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstCardNo": self.strCardNo,
                "BrowserWidth": 1450,
                "MarginsLeft": 27,
                "MarginsRight": 27,
                "HeaderHeight": 30,
                "FooterHeight": 30
            ]
            print("url===\(AppConstant.downloadDocumentHealthHistoryQuestionnaireUrl)")
            print("param===\(params)")
            AFManager.request( AppConstant.downloadDocumentHealthHistoryQuestionnaireUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToDownloadDocumentHealthHistoryQuestionnaire()
                            }
                        })
                    }else{
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        if let status = dict!["Status"] as? String {
                            if(status == "1"){
                                if let pdfBase64String = dict!["Data"] as? String{
                                    self.strPdfBase64 =  pdfBase64String
                                    self.performSegue(withIdentifier: "view_gl_letter", sender: self)
                                }
                            }else{
                                AppConstant.hideHUD()
                                if let msg = dict!["Message"] as? String{
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
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.downloadDocumentHealthHistoryQuestionnaireUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetToken3dParty(){
        if (AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstAppID": "1234567890",
                "pstCardNo": self.strCardNo
            ]
            print("url===\(AppConstant.getToken3dPartyUrl)")
            print("param===\(params)")
            AFManager.request( AppConstant.getToken3dPartyUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if (headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetToken3dParty()
                            }
                        })
                    } else {
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        if let status = dict!["Status"] as? String {
                            if (status == "1") {
                                let url = dict!["Url"] as! String
                                self.dokterinToken = dict!["Token"] as! String
                                self.dokterinUrl = "\(url)\(self.dokterinToken)"
                                self.performSegue(withIdentifier: "dokterin", sender: self)
                            } else {
                                AppConstant.hideHUD()
                                if let msg = dict!["Message"] as? String {
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
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.getToken3dPartyUrl)
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
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "submit_request"){
            let vc = segue.destination as! SubmitRequestViewController
            vc.className = className
            vc.pageHeader = pageTitle
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            vc.strCardNo = strCardNo
            vc.strPolicyNo = strPolicyNo
            vc.strName = strName
            vc.strHeaderImageName = strHeaderImageName
            vc.arrPlanCode = arrPlanCode
            return
        }else if (segue.identifier == "policy_info"){
            let vc = segue.destination as! PolicyInfoViewController
            vc.policyBo = selectedPolicy
            vc.strCardNo = strCardNo
            vc.strPolicyNo = strPolicyNo
            vc.strHeaderImageName = strHeaderImageName
            vc.pageHeader = self.pageTitle
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            return
        }else if (segue.identifier == "my_today_gl_status"){
            let vc = segue.destination as! MyTodayGLStatusViewController
            vc.strCardNo = strCardNo
            vc.strHeaderImageName = strHeaderImageName
            vc.pageHeader = self.pageTitle
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            return
        }else if (segue.identifier == "view_gl_letter"){
            let vc = segue.destination as! ViewGLLettersViewController
            vc.className = className
            vc.strPdfBase64 =  strPdfBase64
            vc.cardNo = strCardNo
            vc.strHeaderImageName = strHeaderImageName
            vc.strHeader = self.pageTitle
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            return
        }else if (segue.identifier == "viewGlLetterList"){
            let vc = segue.destination as! ViewGlLetterListViewController
            vc.cardNo = strCardNo
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            vc.strHeaderImageName = strHeaderImageName
            vc.strHeader = self.pageTitle
            return
        }else if (segue.identifier == "claim_list"){
            let vc = segue.destination as! ClaimListViewController
            vc.cardNo = strCardNo
            vc.className = className
            vc.strPageHeader = isForMedicalChitView == true ? "View Medical Chit" : pageTitle
            vc.strHeaderImageName = strHeaderImageName
            vc.cardNo = strCardNo
            vc.isForMedicalChitView = isForMedicalChitView
            vc.strPageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            return
        }else if (segue.identifier == "status_screen"){
            let vc = segue.destination as! StatusViewController
            vc.className = className
            vc.strCardNo = strCardNo
            vc.strName = strName
            vc.strType = strType
            vc.strHeaderImageName = strHeaderImageName
            vc.strHeader = self.pageTitle
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            return
        }else if (segue.identifier == "qr_scanner"){
            let vc = segue.destination as! QRScannerViewController
            vc.delegate = self
            vc.pageHeader = self.pageTitle
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            vc.headerImage = strHeaderImageName
             
            return
        }else if (segue.identifier == "virtual_card_screen"){
            let vc = segue.destination as! VirtualCardViewController
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            vc.strCardNo = strCardNo
            return
        }else if (segue.identifier == "selfDoctor"){
            let vc = segue.destination as! SelfDoctorViewController
            vc.strCardNo = strCardNo
            vc.strPayorMemberId = strPayorMemberId
            vc.pageTitle = isFromPrinciple == true ? "Principal" : "Dependent"
            return
        }else if (segue.identifier == "list_coverage"){
            let vc = segue.destination as! ListCoverageViewController
            vc.arayCoverageBo = arayCoverageBo
            vc.titlePage = "List Coverage"
            return
        }else if (segue.identifier == "health_risk_assessment"){
            let vc = segue.destination as! HealthRiskAssessmentViewController
            let healthRiskAssessmentBo = HealthRiskAssessmentBo()
            healthRiskAssessmentBo.cardNo = strCardNo
            healthRiskAssessmentBo.name = strName
            healthRiskAssessmentBo.gender = strGender
            healthRiskAssessmentBo.dateOfBirth = strDateOfBirth
            healthRiskAssessmentBo.employeeId = strEmployeeId
            healthRiskAssessmentBo.memberControlNo = strMemberControlNo
            healthRiskAssessmentBo.payorCode = strPayorCode
            healthRiskAssessmentBo.corpCode = strCorpCode
            healthRiskAssessmentBo.nationalId = strNationalId
            healthRiskAssessmentBo.dependentId = strDependentId
            vc.healthRiskAssessmentBo = healthRiskAssessmentBo
            vc.pageTitle = pageTitle
            return
        }else if (segue.identifier == "dokterin"){
            let vc = segue.destination as! DokterinViewController
            vc.classname = className
            vc.headerTitle = "Dokterin"
            vc.myUrl = self.dokterinUrl
            return
        }
    }
}
extension UIButton {
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        let imageSize: CGSize = imageView!.image!.size
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + padding), right: 0.0)
        let labelString = NSString(string: titleLabel!.text!)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
}


