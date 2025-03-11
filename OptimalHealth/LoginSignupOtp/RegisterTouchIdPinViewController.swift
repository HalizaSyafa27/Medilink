//
//  RegisterTouchIdPinViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 15/04/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class RegisterTouchIdPinViewController: UIViewController {

    @IBOutlet var txtFldPin: UITextField!
    @IBOutlet var txtFldCnfPin: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var viewPopup: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        viewPopup.layer.cornerRadius = 10
        viewPopup.clipsToBounds = true
        
        btnApply.layer.cornerRadius = btnApply.frame.size.height / 2
        btnApply.clipsToBounds = true
        
    }
    
    //MARK: Button Action
    @IBAction func btnCancelAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func btnApplyAction(_ sender: Any) {
        
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
