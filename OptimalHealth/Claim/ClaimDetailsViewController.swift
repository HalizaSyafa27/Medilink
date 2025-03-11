//
//  ClaimDetailsViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ClaimDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblViewClaimDetails: UITableView!
    @IBOutlet var viewLetter: UIView!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblTitleViewLetter: UILabel!
    @IBOutlet weak var letterView: UIView!
    
    var className = ""
    var claimObj = ClaimBo()
    var pageTitle = ""
    var strHeaderImageName = ""
    let currencySymbol = AppConstant.retrievFromDefaults(key: StringConstant.currencySymbol)
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewLetterAction(sender:)))
        viewLetter.addGestureRecognizer(tap)
        
        self.setValues()
        
        if ((className == StringConstant.teleconsultAppoinments) || (className == StringConstant.teleconsultE_Prescription) || (className == StringConstant.teleconsultE_Lab) || (className == StringConstant.teleconsultE_Referral) || (className == StringConstant.teleconsultHistory) || (className == StringConstant.teleconsultE_Delivery)) {
            if claimObj.claimId == ""
            {
                self.viewLetter.isHidden = true
            }
        }
        else if claimObj.claimId == "" {
            self.viewLetter.isHidden = true
        }
        else if (className == StringConstant.uploadMedicalChit){
            if claimObj.claimId == ""{
                self.viewLetter.isHidden = true
            }
        }
        else if(className == StringConstant.DisChargeAlert){
            lblTitleViewLetter.text = "Trigger Discharge Alert"
        }
    }
    
    //MARK: Tableview Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if className == StringConstant.claim{
            return section == 0 ? 1 : 12
        }else{
          return section == 0 ? 1 : 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimDetailsTableViewCell1", for: indexPath) as! ClaimDetailsTableViewCell1
            cell.selectionStyle = .none
            cell.lblTotalBillTitle.text = "Total Bill"// (" + currencySymbol + ")"
            cell.lblClaimId.text = "CLAIM ID - \(claimObj.claimId)"
            if((className == StringConstant.viewReimbursementClaim) || (className == StringConstant.GP) || (className == StringConstant.OPSP) || (className == StringConstant.Pharmacy) || (className == StringConstant.claim)){
                cell.lblAdmissionDateHeader.text = "Event Date"
                
            }else{
                cell.lblAdmissionDateHeader.text = "Admission Date"
            }
            
            if ((className == StringConstant.GP) || (className == StringConstant.OPSP) || (className == StringConstant.Pharmacy)) {
                cell.viewWithOutDischargeDate.isHidden = false
                cell.viewWithDischargeDate.isHidden = true
                
                cell.labelWithOutDischargeDate1.text = claimObj.admissionDate
                cell.labelWithOutDischargeDate2.text = claimObj.totalAmount
            }else{
                cell.viewWithOutDischargeDate.isHidden = true
                cell.viewWithDischargeDate.isHidden = false
            }
            
            if claimObj.admissionDate == ""{
                cell.lblAdmissionDate.text = "NA"
            }else{
                cell.lblAdmissionDate.text = claimObj.admissionDate
            }
            
            cell.lblDischargeDateHeader.text = "Discharge Date"
            
            if claimObj.dischargableDate == ""{
                cell.lblDischargeDate.text = "NA"
            }else{
                cell.lblDischargeDate.text = claimObj.dischargableDate
            }
            
            if claimObj.totalAmount == ""{
                cell.lblTotalBill.text = "NA"
            }else{
                cell.lblTotalBill.text = claimObj.totalAmount
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimDetailsTableViewCell2", for: indexPath) as! ClaimDetailsTableViewCell2
            cell.selectionStyle = .none
            
            if indexPath.row == 0{
                cell.labelTitle.text = "Provider:"
                cell.lblValue.text = claimObj.providerName
            }else if indexPath.row == 1{
                cell.labelTitle.text = "Status:"
                cell.lblValue.text = claimObj.claimStatus
            }else if indexPath.row == 2{
                cell.labelTitle.text = "Approved Amount:"
                cell.lblValue.text = claimObj.approvedAmount
            }else if indexPath.row == 3{
                cell.labelTitle.text = "Non Covered:"// (" + currencySymbol + "):"
                cell.lblValue.text = claimObj.noncoveredAmount
            }else if indexPath.row == 4{
                cell.labelTitle.text = "Remarks:"
                cell.lblValue.text = claimObj.remarks
            }else if indexPath.row == 5{
                cell.labelTitle.text = "Coverage ID:"
                cell.lblValue.text = claimObj.coverageId
            }else if indexPath.row == 6{
                cell.labelTitle.text = "Admission Type:"
                cell.lblValue.text = claimObj.admissionType
            }else if indexPath.row == 7{
                cell.labelTitle.text = "Payment Mode:"
                cell.lblValue.text = claimObj.paymentMode == "" ? "NA" : claimObj.paymentMode
            }else if indexPath.row == 8{
                cell.labelTitle.text = "Payee Type:"
                cell.lblValue.text = claimObj.payeeType == "" ? "NA" : claimObj.payeeType
            }else if indexPath.row == 9{
                cell.labelTitle.text = "Payee Name:"
                cell.lblValue.text = claimObj.payeeName == "" ? "NA" : claimObj.payeeName
            }else if indexPath.row == 10{
                cell.labelTitle.text = "Payment Date:"
                cell.lblValue.text = claimObj.paymentDate == "" ? "NA" : claimObj.paymentDate
            }else if indexPath.row == 11{
                cell.labelTitle.text = "Disbursement Amount:"
                cell.lblValue.text = claimObj.disbursementAmount == "" ? "NA" : claimObj.disbursementAmount
            }
            
            return cell
        }
        
    }
    
    func setValues(){
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func viewLetterAction(sender: UITapGestureRecognizer? = nil) {
        if(className == StringConstant.DisChargeAlert){
            self.serviceCallToPostDischargeNotification()
        }else{
            self.performSegue(withIdentifier: "viewLetter", sender: self)
        }
    }
    
    //MARK: Service Call Methods
    func serviceCallToPostDischargeNotification(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let params: Parameters = ["pstClaimsID": claimObj.claimId]
            print("params===\(params)")
            print("url===\(AppConstant.postDischargeNotificationUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.postDischargeNotificationUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToPostDischargeNotification()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.letterView.isHidden = true
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDischargeNotificationUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDischargeNotificationUrl)
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
        if (segue.identifier == "viewLetter"){
            let vc = segue.destination as! ViewGLLettersViewController
            vc.className = className
            vc.claimId = claimObj.claimId
            vc.pageTitle = pageTitle
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
