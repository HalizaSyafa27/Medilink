//
//  VirtualPolicyCardCollectionViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 24/06/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class VirtualPolicyCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    @IBOutlet var lblMemberSince: UILabel!
    @IBOutlet var lblMemberSinceTitle: UILabel!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var imgViewQRCode: UIImageView!
    @IBOutlet var valueTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var valueBottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var verticalSpacingConstraint1: NSLayoutConstraint!
    @IBOutlet var verticalSpacingConstraint2: NSLayoutConstraint!
    @IBOutlet var verticalSpacingConstraint3: NSLayoutConstraint!
    @IBOutlet var QRCodeImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet var QRCodeImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet var logoImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet var logoImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet var logoImgBottomConstraint: NSLayoutConstraint!
    @IBOutlet var lblMemberSinceWidthConstraint: NSLayoutConstraint!
    @IBOutlet var lblMemberSinceLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var imgViewBg: UIImageView!
    @IBOutlet var QRCodeImgTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var QRCodeImgBottomConstraint: NSLayoutConstraint!
    
    var viewContainerHeightConstraint: CGFloat = 0.0
    
    func initDesign(){
        print("viewContainerwidth==\(viewContainer.bounds.width)")
        print("viewContainerHeight==\(viewContainerHeightConstraint)")
        QRCodeImgTrailingConstraint.constant = (viewContainer.bounds.width * 8.666)/100
        QRCodeImgBottomConstraint.constant = -(viewContainerHeightConstraint * 48.85317)/100
        if AppConstant.screenSize.width >= 414{
            self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint * 35)/100
            self.self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint * 4.5)/100
            
            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 6.0)
            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 8.0)
            self.lbl1.font = UIFont.init(name: "Poppins-SemiBold", size: 8.0)
            self.lbl2.font = UIFont.init(name: "Poppins-SemiBold", size: 8.0)
            self.lbl3.font = UIFont.init(name: "Poppins-SemiBold", size: 8.0)
            self.lbl4.font = UIFont.init(name: "Poppins-SemiBold", size: 8.0)
            
            self.verticalSpacingConstraint1.constant = (self.viewContainerHeightConstraint * 2.0)/100
            self.verticalSpacingConstraint2.constant = (self.viewContainerHeightConstraint * 2.0)/100
            self.verticalSpacingConstraint3.constant = (self.viewContainerHeightConstraint * 2.0)/100
        }else{
            QRCodeImgTrailingConstraint.constant = (viewContainer.bounds.width * 6.766)/100
            QRCodeImgBottomConstraint.constant = -(viewContainerHeightConstraint * 52.85317)/100
            self.valueTopSpaceConstraint.constant = (self.viewContainerHeightConstraint * 35)/100
            self.self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint * 4)/100
        }
        
        if AppConstant.screenSize.width <= 320{//iPhone 5 or earlier
            QRCodeImgHeightConstraint.constant = 25.0
            QRCodeImgWidthConstraint.constant = 25.0
            lblMemberSinceLeadingConstraint.constant = -4.0
            self.self.valueBottomSpaceConstraint.constant = (self.viewContainerHeightConstraint * 2.7)/100
            
            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 6.0)
            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 7.0)
            self.lbl1.font = UIFont.init(name: "Poppins-SemiBold", size:7.0)
            self.lbl2.font = UIFont.init(name: "Poppins-SemiBold", size: 7.0)
            self.lbl3.font = UIFont.init(name: "Poppins-SemiBold", size: 7.0)
            self.lbl4.font = UIFont.init(name: "Poppins-SemiBold", size: 7.0)
            
            self.verticalSpacingConstraint1.constant = (self.viewContainerHeightConstraint * 2.0)/100
            self.verticalSpacingConstraint2.constant = (self.viewContainerHeightConstraint * 2.0)/100
            self.verticalSpacingConstraint3.constant = (self.viewContainerHeightConstraint * 2.0)/100
            
        }else{
            self.verticalSpacingConstraint1.constant = CGFloat((self.viewContainerHeightConstraint * 1)/100.0)
            self.verticalSpacingConstraint2.constant = CGFloat((self.viewContainerHeightConstraint * 1)/100.0)
            self.verticalSpacingConstraint3.constant = CGFloat((self.viewContainerHeightConstraint * 1)/100.0)
            lblMemberSinceLeadingConstraint.constant = -9.5
            
//            self.lblMemberSinceTitle.font = UIFont.init(name: "Poppins-Regular", size: 11.0)
//            self.lblMemberSince.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lbl1.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lbl2.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lbl3.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
//            self.lbl4.font = UIFont.init(name: "Poppins-SemiBold", size: 15.0)
        }
        if AppConstant.screenSize.width >= 414{
            lblMemberSinceLeadingConstraint.constant = 16.0
        }
        
        self.viewContainer.layoutIfNeeded()
    }
    
    func setQRImage(qrcodeImage: CIImage?){
        //Set QR Code Image
        if qrcodeImage != nil{
            let scaleX = imgViewQRCode.frame.size.width / qrcodeImage!.extent.size.width
            let scaleY = imgViewQRCode.frame.size.height / qrcodeImage!.extent.size.height
            
            let transformedImage = qrcodeImage!.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            self.imgViewQRCode.image = UIImage.init(ciImage: transformedImage)
        }
    }
}
