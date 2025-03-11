//
//  ClaimListViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ClaimListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var tblClaimList: UITableView!
    @IBOutlet var lblNoResults: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPageTitle: UILabel!
    
    var arrClaimData = [ClaimBo]()
    var className = ""
    var cardNo = ""
    var strPageHeader = ""
    var selectedClaimBo = ClaimBo()
    var strHeaderImageName = ""
    var isForMedicalChitView = false
    var strPageTitle: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if className == StringConstant.gl {
            self.serviceCallToGetClaimDetails()
        }
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        print("className: \(className)")
        self.lblPageHeader.text = strPageHeader
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        lblPageTitle.text = strPageTitle
        
        if className == StringConstant.uploadMedicalChit {
            self.serviceCallToGetClaimListForMedicalChit()
        }else if className != StringConstant.gl {
            self.serviceCallToGetClaimDetails()
        }
        
    }
    
    
    // MARK: Tableview Delegates & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrClaimData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "claimListCell", for: indexPath as IndexPath) as! ClaimListTableViewCell
        
        //cell.selectionStyle = .none
        let claimBo = self.arrClaimData[indexPath.row]
        cell.lblDate.text = claimBo.admissionDate
        cell.lblClaimId.text = claimBo.claimId == "" ? "CLAIM ID - NA" : "CLAIM ID - \(claimBo.claimId)"
        cell.lblCoverageId.text = claimBo.coverageId == "" ? "COVERAGE ID - NA" : "COVERAGE ID - \(claimBo.coverageId)"
        cell.lblProviderName.text = claimBo.providerName
        
        if((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.GP) || (className == StringConstant.OPSP) || (className == StringConstant.Pharmacy) || (className == StringConstant.claim)){
            cell.lblDateHeader.text = "Event Date"
        }
        
        if className == StringConstant.gl{
            if claimBo.rating > 0{
                cell.imgStar1.image = UIImage(named: "star_custom.png")
                cell.imgStar1.isHidden = false
                cell.imgStar2.isHidden = false
                cell.imgStar3.isHidden = false
                cell.imgStar4.isHidden = false
                cell.imgStar5.isHidden = false
                cell.btnStar.setTitle("", for: .normal)
            }else{
                cell.imgStar1.image = UIImage(named: "starempty_white.png")
                cell.btnStar.setTitle("Click to rate", for: .normal)
                cell.imgStar1.isHidden = true
                cell.imgStar2.isHidden = true
                cell.imgStar3.isHidden = true
                cell.imgStar4.isHidden = true
                cell.imgStar5.isHidden = true
            }
            if claimBo.rating > 1{
                cell.imgStar2.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar2.image = UIImage(named: "starempty_white.png")
            }
            if claimBo.rating > 2{
                cell.imgStar3.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar3.image = UIImage(named: "starempty_white.png")
            }
            if claimBo.rating > 3{
                cell.imgStar4.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar4.image = UIImage(named: "starempty_white.png")
            }
            if claimBo.rating > 4{
                cell.imgStar5.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar5.image = UIImage(named: "starempty_white.png")
            }
            let tap1Gesture = GLApplicationStatusTapGestureRecognizer(target: self, action: #selector(goRatingSelector(sender:)))
            tap1Gesture.indexRowSelected = indexPath.row
            cell.btnStar.isUserInteractionEnabled = true
            cell.btnStar.addGestureRecognizer(tap1Gesture)
            cell.starIconView.isHidden = false
            cell.starViewConstraintHeight.constant = 107
        }else{
            cell.starIconView.isHidden = true
            cell.starViewConstraintHeight.constant = 0
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if className == StringConstant.uploadMedicalChit{
            selectedClaimBo = self.arrClaimData[indexPath.row]
            if isForMedicalChitView == true{
//                let viewGlVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewGLLettersViewController") as! ViewGLLettersViewController
//                viewGlVC.className = className
//                viewGlVC.claimId = selectedClaimBo.claimId
//                viewGlVC.strHeader = strPageHeader
//                viewGlVC.pageTitle = strPageTitle
//                self.navigationController?.pushViewController(viewGlVC, animated: true)
                self.performSegue(withIdentifier: "claim_document_list", sender: self)
            }else{
                let uploadFileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadFileViewController") as! UploadFileViewController
                uploadFileVC.className = className
                uploadFileVC.headerImage = strHeaderImageName
                uploadFileVC.pageTitle = strPageTitle
                uploadFileVC.pageHeader = strPageHeader
                uploadFileVC.cardNo = cardNo
                uploadFileVC.strClaimId = selectedClaimBo.claimId
                self.navigationController?.pushViewController(uploadFileVC, animated: true)
            }
        }else{
            selectedClaimBo = self.arrClaimData[indexPath.row]
            self.performSegue(withIdentifier: "claim_details", sender: self)
        }
        
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func goRatingSelector(sender: GLApplicationStatusTapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingStoryboardID") as! RatingViewController
        vc.strTitleHeader = strPageHeader
        vc.className = self.className
        vc.model = self.arrClaimData[sender.indexRowSelected!]
        vc.strPageTitle = strPageTitle
        vc.pageHeaderImage = strHeaderImageName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Service Call Methods
    func serviceCallToGetClaimDetails(){
        if(AppConstant.hasConnectivity()) {//true connected
            var apiUrl = ""
            AppConstant.showHUD()
            
            if(className == StringConstant.InPatient){
                //In-Patient Claims
                apiUrl = AppConstant.getMedicalVisitIPUrl
            }else if(className == StringConstant.OPSP){
                //OPSP Claims
                apiUrl = AppConstant.getMedicalVisitOPSPUrl
            }else if(className == StringConstant.GP){
                //GP Claims
                //cardNo = "8000147005585957"
                apiUrl = AppConstant.getMedicalVisitGPUrl
            }else if(className == StringConstant.Pharmacy){
                //Pharmacy Claims
                apiUrl = AppConstant.getMedicalVisitPharmacyUrl
            }else if(className == StringConstant.gl){
                //Gl
                apiUrl = AppConstant.getMedicalVisitGLUrl
            }else if(className == StringConstant.claim){
                //Claims
                apiUrl = AppConstant.getMedicalVisitClaimsUrl
            }else if(className == StringConstant.DisChargeAlert){
                //Discharge Alert
                apiUrl = AppConstant.postDischargeAlertUrl
            }else{
                //View Reimbursement Claims
                apiUrl = AppConstant.getMedicalVisitClaimsForGoldmemberUrl
            }
            
            var params: Parameters = ["pstCardNo": cardNo]
            if(className == StringConstant.DisChargeAlert){
                params["pstPlancode"] = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            }
            print("params===\(params)")
            print("url===\(apiUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            AFManager.request( apiUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetClaimDetails()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    let arrPolInfo = dict?["ViewGLList"] as? [[String: Any]]
                                    self.arrClaimData.removeAll()
                                    if(arrPolInfo?.count == 0){
                                        self.displayAlert(message: "No data available")
                                    }else{
                                        for dict in arrPolInfo! {
                                            let claimObj = ClaimBo()
                                            if let claimId = dict["CLAIMS_ID"] as? String{
                                                claimObj.claimId = claimId
                                            }else{
                                                claimObj.claimId = ""
                                            }
                                            if let providerName = dict["PROVIDER_NAME"] as? String{
                                                claimObj.providerName = providerName
                                            }else{
                                                claimObj.providerName = ""
                                            }
                                            if let admissionDate = dict["ADMISSION_DATE"] as? String{
                                                claimObj.admissionDate = admissionDate
                                            }else{
                                                claimObj.admissionDate = ""
                                            }
                                            if let payeeCode = dict["PAYEE_CODE"] as? String{
                                                claimObj.payeeCode = payeeCode
                                            }else{
                                                claimObj.payeeCode = ""
                                            }
                                            if let payeeName = dict["PAYEE_NAME"] as? String{
                                                claimObj.payeeName = payeeName
                                            }else{
                                                claimObj.payeeName = ""
                                            }
                                            if let payeeType = dict["PAYEE_TYP"] as? String{
                                                claimObj.payeeType = payeeType
                                            }else{
                                                claimObj.payeeType = ""
                                            }
                                            if let paymentMode = dict["PAYMENT_MODE"] as? String{
                                                claimObj.paymentMode = paymentMode
                                            }else{
                                                claimObj.paymentMode = ""
                                            }
                                            if let disbursementAmount = dict["DISBURSEMENT_AMT"] as? String{
                                                claimObj.disbursementAmount = disbursementAmount //String(format: "%.2f", disbursementAmount)
                                            }else{
                                                claimObj.disbursementAmount = "NA"
                                            }
                                            if let paymentDate = dict["PAYMENT_DATE"] as? String{
                                                claimObj.paymentDate = paymentDate
                                            }else{
                                                claimObj.paymentDate = ""
                                            }
                                            if let chequeNo = dict["CHQNO"] as? String{
                                                claimObj.chequeNo = chequeNo
                                            }else{
                                                claimObj.chequeNo = ""
                                            }
                                            if let bankCode = dict["BANK_CODE"] as? String{
                                                claimObj.bankCode = bankCode
                                            }else{
                                                claimObj.bankCode = ""
                                            }
                                            if let FDESC = dict["FDESC"] as? String{
                                                claimObj.FDESC = FDESC
                                            }else{
                                                claimObj.FDESC = ""
                                            }
                                            if let insertBy = dict["INSERT_BY"] as? String{
                                                claimObj.insertBy = insertBy
                                            }else{
                                                claimObj.insertBy = ""
                                            }
                                            if let insertDate = dict["INSERT_DATE"] as? String{
                                                claimObj.insertDate = insertDate
                                            }else{
                                                claimObj.insertDate = ""
                                            }
                                            if let bankName = dict["BANK_NAME"] as? String{
                                                claimObj.bankName = bankName
                                            }else{
                                                claimObj.bankName = ""
                                            }
                                            if let claimStatus = dict["CLAIMS_STATUS"] as? String{
                                                claimObj.claimStatus = claimStatus
                                            }else{
                                                claimObj.claimStatus = ""
                                            }
                                            if let totalAmount = dict["TOTAL_AMT"] as? String{
                                                claimObj.totalAmount = totalAmount//String(format: "%.2f", totalAmount)
                                            }else{
                                                claimObj.totalAmount = "NA"
                                            }
                                            if let approvedAmount = dict["APPROVED_AMT"] as? String{
                                                claimObj.approvedAmount = approvedAmount//String(format: "%.2f", approvedAmount)
                                            }else{
                                                claimObj.approvedAmount = "NA"
                                            }
                                            if let noncoveredAmount = dict["NONCOVERED_AMT"] as? String{
                                                claimObj.noncoveredAmount = noncoveredAmount//String(format: "%.2f", noncoveredAmount)
                                            }else{
                                                claimObj.noncoveredAmount = "NA"
                                            }
                                            if let remarks = dict["REMARKS"] as? String{
                                                claimObj.remarks = remarks
                                            }else{
                                                claimObj.remarks = "NA"
                                            }
                                            if let bankAccountNo = dict["BANKACCTNO"] as? String{
                                                claimObj.bankAccountNo = bankAccountNo
                                            }else{
                                                claimObj.bankAccountNo = ""
                                            }
                                            if let dischargableDate = dict["DISCHARGEABLE_DATE"] as? String{
                                                claimObj.dischargableDate = dischargableDate
                                            }else{
                                                claimObj.dischargableDate = ""
                                            }
                                            if let primaryDiagnosys = dict["PRIMARY_DIAGNOSIS"] as? String{
                                                claimObj.primaryDiagnosys = primaryDiagnosys
                                            }else{
                                                claimObj.primaryDiagnosys = ""
                                            }
                                            if let coverageId = dict["COVERAGE_ID"] as? String{
                                                claimObj.coverageId = coverageId
                                            }else{
                                                claimObj.coverageId = ""
                                            }
                                            if let admissionType = dict["ADMISSION_TYPE"] as? String{
                                                claimObj.admissionType = admissionType
                                            }else{
                                                claimObj.admissionType = ""
                                            }
                                            
                                            if let providerCode = dict["PROVIDER_CODE"] as? String{
                                                claimObj.providerCode = providerCode
                                            }else{
                                                claimObj.providerCode = ""
                                            }
                                            if let rating = dict["RATING"] as? Int{
                                                claimObj.rating = rating
                                            }else{
                                                claimObj.rating = 0
                                            }
                                            if let star = dict["STAR"] as? Int{
                                                claimObj.star = star
                                            }else{
                                                claimObj.star = 0
                                            }
                                            if let ratingId = dict["RATING_ID"] as? String{
                                                claimObj.ratingID = ratingId
                                            }else{
                                                claimObj.ratingID = ""
                                            }
                                            
                                            self.arrClaimData.append(claimObj)
                                        }
                                    }
                                    
                                    //Reload table view
                                    self.tblClaimList.reloadData()
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                        self.lblNoResults?.isHidden = false
                                        self.lblNoResults?.text = msg
                                        self.tblClaimList.isHidden = true
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: apiUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: apiUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetClaimListForMedicalChit(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstPlancode : String = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            
            let params: Parameters = ["pstCardNo": cardNo, "pstPlancode": pstPlancode
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.claimListForMedicalChitUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.claimListForMedicalChitUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetClaimListForMedicalChit()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    let arrPolInfo = dict?["MedicalClaimList"] as? [[String: Any]]
                                    self.arrClaimData.removeAll()
                                    if(arrPolInfo?.count == 0){
                                        self.displayAlert(message: "No data available")
                                    }else{
                                        for dict in arrPolInfo! {
                                            let claimObj = ClaimBo()
                                            if let claimId = dict["Claimsid"] as? String{
                                                claimObj.claimId = claimId
                                            }else{
                                                claimObj.claimId = ""
                                            }
                                            if let providerName = dict["ProviderName"] as? String{
                                                claimObj.providerName = providerName
                                            }else{
                                                claimObj.providerName = ""
                                            }
                                            if let admissionDate = dict["AdmissionDate"] as? String{
                                                claimObj.admissionDate = admissionDate
                                            }else{
                                                claimObj.admissionDate = ""
                                            }
                                            if let payeeCode = dict["PAYEE_CODE"] as? String{
                                                claimObj.payeeCode = payeeCode
                                            }else{
                                                claimObj.payeeCode = ""
                                            }
                                            if let payeeName = dict["PAYEE_NAME"] as? String{
                                                claimObj.payeeName = payeeName
                                            }else{
                                                claimObj.payeeName = ""
                                            }
                                            if let payeeType = dict["PAYEE_TYP"] as? String{
                                                claimObj.payeeType = payeeType
                                            }else{
                                                claimObj.payeeType = ""
                                            }
                                            if let paymentMode = dict["PAYMENT_MODE"] as? String{
                                                claimObj.paymentMode = paymentMode
                                            }else{
                                                claimObj.paymentMode = ""
                                            }
                                            if let disbursementAmount = dict["DISBURSEMENT_AMT"] as? Double{
                                                claimObj.disbursementAmount = String(format: "%.2f", disbursementAmount)
                                            }else{
                                                claimObj.disbursementAmount = "NA"
                                            }
                                            if let paymentDate = dict["PAYMENT_DATE"] as? String{
                                                claimObj.paymentDate = paymentDate
                                            }else{
                                                claimObj.paymentDate = ""
                                            }
                                            if let chequeNo = dict["CHQNO"] as? String{
                                                claimObj.chequeNo = chequeNo
                                            }else{
                                                claimObj.chequeNo = ""
                                            }
                                            if let bankCode = dict["BANK_CODE"] as? String{
                                                claimObj.bankCode = bankCode
                                            }else{
                                                claimObj.bankCode = ""
                                            }
                                            if let FDESC = dict["FDESC"] as? String{
                                                claimObj.FDESC = FDESC
                                            }else{
                                                claimObj.FDESC = ""
                                            }
                                            if let insertBy = dict["INSERT_BY"] as? String{
                                                claimObj.insertBy = insertBy
                                            }else{
                                                claimObj.insertBy = ""
                                            }
                                            if let insertDate = dict["INSERT_DATE"] as? String{
                                                claimObj.insertDate = insertDate
                                            }else{
                                                claimObj.insertDate = ""
                                            }
                                            if let bankName = dict["BANK_NAME"] as? String{
                                                claimObj.bankName = bankName
                                            }else{
                                                claimObj.bankName = ""
                                            }
                                            if let claimStatus = dict["CLAIMS_STATUS"] as? String{
                                                claimObj.claimStatus = claimStatus
                                            }else{
                                                claimObj.claimStatus = ""
                                            }
                                            if let totalAmount = dict["TOTAL_AMT"] as? Double{
                                                claimObj.totalAmount = String(format: "%.2f", totalAmount)
                                            }else{
                                                claimObj.totalAmount = "NA"
                                            }
                                            if let approvedAmount = dict["APPROVED_AMT"] as? Double{
                                                claimObj.approvedAmount = String(format: "%.2f", approvedAmount)
                                            }else{
                                                claimObj.approvedAmount = "NA"
                                            }
                                            if let noncoveredAmount = dict["NONCOVERED_AMT"] as? Double{
                                                claimObj.noncoveredAmount = String(format: "%.2f", noncoveredAmount)
                                            }else{
                                                claimObj.noncoveredAmount = "NA"
                                            }
                                            if let remarks = dict["REMARKS"] as? String{
                                                claimObj.remarks = remarks
                                            }else{
                                                claimObj.remarks = "NA"
                                            }
                                            if let bankAccountNo = dict["BANKACCTNO"] as? String{
                                                claimObj.bankAccountNo = bankAccountNo
                                            }else{
                                                claimObj.bankAccountNo = ""
                                            }
                                            if let dischargableDate = dict["DischargeDate"] as? String{
                                                claimObj.dischargableDate = dischargableDate
                                            }else{
                                                claimObj.dischargableDate = ""
                                            }
                                            if let primaryDiagnosys = dict["PRIMARY_DIAGNOSIS"] as? String{
                                                claimObj.primaryDiagnosys = primaryDiagnosys
                                            }else{
                                                claimObj.primaryDiagnosys = ""
                                            }
                                            if let coverageId = dict["CoverageID"] as? String{
                                                claimObj.coverageId = coverageId
                                            }else{
                                                claimObj.coverageId = ""
                                            }
                                            if let admissionType = dict["AdmissionType"] as? String{
                                                claimObj.admissionType = admissionType
                                            }else{
                                                claimObj.admissionType = ""
                                            }
                                            
                                            self.arrClaimData.append(claimObj)
                                        }
                                    }
                                    
                                    //Reload table view
                                    self.tblClaimList.reloadData()
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                        self.lblNoResults?.isHidden = false
                                        self.lblNoResults?.text = msg
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.claimListForMedicalChitUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.claimListForMedicalChitUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "claim_details"){
            let vc = segue.destination as! ClaimDetailsViewController
            vc.className = className
            vc.claimObj = selectedClaimBo
            vc.strHeaderImageName = strHeaderImageName
            vc.pageTitle = strPageTitle
            return
        }else if (segue.identifier == "claim_document_list"){
            let vc = segue.destination as! ClaimDocumentListingViewController
            vc.className = className
            vc.claimId = selectedClaimBo.claimId
            vc.strHeaderImageName = strHeaderImageName
            vc.pageTitle = strPageTitle
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
