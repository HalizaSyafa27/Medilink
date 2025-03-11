//
//  ViewGlLetterListViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/06/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ViewGlLetterListViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var glLettersTableView: UITableView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblNoDataAvail: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblHeader: UILabel!
    
    var arrGlList = [ViewGlBo]()
    var cardNo = ""
    var claimId = ""
    var selectedClaimId = ""
    var pageTitle: String = ""
    var strHeader = ""
    var strHeaderImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        initDesigns()
        serviceCallToGetViewGlLettersList()
    }
    
    func initDesigns() {
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        lblTitle.text = pageTitle
        lblHeader.text = strHeader
        
        self.glLettersTableView.tableFooterView = UIView()
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: TableView Delegate & Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGlList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewGlLetterListTableViewCell", for: indexPath as IndexPath) as! ViewGlLetterListTableViewCell
        
        
        let glListBo = arrGlList[indexPath.row]
        
        cell.lblStatus.text = glListBo.glStatus == "" ? "NA" : glListBo.glStatus
        cell.lblAdmissionDate.text = glListBo.admissionDate == "" ? "NA" : glListBo.admissionDate
        cell.lblCoverageId.text = glListBo.CovId == "" ? "NA" : glListBo.CovId
        cell.lblPatientName.text = glListBo.patientName == "" ? "NA" : glListBo.patientName
        cell.lblClaimId.text = glListBo.claimId == "" ? "NA" : "CLAIM ID - \(glListBo.claimId)"
        
        if glListBo.glImage == "RECEIVED-IMAGE"{
            cell.imgViewStatus.image = UIImage.init(named: "received")
        }else if glListBo.glImage == "APPROVED-IMAGE"{
            cell.imgViewStatus.image = UIImage.init(named: "approved")
        }else if glListBo.glImage == "DECLINED-IMAGE"{
            cell.imgViewStatus.image = UIImage.init(named: "declined")
        }else if glListBo.glImage == "PENDING-IMAGE"{
            cell.imgViewStatus.image = UIImage.init(named: "pending")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let glListBo = arrGlList[indexPath.row]
        selectedClaimId = glListBo.claimId
        self.performSegue(withIdentifier: "view_gl_letter", sender: self)
        
    }
    
    //MARK: Service Call
    func serviceCallToGetViewGlLettersList() {
        
        if(AppConstant.hasConnectivity()) {//true connected
            
            AppConstant.showHUD()
//            let emailId = AppConstant.retrievFromDefaults(key: StringConstant.email)
//            let password = AppConstant.retrievFromDefaults(key: StringConstant.password)
            
            let pstPlancode : String = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            
            let params: Parameters = [
                "pstCardNo": cardNo,
                "pstPlancode": pstPlancode
//                "pstCardNo": "8000145900000239",
//                "pstPlancode": "MLOPS-DEN"
            ]
            print("params===\(params)")
            print("URL===\(AppConstant.getGlLetterListUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.getGlLetterListUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallToGetViewGlLettersList()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    self.arrGlList.removeAll()
                                    if let dict_array = dict?["ViewGLList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let viewGlBo = ViewGlBo()
                                            if let claimId = item["Claims_Id"] as? String{
                                                viewGlBo.claimId = claimId
                                            }
                                            if let Admission_Date = item["Admission_Date"] as? String{
                                                viewGlBo.admissionDate = Admission_Date
                                            }
                                            if let COVERAGE_ID = item["COVERAGE_ID"] as? String{
                                                viewGlBo.CovId = COVERAGE_ID
                                            }
                                            if let Patient_Name = item["Patient_Name"] as? String{
                                                viewGlBo.patientName = Patient_Name
                                            }
                                            if let ADMISSION_TYPE = item["ADMISSION_TYPE"] as? String{
                                                viewGlBo.admType = ADMISSION_TYPE
                                            }
                                            if let New_Ic = item["New_Ic"] as? String{
                                                viewGlBo.newIc = New_Ic
                                            }
                                            if let Claims_Status = item["Claims_Status"] as? String{
                                                viewGlBo.claimStatus = Claims_Status
                                            }
                                            if let Payor_Remarks = item["Payor_Remarks"] as? String{
                                                viewGlBo.payorRemarks = Payor_Remarks
                                            }
                                            if let Doc_Received_Date = item["Doc_Received_Date"] as? String{
                                                viewGlBo.docReceivedDate = Doc_Received_Date
                                            }
                                            if let GL_Status = item["GL_Status"] as? String{
                                                viewGlBo.glStatus = GL_Status
                                            }
                                            if let GL_Print_Date = item["GL_Print_Date"] as? String{
                                                viewGlBo.glPrintDate = GL_Print_Date
                                            }
                                            if let Transaction_Date = item["Transaction_Date"] as? String{
                                                viewGlBo.transactionDate = Transaction_Date
                                            }
                                            if let GL_Image = item["GL_Image"] as? String{
                                                viewGlBo.glImage = GL_Image
                                            }
                                            
                                            self.arrGlList.append(viewGlBo)
                                        }
                                        
                                    }
                                    if self.arrGlList.count == 0{
                                        self.lblNoDataAvail.isHidden = false
                                    }else{
                                        self.lblNoDataAvail.isHidden = true
                                    }
                                    
                                    self.glLettersTableView.reloadData()
                                    
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                        if self.arrGlList.count == 0{
                                            self.lblNoDataAvail.isHidden = false
                                            self.lblNoDataAvail.text = msg
                                            self.glLettersTableView.isHidden = true
                                        }else{
                                            self.lblNoDataAvail.isHidden = true
                                            self.glLettersTableView.isHidden = false
                                        }
                                        //self.showAlertPopOnOkButton(strTitle: msg, strDesc: "")
                                    }
                                    
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getGlLetterListUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getGlLetterListUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Alert Method
    func showAlertPopOnOkButton(strTitle: String, strDesc: String) {
        let alert = UIAlertController(title: strTitle, message: strDesc,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "view_gl_letter"){
            let vc = segue.destination as! ViewGLLettersViewController
            vc.claimId = selectedClaimId
            vc.pageTitle = pageTitle
            return
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
