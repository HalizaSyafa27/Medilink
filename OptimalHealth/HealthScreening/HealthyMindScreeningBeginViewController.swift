//
//  HealthyMindScreeningBeginViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit

class HealthyMindScreeningBeginViewController: UIViewController {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoView1: UIView!
    @IBOutlet weak var infoView2: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    
    var cardNo:String = ""
    var className:String = ""
    var model = HealthScreeningModel()
    var isULangBorang:Bool = false
    var questionList = HealthScreeningModel.createQuestionList()

    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            if self.navigationController != nil{
                for controller in self.navigationController!.viewControllers as Array
                {
                    if controller.isKind(of: HealthScreeningViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.btnContinue.layer.cornerRadius = self.btnContinue.layer.frame.height/2
        self.infoView1.layer.cornerRadius = 6
        self.infoView1.layer.masksToBounds = true
        self.infoView2.layer.cornerRadius = 6
        self.infoView2.layer.masksToBounds = true
        self.infoView2.layer.borderWidth = 1
        self.infoView2.layer.borderColor = AppConstant.colorButton.cgColor
        if !self.isULangBorang{
            if self.navigationController != nil{
                for controller in self.navigationController!.viewControllers as Array
                {
                    if controller.isKind(of: HealthStatusFormViewController.self) {
                        self.navigationController!.viewControllers.removeAll(where: { $0 is HealthStatusFormViewController } )
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthyMindScreeningFormViewStoryboardID") as! HealthyMindScreeningFormViewController
        vc.cardNo = self.cardNo
        vc.className = self.className
        vc.model = self.model
        vc.stepNumber = 1
        vc.isULangBorang = self.isULangBorang
        vc.questionList = self.questionList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
