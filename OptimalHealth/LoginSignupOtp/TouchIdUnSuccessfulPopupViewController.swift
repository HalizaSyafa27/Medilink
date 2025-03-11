//
//  TouchIdUnSuccessfulPopupViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 15/04/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
@objc protocol TouchIdPopupCancelledDelegate: class {
    @objc optional func popupOkAction()
}

class TouchIdUnSuccessfulPopupViewController: UIViewController {

    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewContainerHeight: NSLayoutConstraint!
    weak var delegate: TouchIdPopupCancelledDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initdesign()
    }
    
    func initdesign(){
        
        if AppConstant.screenSize.width > 320{
            viewContainerHeight.constant = 265
        }
        viewContainer.layer.cornerRadius = 10
        viewContainer.clipsToBounds = true
        
        btnOk.layer.cornerRadius = btnOk.frame.size.height / 2
        btnOk.layer.borderWidth = 1.0
        btnOk.layer.borderColor = AppConstant.themeRedColor.cgColor
        btnOk.clipsToBounds = true
    }
    
    //MARK: Button Action
    @IBAction func btnCancelAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
        delegate?.popupOkAction?()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
