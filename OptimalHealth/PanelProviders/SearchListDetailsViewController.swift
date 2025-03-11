//
//  SearchListDetailsViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/14/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

protocol PanelProviderDetailsDelegate: AnyObject {
    func updatePanelListData(panelBo: PanelProvidersBo, selectedIndex: Int)
}

class SearchListDetailsViewController: BaseViewController, FeedbackDelegate {
    
    @IBOutlet var providerType: UILabel!
    @IBOutlet var providerName: UILabel!
    @IBOutlet var addressName: UILabel!
    @IBOutlet var stateName: UILabel!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var phoneNoTitle: UIView!
    @IBOutlet var phoneNo: UILabel!
    @IBOutlet var faxNoTitle: UIView!
    @IBOutlet var faxNo: UILabel!
    @IBOutlet var workingHoursTitle: UIView!
    @IBOutlet var workingHours: UILabel!
    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var searchCallBtn: UIButton!
    @IBOutlet var appointmentTitle: UIView!
    @IBOutlet var btnViewMap: UIButton!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var addressHeightConstraint: NSLayoutConstraint!
    @IBOutlet var appointmentTitleHeight: NSLayoutConstraint!
    @IBOutlet var viewPhoneHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewFaxHeightConstraint: NSLayoutConstraint!
    @IBOutlet var workingHourHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewMapHeightCOnstraint: NSLayoutConstraint!
    
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var lblDisappointCount: UILabel!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnDisappoint: UIButton!
    @IBOutlet var imgViewLike: UIImageView!
    @IBOutlet var imgViewDisappoint: UIImageView!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewPageHeader: UIImageView!
    
    @IBOutlet weak var lblRatingCount: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var btnRating: UIButton!
    
    var selectedPanel = PanelProvidersBo()
    var arrPanelProviders = [PanelProvidersBo]()
    var providerTypeNameTitle = ""
    var strHeaderImageName = ""
    var params: Parameters = [:]
    var url: String = ""
    var selectedRow = 0
    weak var delegate : PanelProviderDetailsDelegate?
    var pageHeader = ""
    var pageHeaderImage = ""
    var strTitleImage = ""
    var className:String = ""
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
        
        providerType?.text = providerTypeNameTitle
        self.lblPageHeader.text = pageHeader
        self.imgViewPageHeader.image = UIImage.init(named: pageHeaderImage)
        setDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setDatas() {
        providerName?.text = selectedPanel.providerName
        addressName?.text = selectedPanel.address
        addressHeightConstraint.constant = selectedPanel.address.heightWithConstrainedWidth(width: addressName.frame.size.width, font: addressName.font)
        imgViewHeader.image = UIImage.init(named: strTitleImage)
        
        if selectedPanel.state == "" {
            stateName?.text = "STATE: NA"
        }else{
            stateName?.text = "STATE: " + selectedPanel.state
        }
        
        if selectedPanel.city == "" {
            cityName?.text = "CITY: NA"
        }else{
            cityName?.text = "CITY: " + selectedPanel.city
        }
        
        searchImageView?.sd_setImage(with: URL(string: selectedPanel.logoUrl), placeholderImage: UIImage(named: "search_list_red"))
        
        if (selectedPanel.phoneNo1 == "" && selectedPanel.phoneNo2 == "") {
            phoneNo.isHidden = true
            phoneNoTitle.isHidden = true
            appointmentTitle.isHidden = true
            appointmentTitleHeight.constant = 0
            viewPhoneHeightConstraint.constant = 0
            searchCallBtn.isHidden = true
        }else {
            phoneNo.isHidden = false
            phoneNoTitle.isHidden = false
            searchCallBtn.isHidden = false
            appointmentTitle.isHidden = true
            appointmentTitleHeight.constant = 0
            viewPhoneHeightConstraint.constant = 85
            phoneNo?.text = selectedPanel.phoneNo2 == "" ? selectedPanel.phoneNo1 : selectedPanel.phoneNo1 + " / " + selectedPanel.phoneNo2
        }
        
        if (selectedPanel.faxNo == "") {
            faxNo.isHidden = true
            faxNoTitle.isHidden = true
            viewFaxHeightConstraint.constant = 0
        }else {
            faxNo.isHidden = false
            faxNoTitle.isHidden = false
            faxNo?.text = selectedPanel.faxNo
        }
        
        if (selectedPanel.workingHours == "") {
            workingHours.isHidden = true
            workingHoursTitle.isHidden = true
            workingHourHeightConstraint.constant = 0
        }else {
            workingHours?.text = selectedPanel.workingHours
            print("Height === \(selectedPanel.workingHours.heightWithConstrainedWidth(width: workingHours.frame.size.width, font: workingHours.font))")
            workingHourHeightConstraint.constant = selectedPanel.workingHours.heightWithConstrainedWidth(width: workingHours.frame.size.width, font: workingHours.font)
            workingHours.isHidden = false
            workingHoursTitle.isHidden = false
            
        }
        
        if ((selectedPanel.latitude == "") || (selectedPanel.longitude == "")){
            self.btnViewMap.isHidden = true
            viewMapHeightCOnstraint.constant = 0
        }
        
        lblLikeCount.text = String(selectedPanel.likeCount)
        lblDisappointCount.text = String(selectedPanel.disappointCount)
        
        if selectedPanel.likeStatus == 0{//Disappoint
            imgViewDisappoint.image = UIImage.init(named: "disappoint_deep_red")
            imgViewLike.image = UIImage.init(named: "like_lite_red")
        }else if selectedPanel.likeStatus == 1{//Like
            imgViewDisappoint.image = UIImage.init(named: "disappoint_lite_red")
            imgViewLike.image = UIImage.init(named: "like_deep_red")
        }else{
            imgViewDisappoint.image = UIImage.init(named: "disappoint_lite_red")
            imgViewLike.image = UIImage.init(named: "like_lite_red")
        }
        
        lblRating.text =  "\(selectedPanel.rating)"
        lblRatingCount.text = "(" + NSDecimalNumber(decimal: Decimal(selectedPanel.ratingCnt)).stringValue + ")"
        if selectedPanel.star > 0{
            self.imgStar1.image = UIImage(named: "star_custom.png")
        }else{
            self.imgStar1.image = UIImage(named: "starempty.png")
        }
        if selectedPanel.star > 1{
            self.imgStar2.image = UIImage(named: "star_custom.png")
        }else{
            self.imgStar2.image = UIImage(named: "starempty.png")
        }
        if selectedPanel.star > 2{
            self.imgStar3.image = UIImage(named: "star_custom.png")
        }else{
            self.imgStar3.image = UIImage(named: "starempty.png")
        }
        if selectedPanel.star > 3{
            self.imgStar4.image = UIImage(named: "star_custom.png")
        }else{
            self.imgStar4.image = UIImage(named: "starempty.png")
        }
        if selectedPanel.star > 4{
            self.imgStar5.image = UIImage(named: "star_custom.png")
        }else{
            self.imgStar5.image = UIImage(named: "starempty.png")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewMapBtnAction (_ sender: UIButton) {
        AppConstant.selectedPanelProvider = selectedPanel
        //Path Testing
//        AppConstant.selectedPanelProvider.latitude = "20.289046"
//        AppConstant.selectedPanelProvider.longitude = "85.813167"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewMapPopUpViewController") as! ViewMapPopUpViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        vc.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        vc.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            vc.view.alpha = 1.0
            vc.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
    }
    
    @IBAction func likeBtnAction (_ sender: UIButton) {
        showFeedbackController(likeStatus: "1")
    }
    
    @IBAction func disappointBtnAction (_ sender: UIButton) {
        showFeedbackController(likeStatus: "0")
    }
    
   @IBAction func btnCallAction (_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CallPopupViewController") as! CallPopupViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.phone1 = selectedPanel.phoneNo1
        vc.phone2 = selectedPanel.phoneNo2
        vc.providerName = selectedPanel.providerName
    
        vc.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        vc.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            vc.view.alpha = 1.0
            vc.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
            
    SearchListDetailsViewController.self.openChildViewController(parentVC: self, with: vc)
    }
    
    public class func openChildViewController(parentVC:UIViewController, with childVC:UIViewController){

        parentVC.addChild(childVC)
        childVC.view.frame = parentVC.view.frame
        parentVC.view.addSubview(childVC.view)
        parentVC.didMove(toParent: childVC)
    }
    
    public class func removeChildViewController(childVC:UIViewController){

        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
    
    func showFeedbackController(likeStatus: String){
        let controller:FeedbackPanelViewController = self.storyboard!.instantiateViewController(withIdentifier: "FeedbackPanelViewController") as! FeedbackPanelViewController
        
        controller.providerBo = selectedPanel
        controller.likeStatus = likeStatus
        controller.selectedRow = selectedRow
        controller.delegate = self
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
    }
    
    //MARK: Feedback Delegate Method
    func updateList(selectedRow: Int, likeVal: String){
        self.serviceCallToGetSearchPanelProviderList()
    }
    
    func updateData(){
        for providerBo in self.arrPanelProviders{
            if selectedPanel.providerCode == providerBo.providerCode{
                if providerBo.likeStatus == 0{//Disappoint
                    imgViewDisappoint.image = UIImage.init(named: "disappoint_deep_red")
                    imgViewLike.image = UIImage.init(named: "like_lite_red")
                }else if providerBo.likeStatus == 1{//Like
                    imgViewDisappoint.image = UIImage.init(named: "disappoint_lite_red")
                    imgViewLike.image = UIImage.init(named: "like_deep_red")
                }
                lblDisappointCount.text = String(providerBo.disappointCount)
                lblLikeCount.text = String(providerBo.likeCount)
                
                delegate?.updatePanelListData(panelBo: providerBo, selectedIndex: selectedRow)
            }
        }
    }
    
    @IBAction func rateUsAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingStoryboardID") as! RatingViewController
        vc.strPageTitle = providerType.text ?? ""
        vc.className = "PANEL_PROVIDER"
        let medicalVisitGL = ClaimBo()
        medicalVisitGL.providerCode = self.selectedPanel.providerCode 
        medicalVisitGL.providerName = self.selectedPanel.providerName 
        medicalVisitGL.ratingID = self.selectedPanel.ratingID 
        vc.model = medicalVisitGL
        vc.strTitleHeader = pageHeader
        vc.pageHeaderImage = pageHeaderImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ratingAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"ListRatingProviderStoryboardID") as! ListRatingbyProviderViewController
        vc.className = self.className
        vc.product = self.selectedPanel
        vc.pageHeader = pageHeader
        vc.pageHeaderImage = pageHeaderImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Service Call
    func serviceCallToGetSearchPanelProviderList(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
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
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    
                                    self.arrPanelProviders.removeAll()
                                    if let dict_array = dict?["PanelProviderList"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
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
                                            
                                            self.arrPanelProviders.append(panelProviders)
                                        }
                                        
                                    }
                                    
                                    //Update Value
                                    self.updateData()
                                    
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

