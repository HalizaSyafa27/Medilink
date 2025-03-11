//
//  UploadProfilePicViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 06/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import RSKImageCropperSwift
import AVFoundation

class UploadProfilePicViewController: BaseViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate {
    
    @IBOutlet var imgViewProfile: UIImageView!
    @IBOutlet var btnCamera: UIButton!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var uploadImage: UIImage?
    var picker = UIImagePickerController()
    var profileImageUrl: String!
    var memberBo = MemberBo()
    var className = ""
    var pageTitle = ""
    var strHeaderImageName = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
    }
    
    func initDesign(){
        self.lblPageHeader.text = pageTitle
        picker.delegate = self
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.size.width / 2
        imgViewProfile.layer.borderColor = AppConstant.themeGreenColor.cgColor //UIColor.white.cgColor
        imgViewProfile.layer.borderWidth = 2.0
        self.imgViewProfile.clipsToBounds = true
        
        self.btnCamera.layer.cornerRadius = self.btnCamera.frame.size.width / 2
        self.btnCamera.clipsToBounds = true
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                imgViewProfile.image = image
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showprofileImage(_:)))
        self.imgViewProfile.addGestureRecognizer(tap)
        self.imgViewProfile.isUserInteractionEnabled = true
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showprofileImage(_ sender: UITapGestureRecognizer) {
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            self.performSegue(withIdentifier: "large_image", sender: self)
        }
    }
    
    @IBAction func btnCameraAction(_ sender: UIButton) {
        if (AppConstant.hasConnectivity())  {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let deleteButton = UIAlertAction(title: "Remove Photo", style: .destructive, handler: { (action) -> Void in
                //Api call to delete photo
                self.deleteProfilePic()
            })
            
            let galleryButton = UIAlertAction(title: "Gallery", style: .default, handler: { (action) -> Void in
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            })
            let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                    self.openCamera()
                }else{
                    let alert = UIAlertController(title: "", message: StringConstant.noCameraMsg, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                    alert.addAction(ok)
                    alert.view.tintColor = AppConstant.themeRedColor
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
            
            let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
            if profileImgStr != ""{
                alertController.addAction(deleteButton)
            }
            
            alertController.addAction(cameraButton)
            alertController.addAction(galleryButton)
            alertController.addAction(cancelButton)
            
//            self.navigationController!.present(alertController, animated: true, completion: nil)
            
            if let popoverPresentationController = alertController.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = sender.bounds
            }
            alertController.view.tintColor = AppConstant.themeRedColor
            self.navigationController!.present(alertController, animated: true, completion: nil)
        }else{
            self.displayAlert(message: StringConstant.uploadPhotoValidationMsg)
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func openCamera(){
        
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
    
    //MARK: Alert Method
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
            let initialViewController : RSKImageCropViewController = RSKImageCropViewController.init(image: myImage, cropMode: RSKImageCropMode.circle)
            initialViewController.delegate = self
            self.navigationController?.pushViewController(initialViewController, animated: true)
            
            
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
        
        if(imgSize > 1.5){
            let compressData = self.uploadImage!.jpegData(compressionQuality: 0.5)
            self.uploadImage = UIImage(data: compressData!)
        }
        
        self.serviceCallToUpdateProfilePic()
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
        
//        self.navigationController!.present(alertController, animated: true, completion: nil)
        
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
    func serviceCallToDeleteProfilePic(){
        
    }
    
    func serviceCallToUpdateProfilePic(){
        if(AppConstant.hasConnectivity()) {//true connected
            if(uploadImage != nil){
                AppConstant.showHUD()
                
                let imgData = uploadImage!.jpegData(compressionQuality: 0.6)
                let imageStr = imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                let medId = AppConstant.retrievFromDefaults(key: StringConstant.memId)
                
                let headers: HTTPHeaders = [
                    "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                    "Accept": "application/json"
                ]
                
                let parameters: Parameters = [
                    "pstMemId": medId,
                    "UploadFileName" : "image1.PNG",
                    "pstUploadFileData" : imageStr
                ]
                //print(parameters)
                
                print("params===\(parameters)")
                print("url===\(AppConstant.updateProfilePicUrl)")
                
//                let configuration = URLSessionConfiguration.default
//                configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//                configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//                AFManager = Alamofire.SessionManager(configuration: configuration)
                AFManager.request( AppConstant.updateProfilePicUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
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
                                        self.serviceCallToUpdateProfilePic()
                                    }
                                })
                            }else{
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                //  debugPrint(dict)
                                
                                if let status = dict?["Status"] as? String {
                                    if(status == "1"){
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg ?? "")
                                        }
                                        self.imgViewProfile?.image = self.uploadImage
                                        AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: imageStr!)
                                        
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg ?? "")
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
