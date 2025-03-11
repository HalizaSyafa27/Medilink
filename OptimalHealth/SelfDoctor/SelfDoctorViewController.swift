//
//  SelfDoctorViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 26/11/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class SelfDoctorViewController: BaseViewController, ChooseDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblPageHeader: UILabel!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblPregnancy: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblSymptoms: UILabel!
    @IBOutlet weak var txtFldAge: UITextField!
    @IBOutlet weak var txtFldPregnantStatus: UITextField!
    @IBOutlet weak var txtFldCountry: UITextField!
    @IBOutlet weak var txtFldSymptoms: UITextField!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var pregnantView: UIView!
    @IBOutlet weak var pregnantViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var symptomsView: UIView!
    @IBOutlet weak var countryViewHeightConstraint: NSLayoutConstraint!
    //@IBOutlet weak var symptomsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var symptomsListViewContainer: UIView!
    @IBOutlet weak var symptomsListViewHeightConstraint: NSLayoutConstraint!
    
    var selectedGender = ""
    var selectType = ""
    var selectedAgeId = ""
    var selectedAgeName = ""
    var selectedPregnantId = ""
    var selectedCountryId = ""
    var selectedAgeFormat1 = ""
    var selectedAgeFormat2 = ""
    var pageTitle = ""
    var strCardNo = ""
    var strPayorMemberId = ""
    
    var arrAgeGroupDetailsList = [AgeGroupDetailsBo]()
    var arrPregnancyStatusList = [PregnancyStatusBo]()
    var arrCountryList = [CountryListBo]()
    var arrSymptomsList = [String]()
    var dataSource = [CustomObject]()
    var arrChoose = [CustomObject]()
    var arrFiltered = [CustomObject]()
    var arrSymptoms = [String]()
    
    let tblChoose: UITableView = UITableView()
    var keyBoardHeight : CGFloat = 0.0
    var selectedField = ""
    var tblHeight : CGFloat = 0.0
    var extraHeight: CGFloat = 150.0
    var params: Parameters = [:]
    
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
        
        //symptomsViewHeightConstraint.constant = 80
        symptomsListViewContainer.isHidden = true
        symptomsListViewHeightConstraint.constant = 0
        
        lblPageTitle.text = pageTitle
        
        txtFldAge.text = "adult(30 To 39 yrs)"
        txtFldPregnantStatus.text = "(- not specified -)"
        txtFldCountry.text = "Malaysia"
        btnFemale.isSelected = true
        selectedGender = "f"
        
        let strAge = NSMutableAttributedString(string: "How old are you ?*")
        strAge.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 17, length: 1))
        lblAge.attributedText = strAge
        
        let strGender = NSMutableAttributedString(string: "What is your gender at birth ?*")
        strGender.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 30, length: 1))
        lblGender.attributedText = strGender
        
        let strPregnancy = NSMutableAttributedString(string: "Are you pregnant ?*")
        strPregnancy.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 18, length: 1))
        lblPregnancy.attributedText = strPregnancy
        
        let strCountry = NSMutableAttributedString(string: "Country of residence or recently visited ?*")
        strCountry.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 42, length: 1))
        lblCountry.attributedText = strCountry
        
        let strSymptoms = NSMutableAttributedString(string: "Describe in your own words or select symptoms from list:*")
        strSymptoms.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 56, length: 1))
        lblSymptoms.attributedText = strSymptoms
        
        tblHeight = AppConstant.screenSize.height - (keyBoardHeight + 70)
        tblChoose.frame = CGRect(x: view.frame.origin.x + 20, y: AppConstant.screenSize.height - tblHeight, width: view.frame.size.width - 40, height: tblHeight)
        self.view.addSubview(tblChoose)
        tblChoose.isHidden = true
        tblChoose.layer.borderColor = UIColor.lightGray.cgColor
        tblChoose.layer.borderWidth = 1.0
        tblChoose.layer.cornerRadius = 5
        tblChoose.layer.masksToBounds = true
        
        tblChoose.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tblChoose.delegate = self
        tblChoose.dataSource = self
        tblChoose.backgroundColor = UIColor.color("#D9D9D9")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Api call to getAge
        self.serviceCallToGetAge()
        
        //Api call to getPregnancy
        self.serviceCallToGetPregnancy()
        
        //Api call to get CountryList
        self.serviceCallToGetCountryList()
        
        //Api call to get SymptomsList
        self.serviceCallToGetSymptomsList()
        
    }
    
    //MARK: Tableview Delegate & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        let obj = self.arrFiltered[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = obj.name
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        self.tblChoose.isHidden = true
        
        var customBo = CustomObject()
        customBo = self.arrFiltered[indexPath.row]
        print(tblChoose.tag)
        
        switch tblChoose.tag {
        case 1://Country
            txtFldCountry.text = customBo.name
            self.selectedCountryId = customBo.code!
            
            //Api call to get SymptomsList
            self.serviceCallToGetSymptomsList()
            
            break
        case 2://Symptoms
            for item in arrSymptoms{
                if item.lowercased() == customBo.name!.lowercased(){
                    self.displayAlert(message: "Item already exist")
                    txtFldSymptoms.text = ""
                    return
                }
            }
            
            arrSymptoms.append(customBo.name!)
            
            symptomsListViewContainer.isHidden = false
            //symptomsViewHeightConstraint.constant = 50 + symptomsListViewHeightConstraint.constant
            symptomsListViewHeightConstraint.constant = setDynamicLabelNextToEachOther(arrString: arrSymptoms, padding: 4.0, containerView: symptomsListViewContainer)
            
            txtFldSymptoms.text = ""
            break
        default:
            break
        }
    }
    
    //MARK: Textfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                            for: UIControl.Event.editingChanged)
        self.view.layoutSubviews()
        
        if textField == txtFldCountry {//Country
            tblChoose.tag = 1
            self.createDataSource(type: "country_name")
            tblHeight = self.countryView.frame.origin.y
        }else if textField == txtFldSymptoms {//Symptoms
            tblChoose.tag = 2
            self.createDataSource(type: "symptoms_name")
            tblHeight = self.symptomsView.frame.origin.y
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
        
        if((textField == txtFldCountry) && (textField.text!.count > 0)){
            self.arrFiltered = self.arrChoose.filter {
                $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
            }
            selectedField = "country_name";
            self.tblChoose.isHidden = false
        }else if((textField == txtFldSymptoms) && (textField.text!.count > 2)){
            self.arrFiltered = self.arrChoose.filter {
                $0.name?.range(of: textField.text!, options: .caseInsensitive) != nil
            }
            selectedField = "symptoms_name";
            self.tblChoose.isHidden = false
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
    }
    
    func createDataSource(type:String){
        self.arrFiltered.removeAll()
        self.arrChoose.removeAll()
        
        if type == "country_name" {
            for item in arrCountryList{
                let customObj = CustomObject()
                customObj.name = item.countryName
                customObj.code = item.countryId
                self.arrChoose.append(customObj)
            }
        }else if type == "symptoms_name" {
            for item in arrSymptomsList{
                let customObj = CustomObject()
                customObj.name = item
                self.arrChoose.append(customObj)
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
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMaleAction(_ sender: Any) {
        btnMale.isSelected = true
        btnFemale.isSelected = false
        self.selectedGender = "m"
        pregnantView.isHidden = true
        pregnantViewHeightConstraint.constant = 0
        
        //Api call to get CountryList
        self.serviceCallToGetCountryList()
    }
    
    @IBAction func btnFemaleAction(_ sender: Any) {
        btnFemale.isSelected = true
        btnMale.isSelected = false
        self.selectedGender = "f"
        pregnantView.isHidden = false
        pregnantViewHeightConstraint.constant = 85
        
        //Api call to getPregnancy
        self.serviceCallToGetPregnancy()
    }
    
    @IBAction func btnSelectAgeAction(_ sender: Any) {
        self.selectType = "Select Age"
        self.performSegue(withIdentifier: "selectAgeGender", sender: self)
    }
    
    @IBAction func btnSelectPregnancyStatusAction(_ sender: Any) {
        self.selectType = "Select Pregnancy Status"
        self.performSegue(withIdentifier: "selectAgeGender", sender: self)
    }
    
    @IBAction func btnInfoAction(_ sender: UIButton) {
        var alertMessage = ""
        if sender.tag == 1{
            alertMessage = "If you have been abroad & become ill shortly after returning home, then you may be affected by a disease more common in that country. Use this function to modify the results according to the region you have travelled from. If you have not travelled then select the country that applies to where you live."
        }else{
            alertMessage = "\("• Use medical terms as far possible")\n\("• If your symptom is not included in the list that appears, you can still just type it in")\n\("• Enter each symptom separately")\n\("• Enter only abnormal test results. Don't use numbers, for test results enter the meaning in words")\n\("• Check your spelling")"
        }
        self.displayAlert(message: alertMessage)
    }
    
    @objc func btnDeleteSymptomsAction(_ sender: UIButton) {
        arrSymptoms.remove(at: sender.tag)
        symptomsListViewHeightConstraint.constant = setDynamicLabelNextToEachOther(arrString: arrSymptoms, padding: 2.0, containerView: symptomsListViewContainer)
        //symptomsViewHeightConstraint.constant = 81 + symptomsListViewHeightConstraint.constant
        
        if arrSymptoms.count == 0{
            //symptomsViewHeightConstraint.constant = 80
            symptomsListViewContainer.isHidden = true
            symptomsListViewHeightConstraint.constant = 0
        }
        
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        validationForSymptomsChecker()
    }
    
    //MARK: Validation Method
    func validationForSymptomsChecker(){
        var errMessage: String?
        
        if txtFldAge.text == ""{
            errMessage = StringConstant.ageGroupValidationMsg
        }else if(pregnantView.isHidden == false){
            if ((txtFldPregnantStatus.text == "") && (btnFemale.isSelected == true)){
                errMessage = StringConstant.pregnancyStatusValidationMsg
            }else if txtFldCountry.text == ""{
                errMessage = StringConstant.countryValidationMsg
            }else if arrSymptoms.count == 0{
                errMessage = StringConstant.symptomsValidationMsg
            }
        }else if txtFldCountry.text == ""{
            errMessage = StringConstant.countryValidationMsg
        }else if arrSymptoms.count == 0{
            errMessage = StringConstant.symptomsValidationMsg
        }
        
        if errMessage != nil {
            self.displayAlert(message: errMessage ?? "")
        }else{
            self.performSegue(withIdentifier: "possibleCauses", sender: self)
        }
        
    }
    
    //MARK: Service Call Method
    func serviceCallToGetAge() {
        if AppConstant.hasConnectivity() {//true connected
            AppConstant.showHUD()
            
            let url = "\(AppConstant.getAgeUrl)?cardNo=\(strCardNo)&memberControlNo=\(strPayorMemberId)"
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
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
                                        self.serviceCallToGetAge()
                                    }
                                })
                            }else{
                                let dict = response.result.value! as! [String: Any]
                                
                                if let success = dict["success"] as? Bool {
                                    if success == true {
                                        self.arrAgeGroupDetailsList.removeAll()
                                        if let dataDict = dict["data"] as? [[String: Any]]{
                                            for dict in dataDict{
                                                let ageGroupDataBo = AgeGroupDetailsBo()
                                                if let ageGroupId = dict["agegroup_id"] as? String{
                                                    ageGroupDataBo.ageGroup_id = ageGroupId
                                                }
                                                if let ordinal = dict["ordinal"] as? String{
                                                    ageGroupDataBo.ordinal = ordinal
                                                }
                                                if let name = dict["name"] as? String{
                                                    ageGroupDataBo.name = name
                                                }
                                                if let yr_from = dict["yr_from"] as? String{
                                                    ageGroupDataBo.yr_From = yr_from
                                                }
                                                if let yr_to = dict["yr_to"] as? String{
                                                    ageGroupDataBo.yr_To = yr_to
                                                }
                                                if let branch = dict["branch"] as? String{
                                                    ageGroupDataBo.branch = branch
                                                }
                                                if let can_conceive = dict["can_conceive"] as? Bool{
                                                    ageGroupDataBo.can_conceive = can_conceive
                                                }
                                                
                                                let ageDetail = "\(ageGroupDataBo.name)" + "(\(ageGroupDataBo.yr_From) To \(ageGroupDataBo.yr_To))"
                                                if (ageDetail == "adult(30 To 39 yrs)"){
                                                    self.txtFldAge.text = "adult(30 To 39 yrs)"
                                                    self.selectedAgeId = ageGroupDataBo.ageGroup_id
                                                    self.selectedAgeFormat1 = "\(ageGroupDataBo.name)"
                                                    self.selectedAgeFormat2 = "aged \(ageGroupDataBo.yr_From) to \(ageGroupDataBo.yr_To)"
                                                }
                                                
                                                self.arrAgeGroupDetailsList.append(ageGroupDataBo)
                                            }
                                        }
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
    
    func serviceCallToGetPregnancy(){
        if AppConstant.hasConnectivity() {//true connected
            AppConstant.showHUD()
            
            let url = "\(AppConstant.getPregnancyUrl)?cardNo=\(strCardNo)&memberControlNo=\(strPayorMemberId)"
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
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
                                        self.serviceCallToGetPregnancy()
                                    }
                                })
                            }else{
                                let dict = response.result.value! as! [String: Any]
                                
                                if let success = dict["success"] as? Bool {
                                    if success == true{
                                        self.arrPregnancyStatusList.removeAll()
                                        if let dataDict = dict["data"] as? [[String: Any]]{
                                            for dict in dataDict{
                                                let pregnancyStatusBo = PregnancyStatusBo()
                                                if let id = dict["pregnancy_id"] as? String{
                                                    pregnancyStatusBo.pregnancyId = id
                                                }
                                                if let name = dict["pregnancy_name"] as? String{
                                                    pregnancyStatusBo.pregnancyName = name
                                                }
                                                
                                                if (pregnancyStatusBo.pregnancyName == "(- not specified -)"){
                                                    self.txtFldPregnantStatus.text = "(- not specified -)"
                                                    self.selectedPregnantId = pregnancyStatusBo.pregnancyId
                                                }
                                                
                                                self.arrPregnancyStatusList.append(pregnancyStatusBo)
                                            }
                                        }
                                        
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
    
    func serviceCallToGetCountryList(){
        if AppConstant.hasConnectivity() {//true connected
            AppConstant.showHUD()
            
            let url = "\(AppConstant.getCountryUrl)?cardNo=\(strCardNo)&memberControlNo=\(strPayorMemberId)"
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
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
                                        self.serviceCallToGetCountryList()
                                    }
                                })
                            }else{
                                let dict = response.result.value! as! [String: Any]
                                
                                if let success = dict["success"] as? Bool {
                                    if success == true{
                                        self.arrCountryList.removeAll()
                                        if let dataDict = dict["data"] as? [[String: Any]]{
                                            for dict in dataDict{
                                                let countryListBo = CountryListBo()
                                                if let country_id = dict["country_id"] as? String{
                                                    countryListBo.countryId = country_id
                                                }
                                                if let country_name = dict["country_name"] as? String{
                                                    
                                                    countryListBo.countryName = country_name
                                                }
                                                if let abbreviation = dict["abbreviation"] as? String{
                                                    countryListBo.abbreviation = abbreviation
                                                }
                                                if let region_id = dict["region_id"] as? String{
                                                    countryListBo.regionId = region_id
                                                }
                                                
                                                if (countryListBo.countryName == "Malaysia"){
                                                    self.txtFldCountry.text = "Malaysia"
                                                    self.selectedCountryId = countryListBo.countryId
                                                }
                                                
                                                self.arrCountryList.append(countryListBo)
                                            }
                                        }
                                        
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
    
    func serviceCallToGetSymptomsList(){
        if AppConstant.hasConnectivity() {//true connected
            AppConstant.showHUD()
            
            let url = "\(AppConstant.getPredictiveTextUrl)?cardNo=\(strCardNo)&memberControlNo=\(strPayorMemberId)"
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    AppConstant.hideHUD()
                    //debugPrint(response)
                    switch(response.result) {
                        case .success(_):
                            let headerStatusCode : Int = (response.response?.statusCode)!
                            print("Status Code: \(headerStatusCode)")
                            
                            if(headerStatusCode == 401){//Session expired
                                self.isTokenVerified(completion: { (Bool) in
                                    if Bool{
                                        self.serviceCallToGetSymptomsList()
                                    }
                                })
                            }else{
                                if let dict = response.result.value! as? [String: Any]{
                                    self.arrSymptomsList.removeAll()
                                    if let arrPredictiveText = dict["predictive_text"] as? [String]{
                                        if arrPredictiveText.count > 0{
                                            for item in arrPredictiveText{
                                                self.arrSymptomsList.append(item)
                                            }
                                        }
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
    
    //MARK: Delegate Methods
    func setDataSource(type: String) -> [CustomObject]{
        if type == "Select Age" {
            self.dataSource.removeAll()
            if self.arrAgeGroupDetailsList.count != 0 {
                for index in 0...self.arrAgeGroupDetailsList.count - 1{
                    let item = self.arrAgeGroupDetailsList[index]
                    let customObj = CustomObject()
                    customObj.name = "\(item.name)" + "(\(item.yr_From) To \(item.yr_To))"
                    customObj.code = item.ageGroup_id
                    customObj.index = index
                    customObj.conceive = item.can_conceive
                    self.dataSource.append(customObj)
                }
            }
            
        }else if type == "Select Pregnancy Status" {
            self.dataSource.removeAll()
            for item in self.arrPregnancyStatusList{
                let customObj = CustomObject()
                customObj.name = item.pregnancyName
                customObj.code = item.pregnancyId
                self.dataSource.append(customObj)
            }
        }
        
        return dataSource
    }
    
    func selectedObject(obj: CustomObject,type: String){
        if type == "Select Age" {
            txtFldAge.text = obj.name
            self.selectedAgeId = obj.code!
            self.selectedAgeFormat1 = "\(self.arrAgeGroupDetailsList[obj.index!].name)"
            self.selectedAgeFormat2 = "aged \(self.arrAgeGroupDetailsList[obj.index!].yr_From) to \(self.arrAgeGroupDetailsList[obj.index!].yr_To)"
            
            if obj.conceive == true {
                pregnantView.isHidden = false
                pregnantViewHeightConstraint.constant = 85
                
                //Api call to getPregnancy
                self.serviceCallToGetPregnancy()
            }else{
                pregnantView.isHidden = true
                pregnantViewHeightConstraint.constant = 0
            }
            
            //Api call to get CountryList
            self.serviceCallToGetCountryList()
            
        }else if type == "Select Pregnancy Status" {
            txtFldPregnantStatus.text = obj.name
            self.selectedPregnantId = obj.code!
            
            //Api call to get CountryList
            self.serviceCallToGetCountryList()
        }
    }
    
    //MARK: Set Dynamic Label
    func setDynamicLabelNextToEachOther(arrString: [String], padding: CGFloat, containerView: UIView) -> CGFloat{
        var xPos:CGFloat = 0.0
        var yPos:CGFloat = 0.0
        
        for view in containerView.subviews{
            if view.isKind(of: UIView.self){
                view.removeFromSuperview()
            }
        }
        var btntag = -1
        for text in arrString {
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = AppConstant.darkColor
            label.font = UIFont.systemFont(ofSize: 12.0)
            label.frame = CGRect(x: 3, y: 4, width: label.intrinsicContentSize.width + 15, height: 37)
            label.layer.backgroundColor = UIColor.clear.cgColor
            label.tag = 100
            label.isUserInteractionEnabled = true
            containerView.isUserInteractionEnabled = true
            let btnDelete = UIButton()
            btnDelete.setImage(UIImage(named: "cross_gray"), for: .normal)
            btnDelete.frame = CGRect(x: label.frame.size.width, y: 10, width: 25, height: 25)
            btnDelete.imageView?.contentMode = .scaleToFill
            btnDelete.tag = btntag + 1
            btntag = btnDelete.tag
            print(btnDelete.tag)
            btnDelete.isUserInteractionEnabled = true
            
            btnDelete.addTarget(self, action: #selector(btnDeleteSymptomsAction(_:)), for: .touchUpInside)
            
            let txtView = UIView()
            txtView.frame = CGRect(x: xPos, y: yPos, width: label.frame.size.width + btnDelete.frame.size.width, height: 45)
            txtView.layer.cornerRadius = 22
            
            xPos = xPos + txtView.frame.size.width + padding
            
            if xPos + txtView.frame.size.width >= containerView.frame.size.width{
                xPos = 0
                yPos = yPos + txtView.frame.size.height + padding
                txtView.frame.origin.y = yPos
                txtView.frame.origin.x = xPos
                xPos = xPos + txtView.frame.size.width + padding
            }
            txtView.backgroundColor = UIColor.lightGray
            txtView.layer.borderColor = UIColor.darkGray.cgColor
            txtView.isUserInteractionEnabled = true
            txtView.addSubview(btnDelete)
            txtView.addSubview(label)
            containerView.addSubview(txtView)
            
        }
        return yPos + 25
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectAgeGender" {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = selectType
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: selectType)
        }else if segue.identifier == "possibleCauses" {
            let vc = segue.destination as! SelfDoctorSymptomsListViewController
            vc.ageId = self.selectedAgeId
            vc.gender = selectedGender
            vc.pregnantId = selectedGender == "m" ? "" : self.selectedPregnantId
            vc.countryId = self.selectedCountryId
            vc.arrSymptoms = arrSymptoms
            vc.selectedAgeFormat1 = self.selectedAgeFormat1
            let gender = selectedGender == "m" ? "Male" : "Female"
            vc.symptomHeader = "\(self.selectedAgeFormat1) \(gender), \(self.selectedAgeFormat2), from/visited \(txtFldCountry.text!) with symptoms \(self.arrSymptoms.joined(separator: ","))"
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
