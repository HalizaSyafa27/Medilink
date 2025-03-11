//
//  SearchNricOrPolicyNumberViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 10/3/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class SearchNricOrPolicyNumberViewController: UIViewController {
    
    @IBOutlet var btnRadioNRIC: UIButton!
    @IBOutlet var btnRadioPolicyNumber: UIButton!
    @IBOutlet weak var nricPolicyNumberTf: UITextField!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var imgHeader: UIImageView!
    @IBOutlet weak var lblNric: UILabel!
    
    var headerText = ""
    var imgHeaderView = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
    }
    
    func initDesigns() {
        lblNric.text = StringConstant.nricSymbol
        lblHeader.text = headerText
        imgHeader.image = UIImage.init(named: imgHeaderView + "_white")
        
        //Manage for iPhone X
        if (AppConstant.screenSize.height >= 812) {
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        btnRadioNRIC.isSelected = true
        nricPolicyNumberTf.placeholder = "Enter " + StringConstant.nricSymbol
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnNRICAction(_ sender: Any) {
        btnRadioNRIC.isSelected = true
        nricPolicyNumberTf.placeholder = "Enter " + StringConstant.nricSymbol
        btnRadioPolicyNumber.isSelected = false
    }
    
    @IBAction func btnPolicyNumberAction(_ sender: Any) {
        btnRadioNRIC.isSelected = false
        btnRadioPolicyNumber.isSelected = true
        nricPolicyNumberTf.placeholder = "Enter Policy Number"
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

}
