//
//  ClaimDocumentListingViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 17/04/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ClaimDocumentListingViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var tbvClaimDocumentList: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var lblPageTitle: UILabel!
    
    var className = ""
    var arayClaimDocumentListing = [ClaimDocumentListing]()
    var pageTitle : String = ""
    var claimId: String = ""
    var strHeaderImageName: String = ""
    
    override func viewDidLoad() {
        lblNoData.isHidden = true
        super.viewDidLoad()
        titleImageView.image = UIImage.init(named: strHeaderImageName)
        lblPageTitle.text = "View Medical Chit"
        PostClaimDocumentByClaimId()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arayClaimDocumentListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimDocumentListTableViewCell", for: indexPath as IndexPath) as! ClaimDocumentListTableViewCell
        cell.selectionStyle = .none
        let item = self.arayClaimDocumentListing[indexPath.row]
        cell.lblFileName.text = item.FILENAME == "" ? "NA" : item.FILENAME
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (self.claimId != ""){
            let viewGlVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewGLLettersViewController") as! ViewGLLettersViewController
            viewGlVC.className = className
            viewGlVC.claimId = claimId
            viewGlVC.type = "C"
            viewGlVC.fileName = arayClaimDocumentListing[indexPath.row].FILENAME
            viewGlVC.strHeader = "View Medical Chit"
            viewGlVC.strHeaderImageName = strHeaderImageName
            viewGlVC.pageTitle = "Principal"
            self.navigationController?.pushViewController(viewGlVC, animated: true)
        }
    }
    
    func PostClaimDocumentByClaimId(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params: Parameters = [
                "pstClaimsid": self.claimId
            ]
            print("params===\(params)")
            print("url===\(AppConstant.postClaimDocumentByClaimIdUrl)")

            AFManager.request( AppConstant.postClaimDocumentByClaimIdUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                    self.PostClaimDocumentByClaimId()
                                }
                            })
                        }else{
                            self.arayClaimDocumentListing.removeAll()
                            if let dict = AppConstant.convertToDictionary(text: response.result.value!){
                                if let status = dict["Status"] as? String {
                                    if(status == "1"){
                                        //success
                                        if let arrList = dict["Data"] as? [[String: Any]]{
                                            if(arrList.count > 0){
                                                for dictItem in arrList{
                                                    let item = ClaimDocumentListing()
                                                    if let fileName = dictItem["FILENAME"] as? String {
                                                        item.FILENAME = fileName
                                                    }
                                                    if let key1 = dictItem["KEY1"] as? String {
                                                        item.KEY1 = key1
                                                    }
                                                    self.arayClaimDocumentListing.append(item)
                                                }
                                            }
                                            self.tbvClaimDocumentList.reloadData()
                                        }
                                    }else{
                                        if let msg = dict["Message"] as? String{
                                            self.displayAlert(message: msg )
                                        }
                                    }
                                    if self.arayClaimDocumentListing.count < 1 {
                                        self.lblNoData.isHidden = false
                                    }
                                }else{
                                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postClaimDocumentByClaimIdUrl)
                                }
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postClaimDocumentByClaimIdUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
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
