//
//  CerificateInfoViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 11/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class CerificateInfoViewController: BaseViewController {
    
    @IBOutlet var lblProduct: UILabel!
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var lblRiskCommDate: UILabel!
    @IBOutlet var lblAnnualLimit: UILabel!
    @IBOutlet var lblFamilyLimit: UILabel!
    @IBOutlet var lblGroupLimit: UILabel!
    @IBOutlet var lblDisabilityLimit: UILabel!
    @IBOutlet var lblLifetimeLimit: UILabel!
    
    @IBOutlet var lblProductTitle: UILabel!
    @IBOutlet var lblCodeTitle: UILabel!
    @IBOutlet var lblRiskCommDateTitle: UILabel!
    @IBOutlet var lblAnnualLimitTitle: UILabel!
    @IBOutlet var lblFamilyLimitTitle: UILabel!
    @IBOutlet var lblGroupLimitTitle: UILabel!
    @IBOutlet var lblDisabilityLimitTitle: UILabel!
    @IBOutlet var lblLifetimeLimitTitle: UILabel!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var btnViewBenefit: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    
    var className: String = ""
    var strCardNo = ""
    var strPolicyNo = ""
    var strConditions : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        mainView.isHidden = true
        serviceCallToGetMemberEntitlementForSilverMember()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func viewBenefitBtnAction (_ sender: UIButton) {
        self.performSegue(withIdentifier: "view_benefit_entitlement_silver", sender: self)
    }
    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Service Call
    func serviceCallToGetMemberEntitlementForSilverMember () {
        
        if(AppConstant.hasConnectivity()) {//true connected
            
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
            print("url===\(AppConstant.getMemberEntitlementForSilverMemberUrl)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.getMemberEntitlementForSilverMemberUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    AppConstant.hideHUD()
                    self.mainView.isHidden = false
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        debugPrint(dict!)
                        
                        if let searchResponse = dict?["SearchResponse"] as? String {
                            if(searchResponse != ""){//success
                                let arrAllPolicyDetails = AppConstant.convertToArray(text: searchResponse)
                                if((arrAllPolicyDetails?.count)! > 0){
                                    let dictPolicy = arrAllPolicyDetails![0]
                                    if let product = dictPolicy["NAME"] as? String {
                                        if (product == "") {
                                            self.lblProduct?.text = "NA"
                                        }else {
                                            self.lblProduct?.text = product
                                        }
                                    }
                                    if let code = dictPolicy["CODE"] as? String {
                                        if (code == "") {
                                            self.lblCode?.text = "NA"
                                        }else {
                                            self.lblCode?.text = code
                                        }
                                    }
                                    if let riskCommDate = dictPolicy["ACTIVATION_DATE"] as? String {
                                        self.lblRiskCommDate?.text = riskCommDate
                                        if (riskCommDate == "") {
                                            self.lblRiskCommDate?.text = "NA"
                                        }else {
                                            self.lblRiskCommDate?.text = riskCommDate
                                        }
                                    }
                                    if let limits_array = dictPolicy["LIMITS"] as? [[String: Any]] {
                                        print(limits_array)
                                        for item in limits_array {
                                            if let annualLimit = item["ANNUAL"] as? String {
                                                if (annualLimit == "") {
                                                    self.lblAnnualLimit?.text = "NA"
                                                }else {
                                                    self.lblAnnualLimit?.text = annualLimit
                                                }
                                            }
                                            if let familyLimit = item["FAMILY"] as? String {
                                                if (familyLimit == "") {
                                                    self.lblFamilyLimit?.text = "NA"
                                                }else {
                                                    self.lblFamilyLimit?.text = familyLimit
                                                }
                                            }
                                            if let groupLimit = item["GROUP"] as? String {
                                                if (groupLimit == "") {
                                                    self.lblGroupLimit?.text = "NA"
                                                }else {
                                                    self.lblGroupLimit?.text = groupLimit
                                                }
                                            }
                                            if let disabilityLimit = item["DISABILITY"] as? String {
                                                if (disabilityLimit == "") {
                                                    self.lblDisabilityLimit?.text = "NA"
                                                }else {
                                                    self.lblDisabilityLimit?.text = disabilityLimit
                                                }
                                            }
                                            if let lifetimeLimit = item["LIFETIME"] as? String {
                                                if (lifetimeLimit == "") {
                                                    self.lblLifetimeLimit?.text = "NA"
                                                }else {
                                                    self.lblLifetimeLimit?.text = lifetimeLimit
                                                }
                                            }
                                        }
                                    }
                                    if let coverage_array = dictPolicy["COVERAGE"] as? [[String: Any]] {
                                        if coverage_array.count > 0{
                                            let dict_coverage_array = coverage_array[0]
                                            if let benefits_array = dict_coverage_array["BENEFITS"] as? [[String: Any]] {
                                                if benefits_array.count > 0{
                                                    let dict_benefits_array = benefits_array[0]
                                                    if let condition_array = dict_benefits_array["CONDITIONS"] as? [String] {
                                                        if condition_array.count > 0{
                                                            self.strConditions = condition_array[0]
                                                            if (self.strConditions == "") {
                                                                self.strConditions = "NA"
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }else {
                            let msg = dict?["Message"] as? String
                            self.displayAlert(message: msg ?? "")
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getMemberEntitlementForSilverMemberUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "view_benefit_entitlement_silver") {
            let vc = segue.destination as! ViewRoomEntitlementViewController
            vc.benefitCondition = strConditions!
        }
    }
    
    
}

