//
//  ListRatingbyProviderViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 27/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class ListRatingbyProviderViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewPageHeader: UIImageView!
    @IBOutlet weak var lblTitlePage: UILabel!
    @IBOutlet weak var lblProviderName: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    @IBOutlet weak var tblRatingByProvider: UITableView!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var lblRatingCount: UILabel!
    @IBOutlet weak var btnNewest: UIButton!
    @IBOutlet weak var btnHighest: UIButton!
    @IBOutlet weak var btnLowest: UIButton!
    @IBOutlet weak var lblTitlePageNumber: UILabel!
    @IBOutlet weak var btnNextPage: UIButton!
    @IBOutlet weak var btnPrePage: UIButton!
    @IBOutlet weak var btnSelectPageSize: UIButton!
    
    let colorText = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    var ratingList = [PanelProvidersBo]()
    var ratingFileList = [PanelProvidersBo]()
    var ratingIdListLoaded = [PanelProvidersBo]()
    var product = PanelProvidersBo()
    var className:String = ""
    var fDesc:String = ""
    var sortBy:String = ""
    var pageHeader:String = ""
    var pageHeaderImage:String = ""
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "10",
            "20",
            "50",
            "All"
        ]
        return menu
    }()
    let colorSortButton = UIColor(red: 229/255, green: 240/255, blue: 254/255, alpha: 1)
    let colorWhiteSortButton = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.lblPageHeader.text = pageHeader
        self.imgViewPageHeader.image = UIImage.init(named: pageHeaderImage)
        self.lblTitlePage.text = product.providerTypeDesc
        self.lblProviderName.text = product.providerName
        self.ratingFileList.removeAll()
        self.ratingIdListLoaded.removeAll()
        self.postViewRatingbyProviderService()
        self.tblRatingByProvider.rowHeight = UITableView.automaticDimension
        self.tblRatingByProvider.estimatedRowHeight = UITableView.automaticDimension
        self.btnNewest.layer.cornerRadius = btnNewest.layer.frame.height/2
        self.btnNewest.layer.borderColor = UIColor.lightGray.cgColor
        self.btnNewest.layer.masksToBounds = true
        self.btnNewest.layer.borderWidth = 1.0
        
        self.btnLowest.layer.cornerRadius = btnLowest.layer.frame.height/2
        self.btnLowest.layer.borderColor = UIColor.lightGray.cgColor
        self.btnLowest.layer.masksToBounds = true
        self.btnLowest.layer.borderWidth = 1.0
        
        self.btnHighest.layer.cornerRadius = btnHighest.layer.frame.height/2
        self.btnHighest.layer.borderColor = UIColor.lightGray.cgColor
        self.btnHighest.layer.masksToBounds = true
        self.btnHighest.layer.borderWidth = 1.0
        
        self.lblTitlePageNumber.text = "Page 1"
        self.btnPrePage.isHidden = true
        self.changePageSize()
        self.btnNewest.backgroundColor = colorSortButton
    }
    
    //Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func newestAction(_ sender: UIButton) {
        self.btnNewest.backgroundColor = colorSortButton
        self.btnHighest.backgroundColor = colorWhiteSortButton
        self.btnLowest.backgroundColor = colorWhiteSortButton
        self.btnNewest.setTitleColor(self.colorText, for: .normal)
        self.btnHighest.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnLowest.setTitleColor(UIColor.lightGray, for: .normal)
        self.sortBy = "LA"
        self.postViewRatingbyProviderService()
    }
    
    @IBAction func highestAction(_ sender: UIButton) {
        self.btnHighest.backgroundColor = colorSortButton
        self.btnNewest.backgroundColor = colorWhiteSortButton
        self.btnLowest.backgroundColor = colorWhiteSortButton
        self.btnNewest.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnHighest.setTitleColor(self.colorText, for: .normal)
        self.btnLowest.setTitleColor(UIColor.lightGray, for: .normal)
        self.sortBy = "HI"
        self.postViewRatingbyProviderService()
    }
    
    @IBAction func lowestAction(_ sender: UIButton) {
        self.btnLowest.backgroundColor = colorSortButton
        self.btnNewest.backgroundColor = colorWhiteSortButton
        self.btnHighest.backgroundColor = colorWhiteSortButton
        self.btnNewest.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnHighest.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnLowest.setTitleColor(self.colorText, for: .normal)
        self.sortBy = "LO"
        self.postViewRatingbyProviderService()
    }
    
    @IBAction func onNextPageAction(_ sender: UIButton) {

    }
    
    @IBAction func onPrePageAction(_ sender: UIButton) {

    }
    
    @IBAction func onChangePageSizeAction(_ sender: UIButton) {
        menu.anchorView = self.btnSelectPageSize
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)
        menu.show()
    }
    
    func changePageSize(){
        self.menu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectPageSize.setTitle(item, for: .normal)
            self.pageZise = item == "All" ? 0 : (Int(item) ?? 10)
            self.pageNumber = 1
            self.postViewRatingbyProviderService()
        }
    }
    
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblRatingByProvider.dequeueReusableCell(withIdentifier: "RatingByProviderCell", for: indexPath) as! RatingByProviderTableViewCell
        print(indexPath.row)
        if(self.ratingList.count > indexPath.row){
            let data = self.ratingList[indexPath.row]
            cell.lblRemarks.text = data.ratingRemarks
            cell.lblUserId.text = data.userID
            cell.lblPublishDate.text = data.publishDt
            for subView in cell.imgsView.subviews {
                subView.removeFromSuperview()
            }
            cell.HeightConstraintImages.constant = 0
            if data.ratingID != ""{
                let result = ratingFileList.filter { $0.ratingID==data.ratingID }
                let ratingLoaded = ratingIdListLoaded.filter { $0.ratingID==data.ratingID }
                if result.count < 1 {
                    if ratingLoaded.count < 1 {
                        ratingIdListLoaded.append(data)
                        self.postViewRatingDocbyProviderService(ratingId: data.ratingID , cell: cell, isLoad: true)
                    }
                }else{
                    self.setImageInTableViewCell(result: result, cell: cell, ratingId: data.ratingID, isLoad: false)
                }
            }
            if data.star > 0{
                cell.imgStar1.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar1.image = UIImage(named: "starempty.png")
            }
            if data.star > 1{
                cell.imgStar2.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar2.image = UIImage(named: "starempty.png")
            }
            if data.star > 2{
                cell.imgStar3.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar3.image = UIImage(named: "starempty.png")
            }
            if data.star > 3{
                cell.imgStar4.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar4.image = UIImage(named: "starempty.png")
            }
            if data.star > 4{
                cell.imgStar5.image = UIImage(named: "star_custom.png")
            }else{
                cell.imgStar5.image = UIImage(named: "starempty.png")
            }
            
            let tap1Gesture = GLApplicationStatusTapGestureRecognizer(target: self, action: #selector(viewImageSelector(sender:)))
            tap1Gesture.indexRowSelected = indexPath.row
            cell.imgsView.isUserInteractionEnabled = true
            cell.imgsView.addGestureRecognizer(tap1Gesture)
        }
        return cell
    }
    
    @objc func viewImageSelector(sender: GLApplicationStatusTapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingFileListStoryboardID") as! RatingFileListViewController
        vc.pageHeader = self.pageHeader
        vc.pageHeaderImage = self.pageHeaderImage
        vc.className = self.className
        let data = self.ratingList[sender.indexRowSelected!]
        data.providerCode = product.providerCode
        data.providerName =  product.providerName
        data.providerTypeDesc =  product.providerTypeDesc
        if data.ratingID != ""{
            let result = ratingFileList.filter { $0.ratingID == data.ratingID }
            if result.count > 0{
                vc.ratingFileList = result
            }
        }
        vc.product = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getStar(numberStar:Float, sumStar:Float, start:Float)-> String{
        var imageName = "star_custom.png"
        if numberStar < start{
            let numberStr = "\(sumStar)".components(separatedBy: ".")
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
    
    // MARK: - Call Services
    func postViewRatingbyProviderService(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params = [
                "pstProviderCode": product.providerCode.trimmingCharacters(in: .whitespacesAndNewlines),
                "pstSortBy": self.sortBy,
                "pstPageNo": String(self.pageNumber),
                "pstPageSize": String(self.pageZise),
            ]
            print("Headers--- \(headers)")
            AFManager.request( AppConstant.postViewRatingbyProvider, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    debugPrint(response)
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postViewRatingbyProviderService()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    let sumRating = dict?["SumRating"] as? Float
                                    let sumStar = dict?["SumStar"] as? Float
                                    let sumRatingCnt = dict?["SumRatingCnt"] as? Float
                                    
                                    self.lblStar.text = "\(sumRating ?? 0)"
                                    self.lblRatingCount.text = "\(sumRatingCnt ?? 0)"
                                    let numberStar = sumStar ?? 0
                                    let starempty = "starempty.png"
                                    var imageName = "star_custom.png"
                                    if numberStar > 0{
                                        imageName = self.getStar(numberStar: numberStar, sumStar: sumStar ?? 0, start: 1)
                                        self.imgStar1.image = UIImage(named: imageName)
                                    }else{
                                        self.imgStar1.image = UIImage(named: starempty)
                                    }
                                    if numberStar > 1{
                                        imageName = self.getStar(numberStar: numberStar, sumStar: sumStar ?? 0, start: 2)
                                        self.imgStar2.image = UIImage(named: imageName)
                                    }else{
                                        self.imgStar2.image = UIImage(named: starempty)
                                    }
                                    if numberStar > 2{
                                        imageName = self.getStar(numberStar: numberStar, sumStar: sumStar ?? 0, start: 3)
                                        self.imgStar3.image = UIImage(named: imageName)
                                    }else{
                                        self.imgStar3.image = UIImage(named: starempty)
                                    }
                                    if numberStar > 3{
                                        imageName = self.getStar(numberStar: numberStar, sumStar: sumStar ?? 0, start: 4)
                                        self.imgStar4.image = UIImage(named: imageName)
                                    }else{
                                        self.imgStar4.image = UIImage(named: starempty)
                                    }
                                    if numberStar > 4{
                                        imageName = self.getStar(numberStar: numberStar, sumStar: sumStar ?? 0, start: 5)
                                        self.imgStar5.image = UIImage(named: imageName)
                                    }else{
                                        self.imgStar5.image = UIImage(named: starempty)
                                    }
                                    
                                    self.ratingList.removeAll()
                                    var arrPanelProviders = [PanelProvidersBo]()
                                    if let dict_array = dict?["ViewRatingbyProviderData"] as? [[String: Any]] {
                                        print(dict_array)
                                        for item in dict_array {
                                            let panelProviders = PanelProvidersBo()
                                           
                                            if let star = item["Star"] as? Int {
                                                panelProviders.star = star
                                            }
                                            if let rating = item["Rating"] as? String {
                                                panelProviders.rating = rating
                                            }
                                            if let publishDt = item["PublishDt"] as? String {
                                                panelProviders.publishDt = publishDt
                                            }
                                            if let providerName = item["ProviderName"] as? String {
                                                panelProviders.providerName = providerName
                                            }
                                            if let ratingRemarks = item["RatingRemarks"] as? String {
                                                panelProviders.ratingRemarks = ratingRemarks
                                            }
                                            if let ratingID = item["RatingID"] as? String {
                                                panelProviders.ratingID = ratingID
                                            }
                                            if let userID = item["UserID"] as? String {
                                                panelProviders.userID = userID
                                            }
                                            arrPanelProviders.append(panelProviders)
                                        }
                                    }
                                    self.ratingList = arrPanelProviders
                                    self.tblRatingByProvider.reloadData()
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName:AppConstant.postViewRatingbyProvider)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postViewRatingbyProvider)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func postViewRatingDocbyProviderService(ratingId:String, cell:RatingByProviderTableViewCell, isLoad:Bool){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant().hideHUDInView(view: cell.imgsView)
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let params = [
                "pstProviderCode": product.providerCode.trimmingCharacters(in: .whitespacesAndNewlines),
                "pstRatingID": ratingId
            ]
            print("Headers--- \(headers)")
            print("Parameters--- \(params)")
            AFManager.request( AppConstant.postViewRatingDocbyProvider, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
//                    debugPrint(response)
                    AppConstant().hideHUDInView(view: cell.imgsView)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
//                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postViewRatingDocbyProviderService(ratingId: ratingId,cell: cell, isLoad: true)
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    var arrPanelProviders = [PanelProvidersBo]()
                                    if let dict_array = dict?["ViewRatingPostedFiles"] as? [[String: Any]] {
//                                        print(dict_array)
                                        if dict_array.count > 0{
                                            for item in dict_array {
                                                let panelProviders = PanelProvidersBo()
                                                if let ratingID = item["RatingID"] as? String {
                                                    panelProviders.ratingID = ratingID
                                                }
                                                if let fileName = item["FileName"] as? String {
                                                    panelProviders.fileName = fileName
                                                }
                                                if let fileData = item["FileData"] as? String {
                                                    panelProviders.fileData = fileData
                                                }
                                                arrPanelProviders.append(panelProviders)
                                            }
                                        }
                                        self.setImageInTableViewCell(result: arrPanelProviders, cell: cell, ratingId: ratingId, isLoad: true)
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName:AppConstant.postViewRatingbyProvider)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postViewRatingbyProvider)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func setImageInTableViewCell(result:[PanelProvidersBo], cell:RatingByProviderTableViewCell, ratingId:String, isLoad:Bool){
        let countImage = result.count
        let width:CGFloat = cell.imgsView.layer.frame.width/2
        let height:CGFloat = cell.imgsView.layer.frame.width/3
        var widthX:CGFloat = 0
        var heightY:CGFloat = 0
        var forIndex:Int = 1
        var count:Float = 0
        var number:Float = 0
        if countImage > 0{
            count = Float(countImage)/Float(2)
            number = count.rounded(.up)
            cell.HeightConstraintImages.constant = CGFloat(number) * height
        }else{
            cell.HeightConstraintImages.constant = 0
        }
        self.tblRatingByProvider.beginUpdates()
        self.tblRatingByProvider.endUpdates()
        for item in result {
            let result = ratingFileList.filter { $0.fileName == item.fileName }
            if isLoad && result.count < 1{
                item.ratingID = ratingId
                self.ratingFileList.append(item)
            }
            let imgStr = item.fileData 
            if self.isNotNullOrNil(imgStr){
                if let data = Data(base64Encoded: imgStr) {
                    let image = UIImage(data: data)
                    if image != nil{
                        if forIndex % 2 != 0{
                            widthX = 0
                        }else{
                            widthX = width
                        }
                        if forIndex >= 3 {
                            if forIndex % 2 != 0 && forIndex > 3{
                                heightY = heightY + height
                            }
                            else if forIndex > 3
                            {
                                
                            }
                            else{
                                heightY = height
                            }
                        }else{
                            heightY = 0
                        }
                        let imageView = UIImageView()
                        if countImage < 2{
                            imageView.frame = CGRect(x: width/2, y: 0, width: width, height:height)
                        }
                        else if countImage >= 2{
                            imageView.frame = CGRect(x: widthX, y: heightY, width: width, height: height)
                        }
                        imageView.contentMode = .scaleAspectFit
                        imageView.layer.masksToBounds = true
                        imageView.image = image
                        cell.imgsView.addSubview(imageView)
                        forIndex = forIndex + 1
                    }
                }
            }
        }
    }
}
