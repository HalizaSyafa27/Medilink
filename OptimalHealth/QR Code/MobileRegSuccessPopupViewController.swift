//
//  MobileRegSuccessPopupViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 07/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class MobileRegSuccessPopupViewController: UIViewController {
    
    @IBOutlet var btnOk: UIButton!
    @IBOutlet var txtViewMsg: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initDesign()
    }
    
    func initDesign(){
        self.txtViewMsg.attributedText = AppConstant.strQRPopupValue.htmlToAttributedString
        self.txtViewMsg.textAlignment = NSTextAlignment.center
    }
    
    //MARK: Button Action
    @IBAction func btnOkAction(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
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
