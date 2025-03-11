//
//  RequestPopupViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 20/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class RequestPopupViewController: UIViewController {
    
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnUploadNew: UIButton!
    @IBOutlet var btnGoHome: UIButton!
    @IBOutlet var btnLongGoHome: UIButton!
    @IBOutlet var lblDevider: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        if AppConstant.currClassName == StringConstant.reimbersmentClaimRequest {
            lblDevider.isHidden = false
            btnLongGoHome.isHidden = true
            btnLongGoHome.isUserInteractionEnabled = false
            btnUploadNew.isHidden = false
            btnGoHome.isHidden = false
        }else{
            lblDevider.isHidden = true
            btnLongGoHome.isHidden = false
            btnLongGoHome.isUserInteractionEnabled = true
            btnUploadNew.isHidden = true
            btnGoHome.isHidden = true
        }
        self.lblMessage.text = AppConstant.requestPopupMsg
    }
    
    //MARK: Button Action
    @IBAction func btnGoHomeAction(_ sender: Any) {
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoHomeScreen()
    }
    
    @IBAction func btnUploadNewAction(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.removeFromParent()
                self.view.removeFromSuperview()
            }
        })
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
