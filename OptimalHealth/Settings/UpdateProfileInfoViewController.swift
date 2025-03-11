//
//  UpdateProfileInfoViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/02/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import AVFoundation
import RSKImageCropperSwift
import Alamofire

@objc protocol ProfileUpdateDelegate: class {
    @objc optional func profileUpdated()
}

class UpdateProfileInfoViewController: BaseViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate {
    
    @IBOutlet var imgViewProfile: UIImageView!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var viewPopup: UIView!
    
    var containerView = UIView()
    var uploadImage: UIImage?
    var picker = UIImagePickerController()
    var profileImage = UIImage(named: "userGray")
    var profileName = ""
    weak var delegate: ProfileUpdateDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()

    }
    
    func initDesign(){
        viewPopup.layer.borderColor = UIColor.init(hexString: "#D9D9D9").cgColor
        viewPopup.layer.borderWidth = 1.0
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.height/2
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.width/2
        self.imgViewProfile.layer.borderWidth = 1.5
        self.imgViewProfile.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewProfile.clipsToBounds = true
        self.imgViewProfile.image = profileImage
           
        self.txtFldName.layer.borderWidth = 1.5
        self.txtFldName.layer.borderColor = AppConstant.themeLightGrayColor.cgColor
        self.txtFldName.layer.cornerRadius = 10
        self.txtFldName.clipsToBounds = true
        self.txtFldName.text = profileName
           
        self.btnSave.layer.cornerRadius = self.btnSave.frame.height/2
        self.btnSave.clipsToBounds = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(showAttachmentView))
        imgViewProfile.addGestureRecognizer(tap)
        imgViewProfile.isUserInteractionEnabled = true
        picker.delegate = self
        
        viewPopup.layer.shadowColor = UIColor.black.cgColor
        viewPopup.layer.shadowOpacity = 1
        viewPopup.layer.shadowOffset = .zero
        viewPopup.layer.shadowRadius = 10
            
    }
    
    //MARK: Button Action
    @IBAction func btnCancelAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        serviceCallToUpdateDisplayname()
    }
    
    @objc func showAttachmentView(){
        self.view.endEditing(true)
        
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: AppConstant.screenSize.width, height: AppConstant.screenSize.height))
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addSubview(containerView)
        
        if AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl) != ""{
            let attactmentview = UIView(frame: CGRect(x: (AppConstant.screenSize.width/2 - 120), y: (AppConstant.screenSize.height/2 + 40), width: 240, height: 90))
            attactmentview.backgroundColor = UIColor.white
            attactmentview.layer.borderColor = UIColor.init(hexString: "#D9D9D9").cgColor
            attactmentview.layer.borderWidth = 1.0
            containerView.addSubview(attactmentview)
            
            let viewgallery = UIView(frame: CGRect(x: 10, y: 0, width: 70, height: 90))
            attactmentview.addSubview(viewgallery)
            let imgGallery = UIImageView(frame: CGRect(x: 10, y: 12, width: 40, height: 40))
            imgGallery.image = UIImage.init(named: "pictureImage")
            imgGallery.isUserInteractionEnabled = false
            viewgallery.addSubview(imgGallery)
            
            let lblGallery = UILabel(frame: CGRect(x: 10, y: imgGallery.frame.size.height + imgGallery.frame.origin.y, width: 40, height: 21))
            lblGallery.text = "Gallery"
            lblGallery.textColor = UIColor.init(hexString: "#333333")
            lblGallery.textAlignment = .center
            lblGallery.font = UIFont.systemFont(ofSize: 12.0)
            viewgallery.addSubview(lblGallery)
            lblGallery.isUserInteractionEnabled = false
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(openGallery))
            viewgallery.addGestureRecognizer(tap)
            viewgallery.isUserInteractionEnabled = true
            
            
            let viewcamera = UIView(frame: CGRect(x: viewgallery.frame.origin.x + viewgallery.frame.size.width + 10 , y: 0, width: 66.6, height: 90))
            attactmentview.addSubview(viewcamera)
            let imgCamera = UIImageView(frame: CGRect(x: 10, y: 12, width: 40, height: 40))
            imgCamera.image = UIImage.init(named: "cameraimage")
            imgCamera.isUserInteractionEnabled = false
            viewcamera.addSubview(imgCamera)
            
            let lblcamera = UILabel(frame: CGRect(x: 6, y: imgGallery.frame.size.height + imgGallery.frame.origin.y, width: 50, height: 21))
            lblcamera.text = "Camera"
            lblcamera.textColor = UIColor.init(hexString: "#333333")
            lblcamera.textAlignment = .center
            lblcamera.font = UIFont.systemFont(ofSize: 12.0)
            viewcamera.addSubview(lblcamera)
            viewcamera.isUserInteractionEnabled = false
            
            let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(openCamera))
            viewcamera.addGestureRecognizer(tap1)
            viewcamera.isUserInteractionEnabled = true
            
            let viewRemovepic = UIView(frame: CGRect(x: viewcamera.frame.origin.x + viewcamera.frame.size.width + 10, y: 0, width: 66.6, height: 90))
            attactmentview.addSubview(viewRemovepic)
            let imgRemove = UIImageView(frame: CGRect(x: 10, y: 12, width: 40, height: 40))
            imgRemove.image = UIImage.init(named: "remove")
            imgRemove.clipsToBounds = true
            imgRemove.contentMode = .scaleAspectFill
            imgRemove.isUserInteractionEnabled = false
            viewRemovepic.addSubview(imgRemove)
            
            let lblRemove = UILabel(frame: CGRect(x: 5, y: imgRemove.frame.size.height + imgRemove.frame.origin.y, width: 45, height: 21))
            lblRemove.text = "Remove"
            lblRemove.textColor = UIColor.init(hexString: "#333333")
            lblRemove.textAlignment = .center
            lblRemove.font = UIFont.systemFont(ofSize: 12.0)
            viewRemovepic.addSubview(lblRemove)
            lblRemove.isUserInteractionEnabled = false
            
            let tap3: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(serviceCallToDeleteProfilePic))
            viewRemovepic.addGestureRecognizer(tap3)
            viewRemovepic.isUserInteractionEnabled = true
        }else{
            let attactmentview = UIView(frame: CGRect(x: (AppConstant.screenSize.width/2 - 110), y: (AppConstant.screenSize.height/2 + 40), width: 220, height: 90))
            attactmentview.backgroundColor = UIColor.white
            attactmentview.layer.borderColor = UIColor.init(hexString: "#D9D9D9").cgColor
            attactmentview.layer.borderWidth = 1.0
            containerView.addSubview(attactmentview)
            
            let viewgallery = UIView(frame: CGRect(x: 30, y: 0, width: 70, height: 90))
            attactmentview.addSubview(viewgallery)
            let imgGallery = UIImageView(frame: CGRect(x: 10, y: 12, width: 40, height: 40))
            imgGallery.image = UIImage.init(named: "pictureImage")
            imgGallery.isUserInteractionEnabled = false
            viewgallery.addSubview(imgGallery)
            
            let lblGallery = UILabel(frame: CGRect(x: 10, y: imgGallery.frame.size.height + imgGallery.frame.origin.y, width: 40, height: 21))
            lblGallery.text = "Gallery"
            lblGallery.textColor = UIColor.init(hexString: "#333333")
            lblGallery.textAlignment = .center
            lblGallery.font = UIFont.systemFont(ofSize: 12.0)
            viewgallery.addSubview(lblGallery)
            lblGallery.isUserInteractionEnabled = false
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(openGallery))
            viewgallery.addGestureRecognizer(tap)
            viewgallery.isUserInteractionEnabled = true
            
            
            let viewcamera = UIView(frame: CGRect(x: viewgallery.frame.origin.x + viewgallery.frame.size.width + 20 , y: 0, width: 70, height: 90))
            attactmentview.addSubview(viewcamera)
            let imgCamera = UIImageView(frame: CGRect(x: 10, y: 12, width: 40, height: 40))
            imgCamera.image = UIImage.init(named: "cameraimage")
            imgCamera.isUserInteractionEnabled = false
            viewcamera.addSubview(imgCamera)
            
            let lblcamera = UILabel(frame: CGRect(x: 6, y: imgGallery.frame.size.height + imgGallery.frame.origin.y, width: 50, height: 21))
            lblcamera.text = "Camera"
            lblcamera.textColor = UIColor.init(hexString: "#333333")
            lblcamera.textAlignment = .center
            lblcamera.font = UIFont.systemFont(ofSize: 12.0)
            viewcamera.addSubview(lblcamera)
            viewcamera.isUserInteractionEnabled = false
            
            let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(openCamera))
            viewcamera.addGestureRecognizer(tap1)
            viewcamera.isUserInteractionEnabled = true
        }
        
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(removeAttachmentView))
        containerView.addGestureRecognizer(tap2)
        containerView.isUserInteractionEnabled = true
        
    }
    
    @objc func removeAttachmentView(){
        containerView.removeFromSuperview()
    }
    
    @objc func openCamera(){
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch (authStatus){
            
        case .notDetermined:
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerController.SourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.present(self.picker, animated: true, completion: nil)
            }
        case .restricted:
            showAlert(title: "Unable to access the Camera", message: "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app.")
        case .denied:
            showAlert(title: "Unable to access the Camera", message: "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app.")
        case .authorized:
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerController.SourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.present(self.picker, animated: true, completion: nil)
            }
        }
    }
    
    @objc func openGallery(){
        self.picker.allowsEditing = false
        self.picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.picker.allowsEditing = true
        self.present(self.picker, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { _ in
            // Take the user to Settings app to possibly change permission.
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        // Finished opening URL
                    })
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        })
        alert.addAction(settingsAction)
        
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Image Picker Delegate
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // Continue with Image
        self.dismiss(animated: true) {
            //self.continueWithImage(self.imageViewProfilePicture.image)
            var myImage : UIImage!
            if (picker.sourceType == UIImagePickerController.SourceType.photoLibrary) {
                
                if let imageData = image.jpegData(compressionQuality: 0.6) {
                    let imageSize: Int = imageData.count
                    let imgSizeInKB = Double(imageSize) / 1024.0
                    let imgSizeInMB = Double(imgSizeInKB) / 1024.0
                    print("size of image in MB: %f ", imgSizeInKB / 1024.0)
                    
                    myImage = self.fixOrientation(img: image)
                    
                }
                
            }else{
                if picker.cameraDevice == .front
                {
                    myImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
                }else{
                    myImage = self.fixOrientation(img: image)
                }
            }
            
            self.imgViewProfile?.contentMode = .scaleToFill
            //self.imgViewProfile?.image = croppedImage
            self.uploadImage = myImage
            let imgSize = self.calculateImageSize(image: self.uploadImage!)
            var compressData = self.uploadImage!.jpegData(compressionQuality: 0.5)
            
            if(imgSize > 0.5){
                compressData = self.uploadImage!.jpegData(compressionQuality: 0.3)
                self.uploadImage = UIImage(data: compressData!)
            }
            
            //self.imgViewProfile.image = myImage
            self.containerView.removeFromSuperview()
            
            self.serviceCallToUpdateProfilePic(imgdata: compressData!)
            
            let initialViewController : RSKImageCropViewController = RSKImageCropViewController.init(image: myImage, cropMode: RSKImageCropMode.circle)
            initialViewController.delegate = self
            //self.navigationController?.pushViewController(initialViewController, animated: true)
            
        }
    }
    @objc func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    func degradeOrientationOfImage(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    //RSKImageCropViewControllerDelegate
    func didCancelCrop(){
        containerView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func didCropImage(_ croppedImage: UIImage, usingCropRect cropRect: CGRect){
        
    }
    
    func willCropImage(_ originalImage: UIImage){
    }
    
    func didCropImage(_ croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat){
        self.navigationController?.popViewController(animated: true)
        self.imgViewProfile?.contentMode = .scaleToFill
        //self.imgViewProfile?.image = croppedImage
        self.uploadImage = croppedImage
        let imgSize = self.calculateImageSize(image: self.uploadImage!)
        var compressData = self.uploadImage!.jpegData(compressionQuality: 0.5)
        
        if(imgSize > 0.5){
            compressData = self.uploadImage!.jpegData(compressionQuality: 0.3)
            self.uploadImage = UIImage(data: compressData!)
        }
        
        imgViewProfile.image = croppedImage
        containerView.removeFromSuperview()
        
        self.serviceCallToUpdateProfilePic(imgdata: compressData!)
    }
    
    func deleteProfilePic(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteButton = UIAlertAction(title: "Delete Photo", style: .destructive, handler: { (action) -> Void in
            //Api call to delete photo
            self.serviceCallToDeleteProfilePic()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            //popoverPresentationController.sourceRect = sender.bounds
        }
        alertController.view.tintColor = AppConstant.themeRedColor
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    func calculateImageSize(image : UIImage) -> Double {
        var imgSizeInMB : Double = 0
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let imageSize: Int = imageData.count
            let imgSizeInKB = Double(imageSize) / 1024.0
            imgSizeInMB = Double(imgSizeInKB) / 1024.0
            print("size of image in MB: %f ", imgSizeInKB / 1024.0)
        }
        return imgSizeInMB
    }
    
    //MARK: Service Call
    @objc func serviceCallToDeleteProfilePic(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let medId = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            print("url===\(AppConstant.postRemoveProfilePicUrl)")
            let params: Parameters = [
                "pstMemId": medId            ]
            
            print("url===\(params)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
    
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.postRemoveProfilePicUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseJSON { response in
                AppConstant.hideHUD()
                
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    let dict = response.result.value as! [String : AnyObject]
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToDeleteProfilePic()
                            }
                        })
                    }else{
                        if let status = dict["Status"] as? String {
                            if(status == "1"){//success
                                self.imgViewProfile?.image = UIImage.init(named: "userGray")
                                AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: "")
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                                self.delegate?.profileUpdated?()
                                self.removeAttachmentView()
                                //self.btnCancelAction(self.btnCancel!)
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg )
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDisplayNameUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDisplayNameUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
        
    func serviceCallToUpdateProfilePic(imgdata: Data){
            if(AppConstant.hasConnectivity()) {//true connected
                if(uploadImage != nil){
                    AppConstant.showHUD()
                    let imageStr = imgdata.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                    let medId = AppConstant.retrievFromDefaults(key: StringConstant.memId)
                    
                    let headers: HTTPHeaders = [
                        "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                        "Accept": "application/json"
                    ]
                    
                    let parameters: Parameters = [
                        //"UserID": userName,
                        //"Password": password,
                        "pstMemId": medId,
                        "UploadFileName" : "image1.PNG",
                        "pstUploadFileData" : imageStr
                    ]
                    //print(parameters)
                    
                    //print("params===\(parameters)")
                    print("url===\(AppConstant.updateProfilePicUrl)")
                    
//                    let configuration = URLSessionConfiguration.default
//                    configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//                    configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//                    AFManager = Alamofire.SessionManager(configuration: configuration)
                    AFManager.request( AppConstant.updateProfilePicUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                        .responseString { response in
                            AppConstant.hideHUD()
                            //debugPrint(response)
                            
                            switch(response.result) {
                            case .success(_):
                                
                                let headerStatusCode : Int = (response.response?.statusCode)!
                                print("Status Code: \(headerStatusCode)")
                                
                                if(headerStatusCode == 401){//Session expired
                                    self.isTokenVerified(completion: { (Bool) in
                                        if Bool{
                                            self.serviceCallToUpdateProfilePic(imgdata: imgdata)
                                        }
                                    })
                                }else{
                                    let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                    //  debugPrint(dict)
                                    
                                    if let status = dict?["Status"] as? String {
                                        if(status == "1"){
                                            if let msg = dict?["Message"] as? String{
                                                self.displayAlert(message: msg )
                                            }
                                            self.imgViewProfile?.image = self.uploadImage
                                            AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: imageStr)
                                            self.delegate?.profileUpdated?()
                                            //self.btnCancelAction(self.btnCancel)
                                            
                                        }else{
                                            if let msg = dict?["Message"] as? String{
                                                self.displayAlert(message: msg )
                                            }
                                        }
                                    }else{
                                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.updateProfilePicUrl)
                                    }
                                }
                                
                                break
                                
                            case .failure(_):
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.updateProfilePicUrl)
                                break
                                
                            }
                    }
                }
            }else{
                self.displayAlert(message: "Please check your internet connection.")
            }
        }
    
    func serviceCallToUpdateDisplayname(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let medId = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            print("url===\(AppConstant.postDisplayNameUrl)")
            let params: Parameters = [
                "pstMemId": medId,
                "pstDisplayName": (txtFldName.text?.trim())!
            ]
            
            print("url===\(params)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
    
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.postDisplayNameUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseJSON { response in
                AppConstant.hideHUD()
                
                switch(response.result) {
                case .success(_):
                    debugPrint(response.result.value!)
                    let dict = response.result.value as! [String : AnyObject]
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToUpdateDisplayname()
                            }
                        })
                    }else{
                        if let status = dict["Status"] as? String {
                            if(status == "1"){//success
                                AppConstant.saveInDefaults(key: StringConstant.displayName, value: (self.txtFldName.text?.trim())!)
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                                self.delegate?.profileUpdated?()
                                self.btnCancelAction(self.btnCancel!)
                            }else{
                                if let msg = dict["Message"] as? String{
                                    self.displayAlert(message: msg ?? "")
                                }
                            }
                        }else{
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDisplayNameUrl)
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: AppConstant.postDisplayNameUrl)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
}
