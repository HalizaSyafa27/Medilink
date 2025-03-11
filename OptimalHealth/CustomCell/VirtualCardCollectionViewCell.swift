//
//  VirtualCardCollectionViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 11/02/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class VirtualCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgViewQRCode: UIImageView!
    @IBOutlet var lblQRCardNo: UILabel!
    @IBOutlet var lblMemberSince: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblVal1: UILabel!
    @IBOutlet var lblVal2: UILabel!
    @IBOutlet var imgViewCardBg: UIImageView!
    
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
