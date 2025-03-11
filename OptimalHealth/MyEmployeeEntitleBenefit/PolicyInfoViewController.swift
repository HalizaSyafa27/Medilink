//
//  PolicyInfoViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class PolicyInfoViewController: BaseViewController {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblPolicyNo: UILabel!
    @IBOutlet var lblNRIC: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblPostcode: UILabel!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblState: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDayofBirth: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    
    @IBOutlet var lblNameTitle: UILabel!
    @IBOutlet var lblPolicyNoTitle: UILabel!
    @IBOutlet var lblNRICTitle: UILabel!
    @IBOutlet var lblAddressTitle: UILabel!
    @IBOutlet var lblPhoneTitle: UILabel!
    @IBOutlet var lblPostcodeTitle: UILabel!
    @IBOutlet var lblCityTitle: UILabel!
    @IBOutlet var lblStateTitle: UILabel!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var addressUnderLabel: UILabel!
    @IBOutlet var phoneUnderLabel: UILabel!
    @IBOutlet var postcodeUnderLabel: UILabel!
    @IBOutlet var cityUnderLabel: UILabel!
    @IBOutlet var stateUnderLabel: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    
    @IBOutlet var imgViewName: UIImageView!
    @IBOutlet var imgViewNRIC: UIImageView!
    @IBOutlet var imgViewAddress: UIImageView!
    @IBOutlet var imgViewPhone: UIImageView!
    @IBOutlet var imgViewCity: UIImageView!
    @IBOutlet var imgViewState: UIImageView!
    @IBOutlet var imgViewPostCode: UIImageView!
    @IBOutlet var imgViewPolicyNo: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewPolicyNumberHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewNRICHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewAddressHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewPhoneHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewPostcodeHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewCityHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewStateHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewUsernameHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewDayOfBirthHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewEmailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLastUpdateHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var viewName: UIView!
    @IBOutlet var viewPolicyNumber: UIView!
    @IBOutlet var viewNRIC: UIView!
    @IBOutlet var viewAddress: UIView!
    @IBOutlet var viewPhone: UIView!
    @IBOutlet var viePostcode: UIView!
    @IBOutlet var viewCity: UIView!
    @IBOutlet var viewState: UIView!
    @IBOutlet weak var viewUsername: UIView!
    @IBOutlet weak var viewDayOfBirth: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewLastUpdate: UIView!
    @IBOutlet var lblHeaderTitle: UILabel!
    @IBOutlet var imgViewUser: UIImageView!
    @IBOutlet var lblEntitlementType: UILabel!
    @IBOutlet var btnViewPolicy: UIButton!
    
    //@ade: start
    @IBOutlet weak var captionUsername: UILabel!
    //@ade: end
    
    var arrViewBenefitGoldMember = [ViewBenefitGoldMemberBo]()
    var policyBo = PolicyDetailsBo()
    var strCardNo = ""
    var strPolicyNo = ""
    var strStatus : String! = ""
    var strHeaderImageName = ""
    var pageTitle: String = ""
    var userProfilepicUrl = ""
    var pageHeader : String = ""
    var action:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView?.isHidden = true
        initDesign()
        self.serviceCallToGetPolicyinfo()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func initDesign(){
        lblNRICTitle.text = StringConstant.nricSymbol
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        self.lblHeaderTitle.text = pageHeader
        self.lblEntitlementType.text = pageTitle
        if action == StringConstant.personalInfo {
            self.btnViewPolicy.isHidden = true
        }else{
            viewUsername.isHidden = true
            viewUsernameHeightConstraint.constant = 0
            viewDayOfBirth.isHidden = true
            viewDayOfBirthHeightConstraint.constant = 0
            viewEmail.isHidden = true
            viewEmailHeightConstraint.constant = 0
            viewLastUpdate.isHidden = true
            viewLastUpdateHeightConstraint.constant = 0
            if (AppConstant.memberType == "GOLDMEMBER") {
                self.btnViewPolicy?.setTitle("View Coverage", for: .normal)
                
    //            lblAddressTitle.isHidden = true
    //            lblPhoneTitle.isHidden = true
    //            lblPostcodeTitle.isHidden = true
    //            lblCityTitle.isHidden = true
    //            lblStateTitle.isHidden = true
    //
    //            lblAddress.isHidden = true
    //            lblPhone.isHidden = true
    //            lblPostcode.isHidden = true
    //            lblCity.isHidden = true
    //            lblState.isHidden = true
    //
    //            imgViewAddress.isHidden = true
    //            imgViewPhone.isHidden = true
    //            imgViewPostCode.isHidden = true
    //            imgViewCity.isHidden = true
    //            imgViewState.isHidden = true
    //
    //            addressUnderLabel.isHidden = true
    //            phoneUnderLabel.isHidden = true
    //            postcodeUnderLabel.isHidden = true
    //            cityUnderLabel.isHidden = true
    //            stateUnderLabel.isHidden = true
            }
            else {
                //self.btnViewPolicy?.setTitle("VIEW POLICY / CERTIFICATE INFO", for: .normal)
                self.btnViewPolicy?.setTitle("View Coverage", for: .normal)
                lblAddressTitle.isHidden = false
                lblPhoneTitle.isHidden = false
                lblPostcodeTitle.isHidden = false
                lblCityTitle.isHidden = false
                lblStateTitle.isHidden = false
                
                lblAddress.isHidden = false
                lblPhone.isHidden = false
                lblPostcode.isHidden = false
                lblCity.isHidden = false
                lblState.isHidden = false
                
                addressUnderLabel.isHidden = false
                phoneUnderLabel.isHidden = false
                postcodeUnderLabel.isHidden = false
                cityUnderLabel.isHidden = false
                stateUnderLabel.isHidden = false
            }
        }
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
        
        if pageTitle == "Principal" || action == StringConstant.personalInfo{
            let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
            if profileImgStr != ""{
                if let data = Data(base64Encoded: profileImgStr) {
                    let image = UIImage(data: data)
                    imgViewUser.image = image
                }
            }
        }
        
    }
    
    func setDataWithDict(dict:[String:Any]){
        if action == StringConstant.personalInfo {
            if let empName = dict["EMP_NAME"] as? String{
                lblName.text = empName
            }else{
                lblName.text = ""
                viewName.isHidden = true
                viewNameHeightConstraint.constant = 0
            }
            if let newIC = dict["NEW_IC"] as? String{
                lblNRIC.text = newIC
            }else{
                lblNRIC.text = ""
                viewNRIC.isHidden = true
                viewNRICHeightConstraint.constant = 0
            }
            if let policyNo = dict["POLICY_NO"] as? String{
                lblPolicyNo.text = policyNo
            }else{
                lblPolicyNo.text = ""
                viewPolicyNumber.isHidden = true
                viewPolicyNumberHeightConstraint.constant = 0
            }
            if let address = dict["ADDRESS"] as? String{
                let addresstype = dict["ADDRESSTYPE"] as? String
                lblAddress.text = "Address Type : \(addresstype!) \n \(address)"
            }else{
                lblAddress.text = ""
                viewAddress.isHidden = true
                viewAddressHeightConstraint.constant = 0
            }
            if let postCode = dict["POSTCODE"] as? String{
                lblPostcode.text = postCode
            }else{
                lblPostcode.text = ""
                viePostcode.isHidden = true
                viewPostcodeHeightConstraint.constant = 0
            }
            if let city = dict["CITY"] as? String{
                lblCity.text = city
            }else{
                lblCity.text = ""
                viewCity.isHidden = true
                viewCityHeightConstraint.constant = 0
            }
            if let state = dict["STATE"] as? String{
                lblState.text = state
            }else{
                lblState.text = ""
                viewState.isHidden = true
                viewStateHeightConstraint.constant = 0
            }
            if let phone = dict["EMPPHONE"] as? String{
                let phoneType = dict["PHONETYPE"] as? String
                lblPhone.text = "Phone Type : \(phoneType!) \n \(phone)"
            }else{
                lblPhone.text = ""
                viewPhone.isHidden = true
                viewPhoneHeightConstraint.constant = 0
            }
            if let username = dict["USERNAME"] as? String{
//                lblUsername.text = username
                //@ade: start
                let uid = AppConstant.retrievFromDefaults(key: StringConstant.email)
                if (AppConstant.isExternalUser(userId: uid)) {
                    var caption = AppConstant.retrievFromDefaults(key: StringConstant.externalUserLabel)
                    if (caption == "") {
                        caption = "External User"
                    }
                    captionUsername.text = caption
                    let items = username.split(separator: ":")
                    if (items.count > 1) {
                        lblUsername.text = String(items[1])
                    } else {
                        lblUsername.text = String(items[0])
                    }
                } else {
                    captionUsername.text = "Username"
                    lblUsername.text = username
                }
                //@ade: end
            }else{
                lblUsername.text = ""
                viewUsername.isHidden = true
                viewUsernameHeightConstraint.constant = 0
            }
            if let dateOfBirth = dict["DATE_OF_BIRTH"] as? String{
                lblDayofBirth.text = dateOfBirth
            }else{
                lblDayofBirth.text = ""
                viewDayOfBirth.isHidden = true
                viewDayOfBirthHeightConstraint.constant = 0
            }
            if let email = dict["EMAIL"] as? String{
                let emailType = dict["EMAILTYPE"] as? String
                lblEmail.text = "Email Type : \(emailType!) \n \(email)"
            }else{
                lblEmail.text = ""
                viewEmail.isHidden = true
                viewEmailHeightConstraint.constant = 0
            }
            if let lastUpdate = dict["LASTUPDATE"] as? String{
                lblLastUpdate.text = lastUpdate
            }else{
                lblLastUpdate.text = ""
                viewLastUpdate.isHidden = true
                viewLastUpdateHeightConstraint.constant = 0
            }
        }
        else{
            if let empName = dict["EMP_NAME"] as? String{
                lblName.text = empName
            }else{
                viewName.isHidden = true
                viewNameHeightConstraint.constant = 0
            }
            
            if AppConstant.memberType == "GOLDMEMBER" {
                if let newIC = dict["NEW_IC"] as? String{
                    lblNRIC.text = newIC
                }else{
                    viewNRIC.isHidden = true
                    viewNRICHeightConstraint.constant = 0
                }
                if let policyNo = dict["POLICY_NO"] as? String{
                    lblPolicyNo.text = policyNo
                }else{
                    viewPolicyNumber.isHidden = true
                    viewPolicyNumberHeightConstraint.constant = 0
                }
                if let address = dict["ADDRESS"] as? String{
                    let addresstype = dict["ADDRESSTYPE"] as? String
                    lblAddress.text = "Address Type : \(addresstype!) \n \(address)"
                }else{
                    viewAddress.isHidden = true
                    viewAddressHeightConstraint.constant = 0
                }
                if let postCode = dict["POSTCODE"] as? String{
                    lblPostcode.text = postCode
                }else{
                    viePostcode.isHidden = true
                    viewPostcodeHeightConstraint.constant = 0
                }
                if let city = dict["CITY"] as? String{
                    lblCity.text = city
                }else{
                    viewCity.isHidden = true
                    viewCityHeightConstraint.constant = 0
                }
                if let state = dict["STATE"] as? String{
                    lblState.text = state
                }else{
                    viewState.isHidden = true
                    viewStateHeightConstraint.constant = 0
                }
                if let phone = dict["EMPPHONE"] as? String{
                    let phoneType = dict["PHONETYPE"] as? String
                    lblPhone.text = "Phone Type : \(phoneType!) \n \(phone)"
                }else{
                    viewPhone.isHidden = true
                    viewPhoneHeightConstraint.constant = 0
                }
                
            }
            else{
                if let newIC = dict["NEW_IC"] as? String{
                    lblNRIC.text = newIC
                }else{
                    viewNRIC.isHidden = true
                    viewNRICHeightConstraint.constant = 0
                }
                if let policyNo = dict["POLICY_NO"] as? String{
                    lblPolicyNo.text = policyNo
                }else{
                    viewPolicyNumber.isHidden = true
                    viewPolicyNumberHeightConstraint.constant = 0
                }
                if let address = dict["ADDRESS"] as? String{
                    let addresstype = dict["ADDRESSTYPE"] as? String
                    lblAddress.text = "Address Type : \(addresstype!) \n \(address)"
                }else{
                    viewAddress.isHidden = true
                    viewAddressHeightConstraint.constant = 0
                }
                if let postCode = dict["POSTCODE"] as? String{
                    lblPostcode.text = postCode
                }else{
                    viePostcode.isHidden = true
                    viewPostcodeHeightConstraint.constant = 0
                }
                if let city = dict["CITY"] as? String{
                    lblCity.text = city
                }else{
                    viewCity.isHidden = true
                    viewCityHeightConstraint.constant = 0
                }
                if let state = dict["STATE"] as? String{
                    lblState.text = state
                }else{
                    viewState.isHidden = true
                    viewStateHeightConstraint.constant = 0
                }
                if let phone = dict["EMPPHONE"] as? String{
                    let phoneType = dict["PHONETYPE"] as? String
                    lblPhone.text = "Phone Type : \(phoneType!) \n \(phone)"
                }else{
                    viewPhone.isHidden = true
                    viewPhoneHeightConstraint.constant = 0
                }
            }
        }
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewPolicyBtnAction (_ sender: UIButton) {
        self.performSegue(withIdentifier: "view_benefit", sender: self)
    }
    
    // MARK: - Service Call
    func serviceCallToGetPolicyinfo(){
        
        if AppConstant.hasConnectivity() {//internet active
            AppConstant.showHUD()
            let pstCardNo = strCardNo
            let json = "{\"pstCardNo\":\"\(pstCardNo)\"}"
            print(json)
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            let url = URL(string: AppConstant.getPolicyInfoUrl)!
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
                self.mainView?.isHidden = false
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    let dict = response.result.value as! [String : AnyObject]
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetPolicyinfo()
                            }
                        })
                    }else{
                        if let status = dict["Status"] as? String {
                            if(status == "1"){//success
                                let arrAllPolicyDetails = dict["Policyinfo"] as? [[String: Any]]
                                
                                if((arrAllPolicyDetails?.count)! > 0){
                                    let dictPolicy = arrAllPolicyDetails![0]
                                    self.setDataWithDict(dict: dictPolicy)
                                }
                            }else {
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getPolicyInfoUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetMemberEntitlementForGoldmember () {
        
        if(AppConstant.hasConnectivity()) {//true connected
            
            AppConstant.showHUD()
            let emailId = AppConstant.retrievFromDefaults(key: StringConstant.email)
            let password = AppConstant.retrievFromDefaults(key: StringConstant.password)
            let planCode = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            let cardNo = strCardNo
            let policyNo = strPolicyNo
            
            AppConstant.showHUD()
            let params: Parameters = [
                
                "pstPaln": planCode,
                "pstUserID": emailId,
                "pstPassword": password,
                "pstCardNo": cardNo,
                "pstPolicyNo": policyNo
            ]
            print("params===\(params)")
            AFManager.request( AppConstant.getMemberEntitlementForGoldmemberUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    AppConstant.hideHUD()
                    self.arrViewBenefitGoldMember.removeAll()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        debugPrint(dict!)
                        
                        if let status = dict?["status"] as? String {
                            if(status == "0"){
                                self.strStatus = status
                                self.performSegue(withIdentifier: "view_benefit_gold", sender: self)
                            }else  if(status == "1"){//success
                                self.strStatus = status
                                if let dict_array = dict?["Response"] as? [[String: Any]] {
                                    print(dict_array)
                                    for item in dict_array {
                                        let viewBenefitGoldMember = ViewBenefitGoldMemberBo()
                                        if let codeName = item["Code"] as? String {
                                            viewBenefitGoldMember.codeName = codeName
                                        }
                                        if let familyLimit = item["FamilyLimit"] as? String {
                                            viewBenefitGoldMember.familyLimit = familyLimit
                                        }
                                        if let annualLimit = item["AnnualLimit"] as? String {
                                            viewBenefitGoldMember.annualLimit = annualLimit
                                        }
                                        if let jobGrade = item["JobGrade"] as? String {
                                            viewBenefitGoldMember.jobGrade = jobGrade
                                        }
                                        if let annualLimitLabelName = item["LabelName"] as? String {
                                            viewBenefitGoldMember.annualLimitLabelName = annualLimitLabelName
                                        }
                                        if let conditions = item["Conditions"] as? String {
                                            viewBenefitGoldMember.conditions = conditions
                                        }else{
                                            viewBenefitGoldMember.conditions = ""
                                        }
                                        
                                        self.arrViewBenefitGoldMember.append(viewBenefitGoldMember)
                                    }
                                    
                                }
                                self.performSegue(withIdentifier: "view_benefit_gold", sender: self)
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMemberEntitlementForGoldmemberUrl)
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMemberEntitlementForGoldmemberUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "view_benefit_gold") {
            let vc = segue.destination as! ViewBenefitGoldMemberViewController
            vc.viewBenefitGoldMember = arrViewBenefitGoldMember
            vc.strStatus = strStatus
            return
        }else if (segue.identifier == "certificate_info") {
            let vc = segue.destination as! CerificateInfoViewController
            vc.strCardNo = strCardNo
            vc.strPolicyNo = strPolicyNo
            return
        }else if (segue.identifier == "view_benefit") {
            let vc = segue.destination as! ViewBenefitViewController
            vc.strCardNo = strCardNo
            vc.strPolicyNo = strPolicyNo
            vc.name = lblName.text!
            vc.pageTitle = pageTitle
            vc.strHeaderImageName = self.strHeaderImageName
            vc.headerTitle = self.pageHeader
            return
        }
    }
    
}

