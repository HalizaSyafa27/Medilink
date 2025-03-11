//
//  ViewHistoryListViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 29/02/2024.
//  Copyright © 2024 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class ViewHistoryListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var dashboardHistoryTableView: UITableView!
    @IBOutlet var imgViewHeader: UIImageView!
    
    var className:String = ""
    var pageTitle:String = ""
    var strHeaderImageName:String = ""
    var planCode:String = ""
    var cardNo:String = ""
    var dashboardHistoryModelList = [DashboardHistoryModel]()
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
        self.imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        self.serviceCallToGetPostDashboardHistory()
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dashboardHistoryModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewHistoryListTableViewCell", for: indexPath) as! ViewHistoryListTableViewCell
        cell.selectionStyle = .none
        let dataItem = dashboardHistoryModelList[indexPath.row]
        cell.lblDate.text = dataItem.DataCaptureDt
        cell.lblWeight.text = dataItem.Weight
        cell.lblBMI.text = dataItem.Bmi
        cell.lblBodyFat.text = dataItem.Fat
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dataSelected = dashboardHistoryModelList[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewHistoryDetailViewController") as! ViewHistoryDetailViewController
        vc.strHeaderImageName = self.strHeaderImageName
        vc.className = self.className
        vc.pageTitle = self.pageTitle
        vc.dashboardHistoryModel = dataSelected
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Button Action
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Service Call Methods
    func serviceCallToGetPostDashboardHistory(){
        if AppConstant.hasConnectivity(){//true connected
            AppConstant.showHUD()
            
            let date = NSDate() // Get Todays Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let stringDate: String = dateFormatter.string(from: date as Date)
            
            let params: Parameters = ["pstUsrID": AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId),
                                      "pdtDataCaptureDt": stringDate]
            let url = AppConstant.postDashboardHistory
            print("params===\(params)")
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
                                        self.serviceCallToGetPostDashboardHistory()
                                    }
                                })
                            }else{
                                let dict = response.result.value! as! [String: Any]
                                
                                if let status = dict["Status"] as? String {
                                    if status == "0"{
                                        let msg = dict["Message"] as? String
                                        self.displayAlert(message: msg ?? "")
                                    }else if status == "1"{//success
                                        self.dashboardHistoryModelList.removeAll()
                                        if let arrDashboardList = dict["DataboardList"] as? [[String: String]]{
                                            if arrDashboardList.count > 0 {
                                                for dict in arrDashboardList{
                                                    let item = DashboardHistoryModel()
                                                    if let Weight = dict["Weight"]{
                                                        item.Weight = Weight != "" ? Weight : "0.0"
                                                    }else{
                                                        item.Weight = "0.0"
                                                    }
                                                    if let Bmi = dict["Bmi"]{
                                                        item.Bmi = Bmi != "" ? Bmi : "0.0"
                                                    }else{
                                                        item.Bmi = "0.0"
                                                    }
                                                    if let Fat = dict["Fat"]{
                                                        item.Fat = Fat == "" || Fat == "%" || Fat == "null%" ? "0%" : Fat
                                                    }else{
                                                        item.Fat = "0%"
                                                    }
                                                    if let DataCaptureDt = dict["DataCaptureDt"]{
                                                        item.DataCaptureDt = DataCaptureDt != "" ? DataCaptureDt : "0.0"
                                                    }else{
                                                        item.DataCaptureDt = "0.0"
                                                    }
                                                    if let Age = dict["Age"]{
                                                        item.Age = Age != "" ? Age : "0"
                                                    }else{
                                                        item.Age = "0"
                                                    }
                                                    if let Height = dict["Height"]{
                                                        item.Height = Height != "" ? Height : "0.0"
                                                    }else{
                                                        item.Height = "0.0"
                                                    }
                                                    if let WalkingDistanceToday = dict["WalkingDistanceToday"]{
                                                        item.WalkingDistanceToday = WalkingDistanceToday != "" ? WalkingDistanceToday : "0"
                                                    }else{
                                                        item.WalkingDistanceToday = "0"
                                                    }
                                                    if let Temperature = dict["Temperature"]{
                                                        item.Temperature = Temperature != "" ? Temperature : "0.0"
                                                    }else{
                                                        item.Temperature = "0.0"
                                                    }
                                                    if let CalBurnied = dict["CalBurnied"]{
                                                        item.CalBurnied = CalBurnied != "" ? CalBurnied : "0.0"
                                                    }else{
                                                        item.CalBurnied = "0.0"
                                                    }
                                                    if let BloodPressure = dict["BloodPressure"]{
                                                        item.BloodPressure = BloodPressure != "" ? BloodPressure : "0.0"
                                                    }else{
                                                        item.BloodPressure = "0.0"
                                                    }
                                                    if let TotalSleep = dict["TotalSleep"]{
                                                        item.TotalSleep = TotalSleep != "" ? TotalSleep : "0h 0m"
                                                    }else{
                                                        item.TotalSleep = "0h 0m"
                                                    }
                                                    if let LightSleep = dict["LightSleep"]{
                                                        item.LightSleep = LightSleep != "" ? LightSleep : "0h 0m"
                                                    }else{
                                                        item.LightSleep = "0h 0m"
                                                    }
                                                    if let DeepSleep = dict["DeepSleep"]{
                                                        item.DeepSleep = DeepSleep != "" ? DeepSleep : "0h 0m"
                                                    }else{
                                                        item.DeepSleep = "0h 0m"
                                                    }
                                                    if let FlightsClimbToday = dict["FlightsClimbToday"]{
                                                        item.FlightsClimbToday = FlightsClimbToday != "" ? FlightsClimbToday : "0"
                                                    }else{
                                                        item.FlightsClimbToday = "0"
                                                    }
                                                    if let StepsToday = dict["StepsToday"]{
                                                        item.StepsToday = StepsToday != "" ? StepsToday : "0"
                                                    }else{
                                                        item.StepsToday = "0"
                                                    }
                                                    if let HeartRate = dict["HeartRate"]{
                                                        item.HeartRate = HeartRate != "" ? HeartRate : "0"
                                                    }else{
                                                        item.HeartRate = "0"
                                                    }
                                                    if let HeartRateVariability = dict["HeartRateVariability"]{
                                                        item.HeartRateVariability = HeartRateVariability != "" ? HeartRateVariability : "0"
                                                    }else{
                                                        item.HeartRateVariability = "0"
                                                    }
                                                    if let DataCaptureDt = dict["DataCaptureDt"]{
                                                        item.DataCaptureDt = DataCaptureDt != "" ? DataCaptureDt : "NA"
                                                    }else{
                                                        item.DataCaptureDt = "NA"
                                                    }
                                                    if let BloodGlucose = dict["BloodGlucose"]{
                                                        item.BloodGlucose = BloodGlucose != "" ? BloodGlucose : "0.0"
                                                    }else{
                                                        item.BloodGlucose = "0.0"
                                                    }
                                                    self.dashboardHistoryModelList.append(item)
                                                }
                                            }
                                        }
                                        self.dashboardHistoryTableView.reloadData()
                                    }
                                }
                            }
                            
                            break
                        case .failure(_):
                            AppConstant.hideHUD()
                            AppConstant.showNetworkAlertMessage(apiName: url)
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

}
