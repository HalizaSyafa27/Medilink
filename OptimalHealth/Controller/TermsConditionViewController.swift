//
//  TermsConditionViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 31/07/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit

class TermsConditionViewController: UIViewController {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
         _ = self.navigationController?.popViewController(animated: true)
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
