//
//  DashboardViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 07/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import HealthKit
import EventKit
import CoreMotion
import Alamofire
import WebKit

class DashboardViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, WKScriptMessageHandler, UpdateDataDelegate {
    
    @IBOutlet var imgViewProfile: UIImageView!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var webView: WKWebView!
    var pageTitle = ""
    var strHeaderImageName = ""
    
    private let userHealthProfile = UserHealthProfile()
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    var activityType = ""
    var inBedSeconds = 0
    var asleepSeconds = 0
    var lightSeconds = 0
    var arrHealthTipsDataArray = [HealthTipsBo]()
    var cardNo = ""
    var planCode = ""
    var arrStepCountLastWeek = [StepsBO]()
    var arrDistanceCountLastWeek = [WalkingRunningDistanceBO]()
    var arrHeartRateCountLastWeek = [HeartRateBo]()
    var arrHeartRateVariabilityCountLastWeek = [HeartRateVariabilityBo]()
    var arrFlightsClimbCountLastWeek = [FlightClimbCountBo]()
    var arrBodyTemperatureCountLastWeek = [BodyTemperatureBo]()
    var arrBloodPressureCountLastWeek = [BloodPressureBo]()
    var arrBodyFatPercentageCountLastWeek = [BodyFatBo]()
    var arrEnergyBurnedCountLastWeek = [EnergyBurnedBo]()
    
    var alertMessage: String = ""
    var dictHealthResponse = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
        self.authorizeHealthKit()
        //self.serviceCallToGetHealthTipsData()
        //getCalendarEvents()  needs to uncomment after test
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
//        startCountingSteps()
//        updateStepsCountLabelUsing(startDate: Date())
    }
    
    func initDesign(){
        
        self.webView = WKWebView(frame: .zero, configuration: AppConstant.webviewConfig())

        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.webView.scrollView.delegate = self
        webView.configuration.userContentController.add(self, name: "jsHandler")
        self.viewContainer.addSubview(webView)
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.height/2
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.width/2
        self.imgViewProfile.layer.borderWidth = 1.5
        self.imgViewProfile.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewProfile.clipsToBounds = true
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data) 
                imgViewProfile.image = image
            }
        }
        
        lblUserName.text = AppConstant.retrievFromDefaults(key: StringConstant.displayName) == "" ? AppConstant.retrievFromDefaults(key: StringConstant.name) : AppConstant.retrievFromDefaults(key: StringConstant.displayName)
        
        self.webView.isHidden = true
        self.lblPageHeader.text = pageTitle
        self.imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        AppConstant.showHUD()
        showDashboardData()
    }
    
    //MARK: My Activty Delegate Method
    func UpdateHealthData() {
        print("Delegate method called")
        self.serviceCallToGetDashBoardData(isShowAlert: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.viewContainer.bounds
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showDashboardData() {
        do {
            guard let filePath = Bundle.main.path(forResource: "index-dashboard", ofType: "html")
                else {
                    // File Error
                    print ("File reading error")
                    return
            }
            
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.isHidden = false
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
            
            // Send the location update to the page
//            self.webView.stringByEvaluatingJavaScript(from: "updateUserName('manas')")
        }
        catch {
            print ("File HTML error")
        }
    }
    
    //MARK: WKWebview Delegates
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //AppConstant.showHUD()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //AppConstant.hideHUD()
        
        webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none'")
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none'")
        webView.evaluateJavaScript("var elems = document.getElementsByTagName('a'); for (var i = 0; i < elems.length; i++) { elems[i]['href'] = 'javascript:(void)'; }")
        
        self.webView.isHidden = false
        print("webview did finish loading called")
        self.updatedataToHTML(dict: self.dictHealthResponse)
        //updatedataToHTML()
        //updateHealthTipsdataToHTML()
    }
    
    func webView(_ webView: WKWebView,
                     runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.view.tintColor = AppConstant.themeRedColor
        present(alert, animated: true)
        completionHandler()
    }

    func webView(_ webView: WKWebView,
                     runJavaScriptTextInputPanelWithPrompt prompt: String,
                     defaultText: String?,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            if let text = alert.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }

        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in

            completionHandler(nil)

        }))
          
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
        
    //        if ipad will crash on this do this (https://stackoverflow.com/questions/42772973/ios-wkwebview-javascript-alert-crashing-on-ipad?noredirect=1&lq=1):
    //        if let presenter = alertController.popoverPresentationController {
    //            presenter.sourceView = self.view
    //        }
    //
    //        self.present(alertController, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView,
                     runJavaScriptConfirmPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        alertController.view.tintColor = AppConstant.themeRedColor
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollView.setZoomScale(1.0, animated: false)
    }
    
    func loadInWebView(url: String){
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
    }
    
    //MARK: - JavaScript Handler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "jsHandler" {
            print(message.body)
            let str:String = message.body as! String
            switch str {
            case "Sync_healthdata":
                 self.serviceCallToUpdateHealthDataToServer(isShowAlert: true)
                break
            case "Enter_healthdata":
                self.performSegue(withIdentifier: "enterMyActivities&Measurement", sender: self)
                break
            case "ViewHistory_healthdata":
                self.performSegue(withIdentifier: "ViewHistoryList", sender: self)
                break
            default:
                break
            }
        }
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
             scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    func updatedataToHTML(dict: [String: String]){
        if dict.count == 0 {
            return
        }
        for step in arrStepCountLastWeek{
            print("Step count \(step.value) == \(step.valueTitle) == \(step.endDate)")
        }
        
//        for distance in arrDistanceCountLastWeek{
//            print("Distance count \(distance.distanceInKm) == \(distance.endDate)")
//        }
        
        //1 step = 0.000762 km
        var stepsInKm = 0.0
        if dict["StepsToday"] != ""{
            if let dblStepsinKm = Double(dict["StepsToday"]!){
                stepsInKm = (Double(dblStepsinKm)) * 0.000762
            }
        }
        
        lightSeconds = (inBedSeconds - asleepSeconds)
        let minutes = (Int(lightSeconds) / 60) % 60
        let hours = Int(lightSeconds) / 3600
        self.userHealthProfile.lightSleepTime = "\(hours)h \(minutes)m"
        print("Manasm")
        var gender = 1
        if let genderData = dict["Gender"]{
            if genderData == "N"{
                gender = 0
            }else if genderData == "M"{
                gender = 1
            }else if genderData == "F"{
                gender = 2
            }else if genderData == "O"{
                gender = 3
            }
        }
        var  doubleHeight = 0.0
        
        if let height = dict["Height"]{
            if height != ""{
                let hgt = height.replacingOccurrences(of: "cm", with: "").trim()
                if let dblHeight = Double(hgt){
                    doubleHeight = Double(dblHeight)
                }
            }
        }
        
        
        let weight = dict["Weight"]!.replacingOccurrences(of: "kg", with: "")
        
        var  doubleTemp = 0.0
        if let temperature = dict["Temperature"]{
            if temperature != ""{
                let temp = temperature.trim()
                if let dblTemp = Double(temp){
                    doubleTemp = Double(dblTemp)
                }
            }
        }
        
        var  doublewalkingDistance = 0.0
        if let walkingDistance = dict["WalkingDistanceToday"]{
            if walkingDistance != ""{
                let distance = walkingDistance.replacingOccurrences(of: "km", with: "").trim()
                if let dblDist = Double(distance){
                    doublewalkingDistance = Double(dblDist)
                }
            }
        }
        
        let inputPayload = ["age": dict["Age"] == "" ? "0" : dict["Age"]!,
                            "weight": dict["Weight"] == "" ? "0" : weight,
                            "height": dict["Height"] == "" ? "0" : String(format: "%.2f", doubleHeight),
                            "bmi": dict["Bmi"] == "" ? "0.0" : dict["Bmi"]!,
                            "fat": dict["Fat"] == "" || dict["Fat"] == "%" || dict["Fat"] == "null%" ? "0%" : dict["Fat"]!,
                            "temperature": dict["Temperature"] == "" ? "0" : String(format: "%.01f", doubleTemp),
                            "cal_burned": dict["CalBurnied"] == "" || dict["CalBurnied"] == " cal" || dict["CalBurnied"] == "null cal" ? "0 cal" : dict["CalBurnied"]!,
                            "heart_rate": dict["HeartRate"] == "" || dict["HeartRate"] == " bpm" || dict["HeartRate"] == "null bpm" ? "0 bpm" : dict["HeartRate"]!,
                            "heart_rate_variability": dict["HeartRateVariability"] == "" || dict["HeartRateVariability"] == " ms" || dict["HeartRateVariability"] == "null ms" ? "0 ms" : dict["HeartRateVariability"]!,
                            "total_sleep": dict["TotalSleep"] == "" ? "0h 0m" : dict["TotalSleep"]!,
                            "deep_sleep": dict["DeepSleep"] == "" ? "0h 0m" : dict["DeepSleep"]!,
                            "light_sleep": dict["LightSleep"] == "" ? "0h 0m" : dict["LightSleep"]!,
                            "steps_today": dict["StepsToday"] == "" ? "0" : dict["StepsToday"]!,
                            "flights_climbed_today": dict["FlightsClimbToday"] == "" ? "0" : dict["FlightsClimbToday"]!,
                            "walking_running_distance_today": doublewalkingDistance == 0.0 ? String(format: "%.2f km", stepsInKm) : String(format: "%.2f km", doublewalkingDistance),
                            "steps_today_in_km": String(format: "%.2f km", stepsInKm),
                            "blood_pressure": dict["BloodPressure"] == "" ? "0/0" : dict["BloodPressure"]!,
                            "gender": gender, "blood_glucose": dict["BloodGlucose"] == "" ? "0.0" : dict["BloodGlucose"]
            ] as [String : Any]
        print("InputData == \(inputPayload)")
        
        let serializedData = try! JSONSerialization.data(withJSONObject: inputPayload, options: [])
        let encodedData = String(data: serializedData, encoding: String.Encoding.utf8)
        print(inputPayload.description)
        
        var arrPayLoad = [[String: Any]]()
        
        for stpData in arrStepCountLastWeek{
            let dict = ["y": stpData.valueTitle,
                        "a": stpData.value
                ] as [String : Any];
            arrPayLoad.append(dict)
        }
        
        arrPayLoad = arrPayLoad.reversed()
        
        let serializedData1 = try! JSONSerialization.data(withJSONObject: arrPayLoad, options: [])
        let encodedData1 = String(data: serializedData1, encoding: String.Encoding.utf8)
        print("Payload === \(arrPayLoad.description)")
        
        DispatchQueue.main.async{
            self.webView.evaluateJavaScript("sendUserHealthDataDictionary('\(encodedData!)')", completionHandler: nil)
            self.webView.evaluateJavaScript("getstepdata('\(encodedData1!)')", completionHandler: nil)
            //self.webView.stringByEvaluatingJavaScript(from: "sendUserHealthDataDictionary('\(encodedData1!)')")
        }
        
    }
    
    func updateHealthTipsdataToHTML(){
        var arrHealthtips = [[String:Any]]()
        arrHealthtips.removeAll()
        for tipsBo in arrHealthTipsDataArray {
            let inputPayload = ["htmlPath": tipsBo.htmlPath!,
                                "lastEditDate": tipsBo.lastEditDate!,
                                "title": tipsBo.title!,
                                "shortDesc": tipsBo.shortDesc!,
                                "imagePath": tipsBo.imagePath!
                ] as [String : Any]

            arrHealthtips.append(inputPayload)
        }


        let serializedData = try! JSONSerialization.data(withJSONObject: arrHealthtips, options: [])
        let encodedData = String(data: serializedData, encoding: String.Encoding.utf8)
        print("Health Tips Data: \(arrHealthtips.description) ===== count \(arrHealthtips.count)")
        DispatchQueue.main.async{
            self.webView.evaluateJavaScript("sendHealthTipsArray('\(encodedData!)')", completionHandler: nil)
            //self.webView.stringByEvaluatingJavaScript(from: "sendHealthTipsArray('\(encodedData!)')")
        }
    }
    
    func showPermissionError() {
        //No Heart Rate Data Found", message: "There was no heart rate data found for the selected dates. If you expected to see data, it may be that ARTRate is not authorised to read you heart rate data.
        let alert = UIAlertController(title: "Seems that you have not allow the permissions. Please go to the settings app (Privacy -> HealthKit) to change this.", message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
    }
    
    func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: Heahth Kit Data
    func authorizeHealthKit() {
        
        HealthKitInterface.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                AppConstant.hideHUD()
                return
            }
            
            self.updateHealthInfo()
            print("HealthKit Successfully Authorized.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                //self.updatedataToHTML()
                //Upload Health Data To Server
                self.serviceCallToUpdateHealthDataToServer(isShowAlert: false)
            }
            
        }
        
    }
    
    
    private func updateHealthInfo() {
        loadAndDisplayAgeSexAndBloodType()
        loadAndDisplayMostRecentWeight()
        loadAndDisplayMostRecentHeight()
        loadAndDisplayTodayStepCount()
        loadAndDisplayTodayFlightClimbCount()
        loadAndDisplayTodayWalkingAndRunningDistance()
        loadAndDisplayMostRecentBodyTemperature()
        loadAndDisplayMostRecentBodyFatPercentage()
        //ProfileDataStore.retrieveSleepAnalysis()
        //ProfileDataStore.readHeartRateData()
        loadAndDisplayMostRecentHeartRate()
        loadAndDisplayMostRecentHeartRateVariability()
        loadAndDisplayMostRecentEnergyBurned()
        //retrieveSleepAnalysis() //old
        //retrieveYesterdaySleepAnalysisData()
        loadAndDisplayMostRecentBloodPressure()
        loadAndDisplayMostRecentSleepData()
        
        
        arrStepCountLastWeek.removeAll()
        let arrlast7Days = Date.getDates(forLastNDays: 6)
        debugPrint("Last 7 days === \(arrlast7Days)")
        
        let weeklyStepBo = StepsBO()
        weeklyStepBo.endDate = Date().string(format: StringConstant.dateFormatter9)
        weeklyStepBo.valueTitle = "Today"//Date().string(format: StringConstant.dateFormatter12)
        arrStepCountLastWeek.append(weeklyStepBo)
        
        for dates in arrlast7Days{
            let weeklyStepBo = StepsBO()
            weeklyStepBo.endDate = dates
            weeklyStepBo.valueTitle = AppConstant.formattedDateFromString(dateString: dates, withFormat: StringConstant.dateFormatter9, ToFormat: StringConstant.dateFormatter12)
            arrStepCountLastWeek.append(weeklyStepBo)
        }
        
//        ProfileDataStore.getStepCount(type: "yearly", duration: -7) { (arrSteps) in
//            print("Yearly Step count = \(arrSteps.count)")
//        }
//
//        ProfileDataStore.getStepCount(type: "monthly", duration: -12) { (arrSteps) in
//            print("Monthly Step count = \(arrSteps.count)")
//        }
        
        ProfileDataStore.getStepCount(type: "weekly", duration: -6) { (arrSteps) in
            print("Weekly Step count = \(arrSteps.count)")
            
            for stp in arrSteps{
                for stp1 in self.arrStepCountLastWeek {
                    if stp.startDate == stp1.endDate{
                        stp1.value = stp.value
                        //stp1.startDate = stp.startDate
                    }
                }
            }
        }
        
//        ProfileDataStore.getWalkingRunningDistance(type: "yearly", duration: -7) { (arrDistance) in
//            print("Yearly distance covered = \(arrDistance.count)")
//        }
        
//        ProfileDataStore.getWalkingRunningDistance(type: "monthly", duration: -12) { (arrDistance) in
//            print("Monthly distance covered = \(arrDistance.count)")
//        }
        
        /*ProfileDataStore.getWalkingRunningDistance(type: "weekly", duration: -6) { (arrDistance) in
            print("Weekly distance covered = \(arrDistance.count)")

            for dst in arrDistance{
                for dst1 in self.arrDistanceCountLastWeek {
                    if dst.startDate == dst1.endDate{
                        dst1.distanceInKm = dst.distanceInKm
                    }
                }
            }
        }
        
        ProfileDataStore.getHeartRate(type: "weekly", duration: -6) { (arrHeartRate) in
            print("Weekly HeartRate count = \(arrHeartRate.count)")
            
            for hrt in arrHeartRate{
                for hrt1 in self.arrHeartRateCountLastWeek {
                    if hrt.startDate == hrt1.endDate{
                        hrt1.heartRate = hrt.heartRate
                    }
                }
            }
        }
        
        ProfileDataStore.getHeartRateVariability(type: "weekly", duration: -6) { (arrHeartRateVariability) in
            print("Weekly HeartRateVariability count = \(arrHeartRateVariability.count)")
            
            for hrt in arrHeartRateVariability{
                for hrt1 in self.arrHeartRateVariabilityCountLastWeek {
                    if hrt.startDate == hrt1.endDate{
                        hrt1.heartRateVariability = hrt.heartRateVariability
                    }
                }
            }
        }
        
        ProfileDataStore.getFlightsClimbed(type: "weekly", duration: -6) { (arrFlightsClimbed) in
            print("Weekly FlightsClimbed count = \(arrFlightsClimbed.count)")
            
            for flight in arrFlightsClimbed{
                for flight1 in self.arrFlightsClimbCountLastWeek {
                    if flight.startDate == flight1.endDate{
                        flight1.flightClimb = flight.flightClimb
                    }
                }
            }
        }
        
        ProfileDataStore.getBodyTemperature(type: "weekly", duration: -6) { (arrBodyTemperature) in
            print("Weekly BodyTemperature count = \(arrBodyTemperature.count)")
            
            for temp in arrBodyTemperature{
                for temp1 in self.arrBodyTemperatureCountLastWeek {
                    if temp.startDate == temp1.endDate{
                        temp1.temperature = temp.temperature
                    }
                }
            }
        }
        
        ProfileDataStore.getBloodPressure(type: "weekly", duration: -6) { (arrBloodPressure) in
            print("Weekly BloodPressure count = \(arrBloodPressure.count)")
            
            for bp in arrBloodPressure{
                for bp1 in self.arrBloodPressureCountLastWeek {
                    if bp.startDate == bp1.endDate{
                        bp1.bpSystolic = bp.bpSystolic
                        bp1.bpDiastolic = bp.bpDiastolic
                    }
                }
            }
        }
        
        ProfileDataStore.getBodyFatPercentage(type: "weekly", duration: -6) { (arrBodyFat) in
            print("Weekly BodyFatPercentage count = \(arrBodyFat.count)")

            for fat in arrBodyFat{
                for fat1 in self.arrBodyFatPercentageCountLastWeek {
                    if fat.startDate == fat1.endDate{
                        fat1.bodyFatPercentage = fat.bodyFatPercentage
                    }
                }
            }
        }
        
        ProfileDataStore.getActiveEnergyBurnedCount(type: "weekly", duration: -6) { (arrEnergyBurned) in
            print("Weekly ActiveEnergyBurned count = \(arrEnergyBurned.count)")

            for energy in arrEnergyBurned{
                for energy1 in self.arrEnergyBurnedCountLastWeek {
                    if energy.startDate == energy1.endDate{
                        energy1.energyBurned = energy.energyBurned
                    }
                }
            }
        }*/
        
        
//        ProfileDataStore.readBloodPressureDatewise()
//        ProfileDataStore.readHeartRateDatewise()
//        ProfileDataStore.readEnergyBurnedDatewise()
//        ProfileDataStore.readTempDatewise()
//        ProfileDataStore.readHeartRateVariabilityDatewise()
//        ProfileDataStore.sleepTime()
//        ProfileDataStore.readFlightClimnbedDatewise()
//        ProfileDataStore.readWalkingRunningDistanceDatewise()
    }
    
    private func loadAndDisplayAgeSexAndBloodType() {
        
        do {
            let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
            updateLabels()
        } catch let error {
            self.displayAlert(for: error)
        }
    }
    
    private func loadAndDisplayMostRecentWeight() {
        
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile.weightInKilograms = self.roundToPlaces(value: weightInKilograms, places: 2)
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentHeight() {
        
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                
                return
            }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.userHealthProfile.heightInMeters = heightInMeters
            
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentBodyTemperature() {
        
        //1. Use HealthKit to create the Height Sample Type
        guard let tempSampleType = HKSampleType.quantityType(forIdentifier: .bodyTemperature) else {
            print("Body temperature Sample Type is no longer available in HealthKit")
            
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: tempSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                
                return
            }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let tempInCelcius = sample.quantity.doubleValue(for: HKUnit.degreeCelsius())
            self.userHealthProfile.tempInCelcius = tempInCelcius
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentBodyFatPercentage() {
        
        //1. Use HealthKit to create the Height Sample Type
        guard let fatPercentageType = HKSampleType.quantityType(forIdentifier: .bodyFatPercentage) else {
            print("Body fat Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: fatPercentageType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                
                return
            }
            
            let fat =  sample.quantity.doubleValue(for: HKUnit.percent())
            self.userHealthProfile.bodyFatPercentage = fat * 100.0
            
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentHeartRate() {
        
        guard let heartRateSampleType = HKSampleType.quantityType(forIdentifier: .heartRate) else {
            print("Heart Rate Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heartRateSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            
            let heartRateUnit:HKUnit = HKUnit(from: "count/min")
            print("manas Heart Rate : \(sample.quantity.doubleValue(for: heartRateUnit))")
//            let heartRateUnit = HKUnit(fromString: "count/min")
//            var strBpm: String = sample.quantity
//            strBpm.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
            self.userHealthProfile.heartRate = Int(sample.quantity.doubleValue(for: heartRateUnit))
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentHeartRateVariability() {
        
        if #available(iOS 11.0, *) {
            guard let heartRateVariabilitySampleType = HKSampleType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
                print("Heart Rate Variability Sample Type is no longer available in HealthKit")
                return
            }
            
            ProfileDataStore.getMostRecentSample(for: heartRateVariabilitySampleType) { (sample, error) in
                
                guard let sample = sample else {
                    
                    if let error = error {
                        self.displayAlert(for: error)
                    }
                    return
                }
                let heartRateVariabilityUnit:HKUnit = HKUnit(from: "ms")
                print("manas Heart Rate Variability : \(sample.quantity.doubleValue(for: heartRateVariabilityUnit))")
                
                self.userHealthProfile.heartRateVariability = Int(sample.quantity.doubleValue(for: heartRateVariabilityUnit))
                self.updateLabels()
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    private func loadAndDisplayMostRecentBloodPressure() {
        
        guard let bloodPressureSystolSampleType = HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic) else {
            print("Blood Pressure Systolic Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: bloodPressureSystolSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            
            let bpSystolic:HKUnit = HKUnit(from: "mmHg")
            self.userHealthProfile.bpSystolic = Int(sample.quantity.doubleValue(for: bpSystolic))
            self.updateLabels()
        }
        
        guard let bloodPressureDiastolicSampleType = HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic) else {
            print("Blood Pressure Diastolic Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: bloodPressureDiastolicSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            
            let bpDiastolic:HKUnit = HKUnit(from: "mmHg")
            self.userHealthProfile.bpDiastolic = Int(sample.quantity.doubleValue(for: bpDiastolic))
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentEnergyBurned() {
        
        guard let energyBurnedType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Energy Burned data is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: energyBurnedType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            self.userHealthProfile.caloriesBurned = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
            self.updateLabels()
        }
    }
    
    func loadAndDisplayMostRecentSleepData() {
        let healthKitStore = HKHealthStore()
        // first, we define the object type we want
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            
            let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                                  end: Date(),
                                                                  options: .strictEndDate)
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                  ascending: false)
            
            let limit = 2
            let query = HKSampleQuery(sampleType: sleepType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    // something happened
                    return
                    
                }
                
                if let result = tmpResult {
                    
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                            print("Most Recent sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                            
                            if value == "InBed"{
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                self.inBedSeconds = Int(seconds)
                                let minutes = (Int(seconds) / 60) % 60
                                let hours = Int(seconds) / 3600
                                print("In bed: \(hours)h \(minutes)m")
                                self.userHealthProfile.totalSleepTime = "\(hours)h \(minutes)m"
                            }else{
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                self.asleepSeconds = Int(seconds)
                                let minutes = (Int(seconds) / 60) % 60
                                let hours = Int(seconds) / 3600
                                print("Asleep: \(hours)h \(minutes)m")
                                self.userHealthProfile.deepSleepTime = "\(hours)h \(minutes)m"
                            }
                            
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthKitStore.execute(query)
        }
    }
    
    func retrieveSleepAnalysis() {
        let healthKitStore = HKHealthStore()
        // first, we define the object type we want
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let now = Date()
            let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date.yesterday, options: .strictStartDate)
            
            // we create our query with a block completion to execute
            //let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    // something happened
                    return
                    
                }
                
                if let result = tmpResult {
                    
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                            
                            if value == "InBed"{
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                //self.inBedSeconds = Int(seconds)
                                let minutes = (Int(seconds) / 60) % 60
                                let hours = Int(seconds) / 3600
                                print("In bed: \(hours)h \(minutes)m")
                                //self.userHealthProfile.totalSleepTime = "\(hours)h \(minutes)m"
                            }else{
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                //self.asleepSeconds = Int(seconds)
                                let minutes = (Int(seconds) / 60) % 60
                                let hours = Int(seconds) / 3600
                                print("Asleep: \(hours)h \(minutes)m")
                                //self.userHealthProfile.deepSleepTime = "\(hours)h \(minutes)m"
                            }
                            
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthKitStore.execute(query)
        }
    }
    
    
    func retrieveYesterdaySleepAnalysisData() {
        let healthStore = HKHealthStore()
        
        // first, we define the object type we want
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        let now = Date()
        
        // we create a predicate to filter our data
        let predicate = HKQuery.predicateForSamples(withStart: Date.yesterday, end: now, options: .strictStartDate)

        // I had a sortDescriptor to get the recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        // we create our query with a block completion to execute
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            if error != nil {
                // handle error
                return
            }
            
            if let result = result {
                
                // do something with those data
                result
                    .compactMap({ $0 as? HKCategorySample })
                    .forEach({ sample in
                        guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                            return
                        }
                        
                        let isAsleep = sleepValue == .asleep
                        
                        print("HealthKit sleep \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                        
                        let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                        print("Yesterday sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                        
                        if value == "InBed"{
                            let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                            self.inBedSeconds = Int(seconds)
                            let minutes = (Int(seconds) / 60) % 60
                            let hours = Int(seconds) / 3600
                            print("In bed: \(hours)h \(minutes)m")
                            self.userHealthProfile.totalSleepTime = "\(hours)h \(minutes)m"
                        }else{
                            let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                            self.asleepSeconds = Int(seconds)
                            let minutes = (Int(seconds) / 60) % 60
                            let hours = Int(seconds) / 3600
                            print("Asleep: \(hours)h \(minutes)m")
                            self.userHealthProfile.deepSleepTime = "\(hours)h \(minutes)m"
                        }
                    })
            }
        }

        // finally, we execute our query
        healthStore.execute(query)
    }
    
    private func displayAlert(for error: Error) {
        print("wet \(error)")
    }
    func updateLabels(){
       // updatedataToHTML()
//        print("My age is \(userHealthProfile.age)")
//        if let biologicalSex = userHealthProfile.biologicalSex {
//            print("My gender is \(biologicalSex.stringRepresentation)")
//        }
//
//        if let bloodType = userHealthProfile.bloodType {
//            print("My blood type is \(bloodType.stringRepresentation)")
//        }
//
//        if let weight = userHealthProfile.weightInKilograms {
//            let weightFormatter = MassFormatter()
//            weightFormatter.isForPersonMassUse = true
//            print("My weight is \(weightFormatter.string(fromKilograms: weight))")
//        }
//
//        if let height = userHealthProfile.heightInMeters {
//            let heightFormatter = LengthFormatter()
//            heightFormatter.isForPersonHeightUse = true
//            print("My height is \(heightFormatter.string(fromMeters: height))")
//        }
//
//        if let temp = userHealthProfile.tempInCelcius {
//            print("My body temp is \(temp)")
//        }
//        if let fat = userHealthProfile.bodyFatPercentage {
//            print("My body fat percentage is \(Int(fat * 100))%")
//        }
//
//        if let bodyMassIndex = userHealthProfile.bodyMassIndex {
//            print("My bmi is \(String(format: "%.02f", bodyMassIndex))")
//        }
//        if let heartRate = userHealthProfile.heartRate {
//            print("My recent Heart rate is \(heartRate)")
//        }
//        if let calBurned = userHealthProfile.caloriesBurned {
//            print("My recent Calories burned is \(Int(calBurned)) kcal")
//        }
    }
    
    private func loadAndDisplayTodayStepCount() {
        
        ProfileDataStore.getTodaysSteps { (steps) in
            self.userHealthProfile.stepsToday = Int(steps)
            print("Today step count \(steps)")
        }
    }
    private func loadAndDisplayTodayFlightClimbCount() {
        
        ProfileDataStore.getTodaysFlightClimbed { (flights) in
            self.userHealthProfile.flightClimbToday = Int(flights)
            print("Today flight climbed count \(flights)")
        }
    }
    
    private func loadAndDisplayTodayWalkingAndRunningDistance() {
        
        ProfileDataStore.getTodaysWalkingAndRunningDistance { (distance) in
            
            let distanceInKm = distance/1000
            print("Today walking + running distnce \(distance) m")
            self.userHealthProfile.walkingRunningDistance = distanceInKm
            print("Today walking + running distnce \(distanceInKm) km")
        }
    }
    
    //MARK: - Calendar Events
    func getCalendarEvents(){
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            readEvents()
        case .denied:
            print("Access denied")
        case .notDetermined:
            
            eventStore.requestAccess(to: .event, completion: { (granted: Bool, NSError) -> Void in
                if granted {
                    self.readEvents()
                    
                }else{
                    print("Access denied")
                }
                
            })
        default:
            print("Case Default")
        }
    }
    
    func readEvents() {
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .event)
        
        for calendar in calendars {
            let oneMonthAgo = NSDate(timeIntervalSinceNow: -30*24*3600)
            let oneMonthAfter = NSDate(timeIntervalSinceNow: +30*24*3600)
            
            
            let predicate = eventStore.predicateForEvents(withStart: Date(), end: oneMonthAfter as Date, calendars: [calendar])
            
            var events = eventStore.events(matching: predicate)
            
            for event in events {
                print(event.title)
                print(event.startDate)
                print(event.endDate)
             }
        }
        
    }
    
    //MARK: Core Motion Methods
    private func updateStepsCountLabelUsing(startDate: Date) {
        pedometer.queryPedometerData(from: startDate, to: Date()) {
            [weak self] pedometerData, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    self?.updateHealthInfo()
                    self?.userHealthProfile.stepsToday = pedometerData.numberOfSteps.intValue
                    let stepsInKm = Double((self?.userHealthProfile.stepsToday)!) * 0.000762
                    
                    let inputPayload = [
                        "steps_today": "\(String(describing: self?.userHealthProfile.stepsToday))",
                        "steps_today_in_km": String(format: "%.02f km", stepsInKm)
                        ] as [String : Any]
                    
                    let serializedData = try! JSONSerialization.data(withJSONObject: inputPayload, options: [])
                    let encodedData = String(data: serializedData, encoding: String.Encoding.utf8)
                    self!.webView.evaluateJavaScript("sendUserStepsDataDictionary('\(encodedData!)')", completionHandler: nil)
                    //self?.webView.stringByEvaluatingJavaScript(from: "sendUserStepsDataDictionary('\(encodedData!)')")
                }
            }
        }
    }
    
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityType = "Walking"
                } else if activity.stationary {
                    self?.activityType = "Stationary"
                } else if activity.running {
                    self?.activityType = "Running"
                } else if activity.automotive {
                    self?.activityType = "Automotive"
                }
            }
        }
    }
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.updateHealthInfo()
                self?.userHealthProfile.stepsToday = pedometerData.numberOfSteps.intValue
                let stepsInKm = Double((self?.userHealthProfile.stepsToday)!) * 0.000762
                
                let inputPayload = [
                    "steps_today": "\(String(describing: self?.userHealthProfile.stepsToday))",
                    "steps_today_in_km": String(format: "%.02f km", stepsInKm)
                    ] as [String : Any]
                
                let serializedData = try! JSONSerialization.data(withJSONObject: inputPayload, options: [])
                let encodedData = String(data: serializedData, encoding: String.Encoding.utf8)
                self!.webView.evaluateJavaScript("sendUserStepsDataDictionary('\(encodedData!)')", completionHandler: nil)
                //self?.webView.stringByEvaluatingJavaScript(from: "sendUserStepsDataDictionary('\(encodedData!)')")
            }
        }
    }
    
    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        }
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
    }
    
    //MARK: Service Call Methods
    func serviceCallToGetHealthTipsData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            print("url===\(AppConstant.getHealthTipsUrl)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.getHealthTipsUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    // debugPrint(response)
                    //AppConstant.hideHUD()
                    
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetHealthTipsData()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    self.arrHealthTipsDataArray.removeAll()
                                    if let arrHealthData = dict!["HealthtipsList"] as? [[String:Any]]{
                                        for dict in arrHealthData{
                                            let healthTipssBo = HealthTipsBo()
                                            if let path = dict["FullPath"] as? String{
                                                healthTipssBo.htmlPath = path
                                            }else{
                                                healthTipssBo.htmlPath = ""
                                            }
                                            if let title = dict["Title"] as? String{
                                                healthTipssBo.title = title
                                            }else{
                                                healthTipssBo.title = ""
                                            }
                                            if let shortDesc = dict["ShortDesc"] as? String{
                                                healthTipssBo.shortDesc = shortDesc
                                            }else{
                                                healthTipssBo.shortDesc = ""
                                            }
                                            if let imagePath = dict["ImagePath"] as? String{
                                                healthTipssBo.imagePath = imagePath
                                            }else{
                                                healthTipssBo.imagePath = ""
                                            }
                                            if let lastDate = dict["LastEditDate"] as? String{
                                                healthTipssBo.lastEditDate = lastDate
                                            }else{
                                                healthTipssBo.lastEditDate = ""
                                            }
                                            self.arrHealthTipsDataArray.append(healthTipssBo)
                                        }
                                    }
                                    
                                    self.updateHealthTipsdataToHTML()
                                }else{
                                    AppConstant.hideHUD()
                                    if let msg = dict!["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                    }
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.hideHUD()
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    func serviceCallToUpdateHealthDataToServer(isShowAlert: Bool) {
        if (AppConstant.hasConnectivity()) {//true connected
            print("ManasDashboard")
            
            AppConstant.showHUD()
            
            let userName = AppConstant.retrievFromDefaults(key: StringConstant.name)
//            let userEmail = AppConstant.retrievFromDefaults(key: StringConstant.email)
//            let password = AppConstant.retrievFromDefaults(key: StringConstant.password)
//            let planCode = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            
            var gender = "N"
            if self.userHealthProfile.biologicalSex == HKBiologicalSex.notSet{
                gender = "N"
            }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.male{
                gender = "M"
            }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.female{
                gender = "F"
            }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.other{
                gender = "O"
            }
            let date = NSDate() // Get Todays Date
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let stringDate: String = dateFormatter.string(from: date as Date)
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)

            let params: Parameters = [
                "pstUsrID": AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId),
                //"pstPassword": password,
                "pstCardNo": userType == "2" ? "0" : cardNo,
                "pstName": userName,
                "pstPlancode": planCode,
                "pstBmi": String(format: "%.02f", userHealthProfile.bodyMassIndex!),
                "pstFat": "\(self.userHealthProfile.bodyFatPercentage)%",
                "pstCalBurnied": "\(Int(userHealthProfile.caloriesBurned)) cal",
                "pstAge": self.userHealthProfile.age,
                "pstWalkingDistanceToday": String(format: "%.02f km", userHealthProfile.walkingRunningDistance),
                "pstStepsToday": "\(self.userHealthProfile.stepsToday)",
                "pstGender": gender,
                "pstBloodPressure": "\(userHealthProfile.bpSystolic)" + "/" + "\(userHealthProfile.bpDiastolic)",
                "pstHeartRate": "\(userHealthProfile.heartRate) bpm",
                "pstHeight": "\(userHealthProfile.heightInMeters * 100) cm",
                "pstHeartRateVariability": "\(self.userHealthProfile.heartRateVariability) ms",
                "pstTotalSleep": userHealthProfile.totalSleepTime,
                "pstWeight": "\(userHealthProfile.weightInKilograms) kg",
                "pstTemperature": String(format: "%.01f", userHealthProfile.tempInCelcius),
                "pstFlightsClimbToday": String(format: "\(userHealthProfile.flightClimbToday)"),
                "pstDeepSleep": userHealthProfile.deepSleepTime,
                "pdtDataCaptureDt": stringDate
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
                    //AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToUpdateHealthDataToServer(isShowAlert: isShowAlert)
                                }
                            })
                        }else{
                            //  debugPrint(dict)
                            let dict = response.result.value! as! [String: Any]
                            
                            if let status = dict["Status"] as? String {
                                if(status == "0"){
                                    AppConstant.hideHUD()
                                    let msg = dict["Message"] as? String
                                    self.displayAlert(message: msg ?? "")
                                }else  if(status == "1"){//success
                                    self.serviceCallToGetDashBoardData(isShowAlert: isShowAlert)
                                    let msg = dict["Message"] as? String
                                    self.alertMessage = msg!
                                }
                            }else{
                                AppConstant.hideHUD()
                                AppConstant.showNetworkAlertMessage(apiName: url)
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
    
    func serviceCallToGetDashBoardData(isShowAlert: Bool){
        if AppConstant.hasConnectivity(){//true connected
            AppConstant.showHUD()
            
            let date = NSDate() // Get Todays Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let stringDate: String = dateFormatter.string(from: date as Date)
            
            let params: Parameters = ["pstUsrID": AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId),
                                      "pdtDataCaptureDt": stringDate]
            let url = AppConstant.dashBoardListUrl
            print("params===\(params)")
            print("url===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    //AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                        case .success(_):
                            let headerStatusCode : Int = (response.response?.statusCode)!
                            print("Status Code: \(headerStatusCode)")
                            
                            if(headerStatusCode == 401){//Session expired
                                self.isTokenVerified(completion: { (Bool) in
                                    if Bool{
                                        self.serviceCallToGetDashBoardData(isShowAlert: isShowAlert)
                                    }
                                })
                            }else{
                                if isShowAlert == false{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        AppConstant.hideHUD()
                                    }
                                }else{
                                    AppConstant.hideHUD()
                                }
                                
                                let dict = response.result.value! as! [String: Any]
                                
                                if let status = dict["Status"] as? String {
                                    if status == "0"{
                                        let msg = dict["Message"] as? String
                                        self.displayAlert(message: msg ?? "")
                                    }else if status == "1"{//success
                                        if isShowAlert == true{
                                            self.displayAlert(message: self.alertMessage)
                                        }
                                        
                                        if let arrDashboardList = dict["DataboardList"] as? [[String: String]]{
                                            if arrDashboardList.count > 0 {
                                                self.dictHealthResponse = arrDashboardList[0]
                                                self.updatedataToHTML(dict: arrDashboardList[0])
                                            }
                                            
                                        }
                                        
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
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    class func fractionDigits(min: Int = 2, max: Int = 2, roundingMode: NumberFormatter.RoundingMode = .halfEven, number: Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = min
        formatter.maximumFractionDigits = max
        formatter.roundingMode = roundingMode
        return formatter.string(for: number) ?? ""
    }
    
    //MARK: Memory Method
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterMyActivities&Measurement" {
            let vc = segue.destination as! MyActivities_MeasurementsViewController
            vc.pageTitle = "My Activities & Measurements"
            vc.planCode = self.planCode
            vc.cardNo = self.cardNo
            vc.delegate = self
        }
        else if segue.identifier == "ViewHistoryList" {
            let vc = segue.destination as! ViewHistoryListViewController
            vc.pageTitle = "History of My Activities & Measurements"
            vc.planCode = self.planCode
            vc.cardNo = self.cardNo
            vc.strHeaderImageName = self.strHeaderImageName
        }
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
