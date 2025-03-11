//
//  BiometricSuccessViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 17/09/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class BiometricSuccessViewController: UIViewController {

    @IBOutlet var lblInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initDesign()
    }
    
    func initDesign(){
        lblInfo.text = "Now you can login with\nQuick Touch"
    }
    
    @IBAction func btnproceedAction(_ sender: Any) {
        if AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) == StringConstant.YES{
            AppConstant.removeFromDefaults(key: StringConstant.isLoggedIn)
            AppConstant.removeFromDefaults(key: StringConstant.policyBackUpData)
            //AppConstant.removeFromDefaults(key: StringConstant.email)
            //AppConstant.removeFromDefaults(key: StringConstant.password)
            //AppConstant.removeFromDefaults(key: StringConstant.roleDesc)//Manas
            AppConstant.removeFromDefaults(key: StringConstant.profileImageUrl)
            //AppConstant.removeFromDefaults(key: StringConstant.name)
            AppConstant.removeFromDefaults(key: StringConstant.lastVisited)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.gotoLoginScreen()
        }else{
            AppConstant.removeFromDefaults(key: StringConstant.isLoggedIn)
            AppConstant.removeFromDefaults(key: StringConstant.policyBackUpData)
            //AppConstant.removeFromDefaults(key: StringConstant.email)
            //AppConstant.removeFromDefaults(key: StringConstant.password)
            AppConstant.removeFromDefaults(key: StringConstant.roleDesc)
            AppConstant.removeFromDefaults(key: StringConstant.profileImageUrl)
            //AppConstant.removeFromDefaults(key: StringConstant.name)
            AppConstant.removeFromDefaults(key: StringConstant.lastVisited)
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is LogInController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }
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
