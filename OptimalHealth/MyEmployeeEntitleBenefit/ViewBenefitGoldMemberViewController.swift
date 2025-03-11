//
//  ViewBenefitGoldMemberViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/14/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class ViewBenefitGoldMemberViewController: UIViewController {
    
    @IBOutlet var opCode: UILabel!
    @IBOutlet var opAnnualLimitTitle: UILabel!
    @IBOutlet var opAnnualLimit: UILabel!
    @IBOutlet var opFamilyLimit: UILabel!
    @IBOutlet var ipCode: UILabel!
    @IBOutlet var ipAnnualLimitTitle: UILabel!
    @IBOutlet var ipAnnualLimit: UILabel!
    @IBOutlet var ipFamilyLimit: UILabel!
    @IBOutlet var jobGrade: UILabel!
    @IBOutlet var noDataLbl: UILabel!
    @IBOutlet var viewBenefitScroll: UIScrollView!
    @IBOutlet var viewRoomEntitlementBtn: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var imgViewOpCode: UIImageView!
    @IBOutlet var opFamilyLimitTitle: UILabel!
    @IBOutlet var imgViewOpAnualLimit: UIImageView!
    @IBOutlet var imgViewOpFamilyLimit: UIImageView!
    @IBOutlet var opAnualLimitSeparatorView: UIView!
    @IBOutlet var opFamilyLimitSeparatorView: UIView!
    
    @IBOutlet var imgViewIpCode: UIImageView!
    @IBOutlet var ipFamilyLimitTitle: UILabel!
    @IBOutlet var imgViewIpAnualLimit: UIImageView!
    @IBOutlet var imgViewIpFamilyLimit: UIImageView!
    @IBOutlet var ipAnualLimitSeparatorView: UIView!
    @IBOutlet var ipFamilyLimitSeparatorView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    
    var viewBenefitGoldMember = [ViewBenefitGoldMemberBo]()
    var strStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDesigns() {
        if (strStatus == "1") {
            noDataLbl.isHidden = true
            viewRoomEntitlementBtn.isHidden = false
            viewBenefitScroll.isHidden = false
            setDatas()
        }else if (strStatus == "0") {
            noDataLbl.isHidden = false
            viewRoomEntitlementBtn.isHidden = true
            viewBenefitScroll.isHidden = true
        }
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
    }
    
    func setDatas() {
        
        if self.viewBenefitGoldMember.count == 1{
            ipCode?.text = "NA"
            ipAnnualLimitTitle?.text = "Employee Limit"
            ipAnnualLimit?.text = "NA"
            ipFamilyLimit?.text = "NA"
            hideIPLimit(isHide: true)
            
            if viewBenefitGoldMember.count > 0{
                let viewBenefitGoldMemberIP = viewBenefitGoldMember[0]
                opCode?.text = viewBenefitGoldMemberIP.codeName
                opAnnualLimitTitle?.text = viewBenefitGoldMemberIP.annualLimitLabelName
                opAnnualLimit?.text = viewBenefitGoldMemberIP.annualLimit
                opFamilyLimit?.text = viewBenefitGoldMemberIP.familyLimit
                if viewBenefitGoldMemberIP.jobGrade == ""{
                    jobGrade?.text = "NA"
                }else{
                    jobGrade?.text = viewBenefitGoldMemberIP.jobGrade
                }
                hideOPLimit(isHide: false)
            }else{
                opCode?.text = "NA"
                opAnnualLimitTitle?.text = "NA"
                opAnnualLimit?.text = "NA"
                opFamilyLimit?.text = "NA"
                jobGrade?.text = "NA"
                hideOPLimit(isHide: true)
            }
        }else{
            if viewBenefitGoldMember.count > 0{
                let viewBenefitGoldMemberIP = viewBenefitGoldMember[0]
                ipCode?.text = viewBenefitGoldMemberIP.codeName
                ipAnnualLimitTitle?.text = viewBenefitGoldMemberIP.annualLimitLabelName
                ipAnnualLimit?.text = viewBenefitGoldMemberIP.annualLimit
                ipFamilyLimit?.text = viewBenefitGoldMemberIP.familyLimit
                hideIPLimit(isHide: false)
            }else{
                ipCode?.text = "NA"
                ipAnnualLimitTitle?.text = "NA"
                ipAnnualLimit?.text = "NA"
                ipFamilyLimit?.text = "NA"
                hideIPLimit(isHide: true)
            }
            if self.viewBenefitGoldMember.count > 1{
                let viewBenefitGoldMemberOP = viewBenefitGoldMember[1]
                jobGrade?.text = viewBenefitGoldMemberOP.jobGrade
                opCode?.text = viewBenefitGoldMemberOP.codeName
                opAnnualLimitTitle?.text = viewBenefitGoldMemberOP.annualLimitLabelName
                opAnnualLimit?.text = viewBenefitGoldMemberOP.annualLimit
                opFamilyLimit?.text = viewBenefitGoldMemberOP.familyLimit
                hideOPLimit(isHide: false)
            }else{
                jobGrade?.text = "NA"
                opCode?.text = "NA"
                opAnnualLimitTitle?.text = "NA"
                opAnnualLimit?.text = "NA"
                opFamilyLimit?.text = "NA"
                hideOPLimit(isHide: true)
            }
        }
    }
    
    func hideIPLimit(isHide: Bool){
        self.imgViewIpCode.isHidden = isHide
        self.ipCode.isHidden = isHide
        self.imgViewIpAnualLimit.isHidden = isHide
        self.ipAnnualLimitTitle.isHidden = isHide
        self.ipFamilyLimitTitle.isHidden = isHide
        self.ipAnnualLimit.isHidden = isHide
        self.ipFamilyLimit.isHidden = isHide
        self.imgViewIpFamilyLimit.isHidden = isHide
        self.ipAnualLimitSeparatorView.isHidden = isHide
        self.ipFamilyLimitSeparatorView.isHidden = isHide
    }
    func hideOPLimit(isHide: Bool){
        self.imgViewOpCode.isHidden = isHide
        self.opCode.isHidden = isHide
        self.imgViewOpAnualLimit.isHidden = isHide
        self.opAnnualLimitTitle.isHidden = isHide
        self.opFamilyLimitTitle.isHidden = isHide
        self.opAnnualLimit.isHidden = isHide
        self.opFamilyLimit.isHidden = isHide
        self.imgViewOpFamilyLimit.isHidden = isHide
        self.opAnualLimitSeparatorView.isHidden = isHide
        self.opFamilyLimitSeparatorView.isHidden = isHide
    }
    
    //MARK: Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewRoomEntitlementBtnAction (_ sender: UIButton) {
        performSegue(withIdentifier: "view_benefit_entitlement_gold", sender: self)
    }
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "view_benefit_entitlement_gold") {
            if viewBenefitGoldMember.count > 0{
                let viewBenefitGoldMemberIP = viewBenefitGoldMember[0]
                let vc = segue.destination as! ViewRoomEntitlementViewController
                if (viewBenefitGoldMemberIP.conditions == ""){
                    if viewBenefitGoldMember.count > 1{
                        let viewBenefitGoldMemberIP = viewBenefitGoldMember[1]
                        vc.benefitCondition = viewBenefitGoldMemberIP.conditions
                    }
                }else{
                    vc.benefitCondition = viewBenefitGoldMemberIP.conditions
                }
            }
            
        }
    }
    
    
}

