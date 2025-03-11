//
//  ContactUsController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/3/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift
import MessageUI
import MobileCoreServices

class ContactUsController: BaseViewController , ChooseDelegate , UIImagePickerControllerDelegate , UIPopoverControllerDelegate , UINavigationControllerDelegate, UITextViewDelegate,ChooseMenuDelegate, MFMailComposeViewControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    
    @IBOutlet weak var subjectBtn: UIButton!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var removeImageBtn: UIButton!
    @IBOutlet weak var attachImage: UIImageView!
    @IBOutlet weak var attachImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var attachView: UIView!
    @IBOutlet weak var attachViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingSubmitWithLabel: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingSubmitWithImage: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingDropUsALine: NSLayoutConstraint!
    
    @IBOutlet var lblInfo1: UILabel!
    @IBOutlet var lblInfo2: UILabel!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtFldEmail: UITextField!
    @IBOutlet var txtViewMsg: UITextView!
    @IBOutlet var viewInfo: UIView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblRemainingCharTitle: UILabel!
    @IBOutlet var lblRemainingChar: UILabel!
    @IBOutlet var lblOr: UILabel!
    @IBOutlet weak var btnCallCustomerCare: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var heightConstraintInfo1: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintInfo2: NSLayoutConstraint!
    @IBOutlet weak var topConstraintCustomerCare: NSLayoutConstraint!
    @IBOutlet weak var lblFileName: UILabel!
    @IBOutlet weak var lblUploadAttachment: UILabel!
    
    //let arrSubjectType = ["Sales Inquiry", "General Inquiry", "Investor Relation/Corporate Affairs", "Customer Service Feedback"]
    let arrSubjectType = ["Sales Inquiry", "General Inquiry"] //"Customer Service Feedback"]
    
    var selectedSubjectType = ""
    var picker:UIImagePickerController? = UIImagePickerController()
    var uploadImage : UIImage?
    var isFromLandingPage: Bool = false
    var attachmentType = ""
    var attachmentFileUrl : URL?
    let allowedFileypes = ["pdf","doc","docx","xls","xlsx","ppt","pptx","png","jpg","jpeg","txt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    func initDesigns() {
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        if (AppConstant.isSlidingMenu == true) {
            backBtn?.setImage(UIImage(named : "menu") , for: .normal)
        }
        else {
            backBtn?.setImage(UIImage(named : "left_arrow") , for: .normal)
        }
        if isFromLandingPage{
            self.btnHome.isHidden = true
        }
        addImageBtn.isHidden = true
        lblUploadAttachment.isHidden = true
//        lblInfo1.font = UIFont.init(name: "Poppins-Regular", size: 12.0)
//        lblInfo2.font = UIFont.init(name: "Poppins-Regular", size: 12.0)
        
        attachImage.isHidden = true
        attachImageHeightConstraint.constant = 0
        attachView.isHidden = true
        attachViewHeightConstraint.constant = 0
        verticalSpacingSubmitWithImage.constant = 0
        verticalSpacingSubmitWithLabel.constant = 50
        self.removeImageBtn?.isHidden = true
        lblFileName.isHidden = true
        
        lblRemainingCharTitle.isHidden = false
        lblRemainingChar.isHidden = false
        self.picker?.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        viewInfo.layer.borderColor = AppConstant.themeRedColor.cgColor
        viewInfo.layer.borderWidth = 1.0
        txtViewMsg.layer.borderColor = AppConstant.themeGrayColor.cgColor
        txtViewMsg.layer.borderWidth = 1.0
        attachView.layer.borderWidth = 1.5
        attachView.layer.borderColor = AppConstant.themeGrayColor.cgColor
        
        addImageBtn.layer.cornerRadius = addImageBtn.frame.height/2
        addImageBtn.clipsToBounds = true
        btnSubmit.layer.cornerRadius = btnSubmit.frame.height/2
        btnSubmit.clipsToBounds = true
        viewInfo.layer.cornerRadius = btnSubmit.frame.height/2
        viewInfo.clipsToBounds = true
        
//        lblInfo1.isHidden = true
//        lblInfo2.isHidden = true
//        heightConstraintInfo1.constant = 0
//        heightConstraintInfo2.constant = 0
//        verticalSpacingDropUsALine.constant = 0
    
        //If Logged in
        if AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) == StringConstant.YES {
//            txtFldEmail.isUserInteractionEnabled = false
            txtFldEmail.text = AppConstant.retrievFromDefaults(key: StringConstant.emailAddress)
            txtFldName.text =  AppConstant.retrievFromDefaults(key: StringConstant.name)
            
        }else{
            verticalSpacingDropUsALine.constant = 8
            btnCallCustomerCare.isHidden = true
            lblOr.isHidden = true
        }
        
        //Hide Video call button
        verticalSpacingDropUsALine.constant = 8
        btnCallCustomerCare.isHidden = true
        lblOr.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.dismissKeyboard()
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnCustomerCareAction(_ sender: Any) {
        let authStoryboard =  UIStoryboard(name: "Users", bundle: nil)
        let authController = authStoryboard.instantiateViewController(withIdentifier: "UsersViewController")
        navigationController?.pushViewController(authController, animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func subjectBtnAction (_ sender: UIButton) {
        performSegue(withIdentifier: "subject_type", sender: self)
    }
    
    @IBAction func removeImageBtnAction(sender: AnyObject){
        attachImage.isHidden = true
        attachImageHeightConstraint.constant = 0
        attachView.isHidden = true
        attachViewHeightConstraint.constant = 0
        verticalSpacingSubmitWithImage.constant = 0
        verticalSpacingSubmitWithLabel.constant = 50
        self.uploadImage = nil
        self.attachImage.image = nil
        self.removeImageBtn?.isHidden = true
        attachmentType = ""
//        addImageBtn.isHidden = false
        lblFileName.isHidden = true
       
    }
    
    @IBAction func addImageBtnAction (_ sender: UIButton) {
        self.performSegue(withIdentifier: "contactUs_AttachmentPopUp", sender: self)
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "AttachmentPopUpViewController") as! AttachmentPopUpViewController
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        self.submitData()
    }
    
    //MARK: Delegates
    func selectedItem(item: String, type: String) {
        if (type == "subject_type") {
            selectedSubjectType = item
            if (selectedSubjectType == "Sales Inquiry") {
                subjectBtn?.setTitle(selectedSubjectType, for: .normal)
            }
            else if (selectedSubjectType == "General Inquiry") {
                subjectBtn?.setTitle(selectedSubjectType, for: .normal)
            }
            else if (selectedSubjectType == "Investor Relation/Corporate Affairs") {
                subjectBtn?.setTitle(selectedSubjectType, for: .normal)
            }
            else if (selectedSubjectType == "Customer Service Feedback") {
                subjectBtn?.setTitle(selectedSubjectType, for: .normal)
            }
        }
    }
    
    //MARK: Choose Menu Delegate
    func selectedDocumentPickerPopup(tag : Int){
        if tag == 1{//Document
            self.openDocumentController()
        }else if tag == 2{//Gallery
          self.picker!.allowsEditing = false
          self.picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
          self.present(self.picker!, animated: true, completion: nil)
        }else if tag == 3{//Camera
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                self.picker!.allowsEditing = false
                self.picker!.sourceType = UIImagePickerController.SourceType.camera
                self.picker!.cameraCaptureMode = .photo
                self.present(self.picker!, animated: true, completion: nil)
             }else{
                self.displayAlert(message: "Camera Not Found.Your device has no Camera.")
            }
        }
    }
    
    //MARK: Image Picker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(
            animated: true, completion: nil)
    }
    
    //handle ui image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            attachImage.isHidden = false
            attachImageHeightConstraint.constant = 80
            attachView.isHidden = false
            attachViewHeightConstraint.constant = 125
            verticalSpacingSubmitWithImage.constant = 30
            verticalSpacingSubmitWithLabel.constant = 175
            attachImage.contentMode = .scaleToFill
            attachImage.image = pickedImage
            self.uploadImage = pickedImage
            self.removeImageBtn?.isHidden = false
            attachmentType = "image"
            addImageBtn.isHidden = true
            attachView.layer.borderWidth = 1.5
            attachView.layer.borderColor = AppConstant.themeGrayColor.cgColor
            
        }
        dismiss(animated: true, completion: nil)
    }
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "subject_type") {
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.type = segue.identifier!
            vc.isCustomObj = false
            vc.arrItems = self.arrSubjectType
            
        }else if (segue.identifier == "contactUs_AttachmentPopUp"){
            let vc = segue.destination as! AttachmentPopUpViewController
            vc.delegate = self
        }
    }
    
    //MARK:- TextView Delegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //100 chars restriction
        
        return textView.text.count + (text.count - range.length) <= 100
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0{
            lblRemainingChar.isHidden = false
            lblRemainingCharTitle.isHidden = false
            lblRemainingChar.text = String(100 - (textView.text.count))
        }else{
            lblRemainingChar.isHidden = true
            lblRemainingCharTitle.isHidden = true
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        IQKeyboardManager.shared.keyboardDistance = 50
    }
    
    //MARK: Document controller
    func openDocumentController() {
        //https://stackoverflow.com/questions/38581723/how-to-access-cloud-drives-to-import-files-to-my-app-in-swift
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF),String(kUTTypePresentation),String(kUTTypeText)], in: .import)
        //let importMenu = UIDocumentMenuViewController(documentTypes: ["attachment.text", "attachment.data","attachment.pdf", "attachment.doc", "attachment.png"], in: .import)
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        present(importMenu, animated: true, completion: nil)
    }
    @available(iOS 8.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.checkFile(fileUrl: url)
    }
    @available(iOS 8.0, *)
    public func documentMenu(_ documentMenu:     UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        //print("we cancelled")
        dismiss(animated: true, completion: nil)
    }
    func checkFile(fileUrl: URL)
    {
        let filePath:NSString = fileUrl.absoluteString as NSString
        //  let onlyName = fileName.deletingPathExtension
        let onlyExt = filePath.pathExtension
        
        //print("onlyName : \(onlyName)")
        
        print("onlyExt : \(onlyExt)")
        if(!allowedFileypes.contains(onlyExt)){
            self.displayAlert(message: "Only files with the following extensions are allowed\n png,jpeg,pdf,doc,docx,xls,xlsx,ppt,pptx,txt")
            return
        }
//        let fileData = NSData (contentsOf: self.attachedFileUrl!) as Data?
//        if(fileData!.count > 5  1024  1024){
//            self.attachedFileUrl = nil
//            return
//        }
        
        attachImage.isHidden = false
        attachImageHeightConstraint.constant = 80
        attachView.isHidden = false
        attachViewHeightConstraint.constant = 125
        verticalSpacingSubmitWithImage.constant = 30
        verticalSpacingSubmitWithLabel.constant = 175
        attachImage.contentMode = .scaleToFill
        self.removeImageBtn?.isHidden = false
        addImageBtn.isHidden = true
        attachView.layer.borderWidth = 1.5
        attachView.layer.borderColor = AppConstant.themeGrayColor.cgColor
        
        if(onlyExt == "png" || onlyExt == "jpg" || onlyExt == "jpeg"){
            do {
                let imageData = try Data(contentsOf: fileUrl)
                self.attachImage.image = UIImage(data: imageData)
                self.attachmentType = "image"
                uploadImage = UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
        }else{
            verticalSpacingSubmitWithImage.constant = 40
            verticalSpacingSubmitWithLabel.constant = 185
            lblFileName.isHidden = false
            attachmentFileUrl = fileUrl
            uploadImage = nil
            self.attachmentType = "document"
            self.attachImage.image = UIImage.init(named: "file_iconRed")
            lblFileName.text = self.attachmentFileUrl!.lastPathComponent
            print(self.attachmentFileUrl!.lastPathComponent)
            //self.attchmentNameLabel.text = self.attachedFileUrl!.localizedName!
        }
        
    }
    
    //MARK: Email Composer
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["sales@medilink-global.com"])
            mailComposer.setMessageBody(txtViewMsg.text!, isHTML: true)
            mailComposer.setSubject((subjectBtn.titleLabel?.text)!)
            
            if self.uploadImage != nil{
                let timestamp = NSDate().timeIntervalSince1970
                let strImagename = String("\(timestamp).PNG")
                let imgData = self.uploadImage!.jpegData(compressionQuality: 0.5)
                if let data = imgData{
                    mailComposer.addAttachmentData(data, mimeType: "image/png", fileName: strImagename)
                }
            }
            
            mailComposer.mailComposeDelegate = self
            self.present(mailComposer, animated: true
                , completion: nil)
            
        } else {
            // show failure alert
            let msg = "Email is not configured in settings app or we are not able to send an email"
            print(msg)
            self.displayAlert(message: msg)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("User cancelled")
            break
            
        case .saved:
            print("Mail is saved by user")
            break
            
        case .sent:
            print("Mail is sent successfully")
            break
            
        case .failed:
            print("Sending mail is failed")
            break
        default:
            break
        }
        
        controller.dismiss(animated: true)
        
    }
    
    func submitData(){
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
            }else if subjectBtn.titleLabel?.text == "Select"{
                self.displayAlert(message: StringConstant.subjectBlankValidationMsg)
                return
            }else if txtViewMsg.text == ""{
                self.displayAlert(message: StringConstant.messageBlankValidationMsg)
                return
            }else{
                self.serviceCallTosendDataToServer()
                //self.sendEmail()
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Service Call Action
    func serviceCallTosendDataToServer(){

        let parameters: Parameters = [
            "pstName": txtFldName.text!,
            "pstSubject": (subjectBtn.titleLabel?.text)!,
            "pstEmailId": txtFldEmail.text!,
            "pstmessage": txtViewMsg.text!
        ]
        print(parameters)
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.postFeedback)")
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.postFeedback, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        if let status = dict!["Status"] as? String{
                            if(status == "1"){//Success
                                if let msg = dict!["Message"] as? String{
                                    let alert = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        _ = self.navigationController?.popViewController(animated: true)
                                    }))
                                    alert.view.tintColor = AppConstant.themeRedColor
                                    self.present(alert, animated: true)
                                }
                            }else{//Invalid login code
                                if let msg = dict!["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.hideHUD()
                            self.displayAlert(message: "Something went wrong.Please try again.")
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postFeedback)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            if self.uploadImage != nil &&  self.attachmentType == "image"{
//                let timestamp = NSDate().timeIntervalSince1970
//                let strImagename = String("\(timestamp).PNG")
//
//                let image = self.uploadImage!.compressTo(Int(1*1024*1024))
//
//                var imgData = image!.jpegData(compressionQuality: 0.3)!
//
//                if (Double(imgData.count / 1024) > 200) && (Double(imgData.count / 1024) < 400){
//                        let thumb1 = image!.resized(withPercentage: 0.5)
//                        imgData = thumb1!.jpegData(compressionQuality: 0.5)!
//                    }else if (Double(imgData.count / 1024) > 400) && (Double(imgData.count / 1024) < 500){
//                        let thumb1 = image!.resized(withPercentage: 0.4)
//                        imgData = thumb1!.jpegData(compressionQuality: 0.5)!
//                    }else if Double(imgData.count / 1024) > 500{
//                        let thumb1 = image!.resized(withPercentage: 0.3)
//                        imgData = thumb1!.jpegData(compressionQuality: 0.5)!
//                    }
//
//                    print("After Compression size of image in KB: %f ", Double(imgData.count) / 1024.0)
//                    print("After Compression size of image in MB: %f ", Double(imgData.count) / 1024.0/1024.0)
//
//                multipartFormData.append(imgData, withName: "fileid", fileName: strImagename, mimeType: "image/png")
//
//            }else if(self.attachmentFileUrl != nil){
//                let filePath:NSString = self.attachmentFileUrl!.absoluteString as NSString
//                let onlyExt = filePath.pathExtension
//
//                print("onlyExt : \(onlyExt)")
//                let fileData = NSData (contentsOf: self.attachmentFileUrl!) as Data?
//                if(fileData!.count > 4 * 1024 * 1024){
//                    print("Size of Image: \(fileData!.count) bytes")
//                }
//                // let data = NSData(contentsOf: url! as URL) as Data? // <==== Added 'as Data?'
//                var mimeType:String = ""
//                if(onlyExt == "pdf"){
//                    mimeType = "application/pdf"
//                }else if(onlyExt == "doc"){
//                    mimeType = "application/msword"
//                }else if(onlyExt == "docx"){
//                    mimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
//                }else if(onlyExt == "xls"){
//                    mimeType = "application/vnd.ms-excel"
//                }else if(onlyExt == "xlsx"){
//                    mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
//                }else if(onlyExt == "ppt"){
//                    mimeType = "application/vnd.ms-powerpoint"
//                }else if(onlyExt == "pptx"){
//                    mimeType = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
//                }else if(onlyExt == "png"){
//                    mimeType = "image/png"
//                }else if(onlyExt == "jpg" || onlyExt == "jpeg"){
//                    mimeType = "image/jpeg"
//                }else if(onlyExt == "txt"){
//                    mimeType = "text/plain"
//                }
//                print("self.attachedFileUrl!.localizedName! : \(self.attachmentFileUrl!.lastPathComponent)")
//                multipartFormData.append(fileData!, withName: "fileid", fileName: self.attachmentFileUrl!.lastPathComponent, mimeType: mimeType)
//
//            }
//
//        }, to: AppConstant.contactUsUrl, method: .post, headers: nil,
//           encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseString { response in
//
//                    switch(response.result) {
//                    case .success(_):
//                        debugPrint(response.result.value!)
//                        AppConstant.hideHUD()
//                        if(response.result.value! != "null"){
//                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
//                            if let msg = dict!["message"] as? String{
//                                let alert = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
//
//                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//
//                                    _ = self.navigationController?.popViewController(animated: true)
//                                }))
//                                alert.view.tintColor = AppConstant.themeRedColor
//                                self.present(alert, animated: true)
//                            }
//                        }else{
//                            AppConstant.hideHUD()
//                            self.displayAlert(message: "Something went wrong.Please try again.")
//                        }
//                        break
//
//                    case .failure(_):
//                        AppConstant.hideHUD()
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.contactUsUrl)
//                        break
//                    }
//
//                }
//            case .failure(let encodingError):
//                print("error:\(encodingError)")
//            }
//        })
    }
    
    
}

