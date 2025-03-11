//
//  VirtualCardViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class VirtualCardViewController: BaseViewController {
    
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewContainerWidthConstraint: NSLayoutConstraint!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var viewMain: UIView!
    @IBOutlet var imgViewQRCode: UIImageView!
    @IBOutlet var lblQRCardNo: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblVal1: UILabel!
    @IBOutlet var lblVal2: UILabel!
    @IBOutlet var lblMemberSinceTitle: UILabel!
    @IBOutlet var lblMemberSince: UILabel!
//    @IBOutlet var valueTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var valueBottomSpaceConstraint: NSLayoutConstraint!
//    @IBOutlet var verticalSpacingConstraint1: NSLayoutConstraint!
//    @IBOutlet var verticalSpacingConstraint2: NSLayoutConstraint!
//    @IBOutlet var verticalSpacingConstraint3: NSLayoutConstraint!
    @IBOutlet var QRCodeImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet var QRCodeImgWidthConstraint: NSLayoutConstraint!
//    @IBOutlet var logoImgWidthConstraint: NSLayoutConstraint!
//    @IBOutlet var logoImgHeightConstraint: NSLayoutConstraint!
//    @IBOutlet var logoImgBottomConstraint: NSLayoutConstraint!
//    @IBOutlet var lblMemberSinceTitleWidthConstraint: NSLayoutConstraint!
    @IBOutlet var lblMemberSinceWidthConstraint: NSLayoutConstraint!
    @IBOutlet var imgViewCardBg: UIImageView!
    @IBOutlet var lblMemberSinceLeadingConstraint: NSLayoutConstraint!
//    @IBOutlet var QRCodeImgTrailingConstraint: NSLayoutConstraint!
//    @IBOutlet var QRCodeImgBottomConstraint: NSLayoutConstraint!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var viewTogleImageBtn1: UIButton!
    @IBOutlet weak var viewTogleImageBtn2: UIButton!
    @IBOutlet weak var viewTogleImageBtn3: UIButton!
    @IBOutlet weak var viewTogleImageBtn4: UIButton!
    @IBOutlet weak var btnViewQRCode: UIButton!
    
    var ratio:CGFloat = 1.56
    var cardBackImage: String = ""
    var strCardNo: String = ""
    var pageTitle: String = ""
    var QRCardNo: String = ""
    var QRName: String = ""
    var QRVal1: String = ""
    var QRVal2: String = ""
    var QRMemberSince: String = ""
    var QrCode: String = ""
    var foregroundColor: String = ""
    var qrcodeImage: CIImage!
    var qrcodeImageLandscape: UIImage?
    var isProtraitMode: Bool = true
    var viewContainerPortraitHeight:CGFloat?
    var viewContainerPortraitWidth:CGFloat?
    var cardBgUrl = ""
    var QRCodeImgWidthConstraintVal:CGFloat = 0.0
    var QRCodeImgHeightConstraintVal:CGFloat = 0.0
    var valueBottomSpaceConstraintVal:CGFloat = 0.0
    var logoImgBottomConstraintVal:CGFloat = 0.0
    var logoImgWidthConstraintVal:CGFloat = 0.0
    var logoImgHeightConstraintVal:CGFloat = 0.0
    var lblMemberSinceWidthConstraintVal:CGFloat = 0.0
    var verticalSpacingConstraint1Val:CGFloat = 0.0
    var verticalSpacingConstraint2Val:CGFloat = 0.0
    var verticalSpacingConstraint3Val:CGFloat = 0.0
    var QRCodeImgTrailingConstraintVal:CGFloat = 0.0
    var QRCodeImgBottomConstraintVal:CGFloat = 0.0
    var isFromHomePage = false
    var isBack:Bool = false
    var backCardImage: UIImage?
    var cardImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDesign()
        if isFromHomePage == true{
            let cardBgBase64 = AppConstant.retrievFromDefaults(key: StringConstant.virtualCardImageBase64)
            if cardBgBase64 != ""{
                if let data = Data(base64Encoded: cardBgBase64) {
                    self.cardImage = UIImage(data: data)
                }
                let cardBackImageBase64 = AppConstant.retrievFromDefaults(key: StringConstant.virtualCardBackImageBase64)
                if cardBackImageBase64 != ""{
                    if let data = Data(base64Encoded: cardBackImageBase64) {
                        self.backCardImage = UIImage(data: data)
                    }
                }
                self.QrCode = AppConstant.retrievFromDefaults(key: StringConstant.virtualQrCode)
                self.QRName = AppConstant.retrievFromDefaults(key: StringConstant.virtualQRName)
                self.QRCardNo = AppConstant.retrievFromDefaults(key: StringConstant.virtualQRCardNo)
                self.setValues()
                self.generateQRCodeImage()
            }else{
                self.serviceCallToGetVirtualCardDetails()
            }
        }else{
            self.serviceCallToGetVirtualCardDetails()
        }
        viewTogleImageBtn1.setTitle("", for: .normal)
        viewTogleImageBtn2.setTitle("", for: .normal)
        viewTogleImageBtn3.setTitle("", for: .normal)
        viewTogleImageBtn4.setTitle("", for: .normal)
        btnViewQRCode.setTitle("", for: .normal)
        //Add auto rotate Observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAutoRotate), name: UIDevice.orientationDidChangeNotification, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func initDesign(){
        self.viewContainer.isHidden = true
        lblPageHeader.text = pageTitle
        
//        self.viewContainer.layer.cornerRadius = 15.0
//        self.viewContainer.clipsToBounds = true
//        self.viewContainer.layer.borderColor = UIColor.clear.cgColor
//        self.viewContainer.layer.borderWidth = 1.5
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        btnBack.isHidden = isFromHomePage == true ? true : false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapForView(sender:)))
        imgViewQRCode.addGestureRecognizer(tap)
        imgViewQRCode.isUserInteractionEnabled = true
        
        self.viewContainerWidthConstraint.constant = self.view.frame.size.width - 20
        self.viewContainerHeightConstraint.constant = ((AppConstant.screenSize.width - 20) / AppConstant.virtualCardHeightRatio)
        
//        QRCodeImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 25)/100
//        QRCodeImgTrailingConstraint.constant = (self.viewContainerWidthConstraint.constant * 11.5)/100
//        self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 32)/100
//        print("Top === \(self.valueTopSpaceConstraint.constant)")
        
//        self.verticalSpacingConstraint1.constant = (self.viewContainerHeightConstraint.constant * 2.6)/100
//        self.verticalSpacingConstraint2.constant = (self.viewContainerHeightConstraint.constant * 2.6)/100
//        self.verticalSpacingConstraint3.constant = (self.viewContainerHeightConstraint.constant * 2.6)/100
        
//        setFontForPortraitMode()
        
        self.viewContainer.layoutIfNeeded()
        
        //self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 18.1)/100
        
        self.QRCodeImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
        self.QRCodeImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
        
        if AppConstant.screenSize.width <= 320{//iPhone 5 or earlier
            self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 6.5)/100
        }else{
            self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 8)/100
        }
        
//        self.logoImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 11)/100
//        self.logoImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 38.1)/100
//        self.logoImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 12.1)/100
        // self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 40.5)/100
        self.lblMemberSinceWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 36.4)/100
        lblMemberSinceLeadingConstraint.constant = (self.viewContainerWidthConstraint.constant * 7)/100
        self.viewContainer.layoutIfNeeded()
        
        viewContainerPortraitHeight = self.viewContainer.frame.size.height
        viewContainerPortraitWidth = self.viewContainer.frame.size.width
        QRCodeImgWidthConstraintVal = QRCodeImgWidthConstraint.constant
        QRCodeImgHeightConstraintVal = QRCodeImgWidthConstraint.constant
        valueBottomSpaceConstraintVal = valueBottomSpaceConstraint.constant
//        logoImgBottomConstraintVal = logoImgBottomConstraint.constant
//        logoImgWidthConstraintVal = logoImgWidthConstraint.constant
//        logoImgHeightConstraintVal = logoImgHeightConstraint.constant
        lblMemberSinceWidthConstraintVal = lblMemberSinceWidthConstraint.constant
//        verticalSpacingConstraint1Val = verticalSpacingConstraint1.constant
//        verticalSpacingConstraint2Val = verticalSpacingConstraint2.constant
//        verticalSpacingConstraint3Val = verticalSpacingConstraint3.constant
//        QRCodeImgTrailingConstraintVal = QRCodeImgTrailingConstraint.constant
//        QRCodeImgBottomConstraintVal = QRCodeImgBottomConstraint.constant
        
        print("Virtual card ratio = \(self.viewContainer.frame.size.width / self.viewContainer.frame.size.height)")
    }
    
//    func setFontColor(){
//        self.lblMemberSinceTitle.textColor = UIColor.init(hexString: self.foregroundColor)
//        self.lblMemberSince.textColor = UIColor.init(hexString: self.foregroundColor)
//        self.lblQRCardNo.textColor = UIColor.init(hexString: self.foregroundColor)
//        self.lblName.textColor = UIColor.init(hexString: self.foregroundColor)
//        self.lblVal1.textColor = UIColor.init(hexString: self.foregroundColor)
//        self.lblVal2.textColor = UIColor.init(hexString: self.foregroundColor)
//    }
    
    func setValues(){
        self.viewContainer.isHidden = false
        self.lblQRCardNo.isHidden = true
        self.lblName.isHidden = true
        self.lblVal1.isHidden = true
        self.lblVal2.isHidden = true
        self.lblMemberSince.isHidden = true
//        self.lblQRCardNo.text = self.QRCardNo
//        self.lblName.text = self.QRName
//        self.lblVal1.text = self.QRVal1
//        self.lblVal2.text = self.QRVal2
//        self.lblMemberSince.text = self.QRMemberSince
        
        //MYEG_Front SAMSUNG_Front VirtualCard self.cardBgUrl virtual_card_bg
        //self.imgViewCardBg.image = UIImage.init(named: "VirtualCard_img_new.png")

        self.imgViewCardBg.image = self.cardImage
        //self.imgViewCardBg.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "samsung"))
        
        print("Virual Card Height= \(self.viewContainer.frame.size.height) width = \(self.viewContainer.frame.size.width)")
        print("Device Height= \(self.view.frame.size.height) width = \(self.view.frame.size.width)")
    }
    
//    func setFontForPortraitMode(){
//        if AppConstant.screenSize.width <= 320{//iPhone 5 or earlier
//            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 9.0)
//            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 11.0)
//            self.lblQRCardNo.font = UIFont.init(name: "Poppins-SemiBold", size: 11.0)
//            self.lblName.font = UIFont.init(name: "Poppins-SemiBold", size: 11.0)
//            self.lblVal1.font = UIFont.init(name: "Poppins-SemiBold", size: 11.0)
//            self.lblVal2.font = UIFont.init(name: "Poppins-SemiBold", size: 11.0)
//
//            self.verticalSpacingConstraint1.constant = (self.viewContainerHeightConstraint.constant * 3.5)/100
//            self.verticalSpacingConstraint2.constant = (self.viewContainerHeightConstraint.constant * 3.5)/100
//            self.verticalSpacingConstraint3.constant = (self.viewContainerHeightConstraint.constant * 3.5)/100
//
//        }else{
//            print("view container height === \(self.viewContainerHeightConstraint.constant)")
////            print("vertical spacing === \(self.verticalSpacingConstraint1.constant)")
//
//            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 12.0)
//            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lblQRCardNo.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lblName.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lblVal1.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lblVal2.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//        }
//    }
    
    func generateQRCodeImage(){
        if QrCode == "" {
            return
        }
        let data = QrCode.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)

        let filter = CIFilter(name: "CIQRCodeGenerator")

        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")

        qrcodeImage = filter?.outputImage

        //Set QR Code Image
//        if qrcodeImage != nil{
//            let scaleX = imgViewQRCode.frame.size.width / qrcodeImage.extent.size.width
//            let scaleY = imgViewQRCode.frame.size.height / qrcodeImage.extent.size.height
//
//            let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
//
//            self.imgViewQRCode.image = UIImage.init(ciImage: transformedImage)
//        }
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTogleAction(_ sender: Any) {
        DispatchQueue.main.async {
            var rotationDegrees = 0.0
            if self.isProtraitMode == true{//Landscape Mode
                rotationDegrees = 90.0
                
                self.turnOnLandscapeMode()
                
            }else{//Portrait Mode
                rotationDegrees = 360.0
                
                self.viewContainerHeightConstraint.constant = self.viewContainerPortraitHeight!
                self.viewContainerWidthConstraint.constant = self.viewContainerPortraitHeight! * self.ratio
                
                self.turnOnportraitMode()
                
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                let rotationAngle = CGFloat(rotationDegrees * .pi / 180.0)
                self.viewContainer.transform = CGAffineTransform(rotationAngle: rotationAngle)
            })
            self.isProtraitMode = !self.isProtraitMode
            //self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 18.1)/100
            
            self.QRCodeImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
            self.QRCodeImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
//            self.logoImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 11)/100
//            self.logoImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 38.1)/100
//            self.logoImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 12.1)/100
            // self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 40.5)/100
//            self.lblMemberSinceWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 36.4)/100
            
            self.viewContainer.layoutIfNeeded()
            
            print("virtual card size = width:height = \(self.viewContainer.frame.size.width):\(self.viewContainer.frame.size.height)")
        }
    }
    
    @IBAction func viewTogleImageAction(_ sender: UIButton) {
        isBack = !isBack
        self.imgViewQRCode.isHidden = isBack
        if isBack{
            self.imgViewCardBg.image = self.backCardImage
            self.QRCodeImgHeightConstraint.constant = 0
            self.btnViewQRCode.isHidden = true
        }else{
            self.imgViewCardBg.image = self.cardImage
            self.QRCodeImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
            self.btnViewQRCode.isHidden = false
        }
    }
    
    @IBAction func btnViewQRCode(_ sender: UIButton) {
        self.performSegue(withIdentifier: "large_virtual_qrCode_screen", sender: self)
    }
    
    @objc func handleTapForView(sender: UITapGestureRecognizer? = nil) {
        self.performSegue(withIdentifier: "large_virtual_qrCode_screen", sender: self)
    }
    
    func turnOnLandscapeMode(){
        self.viewContainerHeightConstraint.constant = self.viewMain.frame.size.width - 70
        self.viewContainerWidthConstraint.constant = (self.viewMain.frame.size.width - 70) * ratio
        
        //        self.viewContainerHeightConstraint.constant = self.viewMain.frame.size.height - 50
        //        self.viewContainerWidthConstraint.constant = ((self.viewMain.frame.size.height - 50) * AppConstant.virtualCardHeightRatio)
        
//        self.verticalSpacingConstraint1.constant = (self.viewContainerHeightConstraint.constant * 2.7)/100
//        self.verticalSpacingConstraint2.constant = (self.viewContainerHeightConstraint.constant * 2.7)/100
//        self.verticalSpacingConstraint3.constant = (self.viewContainerHeightConstraint.constant * 2.7)/100
        //self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 35)/100
        lblMemberSinceLeadingConstraint.constant = (self.viewContainerWidthConstraint.constant * 8)/100
        
        if AppConstant.screenSize.height >= 896{//iPhone 11
//            lblMemberSinceLeadingConstraint.constant = (self.viewContainerWidthConstraint.constant * 11)/100
        }
        self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 9)/100
        
        self.viewContainer.layoutIfNeeded()
        
        if AppConstant.screenSize.width <= 320{//iPhone 5 or earlier
            self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 8.5)/100
//            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 11.0)
//            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 16.0)
//            self.lblQRCardNo.font = UIFont.init(name: "Poppins-SemiBold", size: 16.0)
//            self.lblName.font = UIFont.init(name: "Poppins-SemiBold", size: 16.0)
//            self.lblVal1.font = UIFont.init(name: "Poppins-SemiBold", size: 16.0)
//            self.lblVal2.font = UIFont.init(name: "Poppins-SemiBold", size: 16.0)
            
        }else{
//            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 17.0)
//            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 20.0)
//            self.lblQRCardNo.font = UIFont.init(name: "Poppins-SemiBold", size: 20.0)
//            self.lblName.font = UIFont.init(name: "Poppins-SemiBold", size: 20.0)
//            self.lblVal1.font = UIFont.init(name: "Poppins-SemiBold", size: 20.0)
//            self.lblVal2.font = UIFont.init(name: "Poppins-SemiBold", size: 20.0)
        }
        
//        QRCodeImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 22.5)/100
//        QRCodeImgTrailingConstraint.constant = (self.viewContainerWidthConstraint.constant * 11.9861)/100
//        self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 32)/100
        
        self.QRCodeImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
        self.QRCodeImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
//        self.logoImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 11)/100
//        self.logoImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 38.1)/100
//        self.logoImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 12.1)/100
        //self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 40.5)/100
//        self.lblMemberSinceWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 36.4)/100
        if AppConstant.screenSize.height >= 812{
//            QRCodeImgTrailingConstraint.constant = (self.viewContainerWidthConstraint.constant * 8.9861)/100
//            QRCodeImgTrailingConstraint.constant = (self.viewContainerWidthConstraint.constant * 12.9861)/100
        }
        
        self.viewContainer.layoutIfNeeded()
    }
    
    func turnOnportraitMode(){
//        self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 32)/100
//        lblMemberSinceLeadingConstraint.constant = (self.viewContainerWidthConstraint.constant * 7)/100
        
        if AppConstant.screenSize.width <= 320{//iPhone 5 or earlier
//            self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 6.5)/100
        }else{
//            self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 6)/100
        }
        
//        print("Top === \(self.valueTopSpaceConstraint.constant)")
        self.QRCodeImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 28.6)/100
        self.QRCodeImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 28.6)/100
        //        self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 10)/100
        //        self.logoImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 11)/100
        //        self.logoImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 38.1)/100
        //        self.logoImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 12.1)/100
        //        //self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 40.5)/100
        //        self.lblMemberSinceWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 36.4)/100
        
        self.QRCodeImgWidthConstraint.constant = QRCodeImgWidthConstraintVal
        self.QRCodeImgHeightConstraint.constant = QRCodeImgHeightConstraintVal
//        self.valueBottomSpaceConstraint.constant = valueBottomSpaceConstraintVal
//        self.logoImgBottomConstraint.constant = logoImgBottomConstraintVal
//        self.logoImgWidthConstraint.constant = logoImgWidthConstraintVal
//        self.logoImgHeightConstraint.constant = logoImgHeightConstraintVal
        //self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 40.5)/100
//        self.lblMemberSinceWidthConstraint.constant = lblMemberSinceWidthConstraintVal
        
//        verticalSpacingConstraint1.constant = verticalSpacingConstraint1Val
//        verticalSpacingConstraint2.constant = verticalSpacingConstraint2Val
//        verticalSpacingConstraint3.constant = verticalSpacingConstraint3Val
//        QRCodeImgTrailingConstraint.constant = QRCodeImgTrailingConstraintVal
//        QRCodeImgBottomConstraint.constant = QRCodeImgBottomConstraintVal
//        setFontForPortraitMode()
        self.viewContainer.layoutIfNeeded()
    }
    
    @objc func handleAutoRotate() {
        var rotationDegrees = 0.0
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            self.isProtraitMode = false
            
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                rotationDegrees = 90.0
            }else{
                rotationDegrees = -90.0
            }
            
            self.turnOnLandscapeMode()
        } else {
            print("Portrait")
            self.isProtraitMode = true
            
            rotationDegrees = 360.0
            
            self.viewContainerHeightConstraint.constant = self.viewContainerPortraitHeight!
            self.viewContainerWidthConstraint.constant = self.viewContainerPortraitWidth!
            
            self.turnOnportraitMode()
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            let rotationAngle = CGFloat(rotationDegrees * .pi / 180.0)
            self.viewContainer.transform = CGAffineTransform(rotationAngle: rotationAngle)
        })
        
        //self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint.constant * 18.1)/100
        
        self.QRCodeImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
        self.QRCodeImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 24)/100
        
//        self.logoImgBottomConstraint.constant = (self.viewContainerHeightConstraint.constant * 11)/100
//        self.logoImgWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 38.1)/100
//        self.logoImgHeightConstraint.constant = (self.viewContainerHeightConstraint.constant * 12.1)/100
        // self.lblMemberSinceTitleWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 40.5)/100
//        self.lblMemberSinceWidthConstraint.constant = (self.viewContainerHeightConstraint.constant * 36.4)/100
        
        self.viewContainer.layoutIfNeeded()
        
    }
    
    //MARK: - Service Call Method
    func serviceCallToGetVirtualCardDetails(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let countryCode : String = AppConstant.retrievFromDefaults(key: StringConstant.countryCodeByLocation)
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            let params: Parameters = [
                "pstgeocode": countryCode,
                "pstCardNo": strCardNo
            ]
            
            print("params===\(params)")
            print("url===\(AppConstant.getVirtualCardUrl)")
            AFManager.request( AppConstant.getVirtualCardUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetVirtualCardDetails()
                                }
                            })
                        }else{
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let arrCardDetails = dict!["CardInfoList"] as? [[String:Any]]{
                                        if arrCardDetails.count > 0{
                                            
                                            let dictCard = arrCardDetails[0]
                                            if let cardBgBase64 = dictCard["CardImageBase64"] as? String{
                                                if cardBgBase64 != ""{
                                                    if self.isFromHomePage == true{
                                                        AppConstant.saveInDefaults(key: StringConstant.virtualCardImageBase64, value: cardBgBase64)
                                                    }
                                                    if let data = Data(base64Encoded: cardBgBase64) {
                                                        self.cardImage = UIImage(data: data)
                                                    }
                                                }
                                            }
                                            if let cardBackImageBase64 = dictCard["CardBackImageBase64"] as? String{
                                                if cardBackImageBase64 != ""{
                                                    if self.isFromHomePage == true{
                                                        AppConstant.saveInDefaults(key: StringConstant.virtualCardBackImageBase64, value: cardBackImageBase64)
                                                    }
                                                    if let data = Data(base64Encoded: cardBackImageBase64) {
                                                        self.backCardImage = UIImage(data: data)
                                                    }
                                                }
                                            }
                                            if let cardBg = dictCard["CardImage"] as? String{
                                                self.cardBgUrl = cardBg
                                            }
                                            if let cardBackImage = dictCard["CardBackImage"] as? String{
                                                self.cardBackImage = cardBackImage
                                            }
                                            if let strQRCode = dictCard["QrCode"] as? String{
                                                 self.QrCode = strQRCode
                                                if self.isFromHomePage == true{
                                                    AppConstant.saveInDefaults(key: StringConstant.virtualQrCode, value: strQRCode)
                                                }
                                            }
                                            if let cardInfoObj = dictCard["CardInfoObj"] as? [String: Any]{
                                                if let Emp_Name = cardInfoObj["Emp_Name"] as? String{
                                                    self.QRName = Emp_Name
                                                    if self.isFromHomePage == true{
                                                        AppConstant.saveInDefaults(key: StringConstant.virtualQRName, value: Emp_Name)
                                                    }
                                                }
                                                if let Card_No = cardInfoObj["Card_No"] as? String{
                                                    self.QRCardNo = Card_No
                                                    if self.isFromHomePage == true{
                                                        AppConstant.saveInDefaults(key: StringConstant.virtualQRCardNo, value: Card_No)
                                                    }
                                                }
                                                if let PayorCode = cardInfoObj["Payor_Code"] as? String{
                                                    if(PayorCode == "MEGACHS"){
                                                        self.btnViewQRCode.isHidden = false
                                                        self.imgViewQRCode.isHidden = true
                                                    }else{
                                                        self.btnViewQRCode.isHidden = true
                                                        self.imgViewQRCode.isHidden = false
                                                    }
                                                }
                                            }
//                                            if let strCardInfo = dictCard["CardInfo"] as? String{
//                                                let arrCardInfo : [String] = strCardInfo.components(separatedBy: "<br/>")
//                                                if arrCardInfo.count > 4{
//                                                    self.QRMemberSince = arrCardInfo[4]
//                                                }
//                                                if arrCardInfo.count > 3{
//                                                    self.QRVal2 = arrCardInfo[3]
//                                                }
//                                                if arrCardInfo.count > 2{
//                                                    self.QRVal1 = arrCardInfo[2]
//                                                }
//                                                if arrCardInfo.count > 1{
//                                                    self.QRName = arrCardInfo[1]
//                                                }
//                                                if arrCardInfo.count > 0{
//                                                    self.QRCardNo = arrCardInfo[0]
//                                                }
//                                                if let color = dictCard["FontColor"] as? String{
//                                                    self.foregroundColor = color //"#66ff33"
//                                                }
                                                
                                                //Set Values
                                                self.setValues()
//                                                self.setFontColor()
                                                self.generateQRCodeImage()
                                                
//                                            }
                                        }
                                    }
                                }else{
                                    if let message = dict!["Message"] as? String{
                                        self.displayAlert(message: message)
                                    }
                                    
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getVirtualCardUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getVirtualCardUrl)
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
        if (segue.identifier == "large_virtual_qrCode_screen"){
            let vc = segue.destination as! LargeVirtualCardQRImageViewController
            vc.pageTitle = pageTitle
            vc.QRCardNo = QRCardNo
            vc.QRName = QRName
            vc.qrcodeImage = qrcodeImage
            return
        }
    }
    
    //MARK: - Memory Method
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
