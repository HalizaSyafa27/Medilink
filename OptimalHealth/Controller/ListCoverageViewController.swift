//
//  ListCoverageViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 20/03/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ListCoverageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var tbvCoverage: UITableView!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgViewHeader: UIImageView!

    var arayCoverageBo = [CoverageBo]()
    var titlePage : String = ""
    var coverageCode:String = ""
    var strCardNo:String = ""
    var planCode :String = ""
    var startDate :String = ""
    var endDate :String = ""
    var className :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        pageTitle.text = titlePage
        initDesign()
    }
    
    func initDesign(){
        pageTitle.text = titlePage
        if(className == "ViewBenefit"){
            contentTitle.text = "Benefit Level"
            lblCode.text = "Benefit"
            lblDesc.text = "Condition"
            serviceCallForBenefit()
            imgViewHeader.image = UIImage.init(named: "hdata_white")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arayCoverageBo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCoverageTableViewCell", for: indexPath as IndexPath) as! ListCoverageTableViewCell
        cell.selectionStyle = .none
        let item = self.arayCoverageBo[indexPath.row]
        cell.lblCode.text = item.coverageCode == "" ? "NA" : item.coverageCode
        cell.lblCoverage.text = item.desc == "" ? "NA" : item.desc
        if (self.className == "ViewBenefit"){
            cell.viewNextPage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.coverageCode = arayCoverageBo[indexPath.row].coverageCode
        if (self.coverageCode != "" && self.className != "ViewBenefit"){
            serviceCallForMobileInquiry()
        }
    }
    
    @IBAction func homeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func serviceCallForMobileInquiry(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstProviderCode": AppConstant.strQRPopupProviderCode,
                "pstCoverageCode": self.coverageCode,
                "pstCardNo": AppConstant.strQRPopupCardNo
            ]
            print("params===\(params)")
            print("url===\(AppConstant.QRMobileInquiryUrl)")
            var strApprovalCode = ""
            var strPopupCode = ""
            AFManager.request( AppConstant.QRMobileInquiryUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallForMobileInquiry()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    //success
                                    let responceArray = dict?["QRMobileInquiryList"] as? [[String: Any]]
                                    if ((responceArray?.count)! > 0){
                                        let dict = responceArray![0]
                                        if let text = dict["PrintableText"] as? String{
                                            strPopupCode = text
                                            AppConstant.strQRPopupValue = strPopupCode
                                        }
                                        if let approvalCode = dict["ApprovalCode"] as? String{
                                            strApprovalCode = approvalCode
                                            if(strApprovalCode == StringConstant.approvalCode){
                                                AppConstant.intPopupTag = 101
                                                self.showPopupForQR(tag: 101, text: strPopupCode, coverageCode: self.coverageCode)
                                            }else{
                                                AppConstant.intPopupTag = 102
                                                self.showPopupForQR(tag: 102, text: strPopupCode, coverageCode: self.coverageCode)
                                            }
                                        }
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.QRMobileInquiryUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.QRMobileInquiryUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallForBenefit(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstPaln": self.planCode,
                "pstCoverageCode": self.coverageCode,
                "pstCardNo": self.strCardNo,
                "pstStartDate": self.startDate,
                "pstEnddate": self.endDate,
            ]
            print("params===\(params)")
            print("url===\(AppConstant.postBenefitUrl)")
            AFManager.request( AppConstant.postBenefitUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.serviceCallForBenefit()
                                }
                            })
                        }else{
                            self.arayCoverageBo.removeAll()
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    //success
                                    let responceArray = dict!["BenefitList"] as! [[String: Any]]
                                    if (responceArray.count > 0){
                                        for dict in responceArray{
                                            let coverageBo = CoverageBo()
                                            if let loaDesc = dict["Loa_Desc"] as? String{
                                                coverageBo.coverageCode = loaDesc
                                            }
                                            if let condition = dict["Condition"] as? String{
                                                coverageBo.desc = condition
                                            }
                                            self.arayCoverageBo.append(coverageBo)
                                        }
                                    }
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postBenefitUrl)
                            }
                            self.tbvCoverage.reloadData()
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postBenefitUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func showPopupForQR(tag: Int, text: String, coverageCode: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRPopUpViewController") as! QRPopUpViewController
        vc.coverageCode = coverageCode
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        AppConstant.intPopupTag = tag
        vc.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        vc.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            vc.view.alpha = 1.0
            vc.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        self.addChild(vc)
        self.view.addSubview(vc.view)
        return
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
