//
//  RequestViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 14/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
// Manas mahala



import UIKit
import Alamofire
import DatePickerDialog
var AFManager = SessionManager()

class RequestViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChooseDelegate {
    
    @IBOutlet var btnCoverage: UIButton!
    @IBOutlet var lblPagetitle: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lbldateofConsulation: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblHospitalName: UILabel!
    @IBOutlet var lblPhysicianName: UILabel!
    @IBOutlet var lblPrimaryDiagnosys: UILabel!
    @IBOutlet var lblSecondaryDiagnosys: UILabel!
    @IBOutlet var lblThirdDiagnosys: UILabel!
    @IBOutlet var lblInvoiceNo: UILabel!
    @IBOutlet var lblMedication: UILabel!
    @IBOutlet var lblConsultation: UILabel!
    @IBOutlet var lblOthers: UILabel!
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var lblMobile: UILabel!
    @IBOutlet var lblRemarks: UILabel!
    @IBOutlet var txtFldPhysicianame: UITextField!
    @IBOutlet var txtFldDateOfConsultation: UITextField!
    @IBOutlet var txtFldTime: UITextField!
    @IBOutlet var txtFldHospitalName: UITextField!
    @IBOutlet var txtFldPrimaryDiagnosys: UITextField!
    @IBOutlet var txtFldSecondaryDiagnosys: UITextField!
    @IBOutlet var txtFldThirdDiagnosys: UITextField!
    @IBOutlet var txtFldInvoiceNo: UITextField!
    @IBOutlet var txtFldMedication: UITextField!
    @IBOutlet var txtFldConsultation: UITextField!
    @IBOutlet var txtFldOthers: UITextField!
    @IBOutlet var txtFldTotalAmount: UITextField!
    @IBOutlet var txtFldMobile: UITextField!
    @IBOutlet var viewHospitalName: UIView!
    @IBOutlet var viewPhysicianName: UIView!
    @IBOutlet var viewThirdDiagnosys: UIView!
    @IBOutlet var viewInvoiceNo: UIView!
    @IBOutlet var viewMedication: UIView!
    @IBOutlet var viewConsultation: UIView!
    @IBOutlet var viewOthers: UIView!
    @IBOutlet var viewTotalAmount: UIView!
    
    @IBOutlet var imgviewHospitalName: UIImageView!
    @IBOutlet var imgviewInvoiceNo: UIImageView!
    @IBOutlet var imgviewMedication: UIImageView!
    @IBOutlet var imgviewConsultation: UIImageView!
    @IBOutlet var imgviewTotalAmount: UIImageView!
    @IBOutlet var imgviewOthers: UIImageView!
    @IBOutlet var imgviewPrimaryDiagnosys: UIImageView!
    @IBOutlet var imgviewSecondaryDiagnosys: UIImageView!
    @IBOutlet var imgviewPhysicianname: UIImageView!
    @IBOutlet var imgviewThirdDiagnosys: UIImageView!
    @IBOutlet var imgviewPhysicianName: UIImageView!
    @IBOutlet var txtFldPlanCode: UITextField!
    
    @IBOutlet var txtViewRemarks: UITextView!
    @IBOutlet var btnHospitalInfo: UIButton!
    @IBOutlet var btnHospitalInfoHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblDateOfConsultationWidthConstraint: NSLayoutConstraint!
    @IBOutlet var lblHospitalNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPhysicianNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblThirdDiagnosysHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblInvoiceNoHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblMedicationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblConsultationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblOthersHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblTotalAmountHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldHospitalNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldPhysicianNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldThirdDiagnosysHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldInvoiceNoHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldMedicationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldConsultationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldOthersHeightConstraint: NSLayoutConstraint!
    @IBOutlet var txtFldTotalAmountHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewHospitalNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewPhysicianNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewThirdDiagnosysHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewInvoiceNoHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewMedicationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewConsultationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewOthersHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewTotalAmountHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var timeWithPhysicianNameVSConstraint: NSLayoutConstraint!
    @IBOutlet var invoiceNoWithMobileNoVSConstraint: NSLayoutConstraint!
    @IBOutlet var thirdDiagnosysWithInvoiceNoVSConstraint: NSLayoutConstraint!
    @IBOutlet var hospitalNameWithPrimaryDiagnosysVSConstraint: NSLayoutConstraint!
    @IBOutlet var secondaryDiagnosysWithThirdDiagnosysVSConstraint: NSLayoutConstraint!
    
    @IBOutlet var imgviewHospitalNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewPhysicianNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewThirdDiagnosysHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewInvoiceNoHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewMedicationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewConsultationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewOthersHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgviewTotalAmountHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var imgViewRightArrow: UIImageView!
    @IBOutlet var imgViewHeader: UIImageView!
    
    var separatorColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
    
    var keyBoardHeight : CGFloat = 0.0
    var selectedField = ""
    var tblHeight : CGFloat = 0.0
    var extraHeight: CGFloat = 150.0
    var params: Parameters = [:]
    
    var strHeaderImageName = ""
    var className = ""
    var pageTitle = ""
    var strCardNo = ""
    var strPlanCode = ""
    var strPolicyNo = ""
    var strName = ""
    var strPharmacyName = ""
    var strPharacyProviderCode = ""
    var strPharacyDeliveryCode = ""
    var strSelectedCoverageCode = ""
    var arrHospitals = [HospitalBo]()
    var arrDiagnosys = [DiagnosysBo]()
    var arrDiagnosysFromSP = [DiagnosysBo]()
    var arrDelivery = [DeliveryAddressBo]()
    var arrCoverage = [CoverageBo]()
    var arrphysician = [PhysicianBo]()
    var arrAdmissionType = [AdmissionTypeBo]()
    var arrFiltered = [CustomObject]()
    var arrChoose = [CustomObject]()
    var arrChooseFromSP = [CustomObject]()
    var dataSource = [CustomObject]()
    var strSelectedProviderCode = ""
    var strSelectedPhysicianCode = ""
    var strSelectedAdmissionTypeCode = ""
    var strSelectedPrimaryDiagnosys = ""
    var strSelectedSecondaryDiagnosys = ""
    var strSelectedthirdDiagnosys = ""
    let tblChoose: UITableView = UITableView()
    let cellReuseIdentifier = "cell"
    var dateFormated = ""
    var timeFormated = ""
    var arrPlanCode = [PlanCodeBo]()
    let currencySymbol = AppConstant.retrievFromDefaults(key: StringConstant.currencySymbol)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initDesign()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDesign(){
        lblMedication.text = "Medication(" + currencySymbol + ")"
        lblConsultation.text = "Consultation(" + currencySymbol + ")"
        lblOthers.text = "Others(" + currencySymbol + ")"
        lblTotalAmount.text = "Total Amount(" + currencySymbol + ")"
        self.lblName.text = strName
        self.txtFldPlanCode.text = strPlanCode
        self.txtViewRemarks.layer.borderColor = AppConstant.themeLightGrayColor.cgColor //UIColor.white.cgColor
        self.txtViewRemarks.layer.borderWidth = 1.0
        
        let strDate = NSMutableAttributedString(string: "Date of Consultation*")
        strDate.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 20, length: 1))
        lbldateofConsulation.attributedText = strDate
        
        let strHospitalName = NSMutableAttributedString(string: "Hospital Name*")
        strHospitalName.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 13, length: 1))
        lblHospitalName.attributedText = strHospitalName
        if (className == StringConstant.outPatientSPGLRequest || className == StringConstant.hospitalAdmissionGLRequest)
        {
            let strPhysiciaName = NSMutableAttributedString(string: "Physician Name*")
            strPhysiciaName.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 14, length: 1))
            lblPhysicianName.attributedText = strPhysiciaName
            
            let strPrimaryDiagnosis = NSMutableAttributedString(string: "Primary Diagnosis*")
            strPrimaryDiagnosis.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 17, length: 1))
            lblPrimaryDiagnosys.attributedText = strPrimaryDiagnosis
       }
        let strTime = NSMutableAttributedString(string: "Time(hh:mm)*")
        strTime.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 11, length: 1))
        lblTime.attributedText = strTime
        
        let strMobile = NSMutableAttributedString(string: "Mobile Number*")
        strMobile.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 13, length: 1))
        lblMobile.attributedText = strMobile
        
        if AppConstant.screenSize.width == 320{
            lblDateOfConsultationWidthConstraint.constant = 114.5
        }else{
            if (className == StringConstant.reimbersmentClaimRequest) {
                lblDateOfConsultationWidthConstraint.constant = (AppConstant.screenSize.width / 2) - 43
            }else{
                lblDateOfConsultationWidthConstraint.constant = 160.0
            }
        }
        
        if (className == StringConstant.outPatientSPGLRequest) {
            btnHospitalInfo.isHidden = true
            btnCoverage.isHidden = true
            btnCoverage.isUserInteractionEnabled = false
//            txtFldHospitalName.placeholder = "Type to search"
//            txtFldPhysicianame.placeholder = "Type to search"
//            txtFldPrimaryDiagnosys.placeholder = "Type to search"
//            txtFldSecondaryDiagnosys.placeholder = "Type to search"
//            txtFldThirdDiagnosys.placeholder = "Type to search"
            
            setPlaceHolder(txtFld: txtFldHospitalName, text: "Type to search")
            setPlaceHolder(txtFld: txtFldPhysicianame, text: "Type to search")
            setPlaceHolder(txtFld: txtFldPrimaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldSecondaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldThirdDiagnosys, text: "Type to search")
            
            lblInvoiceNo.isHidden = true
            lblMedication.isHidden = true
            lblConsultation.isHidden = true
            lblOthers.isHidden = true
            lblTotalAmount.isHidden = true
            
            imgviewInvoiceNo.isHidden = true
            imgviewMedication.isHidden = true
            imgviewConsultation.isHidden = true
            imgviewOthers.isHidden = true
            imgviewTotalAmount.isHidden = true
            
            txtFldInvoiceNo.isHidden = true
            txtFldMedication.isHidden = true
            txtFldConsultation.isHidden = true
            txtFldOthers.isHidden = true
            txtFldTotalAmount.isHidden = true
            
            viewInvoiceNo.isHidden = true
            viewMedication.isHidden = true
            viewConsultation.isHidden = true
            viewOthers.isHidden = true
            viewTotalAmount.isHidden = true
            
            lblInvoiceNoHeightConstraint.constant = 0
            lblMedicationHeightConstraint.constant = 0
            lblConsultationHeightConstraint.constant = 0
            lblOthersHeightConstraint.constant = 0
            lblTotalAmountHeightConstraint.constant = 0
            
            imgviewInvoiceNoHeightConstraint.constant = 0
            imgviewMedicationHeightConstraint.constant = 0
            imgviewConsultationHeightConstraint.constant = 0
            imgviewOthersHeightConstraint.constant = 0
            imgviewTotalAmountHeightConstraint.constant = 0
            
            txtFldInvoiceNoHeightConstraint.constant = 0
            txtFldMedicationHeightConstraint.constant = 0
            txtFldConsultationHeightConstraint.constant = 0
            txtFldOthersHeightConstraint.constant = 0
            txtFldTotalAmountHeightConstraint.constant = 0
            
            viewInvoiceNoHeightConstraint.constant = 0
            viewMedicationHeightConstraint.constant = 0
            viewConsultationHeightConstraint.constant = 0
            viewOthersHeightConstraint.constant = 0
            viewTotalAmountHeightConstraint.constant = 0
            
            thirdDiagnosysWithInvoiceNoVSConstraint.constant = 0
            invoiceNoWithMobileNoVSConstraint.constant = 16
            
            
        }else if (className == StringConstant.pharmacyRequest) {
            btnHospitalInfo.isHidden = true
            btnCoverage.isHidden = true
            btnCoverage.isUserInteractionEnabled = false
            txtFldTotalAmount.isHidden = true
            
//            txtFldPrimaryDiagnosys?.placeholder = "Type to search"
//            txtFldSecondaryDiagnosys?.placeholder = "Type to search"
//            txtFldThirdDiagnosys?.placeholder = "Type to search"
//            txtFldPhysicianame.placeholder = "Pharmacy Name"
            
            setPlaceHolder(txtFld: txtFldPrimaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldSecondaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldThirdDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldPhysicianame, text: "Pharmacy Name")
            
            lblPhysicianName?.text = "Pharmacy Name"
            txtFldPhysicianame.isUserInteractionEnabled = false
            imgviewPhysicianName.image = UIImage.init(named: "pharmacy_gray")
            
            let strDeliveryAddress = NSMutableAttributedString(string: "Delivery Address*")
            
            
            strDeliveryAddress.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 16, length: 1))
            lblInvoiceNo.attributedText = strDeliveryAddress
            imgviewInvoiceNo.image = UIImage.init(named: "address_gray")
            
            lblHospitalName.isHidden = true
            lblInvoiceNo.isHidden = false
            lblMedication.isHidden = true
            lblConsultation.isHidden = true
            lblOthers.isHidden = true
            lblTotalAmount.isHidden = true
            
            imgviewHospitalName.isHidden = true
            imgviewInvoiceNo.isHidden = false
            imgviewMedication.isHidden = true
            imgviewConsultation.isHidden = true
            imgviewOthers.isHidden = true
            imgviewTotalAmount.isHidden = true
            
            txtFldHospitalName.isHidden = true
            txtFldInvoiceNo.isHidden = false
            txtFldMedication.isHidden = true
            txtFldConsultation.isHidden = true
            txtFldOthers.isHidden = true
            txtFldTotalAmount.isHidden = true
            
            viewHospitalName.isHidden = true
            viewInvoiceNo.isHidden = false
            viewMedication.isHidden = true
            viewConsultation.isHidden = true
            viewOthers.isHidden = true
            viewTotalAmount.isHidden = true
            
            lblHospitalNameHeightConstraint.constant = 0
            lblInvoiceNoHeightConstraint.constant = 20
            lblMedicationHeightConstraint.constant = 0
            lblConsultationHeightConstraint.constant = 0
            lblOthersHeightConstraint.constant = 0
            lblTotalAmountHeightConstraint.constant = 0
            
            imgviewHospitalNameHeightConstraint.constant = 0
            imgviewInvoiceNoHeightConstraint.constant = 25
            imgviewMedicationHeightConstraint.constant = 0
            imgviewConsultationHeightConstraint.constant = 0
            imgviewOthersHeightConstraint.constant = 0
            imgviewTotalAmountHeightConstraint.constant = 0
            
            txtFldHospitalNameHeightConstraint.constant = 0
            txtFldInvoiceNoHeightConstraint.constant = 30
            txtFldMedicationHeightConstraint.constant = 0
            txtFldConsultationHeightConstraint.constant = 0
            txtFldOthersHeightConstraint.constant = 0
            txtFldTotalAmountHeightConstraint.constant = 0
            
            viewHospitalNameHeightConstraint.constant = 0
            viewInvoiceNoHeightConstraint.constant = 1
            viewMedicationHeightConstraint.constant = 0
            viewConsultationHeightConstraint.constant = 0
            viewOthersHeightConstraint.constant = 0
            viewTotalAmountHeightConstraint.constant = 0
            
            btnHospitalInfo.isHidden = true
            btnHospitalInfoHeightConstraint.constant = 0
            
            timeWithPhysicianNameVSConstraint.constant = 16 + 67
            thirdDiagnosysWithInvoiceNoVSConstraint.constant = 67
            invoiceNoWithMobileNoVSConstraint.constant = 16
            
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            
            btnHospitalInfo.isHidden = false
            btnCoverage.isHidden = false
            btnCoverage.isUserInteractionEnabled = true
            imgViewRightArrow.isHidden = false
            let strEventDate = NSMutableAttributedString(string: "Event Date*")
            strEventDate.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 10, length: 1))
            lbldateofConsulation.attributedText = strEventDate
            
            let strInvoiceNo = NSMutableAttributedString(string: "Invoice No*")
            strInvoiceNo.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 10, length: 1))
            lblInvoiceNo.attributedText = strInvoiceNo
            
            //Primary Diagnosis
            let strDiagnosis = NSMutableAttributedString(string: "Primary Diagnosis")
//            strDiagnosis.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 17, length: 1))
            lblPrimaryDiagnosys.attributedText = strDiagnosis
            
            //Primary Diagnosis
            let strTotalAmount = NSMutableAttributedString(string: "Total amount(" + currencySymbol + ")*")
            strTotalAmount.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 16, length: 1))
            lblTotalAmount.attributedText = strTotalAmount
            let strProvider = NSMutableAttributedString(string: "Provider*")
            strProvider.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 8, length: 1))
            lblPhysicianName.attributedText = strProvider
            txtFldPhysicianame.placeholder = ""
            imgviewPhysicianName.image = UIImage.init(named: "provider_type-gray")
            
            let strCoverage = NSMutableAttributedString(string: "Coverage*")
            strCoverage.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 8, length: 1))
            lblPrimaryDiagnosys.attributedText = strCoverage
            txtFldPrimaryDiagnosys.text = "Select Coverage"
            imgviewPrimaryDiagnosys.image = UIImage.init(named: "coverage_gray")
            
            let strPrimaryDiagnosis = NSMutableAttributedString(string: "Primary Diagnosis")
//            strPrimaryDiagnosis.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 17, length: 1))
            lblSecondaryDiagnosys.attributedText = strPrimaryDiagnosis
//            txtFldSecondaryDiagnosys.placeholder = "Type To Search"
//            txtFldHospitalName.placeholder = "Type To Search"
            
            setPlaceHolder(txtFld: txtFldSecondaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldHospitalName, text: "Type to search")
            
            imgviewSecondaryDiagnosys.image = UIImage.init(named: "PrimaryDiagnosis_gray")
            
            let strMobile = NSMutableAttributedString(string: "Mobile Number")
            lblMobile.attributedText = strMobile
            
            lblHospitalName.isHidden = false
            lblPhysicianName.isHidden = true
            lblThirdDiagnosys.isHidden = true
            lblInvoiceNo.isHidden = false
            lblMedication.isHidden = false
            lblConsultation.isHidden = false
            lblOthers.isHidden = false
            lblTotalAmount.isHidden = false
            
            imgviewHospitalName.isHidden = false
            imgviewPhysicianName.isHidden = true
            imgviewThirdDiagnosys.isHidden = true
            imgviewInvoiceNo.isHidden = false
            imgviewMedication.isHidden = false
            imgviewConsultation.isHidden = false
            imgviewOthers.isHidden = false
            imgviewTotalAmount.isHidden = false
            
            txtFldHospitalName.isHidden = false
            txtFldPhysicianame.isHidden = true
            txtFldThirdDiagnosys.isHidden = true
            txtFldInvoiceNo.isHidden = false
            txtFldMedication.isHidden = false
            txtFldConsultation.isHidden = false
            txtFldOthers.isHidden = false
            txtFldTotalAmount.isHidden = false
            
            viewHospitalName.isHidden = false
            viewPhysicianName.isHidden = true
            viewThirdDiagnosys.isHidden = true
            viewInvoiceNo.isHidden = false
            viewMedication.isHidden = false
            viewConsultation.isHidden = false
            viewOthers.isHidden = false
            viewTotalAmount.isHidden = false
            
            lblHospitalNameHeightConstraint.constant = 20
            lblPhysicianNameHeightConstraint.constant = 0
            lblThirdDiagnosysHeightConstraint.constant = 0
            lblInvoiceNoHeightConstraint.constant = 20
            lblMedicationHeightConstraint.constant = 20
            lblConsultationHeightConstraint.constant = 20
            lblOthersHeightConstraint.constant = 20
            lblTotalAmountHeightConstraint.constant = 20
            
            imgviewHospitalNameHeightConstraint.constant = 25
            imgviewPhysicianNameHeightConstraint.constant = 0
            imgviewThirdDiagnosysHeightConstraint.constant = 0
            imgviewInvoiceNoHeightConstraint.constant = 25
            imgviewMedicationHeightConstraint.constant = 25
            imgviewConsultationHeightConstraint.constant = 25
            imgviewOthersHeightConstraint.constant = 25
            imgviewTotalAmountHeightConstraint.constant = 25
            
            txtFldHospitalNameHeightConstraint.constant = 30
            txtFldPhysicianNameHeightConstraint.constant = 0
            txtFldThirdDiagnosysHeightConstraint.constant = 0
            txtFldInvoiceNoHeightConstraint.constant = 30
            txtFldMedicationHeightConstraint.constant = 30
            txtFldConsultationHeightConstraint.constant = 30
            txtFldOthersHeightConstraint.constant = 30
            txtFldTotalAmountHeightConstraint.constant = 30
            
            viewHospitalNameHeightConstraint.constant = 1
            viewPhysicianNameHeightConstraint.constant = 0
            viewThirdDiagnosysHeightConstraint.constant = 0
            viewInvoiceNoHeightConstraint.constant = 1
            viewMedicationHeightConstraint.constant = 1
            viewConsultationHeightConstraint.constant = 1
            viewOthersHeightConstraint.constant = 1
            viewTotalAmountHeightConstraint.constant = 1
            
            btnHospitalInfo.isHidden = false
            btnHospitalInfoHeightConstraint.constant = 20
            
            hospitalNameWithPrimaryDiagnosysVSConstraint.constant = 16
            secondaryDiagnosysWithThirdDiagnosysVSConstraint.constant = 0
            thirdDiagnosysWithInvoiceNoVSConstraint.constant = 67
            
            let coverageBo = CoverageBo()
            coverageBo.coverageCode = ""
            coverageBo.desc = "Select Coverage"
            self.arrCoverage.append(coverageBo)
        }else if (className == StringConstant.hospitalAdmissionGLRequest) {
            btnHospitalInfo.isHidden = true
            btnCoverage.isHidden = true
            btnCoverage.isUserInteractionEnabled = false
            
//            txtFldHospitalName.placeholder = "Type to search"
//            txtFldPhysicianame.placeholder = "Type to search"
//            txtFldPrimaryDiagnosys.placeholder = "Type to search"
//            txtFldSecondaryDiagnosys.placeholder = "Type to search"
//            txtFldThirdDiagnosys.placeholder = "Type to search"
//            txtFldInvoiceNo.placeholder = "Type to search"//Admission Type
            
            setPlaceHolder(txtFld: txtFldHospitalName, text: "Type to search")
            setPlaceHolder(txtFld: txtFldHospitalName, text: "Type to search")
            setPlaceHolder(txtFld: txtFldPhysicianame, text: "Type to search")
            setPlaceHolder(txtFld: txtFldPrimaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldSecondaryDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldThirdDiagnosys, text: "Type to search")
            setPlaceHolder(txtFld: txtFldInvoiceNo, text: "Type to search")//Admission Type
            
            let strAdmType = NSMutableAttributedString(string: "Admission Type*")
            strAdmType.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 14, length: 1))
            lblInvoiceNo.attributedText = strAdmType
            
            lblInvoiceNo.isHidden = false
            //lblInvoiceNo.text = "Admission Type"
            imgviewInvoiceNo.image = UIImage.init(named: "admission_type_gray")
            
            lblMedication.isHidden = true
            lblConsultation.isHidden = true
            lblOthers.isHidden = true
            lblTotalAmount.isHidden = true
            
            imgviewInvoiceNo.isHidden = false
            imgviewMedication.isHidden = true
            imgviewConsultation.isHidden = true
            imgviewOthers.isHidden = true
            imgviewTotalAmount.isHidden = true
            
            txtFldInvoiceNo.isHidden = false
            txtFldMedication.isHidden = true
            txtFldConsultation.isHidden = true
            txtFldOthers.isHidden = true
            txtFldTotalAmount.isHidden = true
            
            viewInvoiceNo.isHidden = false
            viewMedication.isHidden = true
            viewConsultation.isHidden = true
            viewOthers.isHidden = true
            viewTotalAmount.isHidden = true
            
            //lblInvoiceNoHeightConstraint.constant = 0
            lblMedicationHeightConstraint.constant = 0
            lblConsultationHeightConstraint.constant = 0
            lblOthersHeightConstraint.constant = 0
            lblTotalAmountHeightConstraint.constant = 0
            
            //imgviewInvoiceNoHeightConstraint.constant = 0
            imgviewMedicationHeightConstraint.constant = 0
            imgviewConsultationHeightConstraint.constant = 0
            imgviewOthersHeightConstraint.constant = 0
            imgviewTotalAmountHeightConstraint.constant = 0
            
            //txtFldInvoiceNoHeightConstraint.constant = 0
            txtFldMedicationHeightConstraint.constant = 0
            txtFldConsultationHeightConstraint.constant = 0
            txtFldOthersHeightConstraint.constant = 0
            txtFldTotalAmountHeightConstraint.constant = 0
            
            //viewInvoiceNoHeightConstraint.constant = 0
            viewMedicationHeightConstraint.constant = 0
            viewConsultationHeightConstraint.constant = 0
            viewOthersHeightConstraint.constant = 0
            viewTotalAmountHeightConstraint.constant = 0
            
            //thirdDiagnosysWithInvoiceNoVSConstraint.constant = 0
            invoiceNoWithMobileNoVSConstraint.constant = 16
            
        }
        
        tblHeight = AppConstant.screenSize.height - (keyBoardHeight + 70)
        tblChoose.frame = CGRect(x: view.frame.origin.x + 20, y: AppConstant.screenSize.height - tblHeight, width: view.frame.size.width - 40, height: tblHeight)
        self.view.addSubview(tblChoose)
        tblChoose.isHidden = true
        tblChoose.layer.borderColor = UIColor.lightGray.cgColor
        tblChoose.layer.borderWidth = 1.0
        tblChoose.layer.cornerRadius = 5
        tblChoose.layer.masksToBounds = true
        
        if ((AppConstant.screenSize.width == 320) && ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.pharmacyRequest))){
            lbldateofConsulation.font = UIFont.init(name: "Poppins-Regular", size: 14.0)
            lblTime.font = UIFont.init(name: "Poppins-Regular", size: 14.0)
        }
        
        txtFldDateOfConsultation.placeholder = "Select Date"
        txtFldTime.placeholder = "Select Time"
        
        txtFldDateOfConsultation.attributedPlaceholder = NSAttributedString(string: "Select Date",
                                                   attributes: [NSAttributedString.Key.foregroundColor: separatorColor])
        txtFldTime.attributedPlaceholder = NSAttributedString(string: "Select Time",
                                                   attributes: [NSAttributedString.Key.foregroundColor: separatorColor])
        
        let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dateButtonClicked))
        self.lbldateofConsulation.addGestureRecognizer(tap1)
        self.lbldateofConsulation.isUserInteractionEnabled = true
        
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(timeButtonClicked))
        self.lblTime.addGestureRecognizer(tap2)
        self.lblTime.isUserInteractionEnabled = true
        
        serViceCallToLoadInitialData()
        tblChoose.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tblChoose.delegate = self
        tblChoose.dataSource = self
        tblChoose.backgroundColor = UIColor.color("#D9D9D9")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setPlaceHolder(txtFld: UITextField ,text: String){
        txtFld.attributedPlaceholder = NSAttributedString(string: text,
                                                                            attributes: [NSAttributedString.Key.foregroundColor: separatorColor])
    }
    
    func serViceCallToLoadInitialData(){
        if (className == StringConstant.outPatientSPGLRequest){
            self.serviceCallToGetHospitalData()
        }else if className == StringConstant.pharmacyRequest{
            self.serviceCallToGetPharmacyData()
        }else if className == StringConstant.reimbersmentClaimRequest{
            self.serviceCallToGetHospitalDataForReimbursementClaim()
        }else if (className == StringConstant.hospitalAdmissionGLRequest){
            self.serviceCallToGetHospitalData()
            self.serviceCallToGetAdmissionTypeData()
        }
        //self.serviceCallToGetDiagnosysData()
        
    }
    
    // MARK: - Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCoverageAction(_ sender: Any) {
        self.performSegue(withIdentifier: "select_coverage", sender: self)
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let strDocTcvDt = self.dateFormated + " " + self.timeFormated
        if self.isValidated() == true {
            if className == StringConstant.outPatientSPGLRequest{
                params = [
                    "fstCardNo": strCardNo,
                    "fstPolicyNo": strPolicyNo,
                    "fstPlan": strPlanCode,
                    "fstRemarks": txtViewRemarks.text!,
                    "fstDocRcvDt": strDocTcvDt,
                    "fstHospital":(strSelectedProviderCode == "") ? "" : strSelectedProviderCode,
                    "fstPhysician":(strSelectedPhysicianCode == "") ? "" : strSelectedPhysicianCode,
                    "fstPrimaryDiagnosis":(strSelectedPrimaryDiagnosys == "") ? "" : strSelectedPrimaryDiagnosys,
                    "fstSecondaryDiagnosis":(strSelectedSecondaryDiagnosys == "") ? "" : strSelectedSecondaryDiagnosys,
                    "fstThirdDiagnosis":(strSelectedthirdDiagnosys == "") ? "" : strSelectedthirdDiagnosys,
                    "fstMobileNo": txtFldMobile.text!
                    
                ]
            }else if className == StringConstant.pharmacyRequest{
                params = [
                    "fstCardNo": strCardNo,
                    "fstPolicyNo": strPolicyNo,
                    "fstPlan": strPlanCode,
                    "fstRemarks": txtViewRemarks.text!,
                    "fstDocRcvDt": strDocTcvDt,
                    "fstHospital":strPharacyProviderCode,
                    "fstDeliveryType":(strPharacyDeliveryCode != "") ? strPharacyDeliveryCode : "",
                    "fstDeliveryAddress" : txtFldInvoiceNo.text!,
                    "fstPrimaryDiagnosis":(strSelectedPrimaryDiagnosys == "") ? "" : strSelectedPrimaryDiagnosys,
                    "fstSecondaryDiagnosis":(strSelectedSecondaryDiagnosys == "") ? "" : strSelectedSecondaryDiagnosys,
                    "fstThirdDiagnosis":(strSelectedthirdDiagnosys == "") ? "" : strSelectedthirdDiagnosys,
                    "fstMobileNo": txtFldMobile.text!
                    
                ]
            }else if className == StringConstant.hospitalAdmissionGLRequest{
                params = [
                    "fstCardNo": strCardNo,
                    "fstPolicyNo": strPolicyNo,
                    "fstPlan": strPlanCode,
                    "fstRemarks": txtViewRemarks.text!,
                    "fstDocRcvDt": strDocTcvDt,
                    "fstHospital":(strSelectedProviderCode == "") ? "" : strSelectedProviderCode,
                    "fstPhysician":(strSelectedPhysicianCode == "") ? "" : strSelectedPhysicianCode,
                    "fstPrimaryDiagnosis":(strSelectedPrimaryDiagnosys == "") ? "" : strSelectedPrimaryDiagnosys,
                    "fstSecondaryDiagnosis":(strSelectedSecondaryDiagnosys == "") ? "" : strSelectedSecondaryDiagnosys,
                    "fstThirdDiagnosis":(strSelectedthirdDiagnosys == "") ? "" : strSelectedthirdDiagnosys,
                    "fstMobileNo": txtFldMobile.text!,
                    "fstAdmissionType": strSelectedAdmissionTypeCode
                    
                ]
            }else{
                //Submit Reimbursement claim
                let newString = txtFldPhysicianame.text!.withoutSpecialCharacters
                let newString0 = newString.replacingOccurrences(of: "'", with: " ", options: .caseInsensitive, range: nil)
                let newString1 = newString0.replacingOccurrences(of: "‘", with: " ", options: .caseInsensitive, range: nil)
                let newString2 = newString1.replacingOccurrences(of: "’", with: " ", options: .caseInsensitive, range: nil)
                let newString3 = newString2.replacingOccurrences(of: ",,", with: " ", options: .literal, range: nil)
                let newString4 = newString3.replacingOccurrences(of: " ,", with: " ", options: .literal, range: nil)
                let newString5 = newString4.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: " ", options: .regularExpression)
                params = [
                    "fstCardNo": strCardNo,
                    "fstPolicyNo": strPolicyNo,
                    "fstPlan": strPlanCode,
                    "fstInvoiceNo": txtFldInvoiceNo.text!,
                    "fstAmount": txtFldTotalAmount.text!,
                    "fstRemarks": txtViewRemarks.text!,
                    "fstDocRcvDt": strDocTcvDt,
                    "fstHospital":(strSelectedProviderCode == "") ? "" : strSelectedProviderCode,
                    "fstCoverageCode":(strSelectedCoverageCode != "") ? strSelectedCoverageCode : "",
                    "fstPrimaryDiagnosis":(strSelectedPrimaryDiagnosys == "") ? "" : strSelectedPrimaryDiagnosys,
                    "fstSecondaryDiagnosis": "",
                    "fstThirdDiagnosis": "",
                    "fstMobileNo": txtFldMobile.text!,
                    "fstMedication": txtFldMedication.text!,
                    "fstConsulation": txtFldConsultation.text!,
                    "fstotherchanges": txtFldOthers.text!,
                    "fstprovidername": newString5.trim()
                ]
            }
            
            AppConstant.selectedViewTag = "2"
            AppConstant.requestParams = params
            //serviceCallToRequest()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
            
        }
    }
    
    @IBAction func btnDateAction(_ sender: Any) {
        self.dateButtonClicked()
    }
    
    @IBAction func btnTimeAction(_ sender: Any) {
        self.timeButtonClicked()
    }
    
    @IBAction func btnHospitalInfoAction(_ sender: Any) {
        self.displayAlert(message: StringConstant.hospitalInfoMsg)
    }
    
    @IBAction func btnPlanCodeAction(_ sender: Any) {
        self.performSegue(withIdentifier: "select_plancode", sender: self)
    }
    
    @objc func dateButtonClicked(){
        self.view.endEditing(true)
        var title = ""
        if(className == StringConstant.reimbersmentClaimRequest){
            title = "Event Date"
        }else{
            title = "Date of Consultation"
        }
        
        if ((className == StringConstant.reimbersmentClaimRequest) || (className == StringConstant.pharmacyRequest)) {
            DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",defaultDate: Date(), datePickerMode: .date) {
                (date) -> Void in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    self.txtFldDateOfConsultation.text = formatter.string(from: dt)
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.dateFormated = formatter.string(from: dt)
                    print("new date : \(self.dateFormated)")
                    
                    //Service call to get Diagnosys data
                    self.serviceCallToGetDiagnosysData()
                    self.serviceCallToGetPrimaryDiagnosysData()
                }
            }
        }else{//Outpatientspglrequest
            DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",defaultDate: Date(), datePickerMode: .date) {
                (date) -> Void in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    self.txtFldDateOfConsultation.text = formatter.string(from: dt)
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.dateFormated = formatter.string(from: dt)
                    print("new date : \(self.dateFormated)")
                    
                    //Service call to get Diagnosys data
                    self.serviceCallToGetDiagnosysData()
                    self.serviceCallToGetPrimaryDiagnosysData()
                }
            }
        }
    }
    
    @objc func timeButtonClicked(){
        self.view.endEditing(true)
        var title = ""
        if(className == StringConstant.reimbersmentClaimRequest){
            title = "Event time"
        }else{
            title = "Time of Consultation"
        }
        
        DatePickerDialog(locale: Locale(identifier: "en_US")).show(title, doneButtonTitle: "Done",defaultDate: Date(), datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                self.txtFldTime.text = formatter.string(from: dt)
                formatter.dateFormat = "HH:mm:ss"
                self.timeFormated = formatter.string(from: dt)
                print("new time : \(self.timeFormated)")
            }
        }
    }
    
    //MARK: Validation Methods
    func isValidated()-> Bool{
        if ((className == StringConstant.outPatientSPGLRequest)) {
            if (txtFldDateOfConsultation.text == "") {
                self.displayAlert(message: "Please enter date of consultation")
                return false
            }else if (txtFldTime.text == "") {
                self.displayAlert(message: "Please enter time of consultation")
                return false
            }else if (txtFldHospitalName.text == "") {
                self.displayAlert(message: "Please enter hospital name")
                return false
            }else if (txtFldHospitalName.text != "" && !checkInvalidValueSelected(strValue: txtFldHospitalName.text ?? "", typeName: "hospital_name")) {
                self.displayAlert(message: "Invalid hospital name")
                return false
            }else if (txtFldPhysicianame.text == "") {
                self.displayAlert(message: "Please enter physician name")
                return false
            }else if (txtFldPhysicianame.text != "" && !checkInvalidValueSelected(strValue: txtFldPhysicianame.text ?? "", typeName: "physician_name")) {
                self.displayAlert(message: "Invalid physician name")
                return false
            }else if (txtFldPrimaryDiagnosys.text == "") {
                self.displayAlert(message: "Please enter primary diagnosis")
                return false
            }else if (txtFldPrimaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldPrimaryDiagnosys.text ?? "", typeName: "diagnosys", 103)) {
                self.displayAlert(message: "Invalid primary diagnosis")
                return false
            }else if (txtFldSecondaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldSecondaryDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid secondary diagnosis")
                return false
            }else if (txtFldThirdDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldThirdDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid third diagnosis")
                return false
            }else if (txtFldMobile.text == "") {
                self.displayAlert(message: "Please enter mobile number")
                return false
            }
            else if (((txtFldMobile.text?.count)! < 10) || ((txtFldMobile.text?.count)! > 12) ) {
                self.displayAlert(message: "Invalid mobile number")
                return false
            }
        }else if (className == StringConstant.pharmacyRequest) {
            if (txtFldDateOfConsultation.text == "") {
                self.displayAlert(message: "Please enter date of consultation")
                return false
            }else if (txtFldTime.text == "") {
                self.displayAlert(message: "Please enter time of consultation")
                return false
            }else if (txtFldPrimaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldPrimaryDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid primary diagnosis")
                return false
            }else if (txtFldSecondaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldSecondaryDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid secondary diagnosis")
                return false
            }else if (txtFldThirdDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldThirdDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid third diagnosis")
                return false
            }else if (txtFldInvoiceNo.text == "") {
                self.displayAlert(message: "Please enter delivery address")
                return false
            }else if (txtFldMobile.text == "") {
                self.displayAlert(message: "Please enter mobile number")
                return false
            }else if (((txtFldMobile.text?.count)! < 10) || ((txtFldMobile.text?.count)! > 12) ) {
                self.displayAlert(message: "Invalid mobile number")
                return false
            }
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            if (txtFldDateOfConsultation.text == "") {
                self.displayAlert(message: "Please enter event date")
                return false
            }else if (txtFldTime.text == "") {
                self.displayAlert(message: "Please enter event time")
                return false
            }else if (txtFldHospitalName.text == "") {
                self.displayAlert(message: "Please enter hospital name")
                return false
            }else if (txtFldHospitalName.text != "" && !checkInvalidValueSelected(strValue: txtFldHospitalName.text ?? "", typeName: "hospital_name")) {
                self.displayAlert(message: "Invalid hospital name")
                return false
            }else if ((strSelectedProviderCode.contains("NP")) && (txtFldPhysicianame.text?.count == 0)) {
                self.displayAlert(message: "Please enter provider")
                return false
            }else if ((strSelectedProviderCode.contains("NP")) && (txtFldPhysicianame.text!.count > 100)) {
                self.displayAlert(message: "Please enter provider max 100 characters")
                return false
            }else if (txtFldPrimaryDiagnosys.text == "Select Coverage") {
                self.displayAlert(message: "Please Select coverage")
                return false
            }
//            else if (txtFldSecondaryDiagnosys.text == "") {
//                self.displayAlert(message: "Please enter primary diagnosis")
//                return false
//            }
            else if (txtFldSecondaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldSecondaryDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid primary diagnosis")
                return false
            }
//            else if (strSelectedPrimaryDiagnosys == "") {
//                self.displayAlert(message: "Please select valid diagnosis")
//                return false
//            }
            else if (txtFldInvoiceNo.text == "") {
                self.displayAlert(message: "Please enter invoice no")
                return false
            }else if (txtFldTotalAmount.text == "") {
                self.displayAlert(message: "Please enter total amount")
                return false
            }
//            else if (txtFldMobile.text == "") {
//                self.displayAlert(message: "Please enter mobile number")
//                return false
//            }
            else if (txtFldMobile.text != "" && (((txtFldMobile.text?.count)! < 10) || ((txtFldMobile.text?.count)! > 12)) ) {
                self.displayAlert(message: "Invalid mobile number")
                return false
            }
        }else if ((className == StringConstant.hospitalAdmissionGLRequest)) {
            if (txtFldDateOfConsultation.text == "") {
                self.displayAlert(message: "Please enter date of consultation")
                return false
            }else if (txtFldTime.text == "") {
                self.displayAlert(message: "Please enter time of consultation")
                return false
            }else if (txtFldHospitalName.text == "") {
                self.displayAlert(message: "Please enter hospital name")
                return false
            }else if (txtFldHospitalName.text != "" && !checkInvalidValueSelected(strValue: txtFldHospitalName.text ?? "", typeName: "hospital_name")) {
                self.displayAlert(message: "Invalid hospital name")
                return false
            }else if (txtFldPhysicianame.text == "") {
                self.displayAlert(message: "Please enter physician name")
                return false
            }else if (txtFldPhysicianame.text != "" && !checkInvalidValueSelected(strValue: txtFldPhysicianame.text ?? "", typeName: "physician_name")){
                self.displayAlert(message: "Invalid physician name")
                return false
            }else if (txtFldPrimaryDiagnosys.text == "") {
                self.displayAlert(message: "Please enter primary diagnosis")
                return false
            }else if (txtFldPrimaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldPrimaryDiagnosys.text ?? "", typeName: "diagnosys")){
                self.displayAlert(message: "Invalid primary diagnosis")
                return false
            }else if (txtFldSecondaryDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldSecondaryDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid secondary diagnosis")
                return false
            }else if (txtFldThirdDiagnosys.text != "" && !checkInvalidValueSelected(strValue: txtFldThirdDiagnosys.text ?? "", typeName: "diagnosys")) {
                self.displayAlert(message: "Invalid third diagnosis")
                return false
            }else if (txtFldInvoiceNo.text == "") {
                self.displayAlert(message: "Please enter admission type")
                return false
            }else if (txtFldInvoiceNo.text != "" && !checkInvalidValueSelected(strValue: txtFldInvoiceNo.text ?? "", typeName: "admissionType")){
                self.displayAlert(message: "Invalid admission type")
                return false
            }else if (txtFldMobile.text == "") {
                self.displayAlert(message: "Please enter mobile number")
                return false
            }
            else if (((txtFldMobile.text?.count)! < 10) || ((txtFldMobile.text?.count)! > 12) ) {
                self.displayAlert(message: "Invalid mobile number")
                return false
            }
        }
        return true
    }
    
    func checkInvalidValueSelected(strValue: String, typeName: String, _ tag:Int = 0) -> Bool{
        if tag > 0 {
            tblChoose.tag = tag
        }
        self.createDataSource(type: typeName)
        var data = self.arrChoose
        if typeName == "diagnosys" && className == StringConstant.outPatientSPGLRequest && tag == 103{
            data = self.arrChooseFromSP
        }
        if (strValue != "" && data.count > 0){
            for item in data {
                let stringNew = item.name!.replacingOccurrences(of: "\\n", with: " ", options: .regularExpression)
                if stringNew == strValue {
                    return true
                }
            }
        }
        return false
    }
    
    
    // MARK: Tableview Delegates & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFiltered.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.numberOfLines = 2
        if self.arrFiltered.count > indexPath.row{
            if let obj = self.arrFiltered[indexPath.row] as? CustomObject{
                cell.textLabel?.text = obj.name
            }
        }
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        self.tblChoose.isHidden = true
        //        self.tblChoose.isUserInteractionEnabled = false
        var customBo = CustomObject()
        customBo = self.arrFiltered[indexPath.row]
        print(tblChoose.tag)
        
        switch tblChoose.tag {
        case 101://Hospital Name
            txtFldHospitalName.text = customBo.name;
            strSelectedProviderCode = customBo.code!
            
            if(className == StringConstant.reimbersmentClaimRequest){
                
                if (strSelectedProviderCode.contains("NP")) {
                    lblPhysicianName.isHidden = false
                    imgviewPhysicianName.isHidden = false
                    txtFldPhysicianame.isHidden = false
                    viewPhysicianName.isHidden = false
                    lblPhysicianNameHeightConstraint.constant = 20
                    imgviewPhysicianNameHeightConstraint.constant = 25
                    txtFldPhysicianNameHeightConstraint.constant = 30
                    viewPhysicianNameHeightConstraint.constant = 1
                    hospitalNameWithPrimaryDiagnosysVSConstraint.constant = 81
                }else{
                    lblPhysicianName.isHidden = true
                    imgviewPhysicianName.isHidden = true
                    txtFldPhysicianame.isHidden = true
                    viewPhysicianName.isHidden = true
                    lblPhysicianNameHeightConstraint.constant = 0
                    imgviewPhysicianNameHeightConstraint.constant = 0
                    txtFldPhysicianNameHeightConstraint.constant = 0
                    viewPhysicianNameHeightConstraint.constant = 0
                    hospitalNameWithPrimaryDiagnosysVSConstraint.constant = 16
                }
                
                //Reset Coverage data
                txtFldPrimaryDiagnosys.text = "Select Coverage";
                strSelectedCoverageCode = ""
                self.serviceCallToGetCoverageData()
            }else{
                //Reset Physician Data
                txtFldPhysicianame.text = ""
                strSelectedPhysicianCode = ""
                
                self.serviceCallToGetPhysicianData()
            }
            
            break
            
        case 102://Physician Name
            txtFldPhysicianame.text = customBo.name;
            strSelectedPhysicianCode = customBo.code!
            break
            
        case 103://Primary Diagnosys
            if (className == StringConstant.reimbersmentClaimRequest) {
                txtFldSecondaryDiagnosys.text = customBo.name;
            }else{
                txtFldPrimaryDiagnosys.text = customBo.name;
            }
            
            strSelectedPrimaryDiagnosys = customBo.code!
            break
            
        case 104://Secondary Diagnosys
            txtFldSecondaryDiagnosys.text = customBo.name;
            strSelectedSecondaryDiagnosys = customBo.code!
            break
            
        case 105://Third Diagnosys
            txtFldThirdDiagnosys.text = customBo.name;
            strSelectedthirdDiagnosys = customBo.code!
            break
            
        case 106://Delivery Address
            txtFldInvoiceNo.text = customBo.name;
            strPharacyDeliveryCode = customBo.code!
            break
            
        case 108://Admission Type
            txtFldInvoiceNo.text = customBo.name;
            strSelectedAdmissionTypeCode = customBo.code!
            break
            
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK: Textfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                            for: UIControl.Event.editingChanged)
        self.view.layoutSubviews()
        
        if (className == StringConstant.outPatientSPGLRequest) {
            if (textField == txtFldHospitalName){
                tblChoose.tag = 101
                self.createDataSource(type: "hospital_name")
                tblHeight = self.txtFldHospitalName.frame.origin.y - 25
            }else if (textField == txtFldPhysicianame){
                tblChoose.tag = 102
                self.createDataSource(type: "physician_name")
                tblHeight = self.txtFldPhysicianame.frame.origin.y - 25
            }else if (textField == txtFldPrimaryDiagnosys){
                tblChoose.tag = 103
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldPrimaryDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldSecondaryDiagnosys){
                tblChoose.tag = 104
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldSecondaryDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldThirdDiagnosys){
                tblChoose.tag = 105
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldThirdDiagnosys.frame.origin.y - 25
            }
        }else if (className == StringConstant.pharmacyRequest) {
            if (textField == txtFldPrimaryDiagnosys){
                tblChoose.tag = 103
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldPrimaryDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldSecondaryDiagnosys){
                self.createDataSource(type: "diagnosys")
                tblChoose.tag = 104
                tblHeight = self.txtFldSecondaryDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldThirdDiagnosys){
                self.createDataSource(type: "diagnosys")
                tblChoose.tag = 105
                tblHeight = self.txtFldThirdDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldInvoiceNo){
                tblChoose.tag = 106
            }
        }else if (className == StringConstant.hospitalAdmissionGLRequest) {
            if (textField == txtFldHospitalName){
                tblChoose.tag = 101
                self.createDataSource(type: "hospital_name")
                tblHeight = self.txtFldHospitalName.frame.origin.y - 25
            }else if (textField == txtFldPhysicianame){
                tblChoose.tag = 102
                self.createDataSource(type: "physician_name")
                tblHeight = self.txtFldPhysicianame.frame.origin.y - 25
            }else if (textField == txtFldPrimaryDiagnosys){
                tblChoose.tag = 103
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldPrimaryDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldSecondaryDiagnosys){
                tblChoose.tag = 104
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldSecondaryDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldThirdDiagnosys){
                tblChoose.tag = 105
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldThirdDiagnosys.frame.origin.y - 25
            }else if (textField == txtFldInvoiceNo){//Admission Type
                tblChoose.tag = 108
                self.createDataSource(type: "admissionType")
                tblHeight = self.txtFldInvoiceNo.frame.origin.y - 25
                
                self.arrFiltered = self.arrChoose
                self.tblChoose.isHidden = false
                selectedField = "admissionType"
                
                if (AppConstant.screenSize.height <= 568) {
                    extraHeight = 70.0
                }
                if tblHeight > (self.view.frame.size.height - (keyBoardHeight + extraHeight)){
                    tblHeight = self.view.frame.size.height - (keyBoardHeight + extraHeight)
                }
                if (CGFloat(40 * self.arrFiltered.count) > tblHeight) {
                    tblChoose.frame = CGRect(x: view.frame.origin.x + 8, y: 8, width: view.frame.size.width - 40, height: tblHeight)
                }else{
                    tblChoose.frame = CGRect(x: view.frame.origin.x + 8, y: 8, width: view.frame.size.width - 40, height: CGFloat(40 * self.arrFiltered.count))
                    //tblChoose.frame = CGRect(x: view.frame.origin.x + 8, y: tblHeight - CGFloat(40 * self.arrFiltered.count), width: view.frame.size.width - 40, height: CGFloat(40 * self.arrFiltered.count))
                }
                
                if self.arrFiltered.count > 0 {
                    self.tblChoose.isHidden = false
                }else{
                    self.tblChoose.isHidden = true
                }
                self.tblChoose.reloadData()
            }
        }else{//Submit Reimbursement Request
            if (textField == txtFldHospitalName){
                self.createDataSource(type: "hospital_name")
                tblHeight = self.txtFldHospitalName.frame.origin.y - 25
                tblChoose.tag = 101
            }else if (textField == txtFldPhysicianame){
                self.createDataSource(type: "physician_name")
                tblHeight = self.txtFldPhysicianame.frame.origin.y - 25
                tblChoose.tag = 107
            }else if (textField == txtFldPrimaryDiagnosys){
                
            }else if (textField == txtFldSecondaryDiagnosys){
                self.createDataSource(type: "diagnosys")
                tblHeight = self.txtFldSecondaryDiagnosys.frame.origin.y - 25
                tblChoose.tag = 103
            }
            
        }
        
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.tblChoose.isHidden = true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.tblChoose.isHidden = true
        self.arrFiltered.removeAll()
        
        if (className == StringConstant.outPatientSPGLRequest) {
            if((textField == txtFldHospitalName) && (textField.text!.count > 2)){
                self.arrFiltered = self.arrChoose.filter {
                    $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                    
                }
                selectedField = "hospital_name";
                self.tblChoose.isHidden = false
                
            }else if((textField == txtFldPrimaryDiagnosys) || (textField == txtFldSecondaryDiagnosys) || (textField == txtFldThirdDiagnosys)){
                
                if self.txtFldDateOfConsultation.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationMsg)
                } else if self.txtFldTime.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationTimeMsg)
                } else{
                    if (textField.text!.count > 2){
                        if(textField == txtFldPrimaryDiagnosys){
                            self.arrFiltered = self.arrChooseFromSP.filter {
                                $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                            }
                        }else{
                            self.arrFiltered = self.arrChoose.filter {
                                $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                            }
                        }
                    }
                }
                
                self.tblChoose.isHidden = false
                selectedField = "diagnosis";
                
            }else if(textField == txtFldPhysicianame){
                self.arrFiltered = self.arrChoose.filter {
                    $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                    
                }
                self.tblChoose.isHidden = false
                selectedField = "physician";
                
            }
        }else if (className == StringConstant.pharmacyRequest) {
            if((textField == txtFldPrimaryDiagnosys) || (textField == txtFldSecondaryDiagnosys) || (textField == txtFldThirdDiagnosys)){
                if self.txtFldDateOfConsultation.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationMsg)
                } else if self.txtFldTime.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationTimeMsg)
                } else {
                    if (textField.text!.count > 2){
                        self.arrFiltered = self.arrChoose.filter {
                            $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                        }
                    }
                }
                
                self.tblChoose.isHidden = false
                selectedField = "diagnosis";
                
            }
        }else if (className == StringConstant.hospitalAdmissionGLRequest) {
            if((textField == txtFldHospitalName) && (textField.text!.count > 2)){
                self.arrFiltered = self.arrChoose.filter {
                    $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                    
                }
                selectedField = "hospital_name";
                self.tblChoose.isHidden = false
                
            }else if((textField == txtFldPrimaryDiagnosys) || (textField == txtFldSecondaryDiagnosys) || (textField == txtFldThirdDiagnosys)){
                
                if self.txtFldDateOfConsultation.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationMsg)
                } else if self.txtFldTime.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationTimeMsg)
                } else {
                    if (textField.text!.count > 2){
                        self.arrFiltered = self.arrChoose.filter {
                            $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                        }
                    }
                }

                self.tblChoose.isHidden = false
                selectedField = "diagnosis";
                
            }else if(textField == txtFldPhysicianame){
                self.arrFiltered = self.arrChoose.filter {
                    $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                    
                }
                self.tblChoose.isHidden = false
                selectedField = "physician";
                
            }else if((textField == txtFldInvoiceNo)){//AdmissionType
                self.arrFiltered = self.arrChoose.filter {
                    $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                    
                }
                if  textField.text == ""{
                    self.arrFiltered = self.arrChoose
                }
                self.tblChoose.isHidden = false
                selectedField = "admissionType";
                
            }
        }else{
            //Submit Reimbursement Request
            if((textField == txtFldHospitalName) && (textField.text!.count > 2)){
                self.arrFiltered = self.arrChoose.filter {
                    $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                    
                }
                selectedField = "hospital_name";
                self.tblChoose.isHidden = false
                
            }else if((textField == txtFldSecondaryDiagnosys) || (textField == txtFldThirdDiagnosys)){
                
                if self.txtFldDateOfConsultation.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationMsg)
                } else if self.txtFldTime.text == ""{
                    self.displayAlert(message: StringConstant.diagnosisvalidationTimeMsg)
                } else {
                    if (textField.text!.count > 2){
                        self.arrFiltered = self.arrChoose.filter {
                            $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
                            
                        }
                    }
                }
                
                self.tblChoose.isHidden = false
                selectedField = "diagnosis";
                
            }
            if ((textField == txtFldMedication) || (textField == txtFldConsultation) || (textField == txtFldOthers)) {
                var medication: Float  = 0
                var consultation: Float  = 0
                var others: Float  = 0
                if txtFldMedication.text != ""{
                    if let val = Float(txtFldMedication.text!){
                        medication = val
                    }
                }
                if txtFldConsultation.text != ""{
                    if let val = Float(txtFldConsultation.text!){
                        consultation = val
                    }
                }
                if txtFldOthers.text != ""{
                    if let val = Float(txtFldOthers.text!){
                        others = val
                    }
                }
                
                let tatalAmount = medication + consultation + others
                txtFldTotalAmount.text = String(format: "%.02f", tatalAmount)
            }
        }
        
        if (AppConstant.screenSize.height <= 568) {
            extraHeight = 80.0
        }
        if tblHeight > (self.view.frame.size.height - (keyBoardHeight + extraHeight)){
            tblHeight = self.view.frame.size.height - (keyBoardHeight + extraHeight)
        }
        if (CGFloat(40 * self.arrFiltered.count) > tblHeight) {
            tblChoose.frame = CGRect(x: view.frame.origin.x + 8, y: 8, width: view.frame.size.width - 40, height: tblHeight)
        }else{
            
            tblChoose.frame = CGRect(x: view.frame.origin.x + 8, y: ((tblHeight - CGFloat(40 * self.arrFiltered.count))) - (UIDevice.current.hasNotch ? 50 : 0), width: view.frame.size.width - 40, height: CGFloat(40 * self.arrFiltered.count))
            
        }
        
        if self.arrFiltered.count > 0 {
            self.tblChoose.isHidden = false
        }else{
            self.tblChoose.isHidden = true
        }
        self.tblChoose.reloadData()
    
        //print("tableview frame === \(self.tblChoose.frame)")
        
    }
    
    func createDataSource(type:String){
        self.arrFiltered.removeAll()
        self.arrChoose.removeAll()
        self.arrChooseFromSP.removeAll()
        if type == "hospital_name" {
            print(arrHospitals.count)
            for item in arrHospitals{
                let customObj = CustomObject()
                customObj.name = item.name
                customObj.code = item.providerCode
                self.arrChoose.append(customObj)
            }
        }else if type == "diagnosys" {
            for item in arrDiagnosys{
                let customObj = CustomObject()
                customObj.name = item.name
                customObj.code = item.diagnosysCode
                self.arrChoose.append(customObj)
            }
            if className == StringConstant.outPatientSPGLRequest && tblChoose.tag == 103 {
                for item in arrDiagnosysFromSP{
                    let customObj = CustomObject()
                    customObj.name = item.name
                    customObj.code = item.diagnosysCode
                    print("Code:\(item.diagnosysCode) - Name:\(item.name)")
                    self.arrChooseFromSP.append(customObj)
                }
            }
        }else if type == "physician_name" {
            for item in self.arrphysician{
                let customObj = CustomObject()
                customObj.name = item.physicianName
                customObj.code = item.physicianId
                self.arrChoose.append(customObj)
            }
        }else if type == "admissionType" {
            for item in arrAdmissionType{
                let customObj = CustomObject()
                customObj.name = item.admissionTypeName
                customObj.code = item.admissionTypeId
                self.arrChoose.append(customObj)
            }
        }
        
    }
    
    func setDataSource(type: String) -> [CustomObject]{
        //States
        dataSource.removeAll()
        if type == "select_coverage" {
            self.dataSource.removeAll()
            for item in self.arrCoverage{
                let customObj = CustomObject()
                customObj.name = item.desc
                customObj.code = item.coverageCode
                self.dataSource.append(customObj)
            }
        }else if type == "select_plancode" {
            self.dataSource.removeAll()
            for item in self.arrPlanCode{
                let customObj = CustomObject()
                customObj.name = item.FDESC
                customObj.code = item.planCode
                self.dataSource.append(customObj)
            }
        }
        return dataSource
    }
    
    //MARK: Delegate Methods
    
    func selectedObject(obj: CustomObject,type: String){
        if type == "select_plancode"{
            strPlanCode = obj.code!
            txtFldPlanCode.text = obj.name
        }else if type == "select_coverage"{
            strSelectedCoverageCode = obj.code!
            txtFldPrimaryDiagnosys.text = obj.name
            if(className == StringConstant.reimbersmentClaimRequest && self.dateFormated != ""){
                self.txtFldSecondaryDiagnosys.text = ""
                self.serviceCallToGetDiagnosysData()
            }
        }
    }
    
    //MARK: Keyboard Delegates
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("Keyboard is showing")
            keyBoardHeight = keyboardSize.height
//            if #available(iOS 11.0, *) {
//                let bottomInset = view.safeAreaInsets.bottom
//                keyBoardHeight -= bottomInset
//            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        print("Keyboard is not showing")
    }
    
    
    //MARK: Service call Methods
    func serviceCallToGetHospitalData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstCorpcode : String = AppConstant.retrievFromDefaults(key: StringConstant.corpDesc)
            
            var urlString = ""
//            if className == StringConstant.reimbersmentClaimRequest{
//                urlString = AppConstant.getProviderForreimbursementClaimUrl
//            }else{
//                urlString = AppConstant.getHospitalUrl
//            }
            urlString = AppConstant.getHospitalUrl
            
            print("url===\(urlString)")
            
            let json = "{\"pstCardNo\":\"\(strCardNo)\",\"pstplan\":\"\(strPlanCode)\",\"pstCorpCode\":\"\(pstCorpcode)\"}"
            let url = URL(string: urlString)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request(request).responseJSON {
                (response) in
                AppConstant.hideHUD()
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetHospitalData()
                            }
                        })
                    }else{
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                self.arrHospitals.removeAll()
                                if let arrHosData = dict["ProviderList"] as? [[String:Any]]{
                                    for dict in arrHosData{
                                        let hospitalBo = HospitalBo()
                                        if let name = dict["Name"] as? String{
                                            hospitalBo.name = name
                                        }
                                        if let providerCode = dict["ProviderCode"] as? String{
                                            hospitalBo.providerCode = providerCode
                                        }
                                        self.arrHospitals.append(hospitalBo)
                                        debugPrint(hospitalBo.name)
                                    }
                                }
                            }else{
                                if let msg = dict["Message"] as? String{
                                    debugPrint(msg)
                                }
                               
                            }
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    func serviceCallToGetHospitalDataForReimbursementClaim(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getProviderForreimbursementClaimUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request(AppConstant.getProviderForreimbursementClaimUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetHospitalDataForReimbursementClaim()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    self.arrHospitals.removeAll()
                                    if let arrHosData = dict!["ProviderList"] as? [[String:Any]]{
                                        for dict in arrHosData{
                                            let hospitalBo = HospitalBo()
                                            if let name = dict["Name"] as? String{
                                                hospitalBo.name = name
                                            }
                                            if let providerCode = dict["ProviderCode"] as? String{
                                                hospitalBo.providerCode = providerCode
                                            }
                                            self.arrHospitals.append(hospitalBo)
                                        }
                                    }
                                }else{
                                    if let msg = dict!["Message"] as? String{
                                        debugPrint(msg)
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    func serviceCallToGetPharmacyData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstCorpcode : String = AppConstant.retrievFromDefaults(key: StringConstant.corpDesc)
            print("url===\(AppConstant.getPharmacyUrl)")
            let json = "{\"pstCardNo\":\"\(strCardNo)\",\"pstplan\":\"\(strPlanCode)\",\"pstCorpCode\":\"\(pstCorpcode)\"}"
            print("Param = \(json)")
            let url = URL(string: AppConstant.getPharmacyUrl)!
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
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetPharmacyData()
                            }
                        })
                    }else{
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                if let arr =  dict["ProviderList"] as? [[String:Any]]{
                                    let dictPharmacy = arr[0]
                                    self.strPharmacyName = (dictPharmacy["Name"] as? String)!
                                    self.strPharacyProviderCode = (dictPharmacy["ProviderCode"] as? String)!
                                    self.txtFldPhysicianame.text = self.strPharmacyName;
                                }
                            }else{
                                if let msg = dict["Message"] as? String{
                                    debugPrint(msg)
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    func serviceCallToGetDiagnosysData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            print("url===\(AppConstant.getDiagnosisUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            let strDocTcvDt = self.dateFormated + " " + self.timeFormated
            
            var params: Parameters = [
                "fstAdmissionDate": strDocTcvDt
            ]
            var url = AppConstant.getDiagnosisUrl
            if(className == StringConstant.reimbersmentClaimRequest && strSelectedCoverageCode != ""){
                let fstCoverage = strSelectedCoverageCode.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                params = [
                    "fstAdmissionDate": strDocTcvDt,
                    "fstCoverage":String(fstCoverage!),
                ]
                url = AppConstant.postDiagnosisbyCoverage
            }
            
            print("Params--- \(params)")
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetDiagnosysData()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    self.arrDiagnosys.removeAll()
                                    if let arrDiagData = dict!["DiagnosisList"] as? [[String:Any]]{
                                        for dict in arrDiagData{
                                            let diagnosysBo = DiagnosysBo()
                                            if let name = dict["FDESC"] as? String{
                                                diagnosysBo.name = name
                                            }
                                            if let code = dict["REFCD"] as? String{
                                                diagnosysBo.diagnosysCode = code
                                            }
                                            self.arrDiagnosys.append(diagnosysBo)
                                        }
                                    }
                                }else{
                                    if let msg = dict!["Message"] as? String{
                                        debugPrint(msg)
                                    }
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetPrimaryDiagnosysData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            print("url===\(AppConstant.getDiagnosisFromSPUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            let strDocTcvDt = self.dateFormated + " " + self.timeFormated
            
            let params: Parameters = [
                "fstAdmissionDate": strDocTcvDt
            ]
            
            print("Params--- \(params)")
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.getDiagnosisFromSPUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetPrimaryDiagnosysData()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    self.arrDiagnosysFromSP.removeAll()
                                    if let arrDiagData = dict!["DiagnosisList"] as? [[String:Any]]{
                                        for dict in arrDiagData{
                                            let diagnosysBo = DiagnosysBo()
                                            if let name = dict["FDESC"] as? String{
                                                diagnosysBo.name = name
                                            }
                                            if let code = dict["REFCD"] as? String{
                                                diagnosysBo.diagnosysCode = code
                                            }
                                            self.arrDiagnosysFromSP.append(diagnosysBo)
                                        }
                                    }
                                }else{
                                    if let msg = dict!["Message"] as? String{
                                        debugPrint(msg)
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetDeliveryAddress(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            print("url===\(AppConstant.getDeliveryTypeUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.getDeliveryTypeUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetDeliveryAddress()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    self.arrDelivery.removeAll()
                                    if let arrHosData = dict!["DeliveryTypeList"] as? [[String:Any]]{
                                        for dict in arrHosData{
                                            let deliveryBo = DeliveryAddressBo()
                                            if let name = dict["FDESC"] as? String{
                                                deliveryBo.name = name
                                            }
                                            if let code = dict["REFCD"] as? String{
                                                deliveryBo.deliveryId = code
                                            }
                                            self.arrDelivery.append(deliveryBo)
                                        }
                                    }
                                }else{
                                    if let msg = dict!["error"] as? String{
                                        debugPrint(msg)
                                    }
                                }
                            }
                        }
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    func serviceCallToGetCoverageData(){
        self.arrCoverage.removeAll()
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstCorpcode : String = AppConstant.retrievFromDefaults(key: StringConstant.corpDesc)
            
            print("url===\(AppConstant.getCoverageUrl)")
            
            let json = "{\"pstprovider\":\"\(strSelectedProviderCode)\",\"pstCardNo\":\"\(strCardNo)\",\"pstplan\":\"\(strPlanCode)\",\"pstCorpCode\":\"\(pstCorpcode)\"}"

            print("Param = \(json)")
            let url = URL(string: AppConstant.getCoverageUrl)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            self.arrCoverage.removeAll()
            let coverageBo = CoverageBo()
            coverageBo.coverageCode = ""
            coverageBo.desc = "Select Coverage"
            self.arrCoverage.append(coverageBo)
            AFManager.request(request).responseJSON {
                (response) in
                AppConstant.hideHUD()
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetCoverageData()
                            }
                        })
                    }else{
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                self.arrCoverage.removeAll()
                                if let arrCoverageData = dict["CoverageList"] as? [[String:Any]]{
                                    for dict in arrCoverageData{
                                        let coverageBo = CoverageBo()
                                        if let code = dict["CoverageCode"] as? String{
                                            coverageBo.coverageCode = code
                                        }
                                        if let desc = dict["Description"] as? String{
                                            coverageBo.desc = desc
                                        }
                                        self.arrCoverage.append(coverageBo)
                                    }
                                }
                            }else{
                                if let msg = dict["Message"] as? String{
                                    debugPrint(msg)
                                }
                            }
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    func serviceCallToGetPhysicianData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            print("url===\(AppConstant.getPhysicianUrl)")
            
            let json = "{\"pstprovider\":\"\(strSelectedProviderCode)\"}"
            print("Param = \(json)")
            let url = URL(string: AppConstant.getPhysicianUrl)!
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
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetPhysicianData()
                            }
                        })
                    }else{
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){
                                self.arrphysician.removeAll()
                                if let arrPhysicianData = dict["PhysicianList"] as? [[String:Any]]{
                                    for dict in arrPhysicianData{
                                        let physicianBo = PhysicianBo()
                                        if let name = dict["PhysicianName"] as? String{
                                            physicianBo.physicianName = name
                                        }
                                        if let pId = dict["PhysicianID"] as? String{
                                            physicianBo.physicianId = pId
                                        }
                                        self.arrphysician.append(physicianBo)
                                    }
                                }
                            }else{
                                if let msg = dict["Message"] as? String{
                                    debugPrint(msg)
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetAdmissionTypeData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getAdmissionTypeUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.getAdmissionTypeUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
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
                                self.serviceCallToGetAdmissionTypeData()
                            }
                        })
                    }else{
                        if let dict = AppConstant.convertToDictionary(text: response.result.value!){
                            if let status = dict["Status"] as? String {
                                if(status == "1"){
                                    self.arrAdmissionType.removeAll()
                                    if let arrAdmTypeData = dict["AdmissionTypeList"] as? [[String:Any]]{
                                        for dict in arrAdmTypeData{
                                            let admissionTypeBo = AdmissionTypeBo()
                                            if let name = dict["FDESC"] as? String{
                                                admissionTypeBo.admissionTypeName = name
                                            }
                                            if let pId = dict["REFCD"] as? String{
                                                admissionTypeBo.admissionTypeId = pId
                                            }
                                            self.arrAdmissionType.append(admissionTypeBo)
                                        }
                                    }
                                }else{
                                    if let msg = dict["Message"] as? String{
                                        debugPrint(msg)
                                    }
                                }
                            }
                        }
                    }
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToRequest(){
        
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            var url = ""
            if className == StringConstant.outPatientSPGLRequest{
                url = AppConstant.submitGLRequestUrl
            }else if className == StringConstant.pharmacyRequest{
                url = AppConstant.submitPharmacyRequestUrl
            }else if className == StringConstant.reimbersmentClaimRequest{
                url = AppConstant.submitReimbursementClaimUrl
            }
            print("params===\(params)")
            print("url===\(url)")
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
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
                                    self.serviceCallToRequest()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["status"] as? String {
                                if(status == "1"){
                                    if let claimId = dict?["ClaimId"] as? String{
                                        AppConstant.strClaimId = claimId
                                    }
                                    if let memId = dict?["MemId"] as? String{
                                        AppConstant.strMemId = memId
                                    }
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }
                        }
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    
    // MARK: - Navigation
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "select_coverage"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: segue.identifier!)
            vc.type = segue.identifier!
            return
        }else if (segue.identifier == "select_plancode"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: segue.identifier!)
            vc.type = segue.identifier!
            return
        }
    }
    
}
public extension Float {

    /// Max float value.
    static var max: Float {
        return Float(greatestFiniteMagnitude)
    }

    /// Min float value.
    static var min: Float {
        return Float(-greatestFiniteMagnitude)
    }
}

extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: " ")
    }
}

