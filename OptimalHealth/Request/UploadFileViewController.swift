//
//  UploadFileViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 18/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class UploadFileViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate , UIPopoverControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet var viewSubmit: UIView!
    @IBOutlet var lblInfo: UILabel!
    @IBOutlet var tblAttachments: UITableView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var viewPageHeader: UIView!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewHeaderHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var viewParent: UIView!
    @IBOutlet var viewTerms: UIView!
    @IBOutlet var imgViewViewAgree: UIImageView!
    @IBOutlet var lblTerms: UILabel!
    @IBOutlet var viewTermsHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewTermsBottomConstraint: NSLayoutConstraint!
    
    var className = ""
    var pageTitle = ""
    var strClaimId = ""
    var strMemId = ""
    var arrImages = [UploadImageBo]()
    var picker:UIImagePickerController? = UIImagePickerController()
    var requestParams: Parameters = [:]
    var strHeaderImageName = ""
    var imageUploadedCount = 0
    var pageHeader: String = ""
    var selectedIndex = 0
    var headerImage = ""
    var selectedClaimBo = ClaimBo()
    var cardNo = ""
    var isAgreeToTerms : Bool = false
    
    //Rating parameters
    var ratingRemarks: String = ""
    var rating: Int = 0
    var visitDate: String = ""
    var providerCode: String = ""
    
    private lazy var submitViewController: SubmitViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDesign()
    }
    
    func initDesign(){
        if ((className == StringConstant.outPatientSPGLRequest) || className == StringConstant.hospitalAdmissionGLRequest) {
            self.lblInfo.text = StringConstant.outPatientSPGLMsg
        }else if className == StringConstant.pharmacyRequest {
            self.lblInfo.text = StringConstant.pharmacyRequestMsg
        }else if className == StringConstant.reimbersmentClaimRequest {
            self.lblInfo.text = StringConstant.reimbursementClaimMsg
        }else{
            self.lblInfo.text = ""
        }
        picker?.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.submitAction(_:)))
        self.viewSubmit.addGestureRecognizer(tap)
        self.viewSubmit.isUserInteractionEnabled = true
        
        if className == StringConstant.uploadMedicalChit {
            //self.lblInfo.text = StringConstant.outPatientSPGLMsg
            imgViewHeader.image = UIImage.init(named: headerImage)
            lblHeader.text = pageHeader
            lblPageTitle.text = pageTitle
            //Manage for iPhone X
            if AppConstant.screenSize.height >= 812{
                navBarHeightConstraint.constant = AppConstant.navBarHeight
                topBarHeightConstraint.constant = AppConstant.navBarHeight
            }
        }else if className == StringConstant.gl || className == "PANEL_PROVIDER"{
            lblHeader.text = pageHeader
            lblPageTitle.text = pageTitle
            //Manage for iPhone X
            if AppConstant.screenSize.height >= 812{
                navBarHeightConstraint.constant = AppConstant.navBarHeight
                topBarHeightConstraint.constant = AppConstant.navBarHeight
            }
        }else{
            navBarHeightConstraint.constant = 0
            topBarHeightConstraint.constant = 0
            viewHeaderHeightConstraint.constant = 0
            viewPageHeader.isHidden = true
        }
        
        if className == StringConstant.teleconsultRequest {
            viewTerms.isHidden = false
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.agreeToTermsLink(_:)))
            self.lblTerms.addGestureRecognizer(tap)
            self.lblTerms.isUserInteractionEnabled = true
        }else{
            viewTerms.isHidden = true
            viewTermsHeightConstraint.constant = 0
            viewTermsBottomConstraint.constant = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppConstant.isClaimSubmitted = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnCameraAction(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            self.picker!.allowsEditing = false
            self.picker!.sourceType = UIImagePickerController.SourceType.camera
            self.picker!.cameraCaptureMode = .photo
            self.present(self.picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            alert.view.tintColor = AppConstant.themeRedColor
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnGalleryAction(_ sender: Any) {
        self.picker!.allowsEditing = false
        self.picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(self.picker!, animated: true, completion: nil)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func submitAction(_ sender: UITapGestureRecognizer) {
        if className == StringConstant.teleconsultRequest{
            if self.isAgreeToTerms == false{
                self.displayAlert(message: StringConstant.agreeToTCValidation)
                return
            }
            self.registerDeviceToken(completion: { (Bool) in
                if Bool{
                    self.serviceCallToRequest()
                }
            })
            
        }
        else if className == StringConstant.gl{
            self.serviceCallToPostViewRatingbyClaimId()
        }
        else if className == "PANEL_PROVIDER"{
            self.postRatingbyProviderService()
        }
        else{
            if self.arrImages.count == 0 {
                self.displayAlert(message: "Please select a file")
            }else{
                if className == StringConstant.uploadMedicalChit{
                    serviceCallToUploadAttachments()
                }else{//Out-Patient Specialist GL Req, Submit Reimbursement Claim, Submit Pharmacy Request, Hospital Admission GL Req
                    self.registerDeviceToken(completion: { (Bool) in
                        if Bool{
                            self.serviceCallToRequest()
                        }
                    })
                }
            }
        }
    }
    
    @objc func removeFileAction(_ sender: UIButton) {
        if (self.arrImages.count) > 0{
            self.arrImages.remove(at: sender.tag)
            self.tblAttachments.reloadData()
        }
    }
    
    @objc func showImageeAction(_ sender: UITapGestureRecognizer) {
        selectedIndex = (sender.view?.tag)!
        self.performSegue(withIdentifier: "viewDoc", sender: self)
    }
    
    @IBAction func btnAgreeToTerms (_ sender: UIButton) {
        isAgreeToTerms = !isAgreeToTerms
        imgViewViewAgree.image = isAgreeToTerms == true ? UIImage.init(named: "checkbox_active")  : UIImage.init(named: "checkbox")
    }
    
    @objc func agreeToTermsLink (_ sender: UITapGestureRecognizer) {
        self.displayAlert(message: "Term of Use\n I understand and acknowledge that advice, messages, are for informational purpose only and DOES NOT CONSTITUTE THE PROVIDING OF MEDICAL ADVICE and is not intended to be a substitute for independent professional medical judgement, advice, diagnosis, or treatment.")
        }
    
    //MARK: Image Picker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(
            animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let uploadImgBo = UploadImageBo()
            var imgData: NSData = pickedImage.jpegData(compressionQuality: 1.0)! as NSData
            
            let sizeInMB = Double(imgData.length) / 1024.0/1024.0
            let sizeInKB = Double(imgData.length) / 1024.0
            
            let bPreBitmap = imgData.length // Ukuran asli dalam byte
            
//            print("Before Compression size of image in KB: %f ", sizeInKB)
//            print("Before Compression size of image in KB: %f ", sizeInMB)
            
            print("Before Compression size: \(Double(bPreBitmap) / 1024.0) KB")
            
            var finalImage = pickedImage

//            if let image = pickedImage.compressTo(Int(1*1024*1024)){
//                //let image = pickedImage.compressTo(Int(0.5*1024*1024))
//                if let imagedat = image.jpegData(compressionQuality: 0.5) as NSData?{
//                    imgData = imagedat
//                }
//                if (Double(imgData.length / 1024) > 50) && (Double(imgData.length / 1024) < 100){
//                    if let thumb1 = image.resized(withPercentage: 0.5){
//                        if let imagedat = thumb1.jpegData(compressionQuality: 0.5) as NSData?{
//                            imgData = imagedat
//                        }
//                    }
//                }else if (Double(imgData.length / 1024) > 100) && (Double(imgData.length / 1024) < 200){
//                    if let thumb1 = image.resized(withPercentage: 0.5){
//                        if let imagedat = thumb1.jpegData(compressionQuality: 0.5) as NSData?{
//                            imgData = imagedat
//                        }
//                    }
//                }else if (Double(imgData.length / 1024) > 200) && (Double(imgData.length / 1024) < 400){
//                    if let thumb1 = image.resized(withPercentage: 0.5){
//                        if let imagedat = thumb1.jpegData(compressionQuality: 0.5) as NSData?{
//                            imgData = imagedat
//                        }
//                    }
//                }else if Double(imgData.length / 1024) > 500{
//                    if let thumb1 = image.resized(withPercentage: 0.3){
//                        if let imagedat = thumb1.jpegData(compressionQuality: 0.5) as NSData?{
//                            imgData = imagedat
//                        }
//                    }
//                }
//            }
            
            if bPreBitmap > 1_000_000 && bPreBitmap <= 3_000_000{
                //if ukuran  1MB - 3MB, resize ke 50%
                if let resizedImage = pickedImage.resized(withPercentage: 0.5) {
                                finalImage = resizedImage
                            }
            } else if bPreBitmap > 3_000_000 {
                // Jika ukuran lebih dari 3MB, resize ke 30%
                if let resizedImage = pickedImage.resized(withPercentage: 0.3) {
                    finalImage = resizedImage
                }
            }
            
            // Kompresi gambar yang sudah di-resize atau yang original jika tidak perlu resize
            if let compressedData = finalImage.jpegData(compressionQuality: 0.7) as NSData? {
                imgData = compressedData
            }
            
            print("After Compression size: \(Double(imgData.length) / 1024.0) KB")
            
            let sizeKB = Double(imgData.length / 1024)
            
//            print("After Compression size of image in KB: %f ", Double(imgData.length) / 1024.0)
//            print("After Compression size of image in MB: %f ", Double(imgData.length) / 1024.0/1024.0)
            
            let timestamp = Int(NSDate().timeIntervalSince1970)
            uploadImgBo.name = String("\(timestamp).PNG")
            uploadImgBo.size = "\(imgData.length / 1024) KB"
//            uploadImgBo.size = String("\(sizeKB) KB")
            uploadImgBo.imgData = imgData
            
            //uploadImgBo.image = pickedImage
            uploadImgBo.image = UIImage(data: imgData as Data)
            self.arrImages.append(uploadImgBo)
        }
        dismiss(animated: true, completion: nil)
        self.tblAttachments.reloadData()
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UploadFileTableViewCell", for: indexPath as IndexPath) as! UploadFileTableViewCell
        
        cell.selectionStyle = .none
        let item = self.arrImages[indexPath.row]
        cell.imgViewAttachment.image = item.image
        cell.lblFileName.text = item.name
        cell.lblFileSize.text = "File Size : \(item.size!)"
        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addTarget(self, action: #selector(removeFileAction(_:)), for: .touchUpInside)
        cell.imgViewAttachment.tag = indexPath.row
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showImageeAction(_:)))
        cell.imgViewAttachment.addGestureRecognizer(tap)
        cell.imgViewAttachment.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: Alert Method
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = AppConstant.themeRedColor
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertPopup(message:String){
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
            if self.className == StringConstant.gl{
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ClaimListViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
            else if self.className == "PANEL_PROVIDER"{
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: SearchListDetailsViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
            else{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Service call Methods
    func serviceCallToRequest(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.imageUploadStartTime = Date()
            AppConstant.showHUD()
            var url = ""
            if className == StringConstant.outPatientSPGLRequest{
                url = AppConstant.submitGLRequestUrl
            }else if className == StringConstant.pharmacyRequest{
                url = AppConstant.submitPharmacyRequestUrl
            }else if className == StringConstant.reimbersmentClaimRequest{
                url = AppConstant.submitReimbursementClaimUrl
            }else if className == StringConstant.hospitalAdmissionGLRequest{
                url = AppConstant.postOnlineHosAdmGLRequestUrl
            }else if className == StringConstant.teleconsultRequest{
                url = AppConstant.postTeleConsultUrl
            }
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            let requestParams = AppConstant.requestParams
            print("params===\(requestParams)")
            print("url===\(url)")
            Alamofire.request( url, method: .post, parameters: requestParams, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    //AppConstant.hideHUD()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.isHudShowing = false
                    MBProgressHUD.hideAllHUDs(for: appDelegate.window, animated: true)
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToRequest()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    if let claimId = dict?["ClaimId"] as? String{
                                        self.strClaimId = claimId
                                        AppConstant.strClaimId = claimId
                                    }
                                    if let memId = dict?["MemId"] as? String{
                                        self.strMemId = memId
                                    }
                                    
                                    if let msg = dict?["Message"] as? String{
                                        AppConstant.requestPopupMsg = msg
                                    }
                                    
                                    //Service call to upload attachments
                                    self.serviceCallToUploadAttachments()
                                   
                                //self.serviceCallToUploadAttachmentForRequests()
                                    
                                }else{
                                    //Failure
                                    AppConstant.imageUploadStartTime = nil
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.imageUploadStartTime = nil
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToDeactivateOnlineClaim(claimId: String, errMsg: String){
        if(AppConstant.hasConnectivity()) {//true connected
            
            AppConstant.showHUD()
            let params: Parameters = [
                "pstIClaimId": claimId,
                "pstErrormsg": errMsg
            ]
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.postDeactivateClaimUrl)")
            AFManager.request( AppConstant.postDeactivateClaimUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)

                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)

                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            //AppConstant.hideHUD()
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToDeactivateOnlineClaim(claimId: claimId, errMsg: errMsg)
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//Success
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                }else{//Failure
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                    
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDeactivateClaimUrl)
                            }
                        }

                        break

                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDeactivateClaimUrl)
                        break

                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToUploadAttachmentForRequests(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            var parameters :Parameters = [
                "pstClaimId": strClaimId,
                "pstMemId": strMemId
            ]
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                for imagesBo in self.arrImages {
                    if let imgDat = imagesBo.image!.jpegData(compressionQuality: 0.6){
                        parameters["pstUploadFileName"] = imagesBo.name!
                        multipartFormData.append(imgDat, withName: "pstUploadFileData", fileName: imagesBo.name!, mimeType: "image/png")
                    }else{
                        let imgData = imagesBo.image!.jpegData(compressionQuality: 0.5)
                        parameters["pstUploadFileName"] = imagesBo.name!
                        multipartFormData.append(imgData!, withName: "pstUploadFileData", fileName: imagesBo.name!, mimeType: "image/png")
                    }
                                        
                }
                
                for (key, value) in parameters {
                    multipartFormData.append(((value as! String).data(using: .utf8))!, withName: key)
                }}, to: AppConstant.savePostedFileUrl, method: .post, headers: headers,
                    encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.responseString { response in
                                AppConstant.hideHUD()
                                switch(response.result) {
                                case .success(_):
                                    debugPrint(response.result.value!)
                                    let headerStatusCode : Int = (response.response?.statusCode)!
                                    print("Status Code: \(headerStatusCode)")
                                    
                                    if(headerStatusCode == 401){//Session expired
                                        self.isTokenVerified(completion: { (Bool) in
                                            if Bool{
                                                self.serviceCallToUploadAttachmentForRequests()
                                            }
                                        })
                                    }else{
                                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                        //  debugPrint(dict)
                                        //self.arrImages.remove(at: i)
                                        //self.tblAttachments.reloadData()
                                        if let status = dict?["Status"] as? String {
                                            if(status == "1"){
                                                AppConstant.currClassName = self.className
                                                if let msg = dict?["Message"] as? String{
                                                    AppConstant.requestPopupMsg = msg
                                                }
                                                
                                                AppConstant.selectedViewTag = "3"
                                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
                                            }else{
                                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.savePostedFileUrl)
                                            }
                                        }
                                    }
                                    
                                    break
                                    
                                case .failure(_):
                                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.savePostedFileUrl)
                                    break
                                }
                                
                            }
                        case .failure(let encodingError):
                            AppConstant.hideHUD()
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.savePostedFileUrl)
                        }
            })
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToUploadAttachments(){
        if ((className == StringConstant.teleconsultRequest) && self.arrImages.count == 0){
            AppConstant.currClassName = self.className
            AppConstant.hideHUD()
            AppConstant.selectedViewTag = "3"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
            
            AppConstant.imageUploadStartTime = nil
        }else{
            AppConstant.showHUD(title: "Loading...")
            //save Image upload Start Time
            AppConstant.imageUploadStartTime = Date()
            
            if className == StringConstant.uploadMedicalChit{
                self.uploadImageToServerForMedicalChit()
            }else{
                self.uploadImageToServer()
            }
        }
    }
    
    func uploadImageToServer(){
        if(AppConstant.hasConnectivity()) {//true connected
            let imagesBo = self.arrImages[self.imageUploadedCount]
             AppConstant.setHudTitle(title: "Uploading \(self.imageUploadedCount + 1) of \(self.arrImages.count)")
            
                        
            let imageStr = imagesBo.imgData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            let parameters: Parameters = [
                //"UserId": userName,
                //"Password": password,
                "pstClaimId": strClaimId,
                "pstMemId": strMemId,
                "pstUploadFileName" : imagesBo.name!,
                "pstUploadFileData" : imageStr
            ]
            //print(parameters)
            print("Item=== \(imagesBo.name!)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            //print("params===\(parameters)")
            print("url===\(AppConstant.savePostedFileUrl)")
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.savePostedFileUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    //AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            //AppConstant.hideHUD()
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToUploadAttachments()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            
                            if let status = dict?["Status"] as? String {
                                print("Successsss")
                                if(status == "1"){//Success
//                                    if index < self.arrImages.count{
//                                        self.arrImages.remove(at: index)
//                                    }
                                    
                                    //self.tblAttachments.reloadData()
                                    
                                    self.imageUploadedCount = self.imageUploadedCount + 1
                                    
                                    AppConstant.currClassName = self.className
                                    
                                    if let msg = dict?["Message"] as? String{
                                        AppConstant.requestPopupMsg = msg
                                    }
                                    
                                    if self.arrImages.count == self.imageUploadedCount{
                                        AppConstant.hideHUD()
                                        self.imageUploadedCount = 0
                                        AppConstant.selectedViewTag = "3"
                                        
                                        //Calculate image upload time
                                        if AppConstant.imageUploadStartTime != nil{
                                            print("Upload start Time = \(AppConstant.imageUploadStartTime!)")
                                            print("Upload end Time = \(Date())")
                                            AppConstant.imageUploadEndTime = Date()
                                            let time = AppConstant.imageUploadEndTime!.offsetFrom(ToDate: AppConstant.imageUploadStartTime!, FromDate: AppConstant.imageUploadEndTime!)
                                            
                                            let strStartTime = AppConstant.formattedDate(date: AppConstant.imageUploadStartTime!, withFormat: StringConstant.dateFormatter1, ToFormat: StringConstant.dateFormatter5)
                                            
                                            let strEndTime = AppConstant.formattedDate(date: AppConstant.imageUploadEndTime!, withFormat: StringConstant.dateFormatter1, ToFormat: StringConstant.dateFormatter5)
                                            
                                            AppConstant.strUploadTime = "Start Time: \(strStartTime!)\nEnd Time: \(strEndTime!)\n\nTotal Time: \(time)"
                                            
                                        }
                                        AppConstant.hideHUD()
                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
                                        
                                        AppConstant.imageUploadStartTime = nil
                                    }else{
                                        //AppConstant.hideHUD()
                                        self.uploadImageToServer()
                                    }
                                }else{
                                    AppConstant.hideHUD()
                                    var errorMessage = ""
                                    if let msg = dict?["Message"] as? String{
                                        errorMessage = msg
                                        self.displayAlert(message: msg)
                                    }
                                    self.serviceCallToDeactivateOnlineClaim(claimId: self.strClaimId, errMsg: errorMessage)
                                    //AppConstant.showNetworkAlertMessage()
                                }
                            }else{
                                var errorMessage = ""
                                if let msg = dict?["Message"] as? String{
                                    errorMessage = msg
                                    self.displayAlert(message: msg)
                                }
                                self.serviceCallToDeactivateOnlineClaim(claimId: self.strClaimId, errMsg: errorMessage)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.hideHUD()
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.savePostedFileUrl)
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func uploadImageToServerForMedicalChit(){
        if(AppConstant.hasConnectivity()) {//true connected
            //AppConstant.showHUD()
            let imagesBo = self.arrImages[self.imageUploadedCount]
            AppConstant.setHudTitle(title: "Uploading \(self.imageUploadedCount + 1) of \(self.arrImages.count)")
            
            let imageStr = imagesBo.imgData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            let parameters: Parameters = [
                "pstClaimID": strClaimId,
                "pstCardNo": cardNo,
                "pstUploadFileName" : imagesBo.name!,
                "pstUploadFileData" : imageStr
            ]
            print(parameters)
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            //print("params===\(parameters)")
            print("url===\(AppConstant.uploadMedicalChitUrl)")
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.uploadMedicalChitUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    //AppConstant.hideHUD()
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            //AppConstant.hideHUD()
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToUploadAttachments()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)
                            
                            if let status = dict?["Status"] as? String {
                                print("Successsss")
                                if(status == "1"){
                                    self.imageUploadedCount = self.imageUploadedCount + 1
                                    
                                    AppConstant.currClassName = self.className
                                    
                                    if let msg = dict?["Message"] as? String{
                                        AppConstant.requestPopupMsg = msg
                                    }
                                    
                                    if self.arrImages.count == self.imageUploadedCount{
                                        AppConstant.hideHUD()
                                        self.imageUploadedCount = 0
                                        
                                        //Calculate image upload time
                                        if AppConstant.imageUploadStartTime != nil{
                                            print("Upload start Time = \(AppConstant.imageUploadStartTime!)")
                                            print("Upload end Time = \(Date())")
                                            AppConstant.imageUploadEndTime = Date()
                                            let time = AppConstant.imageUploadEndTime!.offsetFrom(ToDate: AppConstant.imageUploadStartTime!, FromDate: AppConstant.imageUploadEndTime!)
                                            
                                            let strStartTime = AppConstant.formattedDate(date: AppConstant.imageUploadStartTime!, withFormat: StringConstant.dateFormatter1, ToFormat: StringConstant.dateFormatter5)
                                            
                                            let strEndTime = AppConstant.formattedDate(date: AppConstant.imageUploadEndTime!, withFormat: StringConstant.dateFormatter1, ToFormat: StringConstant.dateFormatter5)
                                            
                                            AppConstant.strUploadTime = "Start Time: \(strStartTime!)\nEnd Time: \(strEndTime!)\n\nTotal Time: \(time)"
                                            
                                        }
                                        AppConstant.currClassName = StringConstant.uploadMedicalChit
                                        
                                        self.viewParent.isUserInteractionEnabled = true
                                        self.viewParent.backgroundColor = UIColor.white
                                        self.add(asChildViewController: self.submitViewController)
                                        AppConstant.imageUploadStartTime = nil
                                    }else{
                                        self.uploadImageToServerForMedicalChit()
                                    }
                                }else{
                                    AppConstant.hideHUD()
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                    
                                    //AppConstant.showNetworkAlertMessage()
                                }
                            }else{
                                AppConstant.hideHUD()
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg)
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.hideHUD()
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.savePostedFileUrl)
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToPostViewRatingbyClaimId(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            var url = AppConstant.postRatingbyClaimId
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            let pstMemID:String = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            let requestParams: Parameters = [
                "pstMemID": pstMemID ,
                "pstClaimID": strClaimId ,
                "pstRating": rating ,
                "pstStar": rating ,
                "pstRatingRemarks": ratingRemarks ,
            ]
            print("params===\(requestParams)")
            print("url===\(url)")
            Alamofire.request( url, method: .post, parameters: requestParams, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.isHudShowing = false
                    MBProgressHUD.hideAllHUDs(for: appDelegate.window, animated: true)
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToPostViewRatingbyClaimId()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    //Service call to upload attachments
                                    if self.arrImages.count > 0{
                                        if let ratingId = dict?["RatingID"] as? String{
                                            self.postRatingFileService(pstRatingID: ratingId)
                                        }
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.showAlertPopup(message: msg)
                                        }
                                    }
                                }else{
                                    //Failure
                                    AppConstant.imageUploadStartTime = nil
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.imageUploadStartTime = nil
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func postRatingFileService(pstRatingID: String){
        if(AppConstant.hasConnectivity()) {//true connected
            let imagesBo = self.arrImages[self.imageUploadedCount]
            AppConstant.setHudTitle(title: "Uploading \(self.imageUploadedCount + 1) of \(self.arrImages.count)")
            let imageStr = imagesBo.imgData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            let parameters: Parameters = [
                "pstRatingID": pstRatingID,
                "pstUploadFileName": imagesBo.name!,
                "pstUploadFileData" : imageStr,
            ]
            print(parameters)
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            print("url===\(AppConstant.postSaveRatingDoc)")
            AppConstant.showHUD()
            Alamofire.request( AppConstant.postSaveRatingDoc, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postRatingFileService(pstRatingID: pstRatingID)
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                print("Successsss")
                                if(status == "1"){
                                    self.imageUploadedCount = self.imageUploadedCount + 1
                                    if self.arrImages.count == self.imageUploadedCount{
                                        AppConstant.hideHUD()
                                        self.imageUploadedCount = 0
                                        if let msg = dict?["Message"] as? String{
                                            self.showAlertPopup(message: msg)
                                        }
                                    }else{
                                        self.postRatingFileService(pstRatingID: pstRatingID)
                                    }
                                }else{
                                    AppConstant.hideHUD()
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg)
                                    }
                                }
                            }else{
                                AppConstant.hideHUD()
                                if let msg = dict?["Message"] as? String{
                                    self.displayAlert(message: msg)
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.hideHUD()
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postSaveRatingDoc)
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func postRatingbyProviderService(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            var url = AppConstant.postRatingbyProvider
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            let pstMemID:String = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            let requestParams: Parameters = [
                "pstMemID": pstMemID ,
                "pstProviderID": providerCode,
                "pstRating": rating ,
                "pstStar": rating ,
                "pstRatingRemarks": ratingRemarks ,
            ]
            print("params===\(requestParams)")
            print("url===\(url)")
            Alamofire.request( url, method: .post, parameters: requestParams, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.isHudShowing = false
                    MBProgressHUD.hideAllHUDs(for: appDelegate.window, animated: true)
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postRatingbyProviderService()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    //Service call to upload attachments
                                    if self.arrImages.count > 0{
                                        if let ratingId = dict?["RatingID"] as? String{
                                            self.postRatingFileService(pstRatingID: ratingId)
                                        }
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.showAlertPopup(message: msg)
                                        }
                                    }
                                }else{
                                    //Failure
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
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
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "viewDoc"){
            let vc = segue.destination as! ViewDocumentViewController
            vc.arrImages = arrImages
            vc.pageHeader = pageHeader
            vc.scrolledToIndex = selectedIndex
            return
        }
    }
    
    // MARK: - Helper Methods
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        self.viewParent.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.viewParent.bounds
        viewController.view.clipsToBounds = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.view.clipsToBounds = false
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }

}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}
extension Date {
    
    func offsetFrom(ToDate : Date, FromDate : Date) -> String {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: ToDate, to: FromDate);

        var seconds = "\(difference.second ?? 1) sec"
        if difference.second != nil{
            if seconds == "0 sec"{
                seconds = "1 sec"
            }
        }
        let minutes = "\(difference.minute ?? 0) min" + ":" + seconds
        let hours = "\(difference.hour ?? 0) hr" + ":" + minutes

        
        return hours
    }
    
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
