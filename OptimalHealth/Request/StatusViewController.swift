//
//  StatusViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/22/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class StatusViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var statusTableView: UITableView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var patientNameLbl: UILabel!
    @IBOutlet var pageSizeLbl: UILabel!
    @IBOutlet var pageSizeView: UIView!
    
    @IBOutlet var viewPageSizeDropDown: UIView!
    @IBOutlet var btnPage10: UIButton!
    @IBOutlet var btnPage25: UIButton!
    @IBOutlet var btnPage50: UIButton!
    @IBOutlet var btnRefresh: UIButton!
    @IBOutlet var btnPrev: UIButton!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnCurrPageNumber: UIButton!
    @IBOutlet var noStatusLbl: UILabel!
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var mySearchBar: UISearchBar!
//    @IBOutlet var lblRequestIdHeader: UILabel!
//    @IBOutlet var lblRequestDateHeader: UILabel!
//    @IBOutlet var lblStatusHeader: UILabel!
//    @IBOutlet var lblRemarksHeader: UILabel!
//    @IBOutlet var lblGlNoHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewBottom: UIView!
    @IBOutlet weak var lblNoStatusFound: UILabel!
    
    var statusArray = [StatusBo]()
    var filteredStatusArray = [StatusBo]()
    var selectedStatus = StatusBo()
    var className = ""
    var strCardNo = ""
    var strName = ""
    var strType = ""
    var strPageNum = "01"
    var strPageSize = "10"
    var currpage:Int = 1
    var strHeaderImageName = ""
    var NoDataMsg = ""
    var strHeader = ""
    var pageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.pageSizeView.layer.borderWidth = 1.5
        self.pageSizeView.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        self.pageSizeView.layer.cornerRadius = 5
        self.pageSizeView.clipsToBounds = true
        
    }
    
    func initDesigns() {
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.lblNoStatusFound.isHidden = true
        lblHeader.text = strHeader
        lblPageTitle.text = pageTitle
        
        self.viewPageSizeDropDown.layer.borderWidth = 1.5
        self.viewPageSizeDropDown.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        self.viewPageSizeDropDown.layer.cornerRadius = 5
        self.viewPageSizeDropDown.clipsToBounds = true
        
        self.mySearchBar.layer.borderWidth = 1.5
        self.mySearchBar.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        self.mySearchBar.layer.cornerRadius = 5
        self.mySearchBar.clipsToBounds = true
        
        self.mySearchBar.sizeToFit()
        self.mySearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        if let textFieldInsideSearchBar = self.mySearchBar.value(forKey: "searchField") as? UITextField{
            textFieldInsideSearchBar.backgroundColor = .white
        }
        
        //self.mySearchBar.searchTextField.backgroundColor = UIColor.white
        self.mySearchBar.delegate = self
        statusTableView.delegate = self
        statusTableView.dataSource = self
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.hospitalAdmissionGLRequest)) {
            lblHeader?.text = "GL Status"
        }else if (className == StringConstant.pharmacyRequest) {
            lblHeader?.text = "Pharmacy Supplies Order Status"
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            lblHeader?.text = "Claim Status"
        }else if (className == StringConstant.teleconsultRequest) {
            lblHeader?.text = "Teleconsult Status"
        }else if (className == StringConstant.teleconsultAppoinments){
            lblHeader?.text = "Teleconsult Appoinments"
        }else if className == StringConstant.teleconsultE_Prescription {
            lblHeader?.text = "Teleconsult Prescription"
        }else if className == StringConstant.teleconsultE_Lab{
            lblHeader?.text = "Teleconsult Lab"
        }else if className == StringConstant.teleconsultE_Referral{
            lblHeader?.text = "Teleconsult Referral"
        }
        
        patientNameLbl?.text = strName
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        pageSizeView.layer.borderColor = UIColor.white.cgColor
        pageSizeView.layer.borderWidth = 1.0
        pageSizeView.layer.cornerRadius = 3
        pageSizeView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showPageSizeView(sender:)))
        pageSizeView.isUserInteractionEnabled = true
        pageSizeView.addGestureRecognizer(tap)
        
        if className == StringConstant.teleconsultAppoinments {
            serviceCallToGetTeleAppointmentList()
        }else if className == StringConstant.teleconsultE_Prescription {
            serviceCallToGetTelePrescriptionList()
        }else if className == StringConstant.teleconsultE_Lab{
            serviceCallToGetTeleLabList()
        }else if className == StringConstant.teleconsultE_Referral{
            serviceCallToGetTeleReferralList()
        }else if className == StringConstant.teleconsultHistory{
            
        }else if className == StringConstant.teleconsultE_Delivery{
            
        }else{
            serviceCallToGetStatus()
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.dismissKeyboard()
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
    
    @IBAction func btnRefreshAction(_ sender: UIButton) {
        if className == StringConstant.teleconsultAppoinments {
            serviceCallToGetTeleAppointmentList()
        }else if className == StringConstant.teleconsultE_Prescription {
            serviceCallToGetTelePrescriptionList()
        }else if className == StringConstant.teleconsultE_Lab{
            serviceCallToGetTeleLabList()
        }else if className == StringConstant.teleconsultE_Referral{
            serviceCallToGetTeleReferralList()
        }else if className == StringConstant.teleconsultHistory{
            
        }else if className == StringConstant.teleconsultE_Delivery{
            
        }else{
            serviceCallToGetStatus()
        }
    }
    
    @IBAction func btnPageSizeAction(_ sender: UIButton) {
        self.viewPageSizeDropDown.isHidden = true
        self.viewPageSizeDropDown.isUserInteractionEnabled = false
        strPageNum = "01"
        currpage = 1
        strPageSize = String(sender.tag)
        if (strPageSize == "10") {
            pageSizeLbl?.text = "10"
        }else if (strPageSize == "25") {
            pageSizeLbl?.text = "25"
        }else if (strPageSize == "50") {
            pageSizeLbl?.text = "50"
        }
        
        if className == StringConstant.teleconsultAppoinments {
            serviceCallToGetTeleAppointmentList()
        }else if className == StringConstant.teleconsultE_Prescription {
            serviceCallToGetTelePrescriptionList()
        }else if className == StringConstant.teleconsultE_Lab{
            serviceCallToGetTeleLabList()
        }else if className == StringConstant.teleconsultE_Referral{
            serviceCallToGetTeleReferralList()
        }else if className == StringConstant.teleconsultHistory{
            
        }else if className == StringConstant.teleconsultE_Delivery{
            
        }else{
            serviceCallToGetStatus()
        }
    }
    
    @IBAction func btnPrevAction(_ sender: UIButton) {
        strPageNum =  String(Int(strPageNum)! - 1)
        if(Int(strPageNum)! > 0){
            currpage = currpage - 1
            
            if className == StringConstant.teleconsultAppoinments {
                serviceCallToGetTeleAppointmentList()
            }else if className == StringConstant.teleconsultE_Prescription {
                serviceCallToGetTelePrescriptionList()
            }else if className == StringConstant.teleconsultE_Lab{
                serviceCallToGetTeleLabList()
            }else if className == StringConstant.teleconsultE_Referral{
                serviceCallToGetTeleReferralList()
            }else if className == StringConstant.teleconsultHistory{
                
            }else if className == StringConstant.teleconsultE_Delivery{
                
            }else{
                serviceCallToGetStatus()
            }
            
        }
    }
    
    @IBAction func btnnextAction(_ sender: UIButton) {
        strPageNum =  String(Int(strPageNum)! + 1)
        currpage = currpage + 1
        
        if className == StringConstant.teleconsultAppoinments {
            serviceCallToGetTeleAppointmentList()
        }else if className == StringConstant.teleconsultE_Prescription {
            serviceCallToGetTelePrescriptionList()
        }else if className == StringConstant.teleconsultE_Lab{
            serviceCallToGetTeleLabList()
        }else if className == StringConstant.teleconsultE_Referral{
            serviceCallToGetTeleReferralList()
        }else if className == StringConstant.teleconsultHistory{
            
        }else if className == StringConstant.teleconsultE_Delivery{
            
        }else{
            serviceCallToGetStatus()
        }
        
    }
    
    @objc func showPageSizeView(sender: UITapGestureRecognizer? = nil) {
        self.viewPageSizeDropDown.isHidden = false
        self.viewPageSizeDropDown.isUserInteractionEnabled = true
    }
    
    //MARK: Tableview Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        if filteredStatusArray.count > 0 {
            self.statusTableView.backgroundView = nil
            self.statusTableView.separatorStyle = .none
            self.viewBottom.isHidden = false
            return 1
        }
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: self.statusTableView.bounds.size.width,
                          height: self.statusTableView.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        
        noDataLabel.text = NoDataMsg
        noDataLabel.textColor = AppConstant.themeGreenColor
        noDataLabel.textAlignment = NSTextAlignment.center
        self.statusTableView.backgroundView = noDataLabel
        self.statusTableView.separatorStyle = .none
        self.viewBottom.isHidden = true
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStatusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell", for: indexPath as IndexPath) as! StatusTableViewCell
        
        if(selectedStatus.GLClaimNo == ""){
            cell.selectionStyle = .none
        }
        
        let statusBo = filteredStatusArray[indexPath.row]
        
        if ((className == StringConstant.outPatientSPGLRequest) || (className == StringConstant.hospitalAdmissionGLRequest)) {
            cell.GLRequestIdLbl?.text = statusBo.GLRequestId == "" ? "GL Request ID - NA" : "GL Request ID - \(statusBo.GLRequestId)"
            cell.GLClaimNoLbl?.text = statusBo.GLClaimNo == "" ? "GL No - NA" : "GL No - \(statusBo.GLClaimNo)"
        }else if (className == StringConstant.pharmacyRequest) {
            cell.GLRequestIdLbl?.text = statusBo.GLRequestId == "" ? "Pharmacy Request ID - NA" : "Pharmacy Request ID - \(statusBo.GLRequestId)"
            cell.GLClaimNoLbl?.text = statusBo.GLClaimNo == "" ? "Claim No - NA" : "Claim No - \(statusBo.GLClaimNo)"
        }else if (className == StringConstant.reimbersmentClaimRequest) {
            cell.GLRequestIdLbl?.text = statusBo.GLRequestId == "" ? "Claim Request ID - NA" : "Claim Request ID - \(statusBo.GLRequestId)"
            cell.GLClaimNoLbl?.text = statusBo.GLClaimNo == "" ? "Claim No - NA" : "Claim No - \(statusBo.GLClaimNo)"
        }else if (className == StringConstant.teleconsultRequest) {
            cell.GLRequestIdLbl?.text = statusBo.GLRequestId == "" ? "GL Request ID - NA" : "GL Request ID - \(statusBo.GLRequestId)"
            cell.GLClaimNoLbl?.text = statusBo.GLClaimNo == "" ? "Claim No - NA" : "Claim No - \(statusBo.GLClaimNo)"
        }
        
        cell.requestDateLbl?.text = statusBo.insertDate
        cell.statusLbl?.text = statusBo.status
        if className == StringConstant.teleconsultRequest{
            cell.remarksLbl?.text = statusBo.approvedRemarks == "" ? "NA" : statusBo.approvedRemarks.htmlToString
        }else{
            cell.remarksLbl?.text = statusBo.remarks == "" ? "NA" : statusBo.remarks.htmlToString
        }
        
        if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)){
            cell.lblTitleReqDate.text = "Consultation Date"
            cell.GLRequestIdLbl?.text = statusBo.GLRequestId == "" ? "Tele Request ID - NA" : "Tele Request ID - \(statusBo.GLRequestId)"
            cell.GLClaimNoLbl?.text = statusBo.coverageID == "" ? "coverageID - NA" : "coverageID - \(statusBo.coverageID)"
            cell.requestDateLbl?.text = statusBo.consultationDate
            cell.remarksLbl?.text = statusBo.providerName == "" ? "Provider Name - NA" : "Provider Name - \(statusBo.providerName)"
            cell.lblRemarksTitle.isHidden = true
            cell.lblRemarksTitleWidthConstraint.constant = 0
        }else{
            cell.lblRemarksTitle.isHidden = false
            cell.lblRemarksTitleWidthConstraint.constant = 72
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        if (self.viewPageSizeDropDown.isHidden == true) {
            selectedStatus = filteredStatusArray[indexPath.row]
            self.performSegue(withIdentifier: "status_details", sender: self)
            
        }else{
            self.viewPageSizeDropDown.isHidden = true
            self.viewPageSizeDropDown.isUserInteractionEnabled = false
        }
    }
    
    //MARK: Search Bar Delegates
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            filteredStatusArray = statusArray
        }
        else {
            filteredStatusArray = statusArray.filter {
                ($0.GLRequestId.range(of: searchText, options: .caseInsensitive) != nil) || ($0.insertDate.range(of: searchText, options: .caseInsensitive) != nil) || ($0.status.range(of: searchText, options: .caseInsensitive) != nil) || ($0.GLClaimNo.range(of: searchText, options: .caseInsensitive) != nil) || ($0.consultationDate.range(of: searchText, options: .caseInsensitive) != nil) || ($0.providerName.range(of: searchText, options: .caseInsensitive) != nil) || ($0.coverageID.range(of: searchText, options: .caseInsensitive) != nil)
            }
        }
         statusTableView.reloadData()
        
        if filteredStatusArray.count == 0 {
            self.statusTableView.isHidden = true
            self.lblNoStatusFound.isHidden = false
        }else{
            self.statusTableView.isHidden = false
            self.lblNoStatusFound.isHidden = true
        }
    }
    
    //MARK: Service Call
    func serviceCallToGetStatus() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let params: Parameters = [
                "pstCardNo": strCardNo,
                "pstType": strType,
                "PageNo": strPageNum,
                "PageSize": strPageSize
            ]
            print("params===\(params)")
            print("URL===\(AppConstant.getStatusUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            AFManager.request( AppConstant.getStatusUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetStatus()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.statusArray.removeAll()
                                    var totalRecords = 0
                                    if let total_records = dict?["TotalRecords"] as? String {
                                        if total_records != ""{
                                            totalRecords = Int(total_records)!
                                        }
                                    }
                                    
                                    if let dict_array = dict?["OnlineClaimList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let statusValueSet = StatusBo()
                                            if  (self.className == StringConstant.outPatientSPGLRequest || self.className == StringConstant.teleconsultRequest) {
                                                if let GLRequestId = item["GLRequestID"] as? String {
                                                    statusValueSet.GLRequestId = GLRequestId
                                                }
                                            }else if  self.className == StringConstant.pharmacyRequest {
                                                if let GLRequestId = item["PharmacyRequestID"] as? String {
                                                    statusValueSet.GLRequestId = GLRequestId
                                                }
                                            }else if self.className == StringConstant.reimbersmentClaimRequest{
                                                if let GLRequestId = item["IclaimRequestID"] as? String {
                                                    statusValueSet.GLRequestId = GLRequestId
                                                }
                                            }else if  self.className == StringConstant.hospitalAdmissionGLRequest {
                                                if let GLRequestId = item["GLRequestID"] as? String {
                                                    statusValueSet.GLRequestId = GLRequestId
                                                }
                                            }
                                            
                                            if let ConsultationDate = item["ConsultationDate"] as? String {
                                                statusValueSet.consultationDate = ConsultationDate
                                            }
                                            if let status = item["Status"] as? String {
                                                statusValueSet.status = status
                                            }
                                            if let remarks = item["Remarks"] as? String {
                                                statusValueSet.remarks = remarks
                                            }
                                            if let GLClaimNo = item["ClaimNo"] as? String {
                                                statusValueSet.GLClaimNo = GLClaimNo
                                            }
                                            if let HospitalName = item["HospitalName"] as? String {
                                                statusValueSet.hospitalName = HospitalName
                                            }
                                            if let InsertDate = item["InsertDate"] as? String {
                                                statusValueSet.insertDate = InsertDate
                                            }
                                            if let PhysicianName = item["PhysicianName"] as? String {
                                                statusValueSet.doctor = PhysicianName
                                            }
                                            if let Symptoms = item["Symptoms"] as? String {
                                                statusValueSet.symptoms = Symptoms
                                            }
                                            if let PastMedicalHisoty = item["PastMedicalHisoty"] as? String {
                                                statusValueSet.pastMedicalHistory = PastMedicalHisoty
                                            }
                                            if let BP = item["BP"] as? String {
                                                statusValueSet.BP = BP
                                            }
                                            if let Temp = item["Temp"] as? String {
                                                statusValueSet.temp = Temp
                                            }
                                            if let DurgAlg = item["DrugAllergy"] as? String {
                                                statusValueSet.drugAlergies = DurgAlg
                                            }
                                            if let Pulse = item["Pulse"] as? String {
                                                statusValueSet.pulse = Pulse
                                            }
                                            if let ApprovedRemarks = item["ApprovedRemarks"] as? String {
                                                statusValueSet.approvedRemarks = ApprovedRemarks
                                            }
                                            
                                            self.statusArray.append(statusValueSet)
                                            self.filteredStatusArray = self.statusArray
                                        }
                                        self.statusTableView.reloadData()
                                        self.btnCurrPageNumber.setTitle("\(self.currpage)", for: .normal)
                                        
                                        if totalRecords > Int(self.strPageSize)!{
                                            if(self.currpage == 1){
                                                self.btnPrev.isHidden = true
                                                self.btnNext.isHidden = false
                                            }else{
                                                self.btnPrev.isHidden = false
                                                self.btnNext.isHidden = false
                                            }
                                        }else{
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        
                                        if((self.statusArray.count == 0) && (self.currpage == 1)){
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        if self.statusArray.count > 0{
                                            self.noStatusLbl.isHidden = true
                                        }
                                        
                                    }
                                    
                                }else{
                                    if Int(self.strPageNum)! > 0{
                                        self.strPageNum =  String(Int(self.strPageNum)! - 1)
                                        self.currpage = self.currpage - 1
                                    }
                                    
                                    if let msg = dict?["Message"] as? String{
                                        if self.statusArray.count == 0{
                                            self.noStatusLbl.isHidden = false
                                            self.noStatusLbl.text = msg
                                        }
                                        
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getStatusUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getStatusUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetTeleAppointmentList() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            //let pstCardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            
            let params: Parameters = ["pstCardNo": strCardNo,"PageNo": strPageNum,
                                      "PageSize": strPageSize]
            let url = AppConstant.teleAppoinmentsUrl
            
            print("params===\(params)")
            print("URL===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetTeleAppointmentList()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.statusArray.removeAll()
                                    var totalRecords = 0
                                    if let total_records = dict?["TotalRecords"] as? String {
                                        if total_records != ""{
                                            totalRecords = Int(total_records)!
                                        }
                                    }
                                    
                                    if let dict_array = dict?["TeleAppoinmentsList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let statusValueSet = StatusBo()
                                            
                                            if let teleRequestID = item["TeleRequestID"] as? String{
                                                statusValueSet.GLRequestId = teleRequestID
                                            }
                                            if let coverageID = item["CoverageID"] as? String{
                                                statusValueSet.coverageID = coverageID
                                            }
                                            if let consultationDate = item["ConsultationDate"] as? String{
                                                statusValueSet.consultationDate = consultationDate
                                            }
                                            if let appointmentDate = item["AppointmentDate"] as? String{
                                                statusValueSet.insertDate = appointmentDate
                                            }
                                            if let symptoms = item["Symptoms"] as? String{
                                                statusValueSet.symptoms = symptoms
                                            }
                                            if let modeofConsult = item["ModeofConsult"] as? String{
                                                statusValueSet.modeofConsult = modeofConsult
                                            }
                                            if let existingillness = item["Existingillness"] as? String{
                                                statusValueSet.existingillness = existingillness
                                            }
                                            if let caseNote = item["CaseNote"] as? String{
                                                statusValueSet.caseNote = caseNote
                                            }
                                            if let advicetoPatient = item["AdvicetoPatient"] as? String{
                                                statusValueSet.advicetoPatient = advicetoPatient
                                            }
                                            if let teleStatus = item["TeleStatus"] as? String{
                                                statusValueSet.status = teleStatus
                                            }
                                            if let drugAllergy = item["DrugAllergy"] as? String{
                                                statusValueSet.drugAlergies = drugAllergy
                                            }
                                            if let providerName = item["ProviderName"] as? String{
                                                statusValueSet.providerName = providerName
                                            }
                                            if let dischargeDate = item["DischargeDate"] as? String{
                                                statusValueSet.dischargeDate = dischargeDate
                                            }
                                            
                                            self.statusArray.append(statusValueSet)
                                            self.filteredStatusArray = self.statusArray
                                        }
                                        self.statusTableView.reloadData()
                                        self.btnCurrPageNumber.setTitle("\(self.currpage)", for: .normal)
                                        
                                        if totalRecords > Int(self.strPageSize)!{
                                            if(self.currpage == 1){
                                                self.btnPrev.isHidden = true
                                                self.btnNext.isHidden = false
                                            }else{
                                                self.btnPrev.isHidden = false
                                                self.btnNext.isHidden = false
                                            }
                                        }else{
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        
                                        if((self.statusArray.count == 0) && (self.currpage == 1)){
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        if self.statusArray.count > 0{
                                            self.noStatusLbl.isHidden = true
                                        }
                                        
                                    }
                                    
                                }else{
                                    if Int(self.strPageNum)! > 0{
                                        self.strPageNum =  String(Int(self.strPageNum)! - 1)
                                        self.currpage = self.currpage - 1
                                    }
                                    
                                    if let msg = dict?["Message"] as? String{
                                        if self.statusArray.count == 0{
                                            self.noStatusLbl.isHidden = false
                                            self.noStatusLbl.text = msg
                                        }
                                        
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetTelePrescriptionList() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            //let pstCardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            
            let params: Parameters = ["pstCardNo": strCardNo, "PageNo": strPageNum,
                                      "PageSize": strPageSize]
            let url = AppConstant.telePrescriptionUrl
            
            print("params===\(params)")
            print("URL===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetTelePrescriptionList()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.statusArray.removeAll()
                                    var totalRecords = 0
                                    if let total_records = dict?["TotalRecords"] as? String {
                                        if total_records != ""{
                                            totalRecords = Int(total_records)!
                                        }
                                    }
                                    
                                    if let dict_array = dict?["TeleAppoinmentsList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let statusValueSet = StatusBo()
                                            
                                            if let teleRequestID = item["TeleRequestID"] as? String{
                                                statusValueSet.GLRequestId = teleRequestID
                                            }
                                            if let coverageID = item["CoverageID"] as? String{
                                                statusValueSet.coverageID = coverageID
                                            }
                                            if let consultationDate = item["ConsultationDate"] as? String{
                                                statusValueSet.consultationDate = consultationDate
                                            }
                                            if let appointmentDate = item["AppointmentDate"] as? String{
                                                statusValueSet.insertDate = appointmentDate
                                            }
                                            if let symptoms = item["Symptoms"] as? String{
                                                statusValueSet.symptoms = symptoms
                                            }
                                            if let modeofConsult = item["ModeofConsult"] as? String{
                                                statusValueSet.modeofConsult = modeofConsult
                                            }
                                            if let existingillness = item["Existingillness"] as? String{
                                                statusValueSet.existingillness = existingillness
                                            }
                                            if let caseNote = item["CaseNote"] as? String{
                                                statusValueSet.caseNote = caseNote
                                            }
                                            if let advicetoPatient = item["AdvicetoPatient"] as? String{
                                                statusValueSet.advicetoPatient = advicetoPatient
                                            }
                                            if let teleStatus = item["TeleStatus"] as? String{
                                                statusValueSet.status = teleStatus
                                            }
                                            if let drugAllergy = item["DrugAllergy"] as? String{
                                                statusValueSet.drugAlergies = drugAllergy
                                            }
                                            if let providerName = item["ProviderName"] as? String{
                                                statusValueSet.providerName = providerName
                                            }
                                            if let dischargeDate = item["DischargeDate"] as? String{
                                                statusValueSet.dischargeDate = dischargeDate
                                            }
                                            
                                            self.statusArray.append(statusValueSet)
                                            self.filteredStatusArray = self.statusArray
                                        }
                                        self.statusTableView.reloadData()
                                        self.btnCurrPageNumber.setTitle("\(self.currpage)", for: .normal)
                                        
                                        if totalRecords > Int(self.strPageSize)!{
                                            if(self.currpage == 1){
                                                self.btnPrev.isHidden = true
                                                self.btnNext.isHidden = false
                                            }else{
                                                self.btnPrev.isHidden = false
                                                self.btnNext.isHidden = false
                                            }
                                        }else{
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        
                                        if((self.statusArray.count == 0) && (self.currpage == 1)){
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        if self.statusArray.count > 0{
                                            self.noStatusLbl.isHidden = true
                                        }
                                        
                                    }
                                    
                                }else{
                                    if Int(self.strPageNum)! > 0{
                                        self.strPageNum =  String(Int(self.strPageNum)! - 1)
                                        self.currpage = self.currpage - 1
                                    }
                                    
                                    if let msg = dict?["Message"] as? String{
                                        if self.statusArray.count == 0{
                                            self.noStatusLbl.isHidden = false
                                            self.noStatusLbl.text = msg
                                        }
                                        
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetTeleLabList() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            //let pstCardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            
            let params: Parameters = ["pstCardNo": strCardNo, "PageNo": strPageNum,
                                      "PageSize": strPageSize]
            let url = AppConstant.teleLabUrl
            
            print("params===\(params)")
            print("URL===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetTeleLabList()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.statusArray.removeAll()
                                    var totalRecords = 0
                                    if let total_records = dict?["TotalRecords"] as? String {
                                        if total_records != ""{
                                            totalRecords = Int(total_records)!
                                        }
                                    }
                                    
                                    if let dict_array = dict?["TeleAppoinmentsList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let statusValueSet = StatusBo()
                                            
                                            if let teleRequestID = item["TeleRequestID"] as? String{
                                                statusValueSet.GLRequestId = teleRequestID
                                            }
                                            if let coverageID = item["CoverageID"] as? String{
                                                statusValueSet.coverageID = coverageID
                                            }
                                            if let consultationDate = item["ConsultationDate"] as? String{
                                                statusValueSet.consultationDate = consultationDate
                                            }
                                            if let appointmentDate = item["AppointmentDate"] as? String{
                                                statusValueSet.insertDate = appointmentDate
                                            }
                                            if let symptoms = item["Symptoms"] as? String{
                                                statusValueSet.symptoms = symptoms
                                            }
                                            if let modeofConsult = item["ModeofConsult"] as? String{
                                                statusValueSet.modeofConsult = modeofConsult
                                            }
                                            if let existingillness = item["Existingillness"] as? String{
                                                statusValueSet.existingillness = existingillness
                                            }
                                            if let caseNote = item["CaseNote"] as? String{
                                                statusValueSet.caseNote = caseNote
                                            }
                                            if let advicetoPatient = item["AdvicetoPatient"] as? String{
                                                statusValueSet.advicetoPatient = advicetoPatient
                                            }
                                            if let teleStatus = item["TeleStatus"] as? String{
                                                statusValueSet.status = teleStatus
                                            }
                                            if let drugAllergy = item["DrugAllergy"] as? String{
                                                statusValueSet.drugAlergies = drugAllergy
                                            }
                                            if let providerName = item["ProviderName"] as? String{
                                                statusValueSet.providerName = providerName
                                            }
                                            if let dischargeDate = item["DischargeDate"] as? String{
                                                statusValueSet.dischargeDate = dischargeDate
                                            }
                                            
                                            self.statusArray.append(statusValueSet)
                                            self.filteredStatusArray = self.statusArray
                                        }
                                        self.statusTableView.reloadData()
                                        self.btnCurrPageNumber.setTitle("\(self.currpage)", for: .normal)
                                        
                                        if totalRecords > Int(self.strPageSize)!{
                                            if(self.currpage == 1){
                                                self.btnPrev.isHidden = true
                                                self.btnNext.isHidden = false
                                            }else{
                                                self.btnPrev.isHidden = false
                                                self.btnNext.isHidden = false
                                            }
                                        }else{
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        
                                        if((self.statusArray.count == 0) && (self.currpage == 1)){
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        if self.statusArray.count > 0{
                                            self.noStatusLbl.isHidden = true
                                        }
                                        
                                    }
                                    
                                }else{
                                    if Int(self.strPageNum)! > 0{
                                        self.strPageNum =  String(Int(self.strPageNum)! - 1)
                                        self.currpage = self.currpage - 1
                                    }
                                    
                                    if let msg = dict?["Message"] as? String{
                                        if self.statusArray.count == 0{
                                            self.noStatusLbl.isHidden = false
                                            self.noStatusLbl.text = msg
                                        }
                                        
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetTeleReferralList() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            //let pstCardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            
            let params: Parameters = ["pstCardNo": strCardNo,"PageNo": strPageNum,
                                      "PageSize": strPageSize]
            let url = AppConstant.teleReferralUrl
            
            print("params===\(params)")
            print("URL===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetTeleReferralList()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.statusArray.removeAll()
                                    var totalRecords = 0
                                    if let total_records = dict?["TotalRecords"] as? String {
                                        if total_records != ""{
                                            totalRecords = Int(total_records)!
                                        }
                                    }
                                    
                                    if let dict_array = dict?["TeleAppoinmentsList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let statusValueSet = StatusBo()
                                            
                                            if let teleRequestID = item["TeleRequestID"] as? String{
                                                statusValueSet.GLRequestId = teleRequestID
                                            }
                                            if let coverageID = item["CoverageID"] as? String{
                                                statusValueSet.coverageID = coverageID
                                            }
                                            if let consultationDate = item["ConsultationDate"] as? String{
                                                statusValueSet.consultationDate = consultationDate
                                            }
                                            if let appointmentDate = item["AppointmentDate"] as? String{
                                                statusValueSet.insertDate = appointmentDate
                                            }
                                            if let symptoms = item["Symptoms"] as? String{
                                                statusValueSet.symptoms = symptoms
                                            }
                                            if let modeofConsult = item["ModeofConsult"] as? String{
                                                statusValueSet.modeofConsult = modeofConsult
                                            }
                                            if let existingillness = item["Existingillness"] as? String{
                                                statusValueSet.existingillness = existingillness
                                            }
                                            if let caseNote = item["CaseNote"] as? String{
                                                statusValueSet.caseNote = caseNote
                                            }
                                            if let advicetoPatient = item["AdvicetoPatient"] as? String{
                                                statusValueSet.advicetoPatient = advicetoPatient
                                            }
                                            if let teleStatus = item["TeleStatus"] as? String{
                                                statusValueSet.status = teleStatus
                                            }
                                            if let drugAllergy = item["DrugAllergy"] as? String{
                                                statusValueSet.drugAlergies = drugAllergy
                                            }
                                            if let providerName = item["ProviderName"] as? String{
                                                statusValueSet.providerName = providerName
                                            }
                                            if let dischargeDate = item["DischargeDate"] as? String{
                                                statusValueSet.dischargeDate = dischargeDate
                                            }
                                            
                                            self.statusArray.append(statusValueSet)
                                            self.filteredStatusArray = self.statusArray
                                        }
                                        self.statusTableView.reloadData()
                                        self.btnCurrPageNumber.setTitle("\(self.currpage)", for: .normal)
                                        
                                        if totalRecords > Int(self.strPageSize)!{
                                            if(self.currpage == 1){
                                                self.btnPrev.isHidden = true
                                                self.btnNext.isHidden = false
                                            }else{
                                                self.btnPrev.isHidden = false
                                                self.btnNext.isHidden = false
                                            }
                                        }else{
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        
                                        if((self.statusArray.count == 0) && (self.currpage == 1)){
                                            self.btnPrev.isHidden = true
                                            self.btnNext.isHidden = true
                                        }
                                        if self.statusArray.count > 0{
                                            self.noStatusLbl.isHidden = true
                                        }
                                        
                                    }
                                    
                                }else{
                                    if Int(self.strPageNum)! > 0{
                                        self.strPageNum =  String(Int(self.strPageNum)! - 1)
                                        self.currpage = self.currpage - 1
                                    }
                                    
                                    if let msg = dict?["Message"] as? String{
                                        if self.statusArray.count == 0{
                                            self.noStatusLbl.isHidden = false
                                            self.noStatusLbl.text = msg
                                        }
                                        
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != self.viewPageSizeDropDown {
            self.view.endEditing(true)
            self.viewPageSizeDropDown.isHidden = true
            self.viewPageSizeDropDown.isUserInteractionEnabled = false
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "status_details"){
            let vc = segue.destination as! StatusDetailsViewController
            vc.selectedStatus = selectedStatus
            vc.className = className
            vc.strHeaderImageName = strHeaderImageName
            vc.cardNo = strCardNo
            vc.pageTitle = pageTitle
            return
        }
    }
    
    
}

