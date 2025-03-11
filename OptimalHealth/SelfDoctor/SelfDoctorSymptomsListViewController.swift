//
//  SelfDoctorSymptomsListViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/11/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class SelfDoctorSymptomsListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var imgViewGender: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTop10Separator: UILabel!
    @IBOutlet weak var lblCommonSeparator: UILabel!
    @IBOutlet weak var lblRedFlagSeparator: UILabel!
    @IBOutlet weak var lblAllSeparator: UILabel!
    @IBOutlet weak var tblViewSymptomsList: UITableView!
    @IBOutlet var lblNoDataAvailable: UILabel!
    
    var pageTitle = ""
    var strCardNo = ""
    var strPayorMemberId = ""
    
    var ageId: String = ""
    var gender: String = ""
    var pregnantId: String = ""
    var countryId: String = ""
    var symptomHeader = ""
    var selectedAgeFormat1 = ""
    var arrSymptoms = [String]()
    
    var arrDiagnosesList = [DiagnosesListBo]()
    var triageApiUrl: String = ""
    var selectedIndexUrl = DiagnosesListBo()
    var arrFiltered = [DiagnosesListBo]()
    
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
        
        lblPageTitle.text = pageTitle
        
        if gender == "f" {
            if (selectedAgeFormat1 == "newborn" || selectedAgeFormat1 == "infant") {
                imgViewGender.image = UIImage.init(named: "child_female")
            }else{
                imgViewGender.image = UIImage.init(named: "female")
            }
        }else{
            if (selectedAgeFormat1 == "newborn" || selectedAgeFormat1 == "infant") {
                imgViewGender.image = UIImage.init(named: "child_male")
            }else{
                imgViewGender.image = UIImage.init(named: "male")
            }
        }
        
        lblDesc.text = symptomHeader
        
        tblViewSymptomsList.layer.cornerRadius = 4
        tblViewSymptomsList.layer.borderWidth = 1
        tblViewSymptomsList.layer.borderColor = AppConstant.themeGrayColor.cgColor
        tblViewSymptomsList.clipsToBounds = true
        
        tblViewSymptomsList.delegate = self
        tblViewSymptomsList.dataSource = self
        tblViewSymptomsList.tableFooterView = UIView()
        
        lblTop10Separator.isHidden = false
        lblCommonSeparator.isHidden = true
        lblRedFlagSeparator.isHidden = true
        lblAllSeparator.isHidden = true
        
        //Api call to get DiagnosesList
        self.serviceCallToGetDiagnosesDetails()
    }
    
    //MARK: Tableview Delegate & Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "symptomsList", for: indexPath) as! SelfDoctorSymptomsListTableViewCell
        cell.selectionStyle = .none
        
        let diagnosesBo = arrFiltered[indexPath.row]
        cell.lblSymptomsName.text = diagnosesBo.diagnosisName
        
        cell.imgViewRedFlagIcon.isHidden = (diagnosesBo.redFlag == "true" && lblCommonSeparator.isHidden == true) ? false : true
        cell.imgViewIconWidthConstraints.constant = (diagnosesBo.redFlag == "true" && lblCommonSeparator.isHidden == true) ? 25 : 0
        if diagnosesBo.redFlag == "true"{
            cell.imgViewRedFlagIcon.image = UIImage(named: "flag_img")
        }
        
        cell.lblCommon.isHidden = (diagnosesBo.commonDiagnosis == "true" && lblRedFlagSeparator.isHidden == true) ? false : true
        cell.lblCommonWidthConstraints.constant = (diagnosesBo.commonDiagnosis == "true" && lblRedFlagSeparator.isHidden == true) ? 85 : 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexUrl = arrDiagnosesList[indexPath.row]
        self.showWebViewPopup()
    }
    
    func showWebViewPopup() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "KnowledgeWindowPopupViewController") as! KnowledgeWindowPopupViewController
        
        vc.knowledgeUrl = selectedIndexUrl.knowledgeWindow_url
        
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        vc.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            vc.view.alpha = 1.0
            vc.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.addChild(vc)
            topController.view.addSubview(vc.view)
        }
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        return
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        self.arrFiltered.removeAll()
        if sender.tag == 1{//Top 10
            lblTop10Separator.isHidden = false
            lblCommonSeparator.isHidden = true
            lblRedFlagSeparator.isHidden = true
            lblAllSeparator.isHidden = true
            
            if (self.arrDiagnosesList.count > 10) {
                let arrSelectedItems = self.arrDiagnosesList[0...9]
                self.arrFiltered = Array(arrSelectedItems)
            }else{
                self.arrFiltered = self.arrDiagnosesList
            }
            
        }else if sender.tag == 2{//Common
            lblTop10Separator.isHidden = true
            lblCommonSeparator.isHidden = false
            lblRedFlagSeparator.isHidden = true
            lblAllSeparator.isHidden = true
            
            self.arrFiltered = self.arrDiagnosesList.filter { $0.commonDiagnosis == "true"}
            
            
        }else if sender.tag == 3{//Red Flag
            lblTop10Separator.isHidden = true
            lblCommonSeparator.isHidden = true
            lblRedFlagSeparator.isHidden = false
            lblAllSeparator.isHidden = true
            
            self.arrFiltered = self.arrDiagnosesList.filter { $0.redFlag == "true"}
            
        }else{//All
            lblTop10Separator.isHidden = true
            lblCommonSeparator.isHidden = true
            lblRedFlagSeparator.isHidden = true
            lblAllSeparator.isHidden = false
            
            self.arrFiltered = self.arrDiagnosesList
        }
        
        self.tblViewSymptomsList.reloadData()
        
        if arrFiltered.count == 0{
            self.lblNoDataAvailable.isHidden = false
            self.lblNoDataAvailable.text = "No Data Available"
        }else{
            self.lblNoDataAvailable.isHidden = true
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "getCare", sender: self)
    }
    
    //MARK: Service Call Method
    func serviceCallToGetDiagnosesDetails(){
        if AppConstant.hasConnectivity() {//true connected
            AppConstant.showHUD()
            
            let params: Parameters = ["age_id": ageId,
                                      "gender": gender,
                                      "pregnant_id": pregnantId,
                                      "country_id": countryId,
                                      "symptoms": self.arrSymptoms.joined(separator: ",")]
            
            let url = "\(AppConstant.diagnosesUrl)?cardNo=\(strCardNo)&memberControlNo=\(strPayorMemberId)"
            print("params===\(params)")
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                        case .success(_):
                            let headerStatusCode : Int = (response.response?.statusCode)!
                            print("Status Code: \(headerStatusCode)")
                            
                            if(headerStatusCode == 401){//Session expired
                                self.isTokenVerified(completion: { (Bool) in
                                    if Bool{
                                        self.serviceCallToGetDiagnosesDetails()
                                    }
                                })
                            }else{
                                let dict = response.result.value! as! [String: Any]
                                
                                if let success = dict["success"] as? Bool{
                                    if success == true{
                                        if let dataDict = dict["data"] as? [String: Any]{
                                            if let triage_api_url = dataDict["triage_api_url"] as? String{
                                                self.triageApiUrl = triage_api_url
                                            }
                                            
                                            self.arrDiagnosesList.removeAll()
                                            if let diagnosesDict = dataDict["diagnoses"] as? [[String: Any]]{
                                                for dict in diagnosesDict{
                                                    let diagnosesBo = DiagnosesListBo()
                                                    
                                                    if let diagnosis_id = dict["diagnosis_id"] as? String{
                                                        diagnosesBo.diagnosisId = diagnosis_id
                                                    }
                                                    if let diagnosis_name = dict["diagnosis_name"] as? String{
                                                        diagnosesBo.diagnosisName = diagnosis_name
                                                    }
                                                    if let knowledge_window_url = dict["knowledge_window_url"] as? String{
                                                        diagnosesBo.knowledgeWindow_url = knowledge_window_url
                                                    }
                                                    if let red_flag = dict["red_flag"] as? String{
                                                        diagnosesBo.redFlag = red_flag
                                                    }
                                                    if let gender = dict["gender"] as? String{
                                                        diagnosesBo.gender = gender
                                                    }
                                                    if let specialty = dict["specialty"] as? String{
                                                        diagnosesBo.specialty = specialty
                                                    }
                                                    if let common_diagnosis = dict["common_diagnosis"] as? String{
                                                        diagnosesBo.commonDiagnosis = common_diagnosis
                                                    }
                                                    if let snomed_diagnosis_id = dict["snomed_diagnosis_id"] as? String{
                                                        diagnosesBo.snomed_diagnosisID = snomed_diagnosis_id
                                                    }
                                                    if let icd9_diagnosis_id = dict["icd9_diagnosis_id"] as? String{
                                                        diagnosesBo.icd9_diagnosisID = icd9_diagnosis_id
                                                    }
                                                    if let icd10_diagnosis_id = dict["icd10_diagnosis_id"] as? String{
                                                        diagnosesBo.icd10_diagnosisID = icd10_diagnosis_id
                                                    }
                                                    self.arrDiagnosesList.append(diagnosesBo)
                                                    
                                                }
                                            }
                                        }
                                        if (self.lblTop10Separator.isHidden == false) {
                                            self.arrFiltered.removeAll()
                                            if self.arrDiagnosesList.count > 10{
                                                let arrSelectedItems = self.arrDiagnosesList[0...9]
                                                self.arrFiltered = Array(arrSelectedItems)
                                            }else{
                                                self.arrFiltered = self.arrDiagnosesList
                                            }
                                            
                                            if (self.arrFiltered.count == 0 || self.arrDiagnosesList.count == 0) {
                                                self.lblNoDataAvailable.isHidden = false
                                                self.lblNoDataAvailable.text = "No Data Available"
                                            }else{
                                                self.lblNoDataAvailable.isHidden = true
                                            }
                                            
                                        }
                                        self.tblViewSymptomsList.reloadData()
                                        
                                    }else{
                                        let msg = dict["Message"] as? String
                                        self.displayAlert(message: msg ?? "")
                                    }
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
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getCare"{
            let vc = segue.destination as! WhereToGetCareViewController
            vc.triageUrl = self.triageApiUrl
            vc.gender = self.gender
            vc.symptomHeader = self.symptomHeader
            vc.selectedAgeFormat1 = self.selectedAgeFormat1
            vc.pageTitle = self.pageTitle
            vc.strCardNo = self.strCardNo
            vc.strPayorMemberId = self.strPayorMemberId
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
