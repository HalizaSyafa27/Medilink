//
//  StatusDetailsViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/25/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class StatusDetailsViewController: UIViewController {
    
    @IBOutlet var pageTitleLbl: UILabel!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var claimIdLbl: UILabel!
    @IBOutlet var applicationStatusLbl: UILabel!
    @IBOutlet var submittedDateTimeLbl: UILabel!
    @IBOutlet var hospitalLbl: UILabel!
    @IBOutlet var remarksLbl: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var doctorLbl: UILabel!
    @IBOutlet var appointmentDateLbl: UILabel!
    @IBOutlet var coverageIdLbl: UILabel!
    @IBOutlet var viewStatus: UIView!
    @IBOutlet var viewReqDate: UIView!
    @IBOutlet var viewHospital: UIView!
    @IBOutlet var viewDoctor: UIView!
    @IBOutlet var viewConsultationDate: UIView!
    @IBOutlet var viewRemarks: UIView!
    @IBOutlet var dateOfConsultationTopConstraint: NSLayoutConstraint!
    @IBOutlet var lblBP: UILabel!
    @IBOutlet var lblTemp: UILabel!
    @IBOutlet var lblPulse: UILabel!
    @IBOutlet var lblTitleDoctor: UILabel!
    @IBOutlet var lbltitleHospital: UILabel!
    @IBOutlet var lbltitleBP: UILabel!
    @IBOutlet var lbltitleTemp: UILabel!
    @IBOutlet var lbltitlePulse: UILabel!
    @IBOutlet var lbltitleRemark: UILabel!
    @IBOutlet var viewBP: UIView!
    @IBOutlet var viewTemp: UIView!
    @IBOutlet var viewPulse: UIView!
    @IBOutlet var lblTitleLast1: UILabel!
    @IBOutlet var lblTitleLast2: UILabel!
    @IBOutlet var viewLast2: UIView!
    @IBOutlet var viewLast1: UIView!
    @IBOutlet var lblLast1: UILabel!
    @IBOutlet var lblLast2: UILabel!
    @IBOutlet var viewRemarksHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblTitleStatus: UILabel!
    @IBOutlet var lblTitleReqDate: UILabel!
    @IBOutlet var lblTitleDateOfConsultation: UILabel!
    @IBOutlet weak var btnViewLetter: UIButton!
    
    var selectedStatus = StatusBo()
    var className = ""
    var strHeaderImageName = ""
    var cardNo = ""
    var pageTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
        setData()
    }
    
    func initDesigns() {
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.hospitalAdmissionGLRequest)) {
            lblHeader?.text = "GL Status"
        }else if (className == StringConstant.pharmacyRequest) {
            lblHeader?.text = "Pharmacy Supplies Order Status"
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            lblHeader?.text = "Claim Status"
        }else if (className == StringConstant.teleconsultRequest) {
            lblHeader?.text = "Teleconsult Status"
        }else if className == StringConstant.teleconsultAppoinments{
            lblHeader?.text = "Teleconsult Appoinments"
        }
        if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)) {
            if selectedStatus.GLRequestId == ""
            {
                self.btnViewLetter.isHidden = true
            }
        }
        else if selectedStatus.GLClaimNo == "" {
            self.btnViewLetter.isHidden = true
        }
        else if (className == StringConstant.uploadMedicalChit){
            if selectedStatus.GLClaimNo == ""{
                self.btnViewLetter.isHidden = true
            }
        }
        
        print("CardNo.=== \(cardNo)")
        
        if className == StringConstant.teleconsultRequest{
            dateOfConsultationTopConstraint.constant = 20 //281
            lblTitleDoctor.text = "Symptoms"
            lbltitleHospital.text = "Existing Illness"
            lbltitleBP.text = "Drug Allergies"
            lbltitlePulse.isHidden = true
            viewPulse.isHidden = true
            lbltitleTemp.isHidden = true
            viewTemp.isHidden = true
            viewLast2.isHidden = true
            viewLast1.isHidden = true
            lblTitleLast1.isHidden = true
            lblTitleLast2.isHidden = true
        }else if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)){
            lblTitleStatus.text = "TeleAppoinment Status"
            lblTitleReqDate.text = "Consultation Date"
            lbltitleHospital.text = "Provider Name"
            lblTitleDoctor.text = "Symptoms"
            lbltitleBP.text = "Existing Illness"
            lbltitleTemp.text = "Drug Allergies"
            lbltitlePulse.text = "Advice To Patient"
            lblTitleLast1.text = "Mode of Consult"
            lblTitleLast2.text = "Appointment Date"
            lblTitleDateOfConsultation.text = "Discharge Date"
            lbltitleRemark.text = "Case Note"
            
        }else{
            dateOfConsultationTopConstraint.constant =  -60 //20
            lbltitleBP.isHidden = true
            viewBP.isHidden = true
            lbltitleTemp.isHidden = true
            viewTemp.isHidden = true
            lbltitlePulse.isHidden = true
            viewPulse.isHidden = true
            viewLast2.isHidden = true
            viewLast1.isHidden = true
            lblTitleLast1.isHidden = true
            lblTitleLast2.isHidden = true
        }
        
        pageTitleLbl.text = pageTitle
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        viewStatus.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewStatus.layer.borderWidth = 1.0
        
        viewReqDate.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewReqDate.layer.borderWidth = 1.0
        
        viewHospital.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewHospital.layer.borderWidth = 1.0
        
        viewDoctor.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewDoctor.layer.borderWidth = 1.0
        
        viewConsultationDate.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewConsultationDate.layer.borderWidth = 1.0
        
        viewRemarks.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewRemarks.layer.borderWidth = 1.0
        
        viewBP.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewBP.layer.borderWidth = 1.0
        
        viewTemp.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewTemp.layer.borderWidth = 1.0
        
        viewPulse.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewPulse.layer.borderWidth = 1.0
        
        viewLast1.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewLast1.layer.borderWidth = 1.0
        
        viewLast2.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        viewLast2.layer.borderWidth = 1.0
        
    }
    
    func setData() {
        //claimIdLbl?.text = "Tracking No (Claim ID) - " + selectedStatus.GLClaimNo
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.hospitalAdmissionGLRequest)) {
            claimIdLbl.text = selectedStatus.GLRequestId == "" ? "GL Request ID - NA" : "GL Request ID - \(selectedStatus.GLRequestId)"
            coverageIdLbl.text = selectedStatus.GLClaimNo == "" ? "GL No - NA" : "GL No - \(selectedStatus.GLClaimNo)"
        }else if (className == StringConstant.pharmacyRequest) {
            claimIdLbl.text = selectedStatus.GLRequestId == "" ? "Pharmacy Request ID - NA" : "Pharmacy Request ID - \(selectedStatus.GLRequestId)"
            coverageIdLbl.text = selectedStatus.GLClaimNo == "" ? "Claim No - NA" : "Claim No - \(selectedStatus.GLClaimNo)"
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            claimIdLbl.text = selectedStatus.GLRequestId == "" ? "Claim Request ID - NA" : "Claim Request ID - \(selectedStatus.GLRequestId)"
            coverageIdLbl.text = selectedStatus.GLClaimNo == "" ? "Claim No - NA" : "Claim No - \(selectedStatus.GLClaimNo)"
        }else if (className == StringConstant.teleconsultRequest) {
            claimIdLbl.text = selectedStatus.GLRequestId == "" ? "GLRequest ID - NA" : "GLRequest ID - \(selectedStatus.GLRequestId)"
            coverageIdLbl.text = selectedStatus.GLClaimNo == "" ? "Claim No - NA" : "Claim No - \(selectedStatus.GLClaimNo)"
        }
        
        applicationStatusLbl?.text = selectedStatus.status
        submittedDateTimeLbl?.text = selectedStatus.insertDate
        remarksLbl?.text = selectedStatus.remarks == "" ? "" : selectedStatus.remarks.htmlToString
        hospitalLbl?.text = selectedStatus.hospitalName == "" ? "NA" : selectedStatus.hospitalName
        doctorLbl?.text = selectedStatus.doctor == "" ? "" : selectedStatus.doctor
        appointmentDateLbl?.text = selectedStatus.consultationDate == "" ? "" : selectedStatus.consultationDate
        if (className == StringConstant.teleconsultRequest) {
            hospitalLbl?.text = selectedStatus.pastMedicalHistory == "" ? "NA" : selectedStatus.pastMedicalHistory
            doctorLbl?.text = selectedStatus.symptoms == "" ? "NA" : selectedStatus.symptoms
            lblBP?.text = selectedStatus.drugAlergies == "" ? "NA" : selectedStatus.drugAlergies
            lblTemp?.text = selectedStatus.temp == "" ? "NA" : selectedStatus.temp
            lblPulse?.text = selectedStatus.pulse == "" ? "NA" : selectedStatus.pulse
            remarksLbl?.text = selectedStatus.approvedRemarks == "" ? "NA" : selectedStatus.approvedRemarks.htmlToString
        }else if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)) {//Appointment,Prescription,Lab,Referral
            claimIdLbl.text = selectedStatus.GLRequestId == "" ? "TeleRequest ID - NA" : "TeleRequest ID - \(selectedStatus.GLRequestId)"
            coverageIdLbl.text = selectedStatus.coverageID == "" ? "Coverage ID - NA" : "Coverage ID - \(selectedStatus.coverageID)"
            submittedDateTimeLbl?.text = selectedStatus.consultationDate == "" ? "NA" : selectedStatus.consultationDate
            hospitalLbl?.text = selectedStatus.providerName == "" ? "NA" : selectedStatus.providerName
            doctorLbl?.text = selectedStatus.symptoms == "" ? "NA" : selectedStatus.symptoms
            lblBP?.text = selectedStatus.existingillness == "" ? "NA" : selectedStatus.existingillness
            lblTemp?.text = selectedStatus.drugAlergies == "" ? "NA" : selectedStatus.drugAlergies
            lblPulse?.text = selectedStatus.advicetoPatient == "" ? "NA" : selectedStatus.advicetoPatient
            lblLast1?.text = selectedStatus.modeofConsult == "" ? "NA" : selectedStatus.modeofConsult
            lblLast2?.text = selectedStatus.insertDate == "" ? "NA" : selectedStatus.insertDate
            appointmentDateLbl?.text = selectedStatus.dischargeDate == "" ? "NA" : selectedStatus.dischargeDate
            remarksLbl?.text = selectedStatus.caseNote == "" ? "NA" : selectedStatus.caseNote
        }
        
        viewRemarksHeightConstraint.constant = (CGFloat((remarksLbl?.text?.height(constraintedWidth: (remarksLbl?.frame.size.width)!, font: (remarksLbl?.font)!))!) < 80) ? 80 : CGFloat((remarksLbl?.text?.height(constraintedWidth: (remarksLbl?.frame.size.width)!, font: (remarksLbl?.font)!))!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewGLLeterBtnAction (_ sender: UIButton) {
        self.performSegue(withIdentifier: "viewGlLetter", sender: self)
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "viewGlLetter"){
            let vc = segue.destination as! ViewGLLettersViewController
            vc.className = className
            vc.claimId = selectedStatus.GLClaimNo
            vc.isFromStatusDetailsPage = true
            vc.pageTitle = pageTitle
            vc.strHeader = lblHeader!.text!
            vc.cardNo = cardNo
            
            if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)) {
                vc.teleReqId = selectedStatus.GLRequestId
            }
            
            return
        }
    }
    
    

}

extension String {
func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.text = self
    label.font = font
    label.sizeToFit()

    return label.frame.height
 }
}
