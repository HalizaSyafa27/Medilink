//
//  SubmitRequestViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 9/12/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class SubmitRequestViewController: UIViewController {
    
    @IBOutlet var viewParent: UIView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var viewRegister: UIView!
    @IBOutlet var viewUpload: UIView!
    @IBOutlet var viewSubmit: UIView!
    @IBOutlet var lblPagetitle: UILabel!
    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblUploadBill: UILabel!
    @IBOutlet var lblTab1: UILabel!
    @IBOutlet var lblTab3: UILabel!
    
    var className = ""
    var pageHeader = ""
    var pageTitle = ""
    var strCardNo = ""
    var strPlanCode = ""
    var strPolicyNo = ""
    var strName = ""
    var strHeaderImageName = ""
    var arrPlanCode = [PlanCodeBo]()
    
    var selectedViewController: UIViewController!
    
    private lazy var requestViewController: RequestViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
        viewController.className = className
        viewController.pageTitle = pageHeader
        viewController.strCardNo = strCardNo
        viewController.strPolicyNo = strPolicyNo
        viewController.strName = strName
        viewController.strHeaderImageName = strHeaderImageName
        viewController.strPlanCode = strPlanCode
        viewController.arrPlanCode = arrPlanCode
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var teleConsultrequestViewController: TeleConsultRequestViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "TeleConsultRequestViewController") as! TeleConsultRequestViewController
        viewController.className = className
        viewController.pageTitle = pageHeader
        viewController.strCardNo = strCardNo
        viewController.strPolicyNo = strPolicyNo
        viewController.strName = strName
        viewController.strHeaderImageName = strHeaderImageName
        viewController.strPlanCode = strPlanCode
        viewController.arrPlanCode = arrPlanCode
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var uploadFileViewController: UploadFileViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "UploadFileViewController") as! UploadFileViewController
        viewController.className = className
        viewController.pageHeader = pageHeader
        viewController.pageHeader = lblUploadBill.text!
        
        //send Req param
//        viewController.requestParams = AppConstant.requestParams
        viewController.strClaimId = AppConstant.strClaimId
        viewController.strMemId = AppConstant.strMemId
        viewController.strHeaderImageName = strHeaderImageName
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var submitViewController: SubmitViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
        viewController.className = className
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
    }
    
    func initDesign() {
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showChildView), name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideBackBtn), name: NSNotification.Name(rawValue: StringConstant.hideBackButtonNotification), object: nil)
        
        if arrPlanCode.count > 0{
            strPlanCode = arrPlanCode[0].planCode
        }
        
        lblPageHeader.text = pageHeader
        lblPagetitle.text = pageTitle
        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        AppConstant.selectedViewTag = "1"
        viewRegister.backgroundColor = AppConstant.themeRedColor
        viewUpload.backgroundColor = AppConstant.themeDarkGrayColor
        viewSubmit.backgroundColor = AppConstant.themeDarkGrayColor
        
        if className == StringConstant.teleconsultRequest{
            add(asChildViewController: teleConsultrequestViewController)
            self.selectedViewController = teleConsultrequestViewController
        }else{
            add(asChildViewController: requestViewController)
            self.selectedViewController = requestViewController
        }
        
        if ((className == "MMWA0190") || (className == "MMWA0191") || (className == StringConstant.hospitalAdmissionGLRequest)){//Out-Patient SP GL Request || Submit Pharmacy Request || Hospital Admission GL Request
            lblUploadBill.text = "Upload Document"
        }
        
        if className == StringConstant.teleconsultRequest{
            lblTab1.text = "Teleconsult Details"
            lblTab3.text = "Doctor"
            lblUploadBill.text = "Upload Document"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnRegClaimAction(_ sender: Any) {
        if AppConstant.isClaimSubmitted == false{
            remove(asChildViewController: self.selectedViewController)
            AppConstant.selectedViewTag = "1"
            viewRegister.backgroundColor = AppConstant.themeRedColor
            viewUpload.backgroundColor = AppConstant.themeDarkGrayColor
            viewSubmit.backgroundColor = AppConstant.themeDarkGrayColor
            
            if className == StringConstant.teleconsultRequest{
                add(asChildViewController: teleConsultrequestViewController)
                self.selectedViewController = teleConsultrequestViewController
            }else{
                add(asChildViewController: requestViewController)
                self.selectedViewController = requestViewController
            }
        }
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        self.viewParent.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.viewParent.bounds
        viewController.view.clipsToBounds = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.view.clipsToBounds = false
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    @objc func showChildView() {
        if (AppConstant.selectedViewTag == "1") {
            viewRegister.backgroundColor = AppConstant.themeRedColor
            viewUpload.backgroundColor = AppConstant.themeDarkGrayColor
            viewSubmit.backgroundColor = AppConstant.themeDarkGrayColor
            remove(asChildViewController: self.selectedViewController)
            add(asChildViewController: requestViewController)
            self.selectedViewController = requestViewController
        }
        else if (AppConstant.selectedViewTag == "2") {
            viewRegister.backgroundColor = AppConstant.themeDarkGrayColor
            viewUpload.backgroundColor = AppConstant.themeRedColor
            viewSubmit.backgroundColor = AppConstant.themeDarkGrayColor
            remove(asChildViewController: self.selectedViewController)
            add(asChildViewController: uploadFileViewController)
            self.selectedViewController = uploadFileViewController
        }
        else if (AppConstant.selectedViewTag == "3") {
            viewRegister.backgroundColor = AppConstant.themeDarkGrayColor
            viewUpload.backgroundColor = AppConstant.themeDarkGrayColor
            viewSubmit.backgroundColor = AppConstant.themeRedColor
            remove(asChildViewController: self.selectedViewController)
            add(asChildViewController: submitViewController)
            self.selectedViewController = submitViewController
        }
    }
    
    @objc func hideBackBtn() {
        btnBack.isHidden = true
    }

}
