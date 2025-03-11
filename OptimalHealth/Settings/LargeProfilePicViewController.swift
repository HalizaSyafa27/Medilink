//
//  LargeProfilePicViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 06/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import ImageScrollView

class LargeProfilePicViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var viewContainer: UIView!
//    @IBOutlet weak var viewMain: UIView!
//    @IBOutlet var viewContainerHeightConstraint: NSLayoutConstraint!
//    @IBOutlet var viewContainerWidthConstraint: NSLayoutConstraint!
    @IBOutlet var imgViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgViewWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        imgViewHeightConstraint.constant = AppConstant.screenSize.width - 60
        imgViewWidthConstraint.constant = AppConstant.screenSize.width - 60
        
        imageViewProfile.layer.cornerRadius = (AppConstant.screenSize.width - 60) / 2
        imageViewProfile.layer.borderColor = AppConstant.themeRedColor.cgColor
        imageViewProfile.layer.borderWidth = 2.0
        imageViewProfile.clipsToBounds = true
        
        imageScrollView.delegate = self
        
        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 10.0//maximum zoom scale you want
        imageScrollView.zoomScale = 1.0
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                //self.imageScrollView.display(image: image!)
                self.imageViewProfile.image = image
            }
        }else{
            //self.imageScrollView.display(image: UIImage.init(named: "profile_new")!)
            self.imageViewProfile.image = UIImage.init(named: "profile_new")
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewProfile
    }
    
    //MARK: Button Action
    @IBAction func backButton(sender: AnyObject){
        _ = self.dismiss(animated: true, completion: nil)
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
