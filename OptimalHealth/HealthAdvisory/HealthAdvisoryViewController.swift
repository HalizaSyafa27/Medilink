//
//  HealthAdvisoryViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class HealthAdvisoryViewController: BaseViewController,UIImagePickerControllerDelegate , UIPopoverControllerDelegate , UINavigationControllerDelegate, ChooseDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var txtViewQuestion: UITextView!
    @IBOutlet weak var tblAttachments: UITableView!
    //    @IBOutlet var imgViewAttachment: UIImageView!
    //    @IBOutlet var viewAttachment: UIView!
    @IBOutlet var btnOpen: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet var imgViewViewAgree: UIImageView!
    @IBOutlet var lblTerms: UILabel!
    @IBOutlet var viewCategoryDesc: UIView!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var viewAttachmentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    
    var picker:UIImagePickerController? = UIImagePickerController()
    //    var uploadImage : UIImage?
    var selectedSubject : String = "Alternative,Traditional and Complementary Care Advisory"
    var arrCategory = ["Emotional Well Being & Mental Health",
                       "Men\'s Health","Wellness & Prevention","Women's Health","Skin Care","Beauty"]
    var isAgreeToTerms : Bool = false
    var arrDropdown = [AdvisoryDropdownBo]()
    var selectedDropdownBo = AdvisoryDropdownBo()
    var pageHeader = ""
    
    var attachmentType = ""
    var attachmentFileUrl : URL?
    let allowedFileypes = ["pdf","doc","docx","xls","xlsx","ppt","pptx","png","jpg","jpeg","txt"]
    var arrImages = [UploadImageBo]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
        }
        //        viewContainer.isHidden = true
        //        viewAttachment.isHidden = true
        //        viewAttachment.layer.borderColor = AppConstant.themeSeparatorGrayColor.cgColor
        //        viewAttachment.layer.borderWidth = 1.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.agreeToTermsLink(_:)))
        self.lblTerms.addGestureRecognizer(tap)
        self.lblTerms.isUserInteractionEnabled = true
        print(pageHeader)
        lblPageHeader.text = pageHeader
        lblSubject.text = pageHeader + " Advisory Request"
        
        txtFldName.text =  AppConstant.retrievFromDefaults(key: StringConstant.name)
        txtFldEmail.text = AppConstant.retrievFromDefaults(key: StringConstant.emailAddress)
        //        apiCallToGetDropdownlist()
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //    @IBAction func btnRemoveAttachmentAction(_ sender: UIButton) {
    //        viewAttachment.isHidden = true
    //        self.uploadImage = nil
    //        self.imgViewAttachment.image = nil
    //        btnOpen.isHidden = false
    //    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        self.serviceCallTosendDataToServer()
    }
    
    @IBAction func btnAddAttachment(_ sender: UIButton) {
        self.picker?.delegate = self
        let alertController = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        
        let galleryButton = UIAlertAction(title: "Gallery", style: .default, handler: { (action) -> Void in
            self.picker!.allowsEditing = false
            self.picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(self.picker!, animated: true, completion: nil)
        })
        let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
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
            }
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        alertController.addAction(galleryButton)
        alertController.addAction(cameraButton)
        alertController.addAction(cancelButton)
        
        alertController.view.tintColor = AppConstant.themeRedColor
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func subjectBtnAction (_ sender: UIButton) {
        performSegue(withIdentifier: "choose_subject", sender: self)
    }
    
    @IBAction func btnAgreeToTerms (_ sender: UIButton) {
        isAgreeToTerms = !isAgreeToTerms
        imgViewViewAgree.image = isAgreeToTerms == true ? UIImage.init(named: "checkbox_active")  : UIImage.init(named: "checkbox")
    }
    
    @objc func agreeToTermsLink (_ sender: UITapGestureRecognizer) {
        self.displayAlert(message: "Term of Use\n I understand and acknowledge that advice, messages, are for informational purpose only and DOES NOT CONSTITUTE THE PROVIDING OF MEDICAL ADVICE and is not intended to be a substitute for independent professional medical judgement, advice, diagnosis, or treatment.")
    }
    
    //MARK: Choose Option Delegate
    func selectedItem(item: String,type: String){
    }
    
    func selectedObject(obj: CustomObject,type: String){
        if type == "choose_subject" {
            selectedDropdownBo = self.arrDropdown[obj.index!]
        }
    }
    
    //MARK: Image Picker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(
            animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            
            self.attachmentType = "image"
            let uploadImgBo = UploadImageBo()
            var imgData: NSData = pickedImage.jpegData(compressionQuality: 1.0)! as NSData
            let bPreBitmap = imgData.length // Ukuran asli dalam byte
            
            print("Before Compression size: \(Double(bPreBitmap) / 1024.0) KB")
            
            var finalImage = pickedImage
            //
            //            if let image = pickedImage.compressTo(Int(1*1024*1024)){
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
                //if uk 1MB - 3MB, resize 50%
                if let resizedImage = pickedImage.resized(withPercentage: 0.5){
                    finalImage = resizedImage
                }
            } else if bPreBitmap > 3_000_000{
                if let resizedImage = pickedImage.resized(withPercentage: 0.3){
                    finalImage = resizedImage
                }
            }
            
            // Kompresi gambar yang sudah di-resize atau yang original jika tidak perlu resize
            if let compressedData = finalImage.jpegData(compressionQuality: 0.7) as NSData? {
                imgData = compressedData
            }
            
            print("After Compression size: \(Double(imgData.length) / 1024.0) KB")
            
            let sizeKB = Double(imgData.length / 1024)
            
            let timestamp = Int(NSDate().timeIntervalSince1970)
            uploadImgBo.name = String("\(timestamp).PNG")
            //            uploadImgBo.size = String("\(sizeKB) KB")
            uploadImgBo.size = "\(imgData.length / 1024) KB"
            uploadImgBo.imgData = imgData
            
            uploadImgBo.image = UIImage(data: imgData as Data)
            self.arrImages.append(uploadImgBo)
        }
        dismiss(animated: true, completion: nil)
        self.tblAttachments.reloadData()
    }
    
    @objc func removeFileAction(_ sender: UIButton) {
        if (self.arrImages.count) > 0{
            self.arrImages.remove(at: sender.tag)
            self.tblAttachments.reloadData()
        }
    }
    
    @objc func showImageeAction(_ sender: UITapGestureRecognizer) {
        selectedIndex = (sender.view?.tag)!
        self.performSegue(withIdentifier: "viewDoc1", sender: self)
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WellnessTableViewCell", for: indexPath as IndexPath) as! WellnessTableViewCell
        
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
    
    //MARK: Service Call Action
    func serviceCallTosendDataToServer(){
        if(AppConstant.hasConnectivity()) {//true connected
            if txtFldName.text == ""{
                self.displayAlert(message: StringConstant.nameBlankValidationMsg)
                return
            }else if txtFldEmail.text == ""{
                self.displayAlert(message: StringConstant.emailBlankValidationMsg)
                return
            }else if !AppConstant.isValidEmail(emailId: (txtFldEmail?.text)!) {
                self.displayAlert(message: StringConstant.emailValidation)
                return
            }else if txtViewQuestion.text == ""{
                self.displayAlert(message: "Please enter your question")
                return
            }else if self.isAgreeToTerms == false{
                self.displayAlert(message: StringConstant.agreeToTCValidation)
                return
            }else{
                AppConstant.showHUD()
                var parameters: Parameters = [
                    "pstName": txtFldName.text!,
                    "pstSubject": lblSubject.text! + " from " + txtFldName.text!,
                    "pstEmail": txtFldEmail.text!,
                    "pstQuestion": txtViewQuestion.text!,
                    "pstPhone": AppConstant.retrievFromDefaults(key: StringConstant.email),
                    "pstNRIC": AppConstant.retrievFromDefaults(key: StringConstant.nationalId),
                ]
                
                let headers: HTTPHeaders = [
                    "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                    "Accept": "application/json"
                ]
                
                var multipartFormData = [InputFileUpload]()
                for imagesBo in self.arrImages {
                    if imagesBo.image != nil{
                        let oimgData = imagesBo.image!.jpegData(compressionQuality: 1.0)
                        let osizeKB = Double(oimgData!.count / 1024)
                        print("Original Image Size = \(osizeKB) KB")
                        
                        let bPreBitmap = oimgData!.count //ukuran asli img
                        var finalImage = imagesBo.image! //gambar asli
                        
                        if bPreBitmap > 1_000_000 && bPreBitmap <= 3_000_000 {
                            //uk 1MB - 3MB, resize 50%
                            if let resizedImage = imagesBo.image!.resized(withPercentage: 0.5) {
                                finalImage = resizedImage
                            }
                        } else if bPreBitmap > 3_000_000 {
                            // uk lebih dari 3MB, resize ke 30%
                            if let resizedImage = imagesBo.image!.resized(withPercentage: 0.3) {
                                finalImage = resizedImage
                            }
                        }
                        
                        // Kompresi gambar yang sudah di-scale atau tidak perlu scale
                        var imgData = finalImage.jpegData(compressionQuality: 0.7)
                        
                        //                        let timestamp = NSDate().timeIntervalSince1970
                        //                        let strImagename = String("\(timestamp).PNG")
                        //                        let thumb1 = imagesBo.image!.resized(withPercentage: 0.3)
                        //                        var imgData = thumb1!.jpegData(compressionQuality: 0.5)
                        //                        if (Double(imgData!.count / 1024) > 300) && (Double(imgData!.count / 1024) < 400){
                        //                            let thumb1 = imagesBo.image!.resized(withPercentage: 0.3)
                        //                            imgData = thumb1!.jpegData(compressionQuality: 0.5)!
                        //                        }else if (Double(imgData!.count / 1024) > 400) && (Double(imgData!.count / 1024) < 500){
                        //                            let thumb1 = imagesBo.image!.resized(withPercentage: 0.4)
                        //                            imgData = thumb1!.jpegData(compressionQuality: 0.5)!
                        //                        }else if Double(imgData!.count / 1024) > 500{
                        //                            let thumb1 = imagesBo.image!.resized(withPercentage: 0.3)
                        //                            imgData = thumb1!.jpegData(compressionQuality: 0.5)!
                        //                        }
                        let sizeKB = Double(imgData!.count / 1024)
                        print("Image Size = \(sizeKB) KB")
                        
                        if let data = imgData{
                            let timestamp = NSDate().timeIntervalSince1970
                            let strImagename = String("\(timestamp).PNG")
                            
                            let itemFile = InputFileUpload()
                            itemFile.pstFileName = strImagename
                            itemFile.pstFile = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                            multipartFormData.append(itemFile)
                        }
                    }
                }
                parameters["pstFiles"] = multipartFormData
                print("params===\(parameters)")
                print("url===\(AppConstant.postAdvisory)")
                AFManager.request( AppConstant.postAdvisory, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                    .responseString { response in
                        debugPrint(response)
                        switch(response.result) {
                        case .success(_):
                            let headerStatusCode : Int = (response.response?.statusCode)!
                            print("Status Code: \(headerStatusCode)")
                            if(headerStatusCode == 401){//Session expired
                                AppConstant.hideHUD()
                                self.isTokenVerified(completion: { (Bool) in
                                    if Bool{
                                        self.serviceCallTosendDataToServer()
                                    }
                                })
                            }else{
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                if let status = dict?["Status"] as? String {
                                    if(status == "1"){
                                        if let msg = dict!["Message"] as? String{
                                            let alert = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                _ = self.navigationController?.popViewController(animated: true)
                                            }))
                                            alert.view.tintColor = AppConstant.themeRedColor
                                            self.present(alert, animated: true)
                                        }
                                    }else{
                                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postAdvisory)
                                    }
                                }else{
                                    
                                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postAdvisory)
                                }
                            }
                            AppConstant.hideHUD()
                            break
                        case .failure(_):
                            AppConstant.hideHUD()
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.postAdvisory)
                            break
                        }
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func setDataForDropdown(title: String) -> [CustomObject]{
        var arrData = [CustomObject]()
        if title == "choose_subject"{
            for data in arrDropdown{
                let obj = CustomObject()
                obj.code = data.id
                obj.name = data.type
                obj.index = data.index
                
                arrData.append(obj)
            }
        }
        
        return arrData
    }
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "choose_subject") {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = true
            vc.arrData = self.setDataForDropdown(title: segue.identifier!)
            
        }else if (segue.identifier == "viewDoc1"){
            let vc = segue.destination as! ViewDocumentViewController
            vc.arrImages = arrImages
            vc.pageHeader = pageHeader
            vc.scrolledToIndex = selectedIndex
            return
        }
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
extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ sizeInBytes:Int) -> UIImage? {
        //let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count <= sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
