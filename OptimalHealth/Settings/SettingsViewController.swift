//
//  SettingsViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/01/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class SettingsViewController: BaseViewController, UITableViewDataSource,UITableViewDelegate, UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate, ProfileUpdateDelegate{

    @IBOutlet weak var tblViewSettings: UITableView!
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    @IBOutlet weak var viewVirtualCard: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblVirtualcardTitle: UILabel!
    @IBOutlet weak var virtualCardCollectionView: UICollectionView!
    
    var arrSettingData = [MainMenuBo]()
    var virtualcardWidth: CGFloat = 0.0
    var arrVirtualCard = [VirtualCardBo]()
    var selectedMenu = MainMenuBo()
    var className = ""
    var memberDetailsbo = MemberBo()
    var strHeaderImageName = ""
    var selectedPolicy = PolicyDetailsBo()
    var isDynamicMenu = true
    var cardImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        serviceCallToGetSettingMenuItems()
        
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
        }
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.height/2
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.width/2
        self.imgViewUser.layer.borderWidth = 1.5
        self.imgViewUser.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewUser.clipsToBounds = true
        
        virtualcardWidth = CGFloat((135 / AppConstant.virtualCardHeightRatio))
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                imgViewUser.image = image
            }
        }else{
            imgViewUser.image = UIImage.init(named: "userGray")
        }
        
        //Show Large Profile pic
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showprofileImage(_:)))
        self.imgViewUser.addGestureRecognizer(tap)
        self.imgViewUser.isUserInteractionEnabled = true
        
        lblUserName.text = AppConstant.retrievFromDefaults(key: StringConstant.displayName) == "" ? AppConstant.retrievFromDefaults(key: StringConstant.name) : AppConstant.retrievFromDefaults(key: StringConstant.displayName)
        let userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
        if (userType == "2") {// NonMedilinkMember
            //Hide Virtual card
            lblVirtualcardTitle.isHidden = true
        }
        let cardBgBase64 = AppConstant.retrievFromDefaults(key: StringConstant.cardImageBase64)
        if cardBgBase64 != ""{
            if let data = Data(base64Encoded: cardBgBase64) {
                self.cardImage = UIImage(data: data)
                self.virtualCardCollectionView.reloadData()
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.serviceCallToGetVirtualCardDetails()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Will appear called")
    }
    
    //MARK: Button Action
    @IBAction func btnHomeAction(_ sender: UIButton) {
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnDisplayNameAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profilePopupVC = storyboard.instantiateViewController(withIdentifier: "UpdateProfileInfoViewController") as! UpdateProfileInfoViewController
        profilePopupVC.profileImage = imgViewUser.image
        profilePopupVC.profileName = lblUserName.text!
        profilePopupVC.delegate = self
        addChild(profilePopupVC)

        //make sure that the child view controller's view is the right size
        profilePopupVC.view.frame = self.view.bounds
        self.view.addSubview(profilePopupVC.view)

        //you must call this at the end per Apple's documentation
        profilePopupVC.didMove(toParent: self)
    }
    
    @objc func showprofileImage(_ sender: UITapGestureRecognizer) {
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            self.performSegue(withIdentifier: "setting_largeProfile_pic", sender: self)
        }else{
            AppConstant.showAlertToAddProfilePic()
        }
    }
    
    //MARK: Profile Delegate
    func profileUpdated(){
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                imgViewUser.image = image
            }
        }else{
            imgViewUser.image = UIImage.init(named: "userGray")
        }
        lblUserName.text = AppConstant.retrievFromDefaults(key: StringConstant.displayName)
    }
    
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VirtualCardCollectionViewCell", for: indexPath) as! VirtualCardCollectionViewCell
                    
        //Set Values
//        let virtualCardBo = self.arrVirtualCard[indexPath.row]
//
//        cell.lblQRCardNo.text = virtualCardBo.cardNo
//        cell.lblName.text = virtualCardBo.name
//        cell.lblVal1.text = virtualCardBo.value1
//        cell.lblVal2.text = virtualCardBo.value2
//        cell.lblMemberSince.text = virtualCardBo.memberSince
//
//        cell.lblQRCardNo.textColor = UIColor.init(hexString: virtualCardBo.foregroundColor)
//        cell.lblName.textColor = UIColor.init(hexString: virtualCardBo.foregroundColor)
//        cell.lblVal1.textColor = UIColor.init(hexString: virtualCardBo.foregroundColor)
//        cell.lblVal2.textColor = UIColor.init(hexString: virtualCardBo.foregroundColor)
//        cell.lblMemberSince.textColor = UIColor.init(hexString: virtualCardBo.foregroundColor)
//        if virtualCardBo.qrCode != ""{
//            if let image =  AppConstant.generateQRCodeImage(QrCode: virtualCardBo.qrCode){
//                cell.setQRImage(qrcodeImage: image)
//            }
//        }
//        cell.imgViewCardBg.sd_setImage(with: URL(string: virtualCardBo.cardBgUrl), placeholderImage: UIImage(named: "virtual_card_bg"))
        cell.imgViewCardBg.image = cardImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = Int(collectionView.bounds.width)
    let height = Int(collectionView.bounds.height)

    return CGSize(width: width, height: height)
        
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSettingData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingBo = arrSettingData[indexPath.row]
        
        if settingBo.FDESC == ""{
          let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell2TableViewCell", for: indexPath as IndexPath) as! SettingsCell2TableViewCell
              cell.selectionStyle = .none
              return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell1TableViewCell", for: indexPath as IndexPath) as! SettingsCell1TableViewCell
            cell.selectionStyle = .none
            cell.lblSettingName.text = settingBo.FDESC
            cell.imgViewIcon?.image = UIImage.init(named: settingBo.Image)
            cell.imgViewIcon?.clipsToBounds = true
             return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMenu = arrSettingData[indexPath.row]
        let touchId = AppConstant.retrievFromDefaults(key: StringConstant.hasTouchIdRegistered)
        
        if selectedMenu.OBJID == StringConstant.logOff{
            showLogoutPopup()
        }else if selectedMenu.OBJID == StringConstant.contactUs{
//            let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsController") as! ContactUsController
            let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
            contactUsVC.pageType = "ContactUs"
            self.navigationController?.pushViewController(contactUsVC, animated: true)
        }else if (selectedMenu.OBJID == StringConstant.HAG){//Hospital Admission Guide
            className = selectedMenu.OBJID
            self.performSegue(withIdentifier: "hospital_admission", sender: self)
        }else if(selectedMenu.OBJID == StringConstant.downloadClaimForms){//Download Claim Forms
            className = selectedMenu.OBJID
//            self.performSegue(withIdentifier: "download_claim_forms", sender: self)
            self.performSegue(withIdentifier: "viewListClaimsForm", sender: self)
        }else if (self.selectedMenu.OBJID == StringConstant.changePassword){
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
            if self.isTouchIdSupportedOnDevice() == true {
                if (touchId == StringConstant.YES) {//Already Registered Touch Id with server
                    self.displayAlert(message: "Touch ID is already registered with us.")
                }else{
                    self.performSegue(withIdentifier: "biometric_option", sender: self)
                }
            }
        }else if(selectedMenu.OBJID == StringConstant.rate){//Rate App
            UIApplication.shared.open(URL(string: AppConstant.rateAppUrl)!)
        }else if (selectedMenu.OBJID == StringConstant.disclaimer){
            let disclaimerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
            disclaimerVC.pageType = "Disclaimer"
            self.navigationController?.pushViewController(disclaimerVC, animated: true)
        }else if (selectedMenu.OBJID == StringConstant.terms){
            let termsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsConditionsController") as! TermsConditionsController
            self.navigationController?.pushViewController(termsVC, animated: true)
        }else if (selectedMenu.OBJID == StringConstant.aboutus){
            let termsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsController") as! AboutUsController
            self.navigationController?.pushViewController(termsVC, animated: true)
        }else if (selectedMenu.OBJID == StringConstant.personalInfo){
            self.performSegue(withIdentifier: "policy_info", sender: self)
        }
    }

    func showLogoutPopup() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopupViewController") as! LogoutPopupViewController
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
    
    //MARK: -Service Call Methods
    func removeTouchId(){
        let alert = UIAlertController(title: "", message: "Do you want to remove Touch Id?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { action in
            
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.servicecallToRemoveTouchId()
        }))
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true)
    }
    
    func servicecallToRemoveTouchId() {
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
                                            self.displayAlert(message: msg )
                                            self.logOut()
                                        }
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg )
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
    
    func serviceCallToGetSettingMenuItems() {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            let roleDesc : String = AppConstant.retrievFromDefaults(key: StringConstant.roleDesc)
            
            let params: Parameters = [
                "pstRole": roleDesc
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.postSettingMenuUrl)")
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.postSettingMenuUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    self.arrSettingData.removeAll()
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        //  debugPrint(dict)
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetSettingMenuItems()
                                }
                            })
                        }else{
                            if let status = dict!["Status"] as? String {
                              if(status == "1"){
                                     if let arrMenuDetails = dict?["Menudetails"] as? [[String: Any]]{
                                        for dict in arrMenuDetails {
                                            let menuBo = MainMenuBo()
                                            if let apiName = dict["APINAME"] as? String{
                                                menuBo.apiName = apiName
                                            } else {
                                                menuBo.apiName = ""
                                            }
                                            if let fdesc = dict["FDESC"] as? String{
                                                menuBo.FDESC = fdesc
                                            } else {
                                                menuBo.FDESC = ""
                                            }
                                            if let img = dict["IMAGE"] as? String{
                                                menuBo.Image = img
                                            } else {
                                                menuBo.Image = ""
                                            }
                                            if let objId = dict["OBJID"] as? String{
                                                menuBo.OBJID = objId
                                            } else {
                                                menuBo.OBJID = ""
                                            }
                                            if let ordseq = dict["ORDSEQ"] as? String{
                                                menuBo.ORDSEQ = ordseq
                                            } else {
                                                menuBo.ORDSEQ = ""
                                            }
                                            if let frame = dict["FRAME"] as? String{
                                               menuBo.frame = frame
                                            } else {
                                               menuBo.frame = ""
                                            }
                                           
                                            //@ade: start
                                            if (menuBo.OBJID == "MCHANGEPWD" ||
                                                menuBo.OBJID == "MMREGISTERTOUCHID" ||
                                                menuBo.OBJID == "MMCHANGEPIN"  ||
                                                menuBo.OBJID == "MMREMOVETOUCHID"
                                            ) {
                                                continue
                                            }
                                            //@ade: end
                                            
                                            self.arrSettingData.append(menuBo)
                                            if menuBo.OBJID == StringConstant.rate{
                                                let menuBo = MainMenuBo()
                                                self.arrSettingData.append(menuBo)
                                            }else if menuBo.OBJID == StringConstant.contactUs{
                                                let menuBo = MainMenuBo()
                                                self.arrSettingData.append(menuBo)
                                            }
                                          
                                       }
                                       self.tblViewSettings.reloadData()

                                    }
                                
                                }else{
                                    if let message = dict!["Message"] as? String{
                                        self.displayAlert(message: message)
                                    }
                                    
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postSettingMenuUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postSettingMenuUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetDepedentList(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            let userType : String = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            var urlString = AppConstant.getMemberDependentDetailsUrl
            print("url===\(urlString)")
            let json = "{\"pstCardNo\":\"\(pstCardNo)\",\"pstUserType\":\"\(userType)\"}"
            print("param===\(json)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            
            let url = URL(string: urlString)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                 debugPrint(response)
                AppConstant.hideHUD()
                
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    let dict = response.result.value as! [String : AnyObject]
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetDepedentList()
                            }
                        })
                    }else{
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
                                        if self.selectedMenu.OBJID == StringConstant.myTodayGLStatus{
                                            if (self.memberDetailsbo.dependentArray.count > 0){
                                                self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                            }else{
                                                self.performSegue(withIdentifier: "my_today_gl_status", sender: self)
                                            }
                                        }else if self.selectedMenu.OBJID == StringConstant.viewGLLetter{
                                            if (self.memberDetailsbo.dependentArray.count > 0){
                                                self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                            }else{
                                                self.performSegue(withIdentifier: "view_gl_letter", sender: self)
                                            }
                                        }else if self.selectedMenu.OBJID == StringConstant.viewReimbursementClaim{
                                            if (self.memberDetailsbo.dependentArray.count > 0){
                                                self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                            }else{
                                                self.performSegue(withIdentifier: "claim_list", sender: self)
                                            }
                                        }else if self.selectedMenu.OBJID == StringConstant.myEmployeeEntitlementBenefit{
                                            if (self.memberDetailsbo.dependentArray.count > 0){
                                                self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                            }else{
                                                self.performSegue(withIdentifier: "policy_info", sender: self)
                                            }
                                        }else if self.selectedMenu.OBJID == StringConstant.myPolicyEntitlement{
                                            if (self.memberDetailsbo.dependentArray.count > 0){
                                                self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                            }else{
                                                self.performSegue(withIdentifier: "policy_info", sender: self)
                                            }
                                        }else{
                                            self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                        }
                                    }
                                    
                                }
                                
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg )
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
    
    func serviceCallToGetVirtualCardDetails(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let countryCode : String = AppConstant.retrievFromDefaults(key: StringConstant.countryCodeByLocation)
            let strCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            let params: Parameters = [
                "pstgeocode": countryCode,
                "pstCardNo": strCardNo
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.getVirtualCardUrl)")
            AFManager.request( AppConstant.getVirtualCardUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
//                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetVirtualCardDetails()
                                }
                            })
                        }else{
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let arrCardDetails = dict!["CardInfoList"] as? [[String:Any]]{
                                        if arrCardDetails.count > 0{
                                            let dictCard = arrCardDetails[0]
                                            if let cardBgBase64 = dictCard["CardImageBase64"] as? String{
                                                if cardBgBase64 != ""{
                                                    if let data = Data(base64Encoded: cardBgBase64) {
                                                        self.cardImage = UIImage(data: data)
                                                        self.virtualCardCollectionView.reloadData()
                                                        AppConstant.saveInDefaults(key: StringConstant.cardImageBase64, value: cardBgBase64)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    if let message = dict!["Message"] as? String{
                                        print(message)
                                    }
                                }
                            }else{
//                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getVirtualCardUrl)
                            }
                        }
                        break
                    case .failure(_):
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getVirtualCardUrl)
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
        if (segue.identifier == "policy_info"){
            let vc = segue.destination as! PolicyInfoViewController
            vc.policyBo = selectedPolicy
            vc.action = StringConstant.personalInfo
            vc.strCardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            vc.strPolicyNo = AppConstant.retrievFromDefaults(key: StringConstant.policyNo)
            vc.strHeaderImageName = self.selectedMenu.Image == "aboutus.png" ? "aboutus_white.png" : self.selectedMenu.Image
            vc.pageHeader = self.selectedMenu.FDESC
            return
        }
        else if (segue.identifier == "panel_providers"){
            let vc = segue.destination as! PanelProvidersViewController
            vc.pageTitle = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image
            return
        }else if (segue.identifier == "dependent_screen"){
            let vc = segue.destination as! DependentViewController
            vc.memberBo = self.memberDetailsbo
            vc.className = self.className
            vc.pageTitle = self.selectedMenu.FDESC
            vc.selectedPolicy = selectedPolicy
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "view_gl_letter"){
            let vc = segue.destination as! ViewGLLettersViewController
            vc.cardNo = selectedPolicy.cardNo
            return
        }else if (segue.identifier == "sub_menu_screen"){
            let vc = segue.destination as! SubMenuViewController
            vc.isDynamicMenu = isDynamicMenu
            vc.arrMenus = self.selectedMenu.arrSubMenu
            vc.className = self.className
            vc.selectedPolicy = self.selectedPolicy
            vc.pageTitle = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image
            return
        }else if (segue.identifier == "my_today_gl_status"){
            let vc = segue.destination as! MyTodayGLStatusViewController
            vc.strCardNo = selectedPolicy.cardNo
            vc.strHeaderImageName = self.selectedMenu.Image
            return
        }else if (segue.identifier == "claim_list"){
            let vc = segue.destination as! ClaimListViewController
            vc.cardNo = selectedPolicy.cardNo
            vc.className = className
            vc.strPageHeader = self.selectedMenu.FDESC
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            if userType != "D"
            {
                vc.strPageTitle = "Principal"
            }else{
                vc.strPageTitle = "Dependents"
            }
            return
        }else if (segue.identifier == "dashboard"){
            let vc = segue.destination as! DashboardViewController
            vc.pageTitle = self.selectedMenu.FDESC
            vc.cardNo = self.selectedPolicy.cardNo
            return
        }else if (segue.identifier == "download_claim_forms"){
            let vc = segue.destination as! DownloadClaimFormsViewController
            vc.pageTitle = self.selectedMenu.FDESC
            return
        }else if (segue.identifier == "virtual_card_screen"){
            let vc = segue.destination as! VirtualCardViewController
            vc.pageTitle = self.selectedMenu.FDESC
            vc.strCardNo = selectedPolicy.cardNo
            return
        }else if (segue.identifier == "health_tips"){
            let vc = segue.destination as! HealthOptimizationTipsViewController
            vc.pageHeader = self.selectedMenu.FDESC
            vc.imgHeader = self.selectedMenu.Image
            return
        }else if (segue.identifier == "myTodayHospitalAdmissionDischarge"){
            let vc = segue.destination as! MyTodayHospitalAdmissionDischargeViewController
            vc.titleHeader = self.selectedMenu.FDESC
            vc.imgHeader = self.selectedMenu.Image
            return
        }else if (segue.identifier == "search_nric_policynumber"){
            let vc = segue.destination as! SearchNricOrPolicyNumberViewController
            vc.headerText = self.selectedMenu.FDESC
            vc.imgHeaderView = self.selectedMenu.Image
            return
        }else if (segue.identifier == "claim_list"){
            let vc = segue.destination as! ClaimListViewController
            vc.cardNo = self.memberDetailsbo.cardNo!
            vc.className = self.selectedMenu.OBJID
            vc.strPageHeader = self.selectedMenu.FDESC.uppercased()
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
            vc.pageTitle = self.selectedMenu.FDESC.uppercased()
            vc.selectedPolicy = selectedPolicy
            vc.strHeaderImageName = strHeaderImageName
            return
        }else if (segue.identifier == "upload_photo"){
            let vc = segue.destination as! UploadProfilePicViewController
            vc.memberBo = self.memberDetailsbo
            vc.className = self.selectedMenu.OBJID
            vc.pageTitle = self.selectedMenu.FDESC.uppercased()
            vc.strHeaderImageName = self.selectedMenu.Image
            return
        } else if (segue.identifier == "viewListClaimsForm"){
            let vc = segue.destination as! ClaimsFormListViewController
            vc.pageHeader = self.selectedMenu.FDESC
            vc.className = selectedMenu.OBJID
            vc.strHeaderImageName = selectedMenu.Image
            return
        }
//        else if (segue.identifier == "download_claim_forms"){
//            let vc = segue.destination as! DownloadClaimFormsViewController
//            vc.pageTitle = self.selectedMenu.FDESC
//            return
//        }
        else if (segue.identifier == "search_nric_policynumber"){
            let vc = segue.destination as! SearchNricOrPolicyNumberViewController
            vc.headerText = self.selectedMenu.FDESC
            vc.imgHeaderView = self.selectedMenu.Image
            return
        }
        else if (segue.identifier == "search_nric_policynumber"){
            let vc = segue.destination as! SearchNricOrPolicyNumberViewController
            vc.headerText = self.selectedMenu.FDESC
            vc.imgHeaderView = self.selectedMenu.Image
            return
        }
    }
    
}
