//
//  CallPopupViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 04/07/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class CallPopupViewController: UIViewController {
    
    @IBOutlet var lblPhone1: UILabel!
    @IBOutlet var lblPhone2: UILabel!
    @IBOutlet var lblProvider: UILabel!
    @IBOutlet var btnRadio1: UIButton!
    @IBOutlet var btnRadio2: UIButton!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var viewRadio1: UIView!
    @IBOutlet var viewRadio2: UIView!
    @IBOutlet var viewRadio2Height: NSLayoutConstraint!
    @IBOutlet var viewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    
    var providerName = ""
    var phone1 = ""
    var phone2 = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if phone2 == ""{
            viewRadio2.isHidden = true
            viewRadio2Height.constant = 0
            viewContainerHeight.constant = 215 - 20
        }
        
        lblPhone1.text = phone1
        lblPhone2.text = phone2
        lblProvider.text = providerName
    }
    
    func initDesign(){
        viewContainer.layer.cornerRadius = 3
        viewContainer.clipsToBounds = true
        btnRadio1.isSelected = true
        self.btnCancel.layer.cornerRadius = 4
        self.btnCall.layer.cornerRadius = 4
    }
    
    //MARK: Button Action
    @IBAction func btnCancelAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func btnCallAction(_ sender: Any) {
        if btnRadio1.isSelected == true {
            if let url = URL(string: "tel://\(phone1.numbers)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }else{
            if let url = URL(string: "tel://\(phone2.numbers)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @IBAction func btnRadio1Action(_ sender: Any) {
        btnRadio1.isSelected = true
        btnRadio2.isSelected = false
    }
    
    @IBAction func btnRadio2Action(_ sender: Any) {
        btnRadio1.isSelected = false
        btnRadio2.isSelected = true
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
