//
//  ViewBenefitViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ViewBenefitViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, ChooseDelegate {
    
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet var viewPersonal: UIView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var tblConditions: UITableView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblPlanCode: UILabel!
    @IBOutlet var lblNodataAvailable: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblHeaderTitle: UILabel!
    @IBOutlet var imgViewUser: UIImageView!
    @IBOutlet var lblEntitlementType: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    
    var name = ""
    var strCardNo = ""
    var strPolicyNo = ""
    var coverageAllDataBo = CoverageAllDataBo()
    var selectedCovBo = CoverageDataBo()
    var arrExpandStatus = [Bool]()
    var pageTitle: String = ""
    var strHeaderImageName = ""
    var headerTitle: String = ""
    var arrPlanCodeData = [PlanCodeBo]()
    var selectedPlanCode = PlanCodeBo()
    var currencySymbol = AppConstant.retrievFromDefaults(key: StringConstant.currencySymbol)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //viewPersonal.isHidden = true
        lblNodataAvailable.isHidden = true
        self.serviceCallToGetPlanCode()
        initDesign()
    }
    
    func initDesign(){
        lblName.text = name
        lblEntitlementType.text = pageTitle
        self.lblHeaderTitle.text = headerTitle
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        //let planCode = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
        //lblPlanCode.text = planCode
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.height/2
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.width/2
        self.imgViewUser.layer.borderWidth = 1.5
        self.imgViewUser.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewUser.clipsToBounds = true
        
        if pageTitle == "Principal"{
            let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
                 if profileImgStr != ""{
                    if let data = Data(base64Encoded: profileImgStr) {
                     let image = UIImage(data: data)
                      imgViewUser.image = image
                }
            }
        }
        
     }
    
    func setPlanCodeArray() -> [CustomObject]{
        var arr = [CustomObject]()
        for plan in self.arrPlanCodeData{
            let customBo = CustomObject()
            customBo.code = plan.planCode
            customBo.name = plan.planCode//plan.FDESC
            arr.append(customBo)
        }
        return arr
    }
    
    //MARK: Delegates
        func selectedItem(item: String,type: String){
            
        }
        func selectedObject(obj: CustomObject,type: String){
            if type == "plancode"{
                let planc = PlanCodeBo()
                planc.FDESC = obj.code!
                planc.planCode = obj.code!
                self.selectedPlanCode = planc
                self.lblPlanCode.text = self.selectedPlanCode.planCode
                self.serviceCallToGetCoverage(planCode: obj.code!)
            }
        }

    // MARK: Tableview Delegates & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let status = self.arrExpandStatus[indexPath.row]
        if status == true {
            return 43.0
        }else{
            if(self.coverageAllDataBo.DISPLAYBENEFIT == "S"){
                return 200.0
            }
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coverageAllDataBo.arrCoverageData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewbenefitConditionTableViewCell", for: indexPath as IndexPath) as! ViewbenefitConditionTableViewCell
        cell.selectionStyle = .none
        
        let covBo = self.coverageAllDataBo.arrCoverageData[indexPath.row]
        
        if(self.coverageAllDataBo.DISPLAYBENEFIT == "S"){
            cell.viewNote.isHidden = true
            cell.viewIndividualBalance.isHidden = true
            cell.lblConditionTitle.text = "Limit"
            cell.lblYtdConsumptionTitle.text = "YTD Consumption"
            cell.HeightViewIndiConstraint.constant = 0
            cell.HeightViewNoteConstraint.constant = 0
            cell.HeightImageIndiConstraint.constant = 0
            cell.HeightImageNoteConstraint.constant = 0
            cell.lblLineYtd.isHidden = true
            cell.lblCondition.text = covBo.NOTE == "" ? "NA" : covBo.NOTE
        }else{
            cell.viewNote.isHidden = false
            cell.viewIndividualBalance.isHidden = false
            cell.lblConditionTitle.text = "Eligibility (Annual/" + currencySymbol + ")"
            cell.lblYtdConsumptionTitle.text = "Utilization (" + currencySymbol + ")"
            cell.lblIndividualBalanceLimitTitle.text = "Individual Balance Limit (" + currencySymbol + ")"
            cell.lblIndividualBalance.text = covBo.AVAILABLELIMIT == "" ? "NA" : covBo.AVAILABLELIMIT
            cell.lblNote.text = covBo.NOTE == "" ? "NA" : covBo.NOTE
            cell.lblCondition.text = covBo.conditions == "" ? "NA" : covBo.conditions
        }
        
        if(self.coverageAllDataBo.DISPLAYBENEFIT == "A"){
            cell.viewBenefit.isHidden = false
            cell.lblBenefit.text = covBo.benefit == "" ? "NA" : covBo.benefit
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.viewBenefitAction(_:)))
            cell.viewBenefitAction.addGestureRecognizer(tap2)
            cell.viewBenefitAction.isUserInteractionEnabled = true
            cell.viewBenefitAction.tag = indexPath.row
        }else{
            cell.heightViewBenefitConstraint.constant = 0
            cell.viewBenefit.isHidden = true
        }
        
        cell.lblName.text = covBo.name == "" ? "NA" : covBo.name
        cell.lblCode.text = covBo.code == "" ? "NA" : covBo.code
        cell.lblYtdConsumption.text = covBo.ytdconsump == "" ? "NA" : covBo.ytdconsump
        
        let status = self.arrExpandStatus[indexPath.row]
        if status == true {
            cell.imgViewArrow.image = UIImage.init(named: "arrow_down")
            //cell.coverageHeightConstraint.constant = 0
            cell.viewCoverage.isHidden = true
        }else{
            cell.imgViewArrow.image = UIImage.init(named: "arrow_up")
            //cell.coverageHeightConstraint.constant = 346
            cell.viewCoverage.isHidden = false
        }
        
        if indexPath.row % 2 == 0{
            cell.viewHeader.layer.backgroundColor = UIColor.init(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
        }else{
            cell.viewHeader.layer.backgroundColor = UIColor.init(displayP3Red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        }
        
        cell.viewHeader.tag = indexPath.row
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.expandRow(sender:)))
        cell.viewHeader.addGestureRecognizer(tap1)
        
        if cell.lblYtdConsumption.text != "NA"{
            cell.imgViewRightArrow.isHidden = false
            
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.showAmountBreakdown(_:)))
            cell.lblYtdConsumption.addGestureRecognizer(tap2)
            cell.lblYtdConsumption.isUserInteractionEnabled = true
            cell.lblYtdConsumption.tag = indexPath.row
            
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.showAmountBreakdownn(_:)))
            cell.lblYtdConsumptionTitle.addGestureRecognizer(tap3)
            cell.lblYtdConsumptionTitle.isUserInteractionEnabled = true
            cell.lblYtdConsumptionTitle.tag = indexPath.row
        }else{
            cell.lblYtdConsumption.isUserInteractionEnabled = false
            cell.lblYtdConsumptionTitle.isUserInteractionEnabled = false
            cell.imgViewRightArrow.isHidden = true
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func expandRow(sender: UITapGestureRecognizer? = nil) {
        let tag = sender?.view!.tag
        
        self.arrExpandStatus[tag!] = !self.arrExpandStatus[tag!]
        print("bool - \(!self.arrExpandStatus[tag!])")
        self.tblConditions.reloadData()
    }
    
    @objc func showAmountBreakdown(_ sender: UITapGestureRecognizer) {
        selectedCovBo = self.coverageAllDataBo.arrCoverageData[(sender.view?.tag)!]
        if selectedCovBo.ytdconsump != ""{
            self.performSegue(withIdentifier: "amount_breakdown", sender: self)
        }
    }
    @objc func showAmountBreakdownn(_ sender: UITapGestureRecognizer) {
        selectedCovBo = self.coverageAllDataBo.arrCoverageData[(sender.view?.tag)!]
        if selectedCovBo.ytdconsump != ""{
            self.performSegue(withIdentifier: "amount_breakdown", sender: self)
        }
    }
    @objc func viewBenefitAction(_ sender: UITapGestureRecognizer) {
        selectedCovBo = self.coverageAllDataBo.arrCoverageData[(sender.view?.tag)!]
        if selectedCovBo.code != "" && selectedCovBo.start_date != "" && selectedCovBo.end_date != ""{
            self.performSegue(withIdentifier: "view_benefit_condition", sender: self)
        }
    }
    @IBAction func btnPlanCodeAction(_ sender: Any) {
        let advisoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseOptionViewController") as! ChooseOptionViewController
        advisoryVC.delegate = self
        advisoryVC.type = "plancode"
        advisoryVC.isCustomObj = true
        advisoryVC.arrData = self.setPlanCodeArray()
        self.navigationController?.pushViewController(advisoryVC, animated: true)
    }
    
    // MARK: - Service Call
    func serviceCallToGetPlanCode(){
            
            if AppConstant.hasConnectivity() {//internet active
                AppConstant.showHUD()
                let pstCardNo = strCardNo
                
                let json = "{\"pstCardNo\":\"\(pstCardNo)\"}"
                print(json)
                let url = URL(string: AppConstant.postPlanCodeUrl)!
                print(url)
                let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
                AFManager.request(request).responseJSON {
                    (response) in
                    // debugPrint(response)
                    AppConstant.hideHUD()
                    self.viewPersonal.isHidden = false
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        self.arrPlanCodeData.removeAll()
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetPlanCode()
                                }
                            })
                        }else{
                            
                            let dataRes = response.result.value as! [String : AnyObject]
                            if let status = dataRes["Status"] as? String {
                                if(status == "1"){//success
                                    if let arrPlanList = dataRes["PlanList"] as? [[String: Any]]{
                                        if(arrPlanList.count > 0){
                                            for dictPlanCode in arrPlanList{
                                                let planBo = PlanCodeBo()
                                                if let planc = dictPlanCode["PLANCODE"] as? String {
                                                    planBo.planCode = planc
                                                }
                                                if let fdesc = dictPlanCode["FDESC"] as? String {
                                                    planBo.FDESC = fdesc
                                                }
                                                self.arrPlanCodeData.append(planBo)
                                            }
                                            
                                            self.selectedPlanCode = self.arrPlanCodeData[0]
                                            self.lblPlanCode.text = self.selectedPlanCode.planCode
                                            self.serviceCallToGetCoverage(planCode: self.selectedPlanCode.planCode)
                                        }
                                    }
                                }else{
                                    self.lblNodataAvailable.isHidden = false
                                    if let msg = dataRes["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }
                            
                        }
                        
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postPlanCodeUrl)
                        break
                        
                    }
                }
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
        }
    
    func serviceCallToGetCoverage(planCode: String){
        
        if AppConstant.hasConnectivity() {//internet active
            AppConstant.showHUD()
            
            let json = "{\"pstCardNo\":\"\(strCardNo)\",\"pstPaln\":\"\(planCode)\"}"
            print(json)
            let url = URL(string: AppConstant.getMemberEntitlementUrl)!
            print(url)
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                self.coverageAllDataBo.arrCoverageData.removeAll()
                // debugPrint(response)
                AppConstant.hideHUD()
                self.viewPersonal.isHidden = false
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetCoverage(planCode: planCode)
                            }
                        })
                    }else{
                        
                        let dataRes = response.result.value as! [String : AnyObject]
                        if let status = dataRes["Status"] as? String {
                            if(status == "1"){//success
                                let arrEntitlementList = dataRes["EntitlementList"] as! [[String: Any]]
                                if(arrEntitlementList.count > 0){
                                    let dictCoverage = arrEntitlementList[0]
                                    if let DISPLAYBENEFIT = dictCoverage["DISPLAYBENEFIT"] as? String {
                                        self.coverageAllDataBo.DISPLAYBENEFIT = DISPLAYBENEFIT
                                    }else{
                                        self.coverageAllDataBo.DISPLAYBENEFIT = ""
                                    }
                                    if let startDate = dictCoverage["START_DATE"] as? String {
                                        self.lblStartDate.text = startDate
                                    }else{
                                        self.lblStartDate.text = ""
                                    }
                                    if let endDate = dictCoverage["END_DATE"] as? String {
                                        self.lblEndDate.text = endDate
                                    }else{
                                        self.lblEndDate.text = ""
                                    }
                                    if let arrCov = dictCoverage["COVERAGE"] as? [[String: Any]]{
                                        if arrCov.count > 0{
                                            for dictCvrg in arrCov{
                                                let covBo = CoverageDataBo()
                                                if let benefits = dictCvrg["BENEFITS"] as? String {
                                                    covBo.benefits = benefits
                                                }else{
                                                    covBo.benefits = "NA"
                                                }
                                                if let limits = dictCvrg["LIMITS"] as? String {
                                                    covBo.limits = limits
                                                }else{
                                                    covBo.limits = "NA"
                                                }
                                                if let exclusions = dictCvrg["EXCLUSIONS"] as? String {
                                                    covBo.exclusion = exclusions
                                                }else{
                                                    covBo.exclusion = "NA"
                                                }
                                                if let code = dictCvrg["CODE"] as? String {
                                                    covBo.code = code
                                                }else{
                                                    covBo.code = "NA"
                                                }
                                                if let name = dictCvrg["NAME"] as? String {
                                                    covBo.name = name
                                                }else{
                                                    covBo.name = "NA"
                                                }
                                                if let ytd = dictCvrg["YTDCONSUMP"] as? String {
                                                    
                                                    if ytd.trim() == ""{
                                                        covBo.ytdconsump = "NA"
                                                    }else{
                                                        covBo.ytdconsump = ytd
                                                    }
                                                }else{
                                                    covBo.ytdconsump = "NA"
                                                }
                                                if let startDate = dictCvrg["START_DATE"] as? String {
                                                    covBo.start_date = startDate
                                                }else{
                                                    covBo.start_date = "NA"
                                                }
                                                if let endDate = dictCvrg["END_DATE"] as? String {
                                                    covBo.end_date = endDate
                                                }else{
                                                    covBo.end_date = "NA"
                                                }
                                                if let rem = dictCvrg["REMAINIGYEARLYLIFETIME"] as? String {
                                                    covBo.remainingYearlyLimeTime = rem
                                                }else{
                                                    covBo.remainingYearlyLimeTime = "NA"
                                                }
                                                if let rem = dictCvrg["AVAILABLELIMIT"] as? String {
                                                    covBo.AVAILABLELIMIT = rem
                                                }else{
                                                    covBo.AVAILABLELIMIT = "NA"
                                                }
                                                if let Condition = dictCvrg["CONDITIONS"] as? String {
                                                    covBo.conditions = Condition
                                                }else{
                                                    covBo.conditions = "NA"
                                                }
                                                if let rem = dictCvrg["NOTE"] as? String {
                                                    covBo.NOTE = rem
                                                }else{
                                                    covBo.NOTE = "NA"
                                                }
                                                if let benefit = dictCvrg["ViewBenefit"] as? String {
                                                    covBo.benefit = benefit
                                                }else{
                                                    covBo.benefit = "NA"
                                                }
                                                self.coverageAllDataBo.arrCoverageData.append(covBo)
                                            }
                                        }
                                    }
                                    
                                    for _ in self.coverageAllDataBo.arrCoverageData{
                                        self.arrExpandStatus.append(true)
                                    }
                                    if self.coverageAllDataBo.arrCoverageData.count > 0 {
                                        
                                        if self.coverageAllDataBo.DISPLAYBENEFIT == "S"
                                        {
                                                self.coverageAllDataBo.arrCoverageData = self.coverageAllDataBo.arrCoverageData.sorted(by: { $0.NOTE < $1.NOTE })
                                        }else{
                                            self.coverageAllDataBo.arrCoverageData = self.coverageAllDataBo.arrCoverageData.sorted(by: { $0.code < $1.code })
                                        }
                                    }
                                    self.tblConditions.reloadData()
                                }
                                
                            }else{
                                self.lblNodataAvailable.isHidden = false
                                if let msg = dataRes["Message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                            }
                        }
                        
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMemberEntitlementUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "amount_breakdown"){
            let vc = segue.destination as! AmountBreakdownViewController
            vc.strCardNo = strCardNo
            vc.covBo = selectedCovBo
            vc.planCode = selectedPlanCode.planCode
        }
        else if (segue.identifier == "view_benefit_condition"){
            let vc = segue.destination as! ListCoverageViewController
            vc.strCardNo = strCardNo
            vc.planCode = selectedPlanCode.planCode
            vc.coverageCode = selectedCovBo.code
            vc.startDate = selectedCovBo.start_date
            vc.endDate = selectedCovBo.end_date
            vc.className = "ViewBenefit"
            vc.titlePage = self.headerTitle
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

    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
