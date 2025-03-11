//
//  LargeVirtualCardQRImageViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 09/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class LargeVirtualCardQRImageViewController: UIViewController {
    
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var largeImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var largeImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var lblQRCardNo: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgViewQRCode: UIImageView!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var lblPageTitle: UILabel!
    
    var pageTitle: String = ""
    var QRCardNo: String = ""
    var QRName: String = ""
    var qrcodeImage: CIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initDesign()
    }
    
    override func viewDidLayoutSubviews() {
        largeImageViewHeightConstraint.constant = self.imgViewQRCode.frame.size.width
        print(largeImageViewHeightConstraint.constant)
        print(self.imgViewQRCode.frame.size.width)
        self.imgViewQRCode.layoutIfNeeded()
    }

    func initDesign(){
        //self.lblPageHeader.text = self.pageTitle.
        self.lblQRCardNo.text = self.QRCardNo
        self.lblName.text = self.QRName
        self.lblPageTitle.text = pageTitle
        
        //Set QR Code Image
        if qrcodeImage != nil{
            //self.imgViewHeader.image = UIImage.init(ciImage: qrcodeImage)
            
            let scaleX = imgViewQRCode.frame.size.width / qrcodeImage.extent.size.width
            let scaleY = imgViewQRCode.frame.size.height / qrcodeImage.extent.size.height
            
            let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            self.imgViewQRCode.image = UIImage.init(ciImage: transformedImage)
        }
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
    }
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
