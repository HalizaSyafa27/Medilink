//
//  BiometricLoginOptionViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 17/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class BiometricLoginOptionViewController: UIViewController {
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet var btnAgree: UIButton!
    @IBOutlet var switchQuickTouch: UISwitch!
    @IBOutlet weak var lblInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        lblInfo.text = "Which biometric \n login options \n would you like to \n enable ?"
        switchQuickTouch.isOn = false
        btnAgree.isEnabled = false
        btnAgree.setTitleColor(UIColor.lightGray, for: .normal)
        switchQuickTouch.onTintColor = AppConstant.themeRedColor
        
        self.viewBack.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(backAction))
        self.viewBack.addGestureRecognizer(tap)
    }
    
    // MARK: - Button Action
    @IBAction func btnSwitchAction(_ sender: Any) {
        if switchQuickTouch.isOn == true {
            btnAgree.isEnabled = true
            btnAgree.setTitleColor(UIColor.white, for: .normal)
        }else{
            btnAgree.setTitleColor(UIColor.lightGray, for: .normal)
            btnAgree.isEnabled = false
        }
    }
    
    @IBAction func btnAgreedAction(_ sender: Any) {
        self.performSegue(withIdentifier: "biometric_registration", sender: self)
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
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
