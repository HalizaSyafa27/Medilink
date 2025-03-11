//
//  SearchListsViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class SearchListsViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource, FeedbackDelegate, PanelProviderDetailsDelegate {
    
    @IBOutlet var searchListsTableView: UITableView!
    @IBOutlet var providerType: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewPageHeader: UIImageView!
    
    var arrPanelProviders = [PanelProvidersBo]()
    var selectedPanel = PanelProvidersBo()
    var selectedRow: Int! = 0
    var providerTypeName = ""
    var strHeaderImageName = ""
    var params: Parameters = [:]
    var url: String = ""
    var pageHeader = ""
    var pageHeaderImage = ""
    var strTitleImage = "ic_etiqapanel_gray"
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
        
        providerType?.text = providerTypeName
        imgViewHeader.image = UIImage.init(named: strTitleImage)
        
        self.lblPageHeader.text = pageHeader
        self.imgViewPageHeader.image = UIImage.init(named: pageHeaderImage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func likeBtnAction (_ sender: UIButton) {
        selectedRow = sender.tag
        selectedPanel = self.arrPanelProviders[sender.tag]
        showFeedbackController(likeStatus: "1")
    }
    
    @objc func disappointBtnAction (_ sender: UIButton) {
        selectedRow = sender.tag
        selectedPanel = self.arrPanelProviders[sender.tag]
        showFeedbackController(likeStatus: "0")
    }
    
    @objc func viewRatingListSelector(sender: GLApplicationStatusTapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"ListRatingProviderStoryboardID") as! ListRatingbyProviderViewController
        vc.className = self.className
        vc.pageHeader = self.pageHeader
        vc.pageHeaderImage = self.pageHeaderImage
        vc.product = self.arrPanelProviders[sender.indexRowSelected!]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPanelProviders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListsTableViewCell", for: indexPath as IndexPath) as! SearchListsTableViewCell
        
        let panelBo = arrPanelProviders[indexPath.row]
        cell.providerName?.text = panelBo.providerName
        cell.addressName?.text =  panelBo.address
        
        let tap1Gesture = GLApplicationStatusTapGestureRecognizer(target: self, action: #selector(viewRatingListSelector(sender:)))
        tap1Gesture.indexRowSelected = indexPath.row
        cell.btnRating.isUserInteractionEnabled = true
        cell.btnRating.addGestureRecognizer(tap1Gesture)
        
        let numberStar = Float(panelBo.rating ) ?? 0
        let starempty = "starempty.png"
        var imageName = "star_custom.png"
        print("numberStar: \(panelBo.providerCode)")
        if numberStar > 0{
            imageName = self.getStar(numberStar: numberStar, sumStar: panelBo.rating, start: 1)
            cell.imgStar1.image = UIImage(named: imageName)
        }else{
            cell.imgStar1.image = UIImage(named: starempty)
        }
        if numberStar > 1{
            imageName = self.getStar(numberStar: numberStar, sumStar: panelBo.rating, start: 2)
            cell.imgStar2.image = UIImage(named: imageName)
        }else{
            cell.imgStar2.image = UIImage(named: starempty)
        }
        if numberStar > 2{
            imageName = self.getStar(numberStar: numberStar, sumStar: panelBo.rating, start: 3)
            cell.imgStar3.image = UIImage(named: imageName)
        }else{
            cell.imgStar3.image = UIImage(named: starempty)
        }
        if numberStar > 3{
            imageName = self.getStar(numberStar: numberStar, sumStar: panelBo.rating, start: 4)
            cell.imgStar4.image = UIImage(named: imageName)
        }else{
            cell.imgStar4.image = UIImage(named: starempty)
        }
        if numberStar > 4{
            imageName = self.getStar(numberStar: numberStar, sumStar: panelBo.rating, start: 5)
            cell.imgStar5.image = UIImage(named: imageName)
        }else{
            cell.imgStar5.image = UIImage(named: starempty)
        }
        if panelBo.state == "" {
            cell.stateName?.text = " STATE: NA "
        }else{
            cell.stateName?.text = " STATE: " + panelBo.state + " "
        }
        
        if panelBo.city == "" {
            cell.cityName?.text = " CITY: NA "
        }else{
            cell.cityName?.text = " CITY: " + panelBo.city + " "
        }
        
        cell.lblDistance?.text = panelBo.distance
        cell.searchImageView?.sd_setImage(with: URL(string: panelBo.logoUrl), placeholderImage: UIImage(named: "search_list_red"))
        //cell.searchImageView?.image = UIImage(named: "search_list")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedPanel = arrPanelProviders[indexPath.row]
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "search_list_details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        //Refresh list
        serviceCallToGetSearchPanelProviderList()
    }
    
    //MARK: panel Provider Details Delegate
    func updatePanelListData(panelBo: PanelProvidersBo, selectedIndex: Int){
        if arrPanelProviders.count > selectedIndex{
            arrPanelProviders[selectedIndex] = panelBo
        }
        self.searchListsTableView.reloadData()
    }
    
    func getStar(numberStar:Float, sumStar:String, start:Float)-> String{
        var imageName = "star_custom.png"
        if numberStar < start{
            let numberStr = sumStar.components(separatedBy: ".")
            if numberStr.count > 1 {
                if Int(numberStr[1]) ?? 0 > 5{
                    imageName = "star_custom_0.6.png"
                }else if Int(numberStr[1]) ?? 0 < 5{
                    imageName = "star_custom_0.4.png"
                }else{
                    imageName = "star_custom_0.5.png"
                }
            }else{
                imageName = "star_custom.png"
            }
        }
        return imageName
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
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
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
                                            if let star = item["Star"] as? Int {
                                                panelProviders.star = star
                                            }
                                            if let rating = item["Rating"] as? String {
                                                panelProviders.rating = rating
                                            }
                                            if let ratingCnt = item["RatingCnt"] as? Int {
                                                panelProviders.ratingCnt = ratingCnt
                                            }
                                            self.arrPanelProviders.append(panelProviders)
                                        }
                                        
                                    }
                                    
                                    self.searchListsTableView.reloadData()
                                    
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
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "search_list_details") {
            let vc = segue.destination as! SearchListDetailsViewController
            vc.selectedPanel = selectedPanel
            vc.providerTypeNameTitle = selectedPanel.providerTypeDesc
            vc.strHeaderImageName = strHeaderImageName
            vc.params = params
            vc.url = url
            vc.selectedRow = selectedRow
            vc.delegate = self
            vc.pageHeader = pageHeader
            vc.pageHeaderImage = strHeaderImageName
            vc.strTitleImage = strTitleImage
            return
        }
    }
    
    
}
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
