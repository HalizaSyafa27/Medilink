//
//  SubMenuViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 05/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class SubMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    @IBOutlet var menuListColView: UICollectionView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var arrMenus = [SubMenuBo]()
    var isDynamicMenu: Bool = false
    var className = ""
    var selectedMenu = SubMenuBo()
    var memberDetailsbo = MemberBo()
    var selectedPolicy = PolicyDetailsBo()
    var pageTitle = ""
    var pageHeader = ""
    var strHeaderImageName = ""
    var strPlanCode = ""
    var cellheight: CGFloat = 40.0
    var isFromSubmenuScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDesign()
    }
    
    func initDesign(){
        if isDynamicMenu == false{
            var subMenuBo = SubMenuBo()
            subMenuBo.Image = strHeaderImageName.replacingOccurrences(of: "_white", with: "")
            subMenuBo.FDESC = "GL"
            self.arrMenus.append(subMenuBo)
            
            subMenuBo = SubMenuBo()
            subMenuBo.Image = strHeaderImageName.replacingOccurrences(of: "_white", with: "")
            subMenuBo.FDESC = "Claims"
            self.arrMenus.append(subMenuBo)
            
            self.menuListColView.reloadData()
//            self.tblViewMenu.reloadData()
            
        }
        
        lblPageHeader.text = pageHeader
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
    }
    
    func removeTouchId(){
        let alert = UIAlertController(title: "", message: "Do you want to remove Touch Id?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { action in
            
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.servicecallToRemoveTouchId()
        }))
        alert.view.tintColor = AppConstant.themeGreenColor
        self.present(alert, animated: true)
    }
    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.arrMenus.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuTableViewCell", for: indexPath as IndexPath) as! SubMenuTableViewCell
           
           let mainMenu = self.arrMenus[indexPath.row]
           var imgName = mainMenu.Image.replacingOccurrences(of: ".png", with: "")
           imgName = "\(imgName)"
           
           cell.imgViewMenu.image = UIImage(named:imgName)
           cell.lblMenuTitle.text = mainMenu.FDESC
           
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        let uType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
        if (uType != "2") {//Member and Agent
            let touchId = AppConstant.retrievFromDefaults(key: StringConstant.hasTouchIdRegistered)
            
            selectedMenu = self.arrMenus[indexPath.row]
            
            if isDynamicMenu == false{
                self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
            }else{
                if (className == StringConstant.Settings) {
                    if (self.selectedMenu.OBJID == StringConstant.changePassword){
                        self.performSegue(withIdentifier: "change_password", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.uploadPhoto){//Upload photo
                        self.performSegue(withIdentifier: "upload_photo", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.changePinForTouchId){//Change pin for Touch Id
                        if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                            self.performSegue(withIdentifier: "change_pin", sender: self)
                        }else{
                            self.displayAlert(message: "Touch ID is not registered with us.")
                        }
                        
                    }else if(selectedMenu.OBJID == StringConstant.removeTouchId){//Remove Touch Id
                        if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                            removeTouchId()
                        }else{
                            self.displayAlert(message: "Touch ID is not registered with us.")
                        }
                    }else if(selectedMenu.OBJID == StringConstant.registerTouchId){//Register Touch Id
                        if self.isTouchIdSupportedOnDevice() == true{
                            if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                                self.displayAlert(message: "Touch ID is already registered with us.")
                            }else{
                                self.performSegue(withIdentifier: "biometric_option", sender: self)
                            }
                        }
                    }
                }else if (className == StringConstant.policyHolderHealthRecordCoorperate) {
                    if(selectedMenu.OBJID == StringConstant.GLpolicyHolderHealthRecordCoorperate){//GL Policy Holder Health Record
                        self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.ClaimspolicyHolderHealthRecordCoorperate){//Claims Policy Holder Health Record
                        self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                    }
                }else if (className == StringConstant.others) {//Others
                    if(selectedMenu.OBJID == StringConstant.HAG){//Hospital Admission Guide
                        self.performSegue(withIdentifier: "hospital_admission", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.QRCode){//QR Code
                        self.serviceCallToGetDepedentList()
                    }else if(selectedMenu.OBJID == StringConstant.downloadClaimForms){//Download Claim Forms
                        self.performSegue(withIdentifier: "download_claim_forms", sender: self)
                    }else if(selectedMenu.OBJID == "CONTACTUS"){//Contact us
                        AppConstant.isSlidingMenu = false
                        self.performSegue(withIdentifier: "contact_us", sender: self)
                    }
                }else if (className == StringConstant.teleconsult) {//telehealth
                    if((selectedMenu.OBJID == StringConstant.teleconsultRequest) || (selectedMenu.OBJID == StringConstant.teleconsultAppoinments) || (selectedMenu.OBJID == StringConstant.teleconsultE_Prescription) || (selectedMenu.OBJID == StringConstant.teleconsultE_Lab) || (selectedMenu.OBJID == StringConstant.teleconsultE_Referral) || (selectedMenu.OBJID == StringConstant.teleconsultHistory) || (selectedMenu.OBJID == StringConstant.teleconsultE_Delivery)){//Tele Consult Icons
                        self.serviceCallToGetDepedentList()
                    }
                }else{
                    self.serviceCallToGetDepedentList()
                }
            }
            
        }else{//Corporate
            selectedMenu = self.arrMenus[indexPath.row]
            if (className == StringConstant.policyHolderHealthRecordCoorperate) {
                if(selectedMenu.OBJID == StringConstant.GLpolicyHolderHealthRecordCoorperate){//GL Policy Holder Health Record
                    self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                }else if(selectedMenu.OBJID == StringConstant.ClaimspolicyHolderHealthRecordCoorperate){//Claims Policy Holder Health Record
                    self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                }
            }
        }

    }
    
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemsCollectionViewCell", for: indexPath as IndexPath) as! MenuItemsCollectionViewCell
        
        let mainMenu = self.arrMenus[indexPath.row]
        var imgName = mainMenu.Image.replacingOccurrences(of: ".png", with: "_circle")
        imgName = "\(imgName)"
        
        cell.imgViewMenu.image = UIImage(named: imgName)
        cell.lblMenuTitle.text = mainMenu.FDESC
        cell.imgViewHeightConstraint.constant = cell.imgViewMenu.bounds.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let nbCol = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
//        if UIScreen.main.bounds.size.width == 320 {
//            return CGSize(width: size, height: size + 5)
//        }else{
//            return CGSize(width: (collectionView.bounds.width ) / CGFloat(nbCol), height: cellheight)
//        }
        return CGSize(width: size, height: size + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let uType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
        if (uType != "2") {//Member and Agent
            let touchId = AppConstant.retrievFromDefaults(key: StringConstant.hasTouchIdRegistered)
            
            selectedMenu = self.arrMenus[indexPath.row]
            strHeaderImageName = selectedMenu.Image.replacingOccurrences(of: ".png", with: "_white")
            if isDynamicMenu == false{
                self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
            }else{
                if (className == StringConstant.Settings) {
                    if (self.selectedMenu.OBJID == StringConstant.changePassword){
                        self.performSegue(withIdentifier: "change_password", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.uploadPhoto){//Upload photo
                        self.performSegue(withIdentifier: "upload_photo", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.changePinForTouchId){//Change pin for Touch Id
                        if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                            self.performSegue(withIdentifier: "change_pin", sender: self)
                        }else{
                            self.displayAlert(message: "Touch ID is not registered with us.")
                        }
                        
                    }else if(selectedMenu.OBJID == StringConstant.removeTouchId){//Remove Touch Id
                        if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                            removeTouchId()
                        }else{
                            self.displayAlert(message: "Touch ID is not registered with us.")
                        }
                    }else if(selectedMenu.OBJID == StringConstant.registerTouchId){//Register Touch Id
                        if self.isTouchIdSupportedOnDevice() == true{
                            if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                                self.displayAlert(message: "Touch ID is already registered with us.")
                            }else{
                                self.performSegue(withIdentifier: "biometric_option", sender: self)
                            }
                        }
                    }
                }else if (className == StringConstant.policyHolderHealthRecordCoorperate) {
                    if(selectedMenu.OBJID == StringConstant.GLpolicyHolderHealthRecordCoorperate){//GL Policy Holder Health Record
                        self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.ClaimspolicyHolderHealthRecordCoorperate){//Claims Policy Holder Health Record
                        self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                    }
                }else if (className == StringConstant.others) {//Others
                    if(selectedMenu.OBJID == StringConstant.HAG){//Hospital Admission Guide
                        self.performSegue(withIdentifier: "hospital_admission", sender: self)
                    }else if(selectedMenu.OBJID == StringConstant.QRCode){//QR Code
                        self.serviceCallToGetDepedentList()
                    }else if(selectedMenu.OBJID == StringConstant.downloadClaimForms){//Download Claim Forms
                        self.performSegue(withIdentifier: "download_claim_forms", sender: self)
                    }else if(selectedMenu.OBJID == "CONTACTUS"){//Contact us
                        AppConstant.isSlidingMenu = false
                        self.performSegue(withIdentifier: "contact_us", sender: self)
                    }
                }else if (className == StringConstant.teleconsult) {//telehealth
                    if((selectedMenu.OBJID == StringConstant.teleconsultRequest) || (selectedMenu.OBJID == StringConstant.teleconsultAppoinments) || (selectedMenu.OBJID == StringConstant.teleconsultE_Prescription) || (selectedMenu.OBJID == StringConstant.teleconsultE_Lab) || (selectedMenu.OBJID == StringConstant.teleconsultE_Referral) || (selectedMenu.OBJID == StringConstant.teleconsultHistory) || (selectedMenu.OBJID == StringConstant.teleconsultE_Delivery)){//Tele Consult Icons
                        self.serviceCallToGetDepedentList()
                    }
                }else{
                    self.serviceCallToGetDepedentList()
                }
            }
            
        }else{//Corporate
            selectedMenu = self.arrMenus[indexPath.row]
            if (className == StringConstant.policyHolderHealthRecordCoorperate) {
                if(selectedMenu.OBJID == StringConstant.GLpolicyHolderHealthRecordCoorperate){//GL Policy Holder Health Record
                    self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                }else if(selectedMenu.OBJID == StringConstant.ClaimspolicyHolderHealthRecordCoorperate){//Claims Policy Holder Health Record
                    self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
                }
            }
        }
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Service Call Method
    func serviceCallToGetDepedentList(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            let userType : String = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            let pstPlancode : String = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            let urlString = AppConstant.getMemberDependentDetailsUrl
            print("url===\(urlString)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            let json = "{\"pstCardNo\":\"\(pstCardNo)\",\"pstUserType\":\"\(userType)\",\"pstPlancode\":\"\(pstPlancode)\"}"
            let url = URL(string: urlString)!
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
                 debugPrint(response)
                AppConstant.hideHUD()
                AppConstant.hideHUD()
                
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetDepedentList()
                            }
                        })
                    }else{
                        let dict = response.result.value as! [String : AnyObject]
                        if let status = dict["Status"] as? String {
                            if(status == "1"){//success
                                
                                if let arrDependentDetails = dict["MemberDependentDetails"] as? [[String:Any]]{
                                    
                                    for dictDependentDetails in arrDependentDetails{
                                        self.memberDetailsbo = MemberBo()
                                        if let cardNo = dictDependentDetails["CardNo"] as? String{
                                            self.memberDetailsbo.cardNo = cardNo
                                        }else{
                                            self.memberDetailsbo.cardNo = ""
                                        }
                                        if let dependentId = dictDependentDetails["DependentId"] as? String{
                                            self.memberDetailsbo.dependentId = dependentId
                                        }else{
                                            self.memberDetailsbo.dependentId = ""
                                        }
                                        if let dependentStatus = dictDependentDetails["Dependentstatus"] as? String{
                                            self.memberDetailsbo.dependentStatus = dependentStatus
                                        }else{
                                            self.memberDetailsbo.dependentStatus = ""
                                        }
                                        if let employeeId = dictDependentDetails["EmployeeId"] as? String{
                                            self.memberDetailsbo.employeeId = employeeId
                                        }else{
                                            self.memberDetailsbo.employeeId = ""
                                        }
                                        if let Gender = dictDependentDetails["Gender"] as? String{
                                            self.memberDetailsbo.gender = Gender
                                        }else{
                                            self.memberDetailsbo.gender = ""
                                        }
                                        if let MemberType = dictDependentDetails["MemberType"] as? String{
                                            self.memberDetailsbo.memberType = MemberType
                                        }else{
                                            self.memberDetailsbo.memberType = ""
                                        }
                                        if let MemberType = dictDependentDetails["MemberType"] as? String{
                                            self.memberDetailsbo.memberType = MemberType
                                        }else{
                                            self.memberDetailsbo.memberType = ""
                                        }
                                        if let name = dictDependentDetails["Name"] as? String{
                                            self.memberDetailsbo.name = name
                                        }else{
                                            self.memberDetailsbo.name = ""
                                        }
                                        if let NationalId = dictDependentDetails["NationalId"] as? String{
                                            self.memberDetailsbo.nationalId = NationalId
                                        }else{
                                            self.memberDetailsbo.nationalId = ""
                                        }
                                        if let PAYOR_MEMBER_ID = dictDependentDetails["PAYOR_MEMBER_ID"] as? String{
                                            self.memberDetailsbo.PAYOR_MEMBER_ID = PAYOR_MEMBER_ID
                                        }else{
                                            self.memberDetailsbo.PAYOR_MEMBER_ID = ""
                                        }
                                        if let PolicyNo = dictDependentDetails["PolicyNo"] as? String{
                                            self.memberDetailsbo.policyNo = PolicyNo
                                        }else{
                                            self.memberDetailsbo.policyNo = ""
                                        }
                                        if let arrDependents = dictDependentDetails["Dependents"] as? [[String:Any]]{
                                            if arrDependents.count > 0 {
                                                for dictDependent in arrDependents{
                                                    let dependentBo = DependentBo()
                                                    if let cardNo = dictDependent["CardNo"] as? String{
                                                        dependentBo.cardNo = cardNo
                                                    }else{
                                                        dependentBo.cardNo = ""
                                                    }
                                                    if let dependentId = dictDependent["DependentId"] as? String{
                                                        dependentBo.dependentId = dependentId
                                                    }else{
                                                        dependentBo.dependentId = ""
                                                    }
                                                    if let dependentStatus = dictDependent["Dependentstatus"] as? String{
                                                        dependentBo.dependentStatus = dependentStatus
                                                    }else{
                                                        dependentBo.dependentStatus = ""
                                                    }
                                                    if let employeeId = dictDependent["EmployeeId"] as? String{
                                                        dependentBo.employeeId = employeeId
                                                    }else{
                                                        dependentBo.employeeId = ""
                                                    }
                                                    if let Gender = dictDependent["Gender"] as? String{
                                                        dependentBo.gender = Gender
                                                    }else{
                                                        dependentBo.gender = ""
                                                    }
                                                    if let MemberType = dictDependent["MemberType"] as? String{
                                                        dependentBo.memberType = MemberType
                                                    }else{
                                                        dependentBo.memberType = ""
                                                    }
                                                    if let MemberType = dictDependent["MemberType"] as? String{
                                                        dependentBo.memberType = MemberType
                                                    }else{
                                                        dependentBo.memberType = ""
                                                    }
                                                    if let name = dictDependent["Name"] as? String{
                                                        dependentBo.name = name
                                                    }else{
                                                        dependentBo.name = ""
                                                    }
                                                    if let NationalId = dictDependent["NationalId"] as? String{
                                                        dependentBo.nationalId = NationalId
                                                    }else{
                                                        dependentBo.nationalId = ""
                                                    }
                                                    if let PAYOR_MEMBER_ID = dictDependent["PAYOR_MEMBER_ID"] as? String{
                                                        dependentBo.PAYOR_MEMBER_ID = PAYOR_MEMBER_ID
                                                    }else{
                                                        dependentBo.PAYOR_MEMBER_ID = ""
                                                    }
                                                    if let PolicyNo = dictDependent["PolicyNo"] as? String{
                                                        dependentBo.policyNo = PolicyNo
                                                    }else{
                                                        dependentBo.policyNo = ""
                                                    }
                                                    self.memberDetailsbo.dependentArray.append(dependentBo)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if (self.memberDetailsbo.dependentArray.count > 0){
                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                }else{
                                    if self.className == StringConstant.cashLessClaim{
                                        if self.selectedMenu.OBJID == StringConstant.viewGLLetter{
                                            self.performSegue(withIdentifier: "claim_list", sender: self)
                                        }else if ((self.selectedMenu.OBJID == StringConstant.InPatient) || (self.selectedMenu.OBJID == StringConstant.GP) || (self.selectedMenu.OBJID == StringConstant.OPSP) || (self.selectedMenu.OBJID == StringConstant.Pharmacy)){
                                            self.performSegue(withIdentifier: "claim_list", sender: self)
                                        }
                                    }else if self.className == StringConstant.viewClaimsRecord{
                                        if self.selectedMenu.OBJID == StringConstant.gl{
                                            self.performSegue(withIdentifier: "claim_list", sender: self)
                                        }else if self.selectedMenu.OBJID == StringConstant.claim{
                                            self.performSegue(withIdentifier: "claim_list", sender: self)
                                        }
                                    }else{
                                        self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                    }
                                }
                                
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: urlString)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: urlString)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func servicecallToRemoveTouchId(){
        let userName = AppConstant.retrievFromDefaults(key: StringConstant.email)
        let password = AppConstant.retrievFromDefaults(key: StringConstant.password)
        if(AppConstant.hasConnectivity()) {//true connected
            let params: Parameters = [
                "pstUsrID": userName,
                "pstPassword": password
            ]
            print("params===\(params)")
            print("url===\(AppConstant.removeTouchIDUrl)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            AppConstant.showHUD()
            self.view.endEditing(true)
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.removeTouchIDUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.servicecallToRemoveTouchId()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    AppConstant.removeFromDefaults(key: StringConstant.hasTouchIdRegistered)
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                        self.logOut()
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.removeTouchIDUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.removeTouchIDUrl)
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
        if (segue.identifier == "claim_list"){
            let vc = segue.destination as! ClaimListViewController
            vc.cardNo = self.memberDetailsbo.cardNo!
            vc.className = self.selectedMenu.OBJID
            vc.strPageHeader = self.selectedMenu.FDESC
            vc.strHeaderImageName = strHeaderImageName
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            if userType != "D"
            {
                vc.strPageTitle = "Principal"
            }else{
                vc.strPageTitle = "Dependents"
            }
            return
        }else if (segue.identifier == "dependent_screen"){
            let vc = segue.destination as! DependentViewController
            vc.memberBo = self.memberDetailsbo
            vc.className = self.selectedMenu.OBJID
            vc.pageTitle = self.selectedMenu.FDESC
            vc.selectedPolicy = selectedPolicy
            vc.strHeaderImageName = strHeaderImageName
            vc.isFromSubmenuScreen = true
            return
        }else if (segue.identifier == "upload_photo"){
            let vc = segue.destination as! UploadProfilePicViewController
            vc.memberBo = self.memberDetailsbo
            vc.className = self.selectedMenu.OBJID
            vc.pageTitle = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image
            return
        }else if (segue.identifier == "download_claim_forms"){
            let vc = segue.destination as! DownloadClaimFormsViewController
            vc.pageTitle = self.selectedMenu.FDESC
            return
        }else if (segue.identifier == "search_nric_policynumber"){
            let vc = segue.destination as! SearchNricOrPolicyNumberViewController
            vc.headerText = self.selectedMenu.FDESC
            vc.imgHeaderView = self.selectedMenu.Image
            return
        }
    }
    
}
