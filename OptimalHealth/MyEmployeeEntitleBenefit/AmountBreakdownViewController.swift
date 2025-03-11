
//
//  AmountBreakdownViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 26/06/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class AmountBreakdownViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblAmountList: UITableView!
    @IBOutlet var lblNoDataAvail: UILabel!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    
    var strCardNo = ""
    var covBo = CoverageDataBo()
    var arrAmountList = [ClaimAmountBo]()
    var planCode = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
        }
        tblAmountList.tableFooterView = UIView()
        serviceCallToGetCoverageClaim()
    }
    
    // MARK: Tableview Delegates & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAmountList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AmountBreakdownTableViewCell", for: indexPath as IndexPath) as! AmountBreakdownTableViewCell
        cell.selectionStyle = .none
        
        let claimAmountBo = self.arrAmountList[indexPath.row]
        cell.lblAdmDate.text = claimAmountBo.admissionDate == "" ? "NA" : claimAmountBo.admissionDate
        cell.lblDueTotal.text = claimAmountBo.durTotal == "" ? "APPROVED AMOUNT - NA" : "APPROVED AMOUNT - \(claimAmountBo.durTotal)"
        cell.lblProviderName.text = claimAmountBo.providerName == "" ? "NA" : claimAmountBo.providerName
        cell.lblClaimId.text = claimAmountBo.claimId == "" ? "CLAIM ID - NA" : "CLAIM ID - \(claimAmountBo.claimId)"
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Service Call
    func serviceCallToGetCoverageClaim(){
        
        if AppConstant.hasConnectivity() {//internet active
            AppConstant.showHUD()
            
            
            let json = "{\"pstCardNo\":\"\(strCardNo)\",\"pstPalnCode\":\"\(planCode)\",\"pstCoverage\":\"\(covBo.code)\",\"pstStartDate\":\"\(covBo.start_date)\",\"pstEndDate\":\"\(covBo.end_date)\"}"
            print(json)
            let url = URL(string: AppConstant.getCoverageRelatedClaimsUrl)!
            print(url)
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request(request).responseJSON {
                (response) in
                // debugPrint(response)
                AppConstant.hideHUD()
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetCoverageClaim()
                            }
                        })
                    }else{
                        
                        let dataRes = response.result.value as! [String : AnyObject]
                        if let status = dataRes["Status"] as? String {
                            if(status == "1"){//success
                                self.arrAmountList.removeAll()
                                let arrEntitlementList = dataRes["EntitlementList"] as! [[String: Any]]
                                if(arrEntitlementList.count > 0){
                                    for dictClaim in arrEntitlementList{
                                        let amtBo = ClaimAmountBo()
                                        if let admDate = dictClaim["AdmissionDate"] as? String {
                                            amtBo.admissionDate = admDate
                                        }else{
                                            amtBo.admissionDate = "NA"
                                        }
                                        if let Claimsid = dictClaim["Claimsid"] as? String {
                                            amtBo.claimId = Claimsid
                                        }else{
                                            amtBo.claimId = "NA"
                                        }
                                        if let Duetotal = dictClaim["Duetotal"] as? String {
                                            amtBo.durTotal = Duetotal
                                        }else{
                                            amtBo.durTotal = "NA"
                                        }
                                        if let PaidtoClaimAmt = dictClaim["PaidtoClaimAmt"] as? String {
                                            amtBo.paidtoClaimAmt = PaidtoClaimAmt
                                        }else{
                                            amtBo.paidtoClaimAmt = "NA"
                                        }
                                        if let PrimaryDiagnosis = dictClaim["PrimaryDiagnosis"] as? String {
                                            amtBo.primaryDiagnosis = PrimaryDiagnosis
                                        }else{
                                            amtBo.primaryDiagnosis = "NA"
                                        }
                                        if let providerId = dictClaim["ProviderID"] as? String {
                                            amtBo.providerID = providerId
                                        }else{
                                            amtBo.providerID = "NA"
                                        }
                                        if let providerName = dictClaim["ProviderName"] as? String {
                                            amtBo.providerName = providerName
                                        }else{
                                            amtBo.providerName = "NA"
                                        }
                                        
                                        self.arrAmountList.append(amtBo)
                                        self.tblAmountList.reloadData()
                                    }
                                }
                                
                            }else{
                                self.lblNoDataAvail.isHidden = false
                                if let msg = dataRes["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }
                        
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.getCoverageRelatedClaimsUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
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
