//
//  RegisterViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import DatePickerDialog
import Alamofire
import DropDown

class RegisterViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,ChooseDelegate, UITextFieldDelegate, myDatePickerDelegate {
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblRegistration: UITableView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var strSelect: String = "Choose ID Type"
    var idTypeDropDown = DropDown()
    let arrMemberType = ["Medilink Member", "Non Medilink Member", "Intermediaries/Agent"]
    let arrGenderType = ["Male", "Female"]
    var selectedMemberType = "Medilink Member" //"Non Medilink Member"
    var personalInfoCellHeight: CGFloat = 300.0
    var dataSource = [CustomObject]()
    var arrSecurityQuestions = [SecurityQuestion]()
    var arrIDType = [SecurityQuestion]()
    var selectedStateCode = ""
    var selectedState = ""
    var selectedDOB = ""
    var selectedMemberSince = ""
    var isAgreeTC : Bool = false
    var questionType = ""
    var selectedGender = "M"
    var selectedQuestion1Id = ""
    var selectedQuestion2Id = ""
    var selectedQuestion3Id = ""
    var name = ""
    var nationalId = ""
    var postCode = ""
    var mobileNo = ""
    var displayName = ""
    var password = ""
    var confirmPassword = ""
    var txtEmail = ""
    var maximumDate = Date()
    var selectDate = Date()
    var idType: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.serviceCallToGetIDType()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
    }
    
    //MARK: Textfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)),
                            for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        print(textField.text!)
        
        let pointInTable = textField.convert(textField.bounds.origin, to: self.tblRegistration)
        let textFieldIndexPath = self.tblRegistration.indexPathForRow(at: pointInTable)
        if textFieldIndexPath?.row == 1{
            let indexPath = IndexPath(row: 1, section: 0)
            let nonMedilinkCell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
            
            switch textField {
            case nonMedilinkCell.txtFldName:
                nonMedilinkCell.txtFldName.text! = nonMedilinkCell.txtFldName.text!.uppercased()
                self.name = nonMedilinkCell.txtFldName.text!
                break
            case nonMedilinkCell.txtFldNationalId:
                nonMedilinkCell.txtFldNationalId.text! = nonMedilinkCell.txtFldNationalId.text!.uppercased()
                self.nationalId = nonMedilinkCell.txtFldNationalId.text!
                break
            case nonMedilinkCell.txtEmail:
                self.txtEmail = nonMedilinkCell.txtEmail.text!
                break
            case nonMedilinkCell.txtFldMobile:
                self.mobileNo = nonMedilinkCell.txtFldMobile.text!
                break
            default:
                break
            }
            
        }else if textFieldIndexPath?.row == 2{
            let indexPath1 = IndexPath(row: 2, section: 0)
            let loginCell = self.tblRegistration.cellForRow(at: indexPath1) as! LoginDetailsTableViewCell
            
            switch textField {
            case loginCell.txtFldEmail:
                loginCell.txtFldEmail.text! = loginCell.txtFldEmail.text!.uppercased()
                self.mobileNo = loginCell.txtFldEmail.text!
                break
            case loginCell.txtFldDisplayName:
                loginCell.txtFldDisplayName.text! = loginCell.txtFldDisplayName.text!.uppercased()
                self.displayName = loginCell.txtFldDisplayName.text!
                break
            case loginCell.txtFldPassword:
                self.password = loginCell.txtFldPassword.text!
                break
            case loginCell.txtFldCnfPassword:
                self.confirmPassword = loginCell.txtFldCnfPassword.text!
                break
            default:
                break
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2000{
           // textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            return true
        }else{
            return true
        }
        
    }
    
    // MARK: Tableview Delegates & Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //return 0.0 //Hide the entire row
            //return 140.0
            return UITableView.automaticDimension
        }else if indexPath.row == 1 {
            return UITableView.automaticDimension//personalInfoCellHeight
        }else if indexPath.row == 3 {
            return 0
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "account_type_cell", for: indexPath as IndexPath) as! AccountTypeTableViewCell
            cell.selectionStyle = .none
//            cell.btnUserType?.setTitle(selectedMemberType, for: .normal)
//            cell.btnUserType.addTarget(self, action: #selector(selectUserType), for: UIControl.Event.touchUpInside)
            if(selectedMemberType == "Medilink Member"){
                cell.imgViewMedilinkMember.image = UIImage.init(named: "radioBtn-checked")
                cell.imgViewNonMedilinkMember.image = UIImage.init(named:"radioBtn")
            }else{
                cell.imgViewMedilinkMember.image = UIImage.init(named: "radioBtn")
                cell.imgViewNonMedilinkMember.image = UIImage.init(named: "radioBtn-checked")
            }
                       
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NonMedilinkMemberTableViewCell", for: indexPath as IndexPath) as! NonMedilinkMemberTableViewCell
            cell.selectionStyle = .none
            
            cell.txtFldName.delegate = self
            cell.txtFldNationalId.delegate = self
            cell.txtEmail.delegate = self
            cell.txtFldMobile.delegate = self
            
//            cell.txtFldName.addTarget(self, action: #selector(textFieldDidChange(_:)),
//                                for: UIControl.Event.editingChanged)
//            cell.txtFldNationalId.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            cell.txtFldPostCode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            cell.txtFldMobile.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            cell.btnState?.addTarget(self, action: #selector(btnStateAction(button:)), for: .touchUpInside)
            cell.btnDOB?.addTarget(self, action: #selector(btnDOBAction(button:)), for: .touchUpInside)
            cell.btnMale?.addTarget(self, action: #selector(btnMaleAction(button:)), for: .touchUpInside)
            cell.btnFemale?.addTarget(self, action: #selector(btnFemaleAction(button:)), for: .touchUpInside)
            //cell.btnMemberSince?.addTarget(self, action: #selector(btnMemberSinceAction(button:)), for: .touchUpInside)
            self.chooseIDType(lblTitel: cell.lblIDType, txtFlied: cell.txtFldNationalId)
            cell.btnChooseIdType?.addTarget(self, action: #selector(btnChooseIDTypeAction(button:)), for: .touchUpInside)
            return cell
            
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "login_cell", for: indexPath as IndexPath) as! LoginDetailsTableViewCell
            cell.selectionStyle = .none
            
            cell.txtFldEmail.delegate = self
            cell.txtFldDisplayName.delegate = self
            cell.txtFldPassword.delegate = self
            cell.txtFldCnfPassword.delegate = self
            
            cell.btnPasswordTogle.addTarget(self, action: #selector(btnPaswordTogleAction(_:)), for: .touchUpInside)
            cell.btnCnfPasswordTogle.addTarget(self, action: #selector(btnCnfPaswordTogleAction(_:)), for: .touchUpInside)
            
//            cell.txtFldEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            cell.txtFldPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            cell.txtFldCnfPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "security_question_cell", for: indexPath as IndexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
            
            cell.btnQuestion1?.addTarget(self, action: #selector(selectQuestion(_:)), for: .touchUpInside)
            cell.btnQuestion2?.addTarget(self, action: #selector(selectQuestion(_:)), for: .touchUpInside)
            cell.btnQuestion3?.addTarget(self, action: #selector(selectQuestion(_:)), for: .touchUpInside)
            
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "register_cell", for: indexPath as IndexPath) as! RegisterTableViewCell
            cell.selectionStyle = .none
            
            cell.btnTermsCond?.addTarget(self, action: #selector(agreeTC(_:)), for: .touchUpInside)
            cell.btnRegisterNow?.addTarget(self, action: #selector(btnRegisterNowAction(_:)), for: .touchUpInside)
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(termCondAction))
            cell.lblTermsCond.addGestureRecognizer(tap)
            cell.lblTermsCond.isUserInteractionEnabled = true
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: Button Action
    
    @objc func btnChooseIDTypeAction(button: UIButton) {
        idTypeDropDown.anchorView = button
        idTypeDropDown.bottomOffset = CGPoint(x: 0, y:(idTypeDropDown.anchorView?.plainView.bounds.height)!)
        idTypeDropDown.show()
    }
    
    func chooseIDType(lblTitel: UILabel, txtFlied:UITextField){
        self.idTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            lblTitel.text =  item
            let result = self.arrIDType.filter{ $0.name == item }
            self.idType = result.count > 0 ? result[0].id : ""
            if idType == "NIK"{
                setplaceHolderColor(txtFld: txtFlied, placeholder: "Insert NIK")
            }else if idType == "CARDNO"{
                setplaceHolderColor(txtFld: txtFlied, placeholder: "Insert Card No")
            }else{
                setplaceHolderColor(txtFld: txtFlied, placeholder: "Insert NIK/Card No")
            }
        }
    }
    
    @IBAction func btnMemberTypeAction(_ sender: UIButton) {
        selectedMemberType = "Medilink Member"
        tblRegistration.reloadData()
    }
    
    @IBAction func btnMedilinkMemberAction(_ sender: UIButton) {
       selectedMemberType = "Medilink Member"
        tblRegistration.reloadData()
    }
    @IBAction func btnMedilinkNonMemberAction(_ sender: UIButton) {
        selectedMemberType = "Non Medilink Member"
         tblRegistration.reloadData()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @objc func selectUserType(_ sender: UIButton!){
        performSegue(withIdentifier: "member_type", sender: self)
    }
    @objc func btnGenderAction(button: UIButton) {
        performSegue(withIdentifier: "gender", sender: self)
    }
    @objc func btnStateAction(button: UIButton) {
        performSegue(withIdentifier: "state", sender: self)
    }
    @objc func btnMemberSinceAction(button: UIButton) {
        self.datePickerTapped(title: "Member Since")
    }
    @objc func btnDOBAction(button: UIButton) {
        self.datePickerTapped(title: "Date of Birth")
    }
    @objc func btnMaleAction(button: UIButton) {
        self.selectedGender = "M"
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
        cell.imgViewMale.image = UIImage.init(named: "radioBtn-checked")
        cell.imgViewFemale.image = UIImage.init(named: "radioBtn")
    }
    @objc func btnFemaleAction(button: UIButton) {
        self.selectedGender = "F"
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
        cell.imgViewMale.image = UIImage.init(named: "radioBtn")
        cell.imgViewFemale.image = UIImage.init(named: "radioBtn-checked")
    }
    @objc func agreeTC(_ sender: UIButton!){
        let indexPath = IndexPath(row: 4, section: 0)
        let cell = self.tblRegistration.cellForRow(at: indexPath) as! RegisterTableViewCell
        if isAgreeTC == false {
            cell.imgViewcheckBox?.image = UIImage.init(named: "checkbox_active")
        }else{
            cell.imgViewcheckBox?.image = UIImage.init(named: "checkbox")
        }
        isAgreeTC = !isAgreeTC
    }
    @objc func btnPaswordTogleAction(_ sender: UIButton!){
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = self.tblRegistration.cellForRow(at: indexPath) as! LoginDetailsTableViewCell
        cell.btnPasswordTogle.isSelected = !cell.btnPasswordTogle.isSelected
        cell.txtFldPassword.isSecureTextEntry = !cell.txtFldPassword.isSecureTextEntry
        
    }
    @objc func btnCnfPaswordTogleAction(_ sender: UIButton!){
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = self.tblRegistration.cellForRow(at: indexPath) as! LoginDetailsTableViewCell
        cell.btnCnfPasswordTogle.isSelected = !cell.btnCnfPasswordTogle.isSelected
        cell.txtFldCnfPassword.isSecureTextEntry = !cell.txtFldCnfPassword.isSecureTextEntry
        
    }
    @objc func btnRegisterNowAction(_ sender: UIButton!){
        if self.ValidationForMedilinkMember(){
            self.serviceCallToSignUp()
        }
        
    }
    @objc func selectQuestion(_ sender: UIButton!){
        questionType = "securityQuestion\(sender.tag)"
        
        performSegue(withIdentifier: "securityQuestions", sender: self)
    }
    @objc func termCondAction(){
        AppConstant.isSlidingMenu = false
        performSegue(withIdentifier: "term_cond", sender: self)
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "member_type"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = false
            vc.arrItems = self.arrMemberType
        }else if (segue.identifier == "state"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = true
            let arrState = self.setDataSource(type: segue.identifier!)
            vc.arrData = arrState.sorted { $0.name! < $1.name! }
        }else if (segue.identifier == "gender"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = false
            vc.arrItems = self.arrGenderType
        }else if (segue.identifier == "securityQuestions"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = questionType
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: segue.identifier!)
        }
    }
    
    //MARK: Delegates
    func selectedItem(item: String,type: String){
        if type == "member_type" {
            selectedMemberType = item
            if(selectedMemberType == "Intermediaries/Agent"){
                personalInfoCellHeight = 330.0
            }else if(selectedMemberType == "Non Medilink Member"){
                personalInfoCellHeight = 420.0
            }else{
                //Medilink Members or Non-Medilink Members
                personalInfoCellHeight = 300.0
            }
            self.tblRegistration.reloadData()
        }else if selectedMemberType == "Medilink Member"{
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = self.tblRegistration.cellForRow(at: indexPath) as! MedilinkMemberTableViewCell
            
        }else if selectedMemberType == "Non Medilink Member"{
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
            if type == "gender" {
//                cell.btnGender?.setTitle(item, for: .normal)
            }
            
        }else if selectedMemberType == "Intermediaries/Agent"{
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = self.tblRegistration.cellForRow(at: indexPath) as! AgentPersonalDetailsTableViewCell
        }
        
    }
    func selectedObject(obj: CustomObject,type: String){
        if type == "state" {
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
            
            selectedState = obj.name!
            selectedStateCode = obj.code!
            cell.btnState?.setTitle(obj.name!, for: .normal)
        }else{
            let indexPath = IndexPath(row: 3, section: 0)
            let cell = self.tblRegistration.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
            
            if type == "securityQuestion1"{
                cell.lblQuestion1.text = obj.name!
                self.selectedQuestion1Id = obj.code!
            }else if type == "securityQuestion2"{
                cell.lblQuestion2.text = obj.name!
                self.selectedQuestion2Id = obj.code!
            }else if type == "securityQuestion3"{
                cell.lblQuestion3.text = obj.name!
                self.selectedQuestion3Id = obj.code!
            }
        }
        
    }
    //MARK: Set Data
    func setDataSource(type: String) -> [CustomObject]{
        //States
        dataSource.removeAll()
        if type == "state" {
            var stateBo = CustomObject()
            stateBo.name = "PERAK"
            stateBo.code = "A"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "SELANGOR"
            stateBo.code = "B"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "PAHANG"
            stateBo.code = "C"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "KELANTAN"
            stateBo.code = "D"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "SABAH"
            stateBo.code = "H"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "JOHOR"
            stateBo.code = "J"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "KEDAH"
            stateBo.code = "K"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "LABUAN"
            stateBo.code = "LB"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "MELAKA"
            stateBo.code = "M"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "NEGERI SEMBILAN"
            stateBo.code = "N"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "PENANG"
            stateBo.code = "P"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "PUTRAJAYA"
            stateBo.code = "PJ"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "PERLIS"
            stateBo.code = "R"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "SARAWAK"
            stateBo.code = "SK"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "TERENGGANU"
            stateBo.code = "T"
            dataSource.append(stateBo)
            
            stateBo = CustomObject()
            stateBo.name = "KUALA LUMPUR"
            stateBo.code = "W"
            dataSource.append(stateBo)
            
        }else if type == "securityQuestions" {
            for qstnBo in self.arrSecurityQuestions{
                let customBo = CustomObject()
                customBo.code = qstnBo.id
                customBo.name = qstnBo.name
                
                dataSource.append(customBo)
            }
        }
        return dataSource
    }
    
    //MARK: Dtate Picker
    func datePickerTapped(title: String) {
        
        self.view.endEditing(true)
        
        //Show Date Picker
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyDatePickerViewController") as! MyDatePickerViewController
        vc.StrTitle = title
        vc.delegate = self
        vc.selectedDateStr = selectedDOB
        vc.myDateFormatter = StringConstant.dateFormatter9
        add(vc)
        
    }
    func mydatePickerPickedDate(dt: Date){
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = StringConstant.dateFormatterUTC
        let strSelectedDate = formatter.string(from: dt)
        self.selectDate = dt
        let strDate = formattedDateFromString(dateString: strSelectedDate, withFormat: StringConstant.dateFormatterUTC, ToFormat: StringConstant.dateFormatter9)
        cell.txtFldDOB.text = formattedDateFromString(dateString: strSelectedDate, withFormat: StringConstant.dateFormatterUTC, ToFormat: StringConstant.dateFormatter8)
        //cell.txtFldDOB.text = strDate
        self.selectedDOB = strDate
    }

    func formattedDateFromString(dateString: String, withFormat format: String, ToFormat newFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format

        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = newFormat
            outputFormatter.timeZone = TimeZone.current
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
    
    //MARK: Validation
    func ValidationForMedilinkMember() -> Bool{
        var errorMsg = ""
        //let indexPath = IndexPath(row: 1, section: 0)
        //let medilinkCell = self.tblRegistration.cellForRow(at: indexPath) as! MedilinkMemberTableViewCell
        
        //let indexPath1 = IndexPath(row: 2, section: 0)
        //let loginCell = self.tblRegistration.cellForRow(at: indexPath1) as! LoginDetailsTableViewCell
        
        let indexPath2 = IndexPath(row: 3, section: 0)
//        let qstnCell = self.tblRegistration.cellForRow(at: indexPath2) as! SecurityQuestionTableViewCell
        if self.name == "" {
            errorMsg = StringConstant.nameBlankValidation
        }
        else if self.idType == "" || self.idType == self.strSelect {
            errorMsg = StringConstant.idTypeBlankValidation
        }
        else if self.nationalId == "" {
            if self.idType == "NIK" {
                errorMsg = StringConstant.nationalIdBlankValidation
            }else if self.idType == "CARDNO" {
                errorMsg = StringConstant.cardNoBlankValidation
            }
        }else if self.selectedDOB == "" {
            errorMsg = StringConstant.dobValidation
        }else if(self.selectDate > maximumDate){
            errorMsg = StringConstant.maximumDateValidation
        }
//        else if medilinkCell.txtFldCardNo?.text == "" {
//            errorMsg = StringConstant.cardNoBlankValidation
//        }
//        else if self.postCode == "" {
//            errorMsg = StringConstant.postCodeBlankValidation
//        }else if selectedState == "" {
//            errorMsg = StringConstant.stateBlankValidation
//        }else if self.mobileNo == "" {
//            errorMsg = StringConstant.mobileBlankValidation
//        }
//        else if selectedMemberSince == "" {
//            errorMsg = StringConstant.memberSinceBlankValidation
//        }
        else if self.txtEmail != "" && !AppConstant.isValidEmail(emailId: (txtEmail)) {
            errorMsg = StringConstant.emailValidation
        }
        else if self.mobileNo == "" {
            errorMsg = StringConstant.mobileBlankValidation
        }
        else if self.mobileNo != "" && !self.mobileNo.isNumeric{
            errorMsg = StringConstant.mobileIsNumberValidation
        }
//        else if self.displayName == "" {
//            errorMsg = StringConstant.displayNameValidation
//        }
        else if self.password == "" {
            errorMsg = StringConstant.passwordValidation
        }else if self.confirmPassword == "" {
            errorMsg = StringConstant.cnfPasswordValidation
        }else if self.password != self.confirmPassword {
            errorMsg = StringConstant.passwordNotMatchValidation
        }
//        else if qstnCell.txtFldAnswer1.text! == "" {
//            errorMsg = StringConstant.ans1Validation
//        }else if qstnCell.txtFldAnswer2.text! == "" {
//            errorMsg = StringConstant.ans2Validation
//        }else if qstnCell.txtFldAnswer3.text! == "" {
//            errorMsg = StringConstant.ans3Validation
//        }
        else if isAgreeTC == false {
            errorMsg = StringConstant.agreeToTCValidation
        }
        
        if errorMsg != "" {
            self.displayAlert(message: errorMsg )
            return false
        }
        
        return true
    }
    func ValidationForNonMedilinkMember() -> Bool{
        return true
        
        var errorMsg = ""
        let indexPath = IndexPath(row: 1, section: 0)
        let non_medilinkCell = self.tblRegistration.cellForRow(at: indexPath) as! NonMedilinkMemberTableViewCell
        
        let indexPath1 = IndexPath(row: 2, section: 0)
        let loginCell = self.tblRegistration.cellForRow(at: indexPath1) as! LoginDetailsTableViewCell
        
        if non_medilinkCell.txtFldName?.text == "" {
            errorMsg = StringConstant.nameBlankValidation
        }else if non_medilinkCell.txtEmail?.text == "" {
            errorMsg = StringConstant.emailBlankValidation
        }else if non_medilinkCell.btnGender?.titleLabel?.text == "Select" {
            errorMsg = StringConstant.genderValidation
        }else if non_medilinkCell.txtFldCity?.text == "" {
            errorMsg = StringConstant.cityBlankValidation
        }else if selectedState == "" {
            errorMsg = StringConstant.stateBlankValidation
        }else if non_medilinkCell.txtFldAddress?.text == "" {
            errorMsg = StringConstant.addressValidation
        }else if selectedDOB == "" {
            errorMsg = StringConstant.dobValidation
        }else if loginCell.txtFldEmail?.text == "" {
            errorMsg = StringConstant.emailBlankValidation
        }else if !AppConstant.isValidEmail(emailId: (loginCell.txtFldEmail?.text)!) {
            errorMsg = StringConstant.emailValidation
        }else if loginCell.txtFldPassword?.text == "" {
            errorMsg = StringConstant.passwordValidation
        }else if loginCell.txtFldCnfPassword?.text == "" {
            errorMsg = StringConstant.cnfPasswordValidation
        }else if loginCell.txtFldPassword?.text != loginCell.txtFldCnfPassword?.text {
            errorMsg = StringConstant.passwordNotMatchValidation
        }else if isAgreeTC == false {
            errorMsg = StringConstant.agreeToTCValidation
        }
        
        if errorMsg != "" {
            self.displayAlert(message: errorMsg )
            return false
        }
        
        return true
    }
    func ValidationForAgent() -> Bool{
        var errorMsg = ""
        let indexPath = IndexPath(row: 1, section: 0)
        let agentCell = self.tblRegistration.cellForRow(at: indexPath) as! AgentPersonalDetailsTableViewCell
        
        let indexPath1 = IndexPath(row: 2, section: 0)
        let loginCell = self.tblRegistration.cellForRow(at: indexPath1) as! LoginDetailsTableViewCell
        
        if agentCell.txtFldName?.text == "" {
            errorMsg = StringConstant.nameBlankValidation
        }else if agentCell.txtFldAgentId?.text == "" {
            errorMsg = StringConstant.agentIDValidation
        }else if agentCell.txtFldPostCode?.text == "Select" {
            errorMsg = StringConstant.postCodeBlankValidation
        }else if agentCell.txtFldNationalId?.text == "" {
            errorMsg = StringConstant.nationalIdBlankValidation
        }else if selectedState == "" {
            errorMsg = StringConstant.stateBlankValidation
        }else if agentCell.txtFldMobile?.text == "" {
            errorMsg = StringConstant.mobileBlankValidation
        }else if loginCell.txtFldEmail?.text == "" {
            errorMsg = StringConstant.emailBlankValidation
        }else if !AppConstant.isValidEmail(emailId: (loginCell.txtFldEmail?.text)!) {
            errorMsg = StringConstant.emailValidation
        }else if loginCell.txtFldDisplayName?.text == "" {
            errorMsg = StringConstant.displayNameBlankValidation
        }else if loginCell.txtFldPassword?.text == "" {
            errorMsg = StringConstant.passwordValidation
        }else if loginCell.txtFldCnfPassword?.text == "" {
            errorMsg = StringConstant.cnfPasswordValidation
        }else if loginCell.txtFldPassword?.text != loginCell.txtFldCnfPassword?.text {
            errorMsg = StringConstant.passwordNotMatchValidation
        }else if isAgreeTC == false {
            errorMsg = StringConstant.agreeToTCValidation
        }
        
        if errorMsg != "" {
            self.displayAlert(message: errorMsg )
            return false
        }
        
        return true
    }
    //MARK: Service Call
    
    func serviceCallToSignUp(){
        AppConstant.showHUD()
        var params: Parameters!
        params = [
            "MemberType": "S",
            "Name": self.name,
            "NationalId": self.nationalId,
            "Email": self.txtEmail,
            "Password": self.password,
            "ConfirmPassword": self.confirmPassword,
            "IDType": self.idType,
            "DeviceName":"iOS",
            "DeviceID": AppConstant.retrievFromDefaults(key: StringConstant.deviceToken),
            "MobileNo": self.mobileNo,
            "DateofBirth": self.selectedDOB,
            "Gender": self.selectedGender,
        ]
        
        var url : String = AppConstant.member_registrationwithmobile_url
        
        print("Url===\(url)")
        print("params===\(String(describing: params))")
        AFManager.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                AppConstant.hideHUD()
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let dict = response.result.value! as! [String: Any]
                    if let status = dict["status"] as? String {
                        if(status == "1"){//Success
                            if let msg = dict["Message"] as? String{
                                self.goToLogin(message:msg)
                            }
                        }else{//Invalid login code
                            if let msg = dict["Message"] as? String{
                                self.displayAlert(message: msg )
                            }
                        }
                    }else{
                        AppConstant.showNetworkAlertMessage(apiName: url + ".")
                    }
                    break
                case .failure(_):
                    AppConstant.showNetworkAlertMessage(apiName: url)
                    break
                }
        }
    }
    
    func serviceCallToGetIDType(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getIDTypeUrl)")
            AFManager.request( AppConstant.getIDTypeUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        if let status = dict?["Status"] as? String {
                            if(status == "1"){//Success
                                let arrQstn = dict?["IDTypeList"] as! [[String: Any]]
                                self.arrIDType.removeAll()
                                if (arrQstn.count > 0){
                                    for dict in arrQstn {
                                        let qstnBo = SecurityQuestion()
                                        if let qstnId = dict["REFCD"] as? String{
                                            qstnBo.id = qstnId
                                        }else{
                                            qstnBo.id = ""
                                        }
                                        if let qstnName = dict["FDESC"] as? String{
                                            qstnBo.name = qstnName
                                        }else{
                                            qstnBo.name = ""
                                        }
                                        self.arrIDType.append(qstnBo)
                                        self.idTypeDropDown.dataSource.append(qstnBo.name)
                                    }
                                }
                            }else{
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg)
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getIDTypeUrl)
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getIDTypeUrl)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: goToLogin Popup
    func goToLogin(message:String){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
            AppConstant.removeSavedDataAndNavigateToLoginPage()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
