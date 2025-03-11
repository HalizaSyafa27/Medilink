//
//  ChooseOptionViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol ChooseDelegate: AnyObject {
    @objc optional func selectedItem(item: String,type: String)
    @objc optional func selectedObject(obj: CustomObject,type: String)
}

class ChooseOptionViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var tblChoose: UITableView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var arrItems: [String] = []
    var arrData: [CustomObject] = []
    var type: String = ""
    weak var delegate: ChooseDelegate?
    var isCustomObj = false
    var isAgreeToTermsAndCond = false
    var CountryCode:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblChoose.delegate = self
        tblChoose.dataSource = self
        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.tblChoose.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        print(type)
        
        if type == "member_type" {
            self.lblPageTitle?.text = "SELECT MEMBER TYPE"
        }else if type == "gender" {
            self.lblPageTitle?.text = "SELECT GENDER"
        }else if type == "state" {
            PostState()
            self.lblPageTitle?.text = "SELECT A STATE"
        }else if type == "speciality" {
            GetSpeciality()
            self.lblPageTitle?.text = "SELECT A SPECIALITY"
        }else if type == "subject_type" {
            self.lblPageTitle?.text = "SELECT SUBJECT"
        }else if type == "provider_type" {
            GetProviderType()
            self.lblPageTitle?.text = "SELECT PROVIDER"
        }else if type == "select_policy" {
            self.lblPageTitle?.text = "SELECT POLICY"
        }else if type == "select_coverage" {
            self.lblPageTitle?.text = "SELECT COVERAGE"
        }else if ((type == "securityQuestion1") || (type == "securityQuestion2") || (type == "securityQuestion3")) {
            self.lblPageTitle?.text = "SELECT QUESTION"
        }else if type == "choose_subject" {
            self.lblPageTitle?.text = "SELECT TYPE"
        }else if type == "plancode" || type == "select_plancode" {
            self.lblPageTitle?.text = "SELECT PLAN CODE"
        }else if type == "Select Age"{
            self.lblPageTitle?.text = "Select Age"
        }else if type == "Select Pregnancy Status"{
            self.lblPageTitle?.text = "Select Pregnancy Status"
        }
        
    }
    
    // MARK: - TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.clear
        
        return vw
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isCustomObj){
            return arrData.count
        }else{
            return arrItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.black
        
        if(isCustomObj){
            var customBo = CustomObject()
            customBo = self.arrData[indexPath.row]
            cell.textLabel?.text = customBo.name
        }else{
            cell.textLabel?.text = self.arrItems[indexPath.row]
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(isCustomObj){
            self.delegate?.selectedObject!(obj: self.arrData[indexPath.row], type: type)
        }else{
            self.delegate?.selectedItem!(item: self.arrItems[indexPath.row], type: type)
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Service Call
    func GetProviderType(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getProviderTypeUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.getProviderTypeUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.GetProviderType()
                            }
                        })
                    }else{
                        self.arrData.removeAll()
                        if let dataRes = AppConstant.convertToDictionary(text: response.result.value!){
                            if let status = dataRes["Status"] as? String {
                                if(status == "1"){//success
                                    let data = dataRes["ProviderTypeList"] as! [[String: Any]]
                                    if(data.count > 0){
                                        for dict in data {
                                            let providerType = CustomObject()
                                            if let code = dict["REFCD"] as? String{
                                                providerType.code = code
                                                if let name = dict["FDESC"] as? String{
                                                    providerType.name = name
                                                }
                                                self.arrData.append(providerType)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        self.tblChoose.reloadData()
                    }
                    AppConstant.hideHUD()
                    break
                    
                case .failure(_):
                    AppConstant.hideHUD()
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func GetSpeciality(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getSpecialityUrl)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.getSpecialityUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.GetSpeciality()
                            }
                        })
                    }else{
                        self.arrData.removeAll()
                        if let dataRes = AppConstant.convertToDictionary(text: response.result.value!){
                            if let status = dataRes["Status"] as? String {
                                if(status == "1"){//success
                                    let data = dataRes["SpecialityList"] as! [[String: Any]]
                                    if(data.count > 0){
                                        for dict in data {
                                            let item = CustomObject()
                                            if let code = dict["Refcd"] as? String{
                                                item.code = code
                                                if let name = dict["Fdesc"] as? String{
                                                    item.name = name
                                                }
                                                self.arrData.append(item)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        self.tblChoose.reloadData()
                    }
                    AppConstant.hideHUD()
                    break
                    
                case .failure(_):
                    AppConstant.hideHUD()
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func PostState(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.postStateUrl)")
            let json = "{\"pstCtrycd\":\"\(self.CountryCode)\"}"
            print("Param = \(json)")
            let url = URL(string: AppConstant.postStateUrl)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField:"Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                AppConstant.hideHUD()
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.PostState()
                            }
                        })
                    }else{
                        self.arrData.removeAll()
                        if let dataRes = response.result.value as? [String: AnyObject]{
                            if let status = dataRes["Status"] as? String {
                                if(status == "1"){//success
                                    let data = dataRes["StateList"] as! [[String: Any]]
                                    if(data.count > 0){
                                        for dict in data {
                                            let item = CustomObject()
                                            if let code = dict["Statecd"] as? String{
                                                item.code = code
                                                if let name = dict["Fdesc"] as? String{
                                                    item.name = name
                                                }
                                                self.arrData.append(item)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        self.tblChoose.reloadData()
                    }
                    AppConstant.hideHUD()
                    break
                    
                case .failure(_):
                    AppConstant.hideHUD()
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
}

