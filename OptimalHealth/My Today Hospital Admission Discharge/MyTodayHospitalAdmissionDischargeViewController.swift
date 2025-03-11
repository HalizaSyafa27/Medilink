//
//  MyTodayHospitalAdmissionDischargeViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/12/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class MyTodayHospitalAdmissionDischargeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imgViewHeader: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    @IBOutlet weak var tblviewHAD: UITableView!
    @IBOutlet weak var btnHome: UIButton!
    
    var imgHeader = ""
    var titleHeader = ""
    var arrStatus = [GLStatusBo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgViewHeader.image = UIImage.init(named: imgHeader)
        lblHeader.text = titleHeader.uppercased()
        
        self.tblviewHAD.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.serviceCallToGetHADData()
    }
    
    // MARK: - Table View Delegate and Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTodayAdmissionDischargeTableViewCell") as! MyTodayAdmissionDischargeTableViewCell
        cell.selectionStyle = .none
        
        let statusBo = self.arrStatus[indexPath.row]

        cell.lblPatientName.text = statusBo.patientName
        cell.lblPolicyNo.text = statusBo.policyNo
        cell.lblProviderName.text = statusBo.providerName
        cell.lblProviderId.text = statusBo.providerId
        cell.lblAdmissionDate.text = statusBo.admissionDate
        cell.lblGLStatus.text = statusBo.glStatus
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Service Call
    func serviceCallToGetHADData(){
        if AppConstant.hasConnectivity() {//internet active
            AppConstant.showHUD()
            let pstUsrID = AppConstant.retrievFromDefaults(key: StringConstant.email)
            let pstPassword = AppConstant.retrievFromDefaults(key: StringConstant.password)
            let agentId = AppConstant.retrievFromDefaults(key: StringConstant.agentId)
            let uType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
           
            var strUrl = ""
            var json = ""
            if uType == "2"{//Corporate
                strUrl = AppConstant.getInsuredMemberGLStatus_CorporateUrl
                json = "{\"pstUserID\":\"\(pstUsrID)\",\"pstPassword\":\"\(pstPassword)\"}"
            }else{
                //Agent
                strUrl = AppConstant.getInsuredMemberGLStatusUrl
                json = "{\"pstAgentId\":\"\(agentId)\",\"pstUserID\":\"\(pstUsrID)\",\"pstPassword\":\"\(pstPassword)\"}"
            }
            
            print(strUrl)
            print(json)
            
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: URL(string: strUrl)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
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
                    self.arrStatus.removeAll()
                    debugPrint(response.result.value!)
                    var dict = response.result.value as! [String : AnyObject]
                    if let strResponse = dict["SearchResponse"] as? String {
                        if let arrRes = AppConstant.convertToArray(text: strResponse){
                            if arrRes.count > 0{
                                for dictStatus in arrRes{
                                    let glStatusBo = GLStatusBo()
                                    if let patient = dictStatus["PATIENT_NAME"] as? String {
                                        glStatusBo.patientName = patient
                                    }else{
                                        glStatusBo.patientName = "NA"
                                    }
                                    if let policyNo = dictStatus["POLICY_NO"] as? String {
                                        glStatusBo.policyNo = policyNo
                                    }else{
                                        glStatusBo.policyNo = "NA"
                                    }
                                    if let providerName = dictStatus["PROVIDER_NAME"] as? String {
                                        glStatusBo.providerName = providerName
                                    }else{
                                        glStatusBo.providerName = "NA"
                                    }
                                    if let providerId = dictStatus["PROVIDER_ID"] as? String {
                                        glStatusBo.providerId = providerId
                                    }else{
                                        glStatusBo.providerId = "NA"
                                    }
                                    if let admDate = dictStatus["ADMISSION_DATE"] as? String {
                                        glStatusBo.admissionDate = admDate
                                    }else{
                                        glStatusBo.admissionDate = "NA"
                                    }
                                    if let glStatus = dictStatus["GLSTATUS"] as? String {
                                        glStatusBo.glStatus = glStatus
                                    }else{
                                        glStatusBo.glStatus = "NA"
                                    }
                                    self.arrStatus.append(glStatusBo)
                                    self.tblviewHAD.reloadData()
                                }
                            }
                        }
                    }else{
                        self.lblNoDataAvailable.isHidden = false
                        if let msg = dict["message"] as? String{
                            self.displayAlert(message: msg)
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: strUrl)
                        }
                    }
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: strUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    // MARK: - Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
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
