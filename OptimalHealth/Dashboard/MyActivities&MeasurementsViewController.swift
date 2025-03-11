//
//  MyActivities&MeasurementsViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/09/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import HealthKit
import DatePickerDialog

struct BMICalculator {
let weightInKG: Double
let heightInCM: Double

init(weightInKG: String, heightInCM: String) {
    self.weightInKG = Double(weightInKG) ?? 0.0
    self.heightInCM = Double(heightInCM) ?? 0.0
}

func calcBmi() -> Double {
    return weightInKG / ((heightInCM / 100) * (heightInCM / 100))
}
}

@objc protocol UpdateDataDelegate: AnyObject {
    @objc optional func UpdateHealthData()
}

class MyActivities_MeasurementsViewController: BaseViewController, ChooseDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblPageHeader: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtFldDate: UITextField!
    @IBOutlet weak var txtFldAge: UITextField!
    @IBOutlet weak var txtFldWeight: UITextField!
    @IBOutlet weak var txtFldHeight: UITextField!
    @IBOutlet weak var txtFldGender: UITextField!
    @IBOutlet weak var txtFldBMI: UITextField!
    @IBOutlet weak var txtFldFat: UITextField!
    @IBOutlet weak var txtFldTemperature: UITextField!
    @IBOutlet weak var txtFldCaloriesBurned: UITextField!
    @IBOutlet weak var txtFldHeartRate: UITextField!
    @IBOutlet weak var txtFldHeartRateVariability: UITextField!
    @IBOutlet weak var txtFldBloodPressure: UITextField!
    @IBOutlet weak var txtFldBloodGlucoseLevel: UITextField!
    @IBOutlet weak var txtFldTotalSleepTime: UITextField!
    @IBOutlet weak var txtFldDeepSleepTime: UITextField!
    @IBOutlet weak var txtFldFlightsClimbed: UITextField!
    @IBOutlet weak var txtFldSteps: UITextField!
    @IBOutlet weak var txtFldWalkingRunningDistance: UITextField!
    
    var pageTitle = ""
    var strGender = ""
    var strDateOfBirth = ""
    var strEmployeeId = ""
    var strMemberControlNo = ""
    var strPayorCode = ""
    var strCorpCode = ""
    var strNationalId = ""
    var strDependentId = ""
    var strPdfBase64 = ""
    var dataSource = [CustomObject]()
    let arrGenderType = ["Male", "Female", "Other"]
    var planCode = ""
    var cardNo = ""
    weak var delegate: UpdateDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
        authorizeHealthKit()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        //self.lblPageHeader.text = pageTitle
        
        lblUserName.text = AppConstant.retrievFromDefaults(key: StringConstant.displayName) == "" ? AppConstant.retrievFromDefaults(key: StringConstant.name) : AppConstant.retrievFromDefaults(key: StringConstant.displayName)
        
        txtFldGender.text = strGender
    }
    
    //MARK: TextField Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
        for: UIControl.Event.editingChanged)
        self.view.layoutSubviews()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == txtFldWeight || textField == txtFldHeight) {
            BMICalculate()
        }
    }
    
    //MARK: BMI Calculation
    func BMICalculate(){
        guard let weightInKG = txtFldWeight.text,
            let heightInCM = txtFldHeight.text else {
                return
        }
        
        let cm = BMICalculator(weightInKG: weightInKG, heightInCM: heightInCM)
        let result = cm.calcBmi()
        
        if txtFldWeight.text != "" && txtFldHeight.text != ""{
            txtFldBMI.text = String(format: "%.02f", result)
        }else{
            txtFldBMI.text = ""
        }
        
    }
    
    //MARK: Heahth Kit Data
    func authorizeHealthKit() {
        HealthKitInterface.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                }else{
                    print(baseMessage)
                }
                
                return
            }
            print("HealthKit Successfully Authorized.")
            
        }
    }
    
    func updateHealthInfo(){
        if txtFldWeight.text != ""{
            writeToSaveWeight()
        }
        if txtFldHeight.text != ""{
            writeToSaveHeight()
        }
        if txtFldBMI.text != ""{
            writeToSaveBMI()
        }
        if txtFldFat.text != ""{
            writeToSaveFatPercentage()
        }
        if txtFldTemperature.text != ""{
            writeToSaveBodyTemperature()
        }
        if txtFldCaloriesBurned.text != ""{
            writeToSaveEnergyBurned()
        }
        if txtFldHeartRate.text != ""{
            writeToSaveHeartRate()
        }
        if txtFldHeartRateVariability.text != ""{
            writeToSaveHeartRateVariability()
        }
        if txtFldBloodPressure.text != ""{
            writeToSaveBloodPressure()
        }
        if txtFldBloodGlucoseLevel.text != ""{
            writeToSaveBloodGlucoseLevel()
        }
//        if txtFldTotalSleepTime.text != ""{
//            writeToSaveTotalSleepTime()
//        }
//        if txtFldDeepSleepTime.text != ""{
//            writeToSaveDeepSleepTime()
//        }
        if txtFldFlightsClimbed.text != ""{
            writeToSaveFlightClimbed()
        }
        if txtFldSteps.text != ""{
            writeToSaveSteps()
        }
        if txtFldWalkingRunningDistance.text != ""{
            writeToSaveWalkingRunningDistance()
        }
        
    }
    
    func writeToSaveWeight(){
        guard let weight = Int(txtFldWeight.text!) else {
            return
        }
        
        ProfileDataStore.saveWeight(bodyMass: weight, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveHeight(){
        //let height = (txtFldHeight.text! as NSString).integerValue
        guard let height = Int(txtFldHeight.text!) else {
            return
        }
        ProfileDataStore.saveHeight(height: height, date: Date()) { (error) in
            print(error as Any)
        }
    }
    
    func writeToSaveBMI(){
        guard let bodyMassIndex = Double(txtFldBMI.text!) else {
            return
        }
        
        ProfileDataStore.saveBodyMassIndexSample(bodyMassIndex: bodyMassIndex, date: Date())
        
    }
    
    func writeToSaveSteps(){
        guard let value = Int(txtFldSteps.text!) else {
            return
        }
        
        ProfileDataStore.saveSteps(stepsCountValue: value, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveFlightClimbed(){
        guard let value = Int(txtFldFlightsClimbed.text!) else {
            return
        }
        
        ProfileDataStore.saveFlightClimbed(flightClimbed: value, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveWalkingRunningDistance(){
        guard let distance = Double(txtFldWalkingRunningDistance.text!) else {
            return
        }
        
        ProfileDataStore.saveWalkingAndRunningDistance(distanceWalkingRunning: distance, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveEnergyBurned(){
        guard let energyBurned = Int(txtFldFat.text!) else {
            return
        }
        
        ProfileDataStore.saveEnergyBurned(energyBurned: energyBurned, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveFatPercentage(){
        guard let fat = Double(txtFldFat.text!) else {
            return
        }
        
        ProfileDataStore.saveFatPercentage(fatPercentage: fat, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveHeartRate(){
        guard let heartRate = Double(txtFldHeartRate.text!) else {
            return
        }
        
        ProfileDataStore.saveHeartRate(heartRate: heartRate, date: Date())
        
    }
    
    func writeToSaveHeartRateVariability(){
        guard let heartRateVariability = Double(txtFldHeartRateVariability.text!) else {
            return
        }
        
        ProfileDataStore.saveHeartRateVariability(heartRateVariability: heartRateVariability, date: Date())
        
    }
    
    func writeToSaveBodyTemperature(){
        guard let temp = Double(txtFldTemperature.text!) else {
            return
        }
        
        ProfileDataStore.saveBodyTemperature(temp: temp, date: Date()) { (error) in
            print(error as Any)
        }
    }
    
    func writeToSaveBloodPressure(){
        let myStringArr = txtFldBloodPressure.text?.components(separatedBy: "/")
        if myStringArr!.count < 2{
            return
        }
        
        guard let systolic = Int(myStringArr![0]),
              let diastolic = Int(myStringArr![1]) else {
            return
        }
        
        ProfileDataStore.saveBloodPressureMeasurement(systolic: systolic, diastolic: diastolic, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveBloodGlucoseLevel(){
        guard let bloodGlucose = Double(txtFldBloodGlucoseLevel.text ??  "") else {
            return
        }
        
        ProfileDataStore.saveBloodGlucoseMeasurement(bloodGlucose: bloodGlucose, date: Date()) { (error) in
            print(error as Any)
        }
        
    }
    
    func writeToSaveTotalSleepTime(){
        guard let totalSleep = Int(txtFldTotalSleepTime.text!) else {
            return
        }
        
        ProfileDataStore.saveTotalSleepData(sleepAnalysis: totalSleep, startDate: Date(), endDate: Date())
    }
    
    func writeToSaveDeepSleepTime(){
        guard let deepSleep = Int(txtFldDeepSleepTime.text!) else {
            return
        }
        
        ProfileDataStore.saveDeepSleepData(sleepAnalysis: deepSleep, startDate: Date(), endDate: Date())
    }
    
    //MARK: Button Actions
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Activity Date"
        
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.txtFldDate.text = dateFormatter.string(from: dt)
            }
        }
    }
    
    @IBAction func btnSelectGenderAction(_ sender: Any) {
        self.view.endEditing(true)
        self.performSegue(withIdentifier: "gender", sender: self)
    }
    
    @IBAction func btnTotalSleepTimeAction(_ sender: Any) {
        let timePicker = TimeIntervalPicker()
        timePicker.titleString = "Select Total Sleep Time: (HH:MM)"
        timePicker.maxMinutes = 1440 //24 Hr
        timePicker.completion = { (timeInterval) in
            print(timeInterval)
            let hour = Int(timeInterval) / 3600
            let min = Int(timeInterval) / 60 % 60
            self.txtFldTotalSleepTime.text = "\(hour)h \(min)m"
        }
        timePicker.show(at: 0)
    }
    
    @IBAction func btnDeepSleepTimeAction(_ sender: Any) {
        let timePicker = TimeIntervalPicker()
        timePicker.titleString = "Select Deep Sleep Time: (HH:MM)"
        timePicker.maxMinutes = 1440 //24 Hr
        timePicker.completion = { (timeInterval) in
            print(timeInterval)
            let hour = Int(timeInterval) / 3600
            let min = Int(timeInterval) / 60 % 60
            self.txtFldDeepSleepTime.text = "\(hour)h \(min)m"
        }
        timePicker.show(at: 0)
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        checkValidation()
    }
    
    //MARK: Validation Method
    func checkValidation() {
        var errMessage: String?
        
        if txtFldDate.text == ""{
            errMessage = StringConstant.dateValidationMsg
        }else if txtFldAge.text == ""{
            errMessage = StringConstant.ageValidationMsg
        }else if txtFldWeight.text == ""{
            errMessage = StringConstant.weightValidationMsg
        }else if txtFldHeight.text == ""{
            errMessage = StringConstant.heightValidationMsg
        }else if txtFldGender.text == ""{
            errMessage = StringConstant.genderValidationMsg
        }
        
        if errMessage != nil{
            self.displayAlert(message: errMessage!)
        }else{
            self.serviceCallToUpdateHealthDataToServer()
        }
    }
    
    //MARK: Service Call Method
    func serviceCallToUpdateHealthDataToServer() {
        if (AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let userName = AppConstant.retrievFromDefaults(key: StringConstant.name)
            
            var gender = ""
            if txtFldGender.text == "Male"{
                gender = "M"
            }else if txtFldGender.text == "Female"{
                gender = "F"
            }else if txtFldGender.text == "Other"{
                gender = "O"
            }
            
            let date = NSDate() // Get Todays Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let stringTodayDate: String = dateFormatter.string(from: date as Date)
            
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
            
            let params: Parameters = [
                "pstUsrID": AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId),
                "pstCardNo": userType == "2" ? "0" : cardNo,
                "pstName": userName,
                "pstPlancode": planCode,
                "pstBmi": txtFldBMI.text!,
                "pstFat": "\(txtFldFat.text!)%",
                "pstCalBurnied": "\(txtFldCaloriesBurned.text!) cal",
                "pstAge": txtFldAge.text!,
                "pstWalkingDistanceToday": "\(txtFldWalkingRunningDistance.text!) km",
                "pstStepsToday": txtFldSteps.text!,
                "pstGender": gender,
                "pstBloodPressure": txtFldBloodPressure.text!,
                "pstBloodGlucose": txtFldBloodGlucoseLevel.text!,
                "pstHeartRate": "\(txtFldHeartRate.text!) bpm",
                "pstHeight": "\(txtFldHeight.text!) cm",
                "pstHeartRateVariability": "\(txtFldHeartRateVariability.text!) ms",
                "pstTotalSleep": txtFldTotalSleepTime.text!,
                "pstWeight": "\(txtFldWeight.text!) kg",
                "pstTemperature": txtFldTemperature.text!,
                "pstFlightsClimbToday": txtFldFlightsClimbed.text!,
                "pstDeepSleep": txtFldDeepSleepTime.text!,
                "pdtDataCaptureDt": txtFldDate.text!
            ]
            
            let url = AppConstant.updateDashboardHealthDataUrl
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
                                        self.serviceCallToUpdateHealthDataToServer()
                                    }
                                })
                            }else{
                                let dict = response.result.value! as! [String: Any]
                                
                                if let status = dict["Status"] as? String {
                                    if(status == "0"){
                                        let msg = dict["Message"] as? String
                                        self.displayAlert(message: msg ?? "")
                                    }else  if(status == "1"){//success
                                        //If update for Today
                                        if self.txtFldDate.text == stringTodayDate {
                                            self.updateHealthInfo()
                                        }
                                                                           
                                        if let msg = dict["Message"] as? String{
                                            let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel) { action in
                                                //If update for Today
                                                if self.txtFldDate.text == stringTodayDate {
                                                    self.delegate?.UpdateHealthData?()
                                                }
                                                
                                                //Move to DashBoard Screen
                                                self.navigationController?.popViewController(animated: true)
                                                
                                            })
                                            alert.view.tintColor = AppConstant.themeRedColor
                                            self.present(alert, animated: true)
                                        }
                                        
                                    }
                                }else{
                                    AppConstant.showNetworkAlertMessage(apiName: url)
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
    func selectedItem(item: String, type: String) {
        if type == "gender"{
            strGender = item
            txtFldGender.text = item
        }
        
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gender" {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = false
            vc.arrItems = self.arrGenderType
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
