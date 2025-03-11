//
//  PanelProvidersViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/10/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class PanelProvidersViewController: BaseViewController , ChooseDelegate , CLLocationManagerDelegate {
    
    @IBOutlet weak var providerTypeBtn: UIButton!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var providerNameTf: UITextField!
    @IBOutlet weak var cityTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var postCodeTf: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var nearestSearchView: UIView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageTitleView: UIView!
    @IBOutlet var pageTitleViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var specialityBtn: UIButton!
    @IBOutlet weak var image24Hours: UIImageView!
    
    var providerTypeDataSource = [CustomObject]()
    var stateDataSource = [CustomObject]()
    var arrPanelProviders = [PanelProvidersBo]()
    var pageTitle = ""
    var selectedProviderType = ""
    var selectedProviderTypeCode = ""
    var selectedState = ""
    var selectedStateCode = ""
    var selectedSpeciality = ""
    var selectedSpecialityCode = ""
    var selectedViewTag : Int = 0
    var locationManager: CLLocationManager!
    var latitude: String?
    var longitude: String?
    var strHeaderImageName = ""
    var params: Parameters = [:]
    var url : String = ""
    var CountryCode:String = ""
    var isCheck24Hours:Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        initDesigns()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initDesigns()
    }
    
    func initDesigns() {
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        getCountry()
        pageTitleView.isHidden = true
        pageTitleViewHeightConstraint.constant = 0
 
        lblPageHeader?.text = pageTitle
        providerNameTf.setplaceHolderColor(placeholder: "Name")
        cityTf.setplaceHolderColor(placeholder: "City")
        addressTf.setplaceHolderColor(placeholder: "Address")
        postCodeTf.setplaceHolderColor(placeholder: "Postcode")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                latitude = nil
                longitude = nil
                AppConstant.saveInDefaults(key: StringConstant.latitude, value: "")
                AppConstant.saveInDefaults(key: StringConstant.longitude,value:"")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access location")
                
            }
        } else {
            latitude = nil
            longitude = nil
            AppConstant.saveInDefaults(key: StringConstant.latitude, value: "")
            AppConstant.saveInDefaults(key: StringConstant.longitude,value:"")
            
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.serviceCallToGetSearchPanelProviders(_sender:)))
        self.searchView.isUserInteractionEnabled = true
        self.searchView.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.serviceCallToGetSearchPanelProviders(_sender:)))
        self.nearestSearchView.isUserInteractionEnabled = true
        self.nearestSearchView.addGestureRecognizer(tapGesture1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func providerTypeBtnAction (_ sender: UIButton) {
        performSegue(withIdentifier: "provider_type", sender: self)
    }
    
    @IBAction func stateBtnAction (_ sender: UIButton) {
        performSegue(withIdentifier: "state", sender: self)
    }
    
    @IBAction func specialityAction(_ sender: UIButton) {
        performSegue(withIdentifier: "speciality", sender: self)
    }
    
    @IBAction func btnCheck24Hours (_ sender: UIButton) {
        isCheck24Hours = !isCheck24Hours
        image24Hours.image = isCheck24Hours == true ? UIImage.init(named: "checkbox_active")  : UIImage.init(named: "checkbox")
    }
    
    @objc func serviceCallToGetSearchPanelProviders(_sender: UIGestureRecognizer){
        let senderViewTag = _sender.view?.tag
        selectedViewTag = senderViewTag!
        print((providerTypeBtn?.titleLabel?.text)!)
        print(selectedViewTag)
        
        self.serviceCallToGetSearchPanelProviderList()
    }
    
    //MARK: Delegates method to choose data
    func selectedObject(obj: CustomObject, type: String) {
        if (type == "provider_type") {
            selectedProviderType = obj.name!
            selectedProviderTypeCode = obj.code!
            providerTypeBtn?.setTitle(selectedProviderType, for: .normal)
        }
        else if (type == "state") {
            selectedState = obj.name!
            selectedStateCode = obj.code!
            stateBtn?.setTitle(selectedState, for: .normal)
        }
        else if (type == "speciality") {
            selectedSpeciality = obj.name!
            selectedSpecialityCode = obj.code!
            specialityBtn?.setTitle(selectedSpeciality, for: .normal)
        }
    }
    
    //MARK: Delegates to get user current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        if(lat != 0.0 && long != 0.0){
            print(lat)
            print(long)
            latitude = String(lat)
            longitude = String(long)
            AppConstant.saveInDefaults(key: StringConstant.latitude, value: latitude!)
            AppConstant.saveInDefaults(key: StringConstant.longitude,value:longitude!)
            locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil;
            self.locationManager = nil;
            
        }
    }
    
    func showAlertForNoLocation(){
        let alert = UIAlertController(title: StringConstant.noLocationTitleMsg, message: StringConstant.noLocationDescMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
            
            if let url = URL(string:UIApplication.openSettingsURLString)
            {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Service Call
    func serviceCallToGetSearchPanelProviderList(){
        
        let latitude = AppConstant.retrievFromDefaults(key: StringConstant.latitude)
        let longitude = AppConstant.retrievFromDefaults(key: StringConstant.longitude)
        if ((selectedViewTag == 1) && (latitude == "")) {
            self.showAlertForNoLocation()
        }
//        else if((selectedViewTag == 0) && ((providerTypeBtn?.titleLabel?.text)! == "Select Provider")) {
//            self.displayAlert(message: "Please select provider")
//        }
        else if((selectedViewTag == 0) && ((stateBtn?.titleLabel?.text)! == "Select a State")) {
            self.displayAlert(message: "Please select state")
        }
        else{
            if(AppConstant.hasConnectivity()) {//true connected
                
                AppConstant.showHUD()
                let userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
                let cardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
                let planCode = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
                
                let providerName = self.providerNameTf?.text
                let city = self.cityTf?.text
                let address = self.addressTf?.text
                let postCode = self.postCodeTf?.text
                
                
                if (userType == "1") { // userType = 1
                    if (selectedViewTag == 0) { // Only Search
                        params = [
                            "pstCardNo": cardNo,
                            "pstplan": planCode,
                            "pstProviderType": selectedProviderTypeCode,
                            "pstState": selectedStateCode,
                            "pstProviderName": providerName!,
                            "pstCity": city!,
                            "pstAddress": address!,
                            "pstPostalCode": postCode!,
                            "pstSpeciality": selectedSpecialityCode,
                            "pstP24Hr" : isCheck24Hours == true ? "1" : "0"
                        ]
                        url = AppConstant.getMemberSearchPanelProviderUrl
                        print("params===\(params)")
                        print("url===\(url)")
                    }
                    else if (selectedViewTag == 1) { // Nearest Search
                        params = [
                            "pstCardNo": cardNo,
                            "pstplan": planCode,
                            "pstProviderType": selectedProviderTypeCode,
                            "pstLatitude" : latitude,
                            "pstLongitude" : longitude,
                            "pstKMRadius" : "5",
                            "pstSearchCriteria" : "",
                            "pstSpeciality": selectedSpecialityCode,
                            "pstP24Hr" : isCheck24Hours == true ? "1" : "0"
                        ]
                        url = AppConstant.getMemberNearestSearchPanelProviderUrl
                        print("params===\(params)")
                        print("url===\(url)")
                    }
                }
                else if (userType == "2") { // userType = 2
                    if (selectedViewTag == 0) { // Only Search
                        params = [
                            "pstCardNo": "0",
                            "pstProviderType": selectedProviderTypeCode,
                            "pstState": selectedStateCode,
                            "pstProviderName": providerName!,
                            "pstCity": city!,
                            "pstAddress": address!,
                            "pstPostalCode": postCode!,
                            "pstSpeciality": selectedSpecialityCode,
                            "pstP24Hr" : isCheck24Hours == true ? "1" : "0"
                        ]
                        url = AppConstant.getMemberSearchPanelProviderUrl
                        print("params===\(params)")
                        print("url===\(url)")
                    }
                    else if (selectedViewTag == 1) { // Nearest Search
                        params = [
                            "pstCardNo": "0",
                            "pstProviderType": selectedProviderTypeCode,
                            "pstLatitude" : latitude,
                            "pstLongitude" : longitude,
                            "pstKMRadius" : "5",
                            "pstSearchCriteria" : "",
                            "pstSpeciality": selectedSpecialityCode,
                            "pstP24Hr" : isCheck24Hours == true ? "1" : "0"
                        ]
                        url = AppConstant.getMemberNearestSearchPanelProviderUrl
                        print("params===\(params)")
                        print("url===\(url)")
                    }
                }
                else { // userType = 3
                    if (selectedViewTag == 0) { // Only Search
                        params = [
                            "pstCardNo": "null",
                            "pstProviderType": selectedProviderTypeCode,
                            "pstState": selectedStateCode,
                            "pstProviderName": providerName!,
                            "pstCity": city!,
                            "pstAddress": address!,
                            "pstPostalCode": postCode!,
                            "pstSpeciality": selectedSpecialityCode,
                            "pstP24Hr" : isCheck24Hours == true ? "1" : "0"
                        ]
                        url = AppConstant.getAgentSearchPanelProviderUrl
                        print("params===\(params)")
                        print("url===\(url)")
                    }
                    else if (selectedViewTag == 1) { // Nearest Search
                        params = [
                            "pstCardNo": "",
                            "pstProviderType": selectedProviderTypeCode,
                            "pstLatitude" : latitude,
                            "pstLongitude" : longitude,
                            "pstKMRadius" : "5",
                            "pstSearchCriteria" : "",
                            "pstSpeciality": selectedSpecialityCode,
                            "pstP24Hr" : isCheck24Hours == true ? "1" : "0"
                        ]
                        url = AppConstant.getAgentNearestSearchPanelProviderUrl
                        print("params===\(params)")
                        print("url===\(url)")
                    }
                }
                
                let headers: HTTPHeaders = [
                    "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                    "Accept": "application/json"
                ]
                
                print("Headers--- \(headers)")
                AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
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
                                        self.serviceCallToGetSearchPanelProviderList()
                                    }
                                })
                            }else{
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                if let status = dict?["Status"] as? String {
                                    if(status == "1"){//success
                                        
                                        self.arrPanelProviders.removeAll()
                                        if let dict_array = dict?["PanelProviderList"] as? [[String: Any]] {
                                          
                                            for item in dict_array {
                                                print(item)
                                                let panelProviders = PanelProvidersBo()
                                                if let providerName = item["Name"] as? String {
                                                    panelProviders.providerName = providerName
                                                }
                                                if let providerCode = item["provider_code"] as? String {
                                                    panelProviders.providerCode = providerCode
                                                }
                                                if let address = item["Address"] as? String {
                                                    panelProviders.address = address
                                                }
                                                if let city = item["City"] as? String {
                                                    panelProviders.city = city
                                                }
                                                if let state = item["State"] as? String {
                                                    panelProviders.state = state
                                                }
                                                if let postcode = item["Postcode"] as? String {
                                                    panelProviders.postCode = postcode
                                                }
                                                if let phoneNo1 = item["Tel_No1"] as? String {
                                                    panelProviders.phoneNo1 = phoneNo1
                                                }
                                                if let phoneNo2 = item["Tel_No2"] as? String {
                                                    panelProviders.phoneNo2 = phoneNo2
                                                }
                                                if let faxNo = item["Fax_No"] as? String {
                                                    panelProviders.faxNo = faxNo
                                                }
                                                if let workingHours = item["Operating_Hours"] as? String {
                                                    panelProviders.workingHours = workingHours
                                                }
                                                if let providerTypeCode = item["Provider_Type_Code"] as? String {
                                                    panelProviders.providerTypeCode = providerTypeCode
                                                }
                                                if let providerTypeDesc = item["Provider_Type_Desc"] as? String {
                                                    panelProviders.providerTypeDesc = providerTypeDesc
                                                }
                                                if let latitude = item["Latitude"] as? String {
                                                    panelProviders.latitude = latitude
                                                }
                                                if let longitude = item["Longitude"] as? String {
                                                    panelProviders.longitude = longitude
                                                }
                                                if let distance = item["Distance"] as? String {
                                                    panelProviders.distance = distance
                                                }else{
                                                    panelProviders.distance = ""
                                                }
                                                if let providerUrl = item["Provider_Url"] as? String {
                                                    panelProviders.providerUrl = providerUrl
                                                }
                                                if let logoUrl = item["Logo_Url"] as? String {
                                                    panelProviders.logoUrl = logoUrl
                                                }else{
                                                    panelProviders.logoUrl = ""
                                                }
                                                if let likeCount = item["likeCount"] as? Int {
                                                    panelProviders.likeCount = likeCount
                                                }
                                                if let disappointCount = item["DisappointCount"] as? Int {
                                                    panelProviders.disappointCount = disappointCount
                                                }
                                                if let likeStatus = item["Like"] as? Int {
                                                    panelProviders.likeStatus = likeStatus
                                                }
                                                if let star = item["Star"] as? Int {
                                                    panelProviders.star = star
                                                }
                                                if let rating = item["Rating"] as? Int {
                                                    panelProviders.rating = "\(rating)"
                                                }
                                                if let ratingCnt = item["RatingCnt"] as? Int {
                                                    panelProviders.ratingCnt = ratingCnt
                                                }
                                                self.arrPanelProviders.append(panelProviders)
                                            }
                                            
                                        }
                                        self.performSegue(withIdentifier: "search_lists", sender: self)
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg )
                                        }
                                    }
                                }else{
                                    AppConstant.showNetworkAlertMessage(apiName: self.url)
                                }
                            }
                            
                            break
                            
                        case .failure(_):
                            AppConstant.showNetworkAlertMessage(apiName: self.url)
                            break
                            
                        }
                }
                
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
        }
    }
    
    func getCountry(){
        self.CountryCode = ""
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getCountryV2Url)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.getCountryV2Url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.getCountry()
                            }
                        })
                    }else{
                        if let dataRes = AppConstant.convertToDictionary(text: response.result.value!){
                            if let status = dataRes["Status"] as? String {
                                if(status == "1"){//success
                                    let data = dataRes["CountryList"] as! [[String: Any]]
                                    if(data.count > 0){
                                        for dict in data {
                                            if let code = dict["Ctrycd"] as? String{
                                                self.CountryCode = code
                                            }
                                        }
                                    }
                                }
                            }
                        }
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
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "provider_type") {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = true
            return
        }
        else if (segue.identifier == "state") {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = true
            vc.CountryCode = self.CountryCode
            return
        }
        else if (segue.identifier == "speciality") {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = true
            return
        }
        else if (segue.identifier == "search_lists") {
            let vc = segue.destination as! SearchListsViewController
            vc.arrPanelProviders = arrPanelProviders
            vc.providerTypeName = selectedProviderType
            vc.strHeaderImageName = strHeaderImageName
            vc.params = params
            vc.url = url
            vc.pageHeader = pageTitle
            vc.pageHeaderImage = strHeaderImageName
            return
        }
    }
    
    
}

