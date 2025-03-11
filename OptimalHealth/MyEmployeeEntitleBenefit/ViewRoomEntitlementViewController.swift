
//
//  ViewRoomEntitlementViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/17/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class ViewRoomEntitlementViewController: UIViewController {
    
    @IBOutlet var conditions: UILabel!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    
    var benefitCondition = ""
    
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
        
        if (benefitCondition == "") {
            conditions?.text = "No records found!"
        }else {
            conditions?.text = benefitCondition
        }
        
        if conditions?.text == "No records found!"{
            conditions?.textAlignment = .center
        }else{
            conditions?.textAlignment = .left
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
