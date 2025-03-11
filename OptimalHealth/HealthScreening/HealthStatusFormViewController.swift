//
//  HealthStatusFormViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import DropDown

class HealthStatusFormViewController: BaseViewController, UITextFieldDelegate{
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblTitlePage: UILabel!
    @IBOutlet weak var lblStepTitle: UILabel!
    //Step 1
    let menuGender: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "MALE",
            "FEMALE",
        ]
        return menu
    }()
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var lblNameText: UILabel!
    
    @IBOutlet weak var lblNoPekerjaTitle: UILabel!
    @IBOutlet weak var lblNoPekerjaText: UILabel!
    @IBOutlet weak var lblUmurTitle: UILabel!
    @IBOutlet weak var lblUmurText: UILabel!
    @IBOutlet weak var txtUmur: UITextField!
    
    @IBOutlet weak var lblJantinaTitle: UILabel!
    @IBOutlet weak var lblJantinaText: UILabel!
    @IBOutlet weak var txtJantina: UITextField!
    
    @IBOutlet weak var lblBangsaTitle: UILabel!
    @IBOutlet weak var lblBangsaText: UILabel!
    @IBOutlet weak var txtBangsa: UITextField!
    
    @IBOutlet weak var lblJawatanTitle: UILabel!
    @IBOutlet weak var lblJawatanText: UILabel!
    @IBOutlet weak var txtJawatan: UITextField!
    
    @IBOutlet weak var lblStesenTitle: UILabel!
    @IBOutlet weak var lblStesenText: UILabel!
    @IBOutlet weak var txtStesen: UITextField!
    
    @IBOutlet weak var lblBahagianTitle: UILabel!
    @IBOutlet weak var lblBahagianText: UILabel!
    @IBOutlet weak var txtBahagian: UITextField!
    
    @IBOutlet weak var lblNoTelefonTitle: UILabel!
    @IBOutlet weak var txtNoTelefon: UITextField!
    
    @IBOutlet weak var btnNextStep1: UIButton!
    
    //Step 2
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var lblHeaderStep2: UILabel!
    @IBOutlet weak var lblQuestion1: UILabel!
    @IBOutlet weak var lblQuestion2: UILabel!
    @IBOutlet weak var lblQuestion3: UILabel!
    @IBOutlet weak var lblQuestion4: UILabel!
    
    @IBOutlet weak var yesDiabetesDiriStep2: UIButton!
    @IBOutlet weak var noDiabetesDiriStep2: UIButton!
    @IBOutlet weak var yesDiabetesIbuStep2: UIButton!
    @IBOutlet weak var noDiabetesIbuStep2: UIButton!
    
    @IBOutlet weak var yesHypertensionDiriStep2: UIButton!
    @IBOutlet weak var noHypertensionDiriStep2: UIButton!
    @IBOutlet weak var yesHypertensionIbuStep2: UIButton!
    @IBOutlet weak var noHypertensionIbuStep2: UIButton!
    
    @IBOutlet weak var yesHeartProsedurStep2: UIButton!
    @IBOutlet weak var noHeartProsedurStep2: UIButton!
    
    @IBOutlet weak var yesHeartDiriStep2: UIButton!
    @IBOutlet weak var noHeartDiriStep2: UIButton!
    @IBOutlet weak var yesHeartIbuStep2: UIButton!
    @IBOutlet weak var noHeartIbuStep2: UIButton!
    
    @IBOutlet weak var yesStrokeDiriStep2: UIButton!
    @IBOutlet weak var noStrokeDiriStep2: UIButton!
    @IBOutlet weak var yesStrokeIbuStep2: UIButton!
    @IBOutlet weak var noStrokeIbuStep2: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    //Step 3
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var lblHeaderStep3: UILabel!
    @IBOutlet weak var lblQuestion5: UILabel!
    @IBOutlet weak var lblQuestion6: UILabel!
    @IBOutlet weak var lblQuestion7: UILabel!
    
    @IBOutlet weak var yesMentalDiriStep3: UIButton!
    @IBOutlet weak var noMentalDiriStep3: UIButton!
    @IBOutlet weak var yesMentalIbuStep3: UIButton!
    @IBOutlet weak var noMentalIbuStep3: UIButton!
    
    @IBOutlet weak var txtJenisKanserStep3: UITextField!
    @IBOutlet weak var yesCancerDiriStep3: UIButton!
    @IBOutlet weak var noCancerDiriStep3: UIButton!
    @IBOutlet weak var yesCancerIbuStep3: UIButton!
    @IBOutlet weak var noCancerIbuStep3: UIButton!
    
    @IBOutlet weak var yesAsthmaDiriStep3: UIButton!
    @IBOutlet weak var noAsthmaDiriStep3: UIButton!
    @IBOutlet weak var yesAsthmaIbuStep3: UIButton!
    @IBOutlet weak var noAsthmaIbuStep3: UIButton!
    
    @IBOutlet weak var txtOthersStep3: UITextField!
    @IBOutlet weak var yesOthersDiriStep3: UIButton!
    @IBOutlet weak var noOthersDiriStep3: UIButton!
    @IBOutlet weak var yesOthersIbuStep3: UIButton!
    @IBOutlet weak var noOthersIbuStep3: UIButton!
    
    @IBOutlet weak var btnNextStep3: UIButton!
    @IBOutlet weak var btnBackStep3: UIButton!
    
    //Step 4
    @IBOutlet weak var step4View: UIView!
    @IBOutlet weak var lblHeaderStep4: UILabel!
    @IBOutlet weak var lblTinggiTitleStep4: UILabel!
    @IBOutlet weak var txtTinggiStep4: UITextField!
    @IBOutlet weak var lblBeratTitleStep4: UILabel!
    @IBOutlet weak var txtBeratStep4: UITextField!
    @IBOutlet weak var btnCalculateBMIStep4: UIButton!
    @IBOutlet weak var lblBMITitleStep4: UILabel!
    @IBOutlet weak var lblBMINumberStep4: UILabel!
    @IBOutlet weak var lblTekananDarahStep4: UILabel!
    @IBOutlet weak var txtTekananDarahStep4: UITextField!
    @IBOutlet weak var txtTekananDarah2Step4: UITextField!
    @IBOutlet weak var lblParasTitleStep4: UILabel!
    @IBOutlet weak var txtParasTitleStep4: UITextField!
    @IBOutlet weak var txtKolesterolStep4: UITextField!
    @IBOutlet weak var lblStatusTitleStep4: UILabel!
    @IBOutlet weak var yesStatusStep4: UIButton!
    @IBOutlet weak var noStatusStep4: UIButton!
    @IBOutlet weak var yesBersediaStep4: UIButton!
    @IBOutlet weak var noBersediaStep4: UIButton!
    @IBOutlet weak var yesDirujukStep4: UIButton!
    @IBOutlet weak var noDirujukStep4: UIButton!
    @IBOutlet weak var btnBackStep4: UIButton!
    @IBOutlet weak var btnNextStep4: UIButton!
    
    var cardNo:String = ""
    var className:String = ""
    var model = HealthScreeningModel()
    var stepNumber:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.changeGender()
        self.txtTinggiStep4.delegate = self
        self.txtBeratStep4.delegate = self
        self.txtTekananDarahStep4.delegate = self
        self.txtTekananDarah2Step4.delegate = self
        self.txtParasTitleStep4.delegate = self
        self.txtKolesterolStep4.delegate = self
        self.design()
        self.setFormRequire()
        self.setData()
        self.controlStep()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.txtTinggiStep4 == textField || self.txtBeratStep4 == textField
            || self.txtParasTitleStep4 == textField || self.txtKolesterolStep4 == textField{
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            let isCheck = newString != "" ? newString.range(of: "^[0-9][0-9]?[0-9]?(?:[.,][0-9]?)?$", options: .regularExpression) != nil : true
            if !isCheck {
                return false
            }
        }
        else if self.txtTekananDarahStep4 == textField
        {
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            if newString != ""{
                let isCheck = newString != "" ? newString.range(of: "^[0-9][0-9]?[0-9]?[0-9]?$", options: .regularExpression) != nil : true
                if newString.count > 3 && isCheck{
                    txtTekananDarah2Step4.becomeFirstResponder()
                    return false
                }
                if !isCheck {
                    return false
                }
            }
        }
        else if self.txtTekananDarah2Step4 == textField
        {
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            if newString != ""{
                let isCheck = newString != "" ? newString.range(of: "^[0-9][0-9]?$", options: .regularExpression) != nil : true
                if !isCheck {
                    return false
                }
            }else{
                self.txtTekananDarah2Step4.text = ""
                txtTekananDarahStep4.becomeFirstResponder()
                return false
            }
        }
        return true
    }
    //Step 1
    
    @IBAction func onChangeGenderAction(_ sender: Any) {
        menuGender.anchorView = self.txtJantina
        menuGender.bottomOffset = CGPoint(x: 0, y:(menuGender.anchorView?.plainView.bounds.height)!)
        menuGender.show()
    }
    
    func changeGender(){
        self.menuGender.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtJantina.text = item
        }
    }
    
    //Step 2
    @IBAction func yesDiabetesDiriStep2Action(_ sender: UIButton) {
        self.yesDiabetesDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noDiabetesDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.diabetes_self = "Y"
    }
    
    @IBAction func noDiabetesDiriStep2Action(_ sender: UIButton) {
        self.yesDiabetesDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noDiabetesDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.diabetes_self = "N"
    }
    
    @IBAction func yesDiabetesIbuStep2Action(_ sender: UIButton) {
        self.yesDiabetesIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noDiabetesIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.diabetes_family = "Y"
    }
    
    @IBAction func noDiabetesIbuStep2Action(_ sender: UIButton) {
        self.yesDiabetesIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noDiabetesIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.diabetes_family = "N"
    }
    
    @IBAction func yesHypertensionDiriStep2Action(_ sender: UIButton) {
        self.yesHypertensionDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noHypertensionDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.hypertension_self = "Y"
    }
    
    @IBAction func noHypertensionDiriStep2Action(_ sender: UIButton) {
        self.yesHypertensionDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noHypertensionDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.hypertension_self = "N"
    }
    
    @IBAction func yesHypertensionIbuStep2Action(_ sender: UIButton) {
        self.yesHypertensionIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noHypertensionIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.hypertension_family = "Y"
    }
    
    @IBAction func noHypertensionIbuStep2Action(_ sender: UIButton) {
        self.yesHypertensionIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noHypertensionIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.hypertension_family = "N"
    }
    
    @IBAction func yesHeartProsedurStep2Action(_ sender: UIButton) {
        self.yesHeartProsedurStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noHeartProsedurStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.heart_procedur = "Y"
    }
    
    @IBAction func noHeartProsedurStep2Action(_ sender: UIButton) {
        self.yesHeartProsedurStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noHeartProsedurStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.heart_procedur = "N"
    }
    
    @IBAction func yesHeartDiriStep2Action(_ sender: UIButton) {
        self.yesHeartDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noHeartDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.heart_self = "Y"
    }
    
    @IBAction func noHeartDiriStep2Action(_ sender: UIButton) {
        self.yesHeartDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noHeartDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.heart_self = "N"
    }
    
    @IBAction func yesHeartIbuStep2Action(_ sender: UIButton) {
        self.yesHeartIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noHeartIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.heart_family = "Y"
    }
    
    @IBAction func noHeartIbuStep2Action(_ sender: UIButton) {
        self.yesHeartIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noHeartIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.heart_family = "N"
    }
    
    @IBAction func yesStrokeDiriStep2Action(_ sender: UIButton) {
        self.yesStrokeDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noStrokeDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.stroke_self = "Y"
    }
    
    @IBAction func noStrokeDiriStep2Action(_ sender: UIButton) {
        self.yesStrokeDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noStrokeDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.stroke_self = "N"
    }
    
    @IBAction func yesStrokeIbuStep2Action(_ sender: UIButton) {
        self.yesStrokeIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noStrokeIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.stroke_family = "Y"
    }
    
    @IBAction func noStrokeIbuStep2Action(_ sender: UIButton) {
        self.yesStrokeIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noStrokeIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.stroke_family = "N"
    }
    
    //Step 3

    @IBAction func yesMentalDiriStep3Action(_ sender: UIButton) {
        self.yesMentalDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noMentalDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.mental_self = "Y"
    }
    
    @IBAction func noMentalDiriStep3Action(_ sender: UIButton) {
        self.yesMentalDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noMentalDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.mental_self = "N"
    }

    @IBAction func yesMentalIbuStep3Action(_ sender: UIButton) {
        self.yesMentalIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noMentalIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.mental_family = "Y"
    }
    
    @IBAction func noMentalIbuStep3Action(_ sender: UIButton) {
        self.yesMentalIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noMentalIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.mental_family = "N"
    }
    
    @IBAction func yesCancerDiriStep3Action(_ sender: UIButton) {
        self.yesCancerDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noCancerDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.cancer_self = "Y"
    }
    
    @IBAction func noCancerDiriStep3Action(_ sender: UIButton) {
        self.yesCancerDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noCancerDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.cancer_self = "N"
    }
    
    @IBAction func yesCancerIbuStep3Action(_ sender: UIButton) {
        self.yesCancerIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noCancerIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.cancer_family = "Y"
    }
    
    @IBAction func noCancerIbuStep3Action(_ sender: UIButton) {
        self.yesCancerIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noCancerIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.cancer_family = "N"
    }
    
    @IBAction func yesAsthmaDiriStep3Action(_ sender: UIButton) {
        self.yesAsthmaDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noAsthmaDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.asthma_self = "Y"
    }
    
    @IBAction func noAsthmaDiriStep3Action(_ sender: UIButton) {
        self.yesAsthmaDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noAsthmaDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.asthma_self = "N"
    }
    
    @IBAction func yesAsthmaIbuStep3Action(_ sender: UIButton) {
        self.yesAsthmaIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noAsthmaIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.asthma_family = "Y"
    }
    
    @IBAction func noAsthmaIbuStep3Action(_ sender: UIButton) {
        self.yesAsthmaIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noAsthmaIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.asthma_family = "N"
    }
    
    @IBAction func yesOthersDiriStep3Action(_ sender: UIButton) {
        self.yesOthersDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noOthersDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.others_self = "Y"
    }
    
    @IBAction func noOthersDiriStep3Action(_ sender: UIButton) {
        self.yesOthersDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noOthersDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.others_self = "N"
    }
    
    @IBAction func yesOthersIbuStep3Action(_ sender: UIButton) {
        self.yesOthersIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noOthersIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.others_family = "Y"
    }
    
    @IBAction func noOthersIbuStep3Action(_ sender: UIButton) {
        self.yesOthersIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noOthersIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.others_family = "N"
    }
    
    //Step 4
    @IBAction func yesStatusStep4Action(_ sender: UIButton) {
        self.yesStatusStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noStatusStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.smoker = "Y"
        
        //Auto set value for Bersedia is null
        self.yesBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.smoker_quitsmoking = ""
        //Auto set value for Dirujuk is null
        self.yesDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.smoker_referclinic = ""
    }
    
    @IBAction func noStatusStep4Action(_ sender: UIButton) {
        self.yesStatusStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noStatusStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.smoker = "N"
        
        //Auto set value for Bersedia is N
        self.yesBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noBersediaStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.smoker_quitsmoking = "N"
        //Auto set value for Dirujuk is N
        self.yesDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noDirujukStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.smoker_referclinic = "N"
    }
    
    @IBAction func yesBersediaStep4Action(_ sender: UIButton) {
        self.yesBersediaStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.smoker_quitsmoking = "Y"
    }
    
    @IBAction func noBersediaStep4Action(_ sender: UIButton) {
        self.yesBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noBersediaStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.smoker_quitsmoking = "N"
    }
    
    @IBAction func yesDirujukStep4Action(_ sender: UIButton) {
        self.yesDirujukStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.noDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.model.smoker_referclinic = "Y"
    }
    
    @IBAction func noDirujukStep4Action(_ sender: UIButton) {
        self.yesDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        self.noDirujukStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        self.model.smoker_referclinic = "N"
    }
    
    @IBAction func calculateBMIAction(_ sender: UIButton) {
        if txtTinggiStep4.text == ""{
            self.displayAlert(message: "Harap mengisi Tinggi")
        }
        else if txtBeratStep4.text == ""{
            self.displayAlert(message: "Harap mengisi Berat")
        }else{
            self.getHraBmiService()
        }
    }
    
    @IBAction func confirmSubmitAction(_ sender: UIButton) {

        self.txtTekananDarahStep4.text = txtTekananDarahStep4.text!.replacingOccurrences(of: ",", with: ".")
        if txtTinggiStep4.text == ""{
            self.displayAlert(message: "Harap mengisi 'Tinggi'")
        }
        else if txtBeratStep4.text == ""{
            self.displayAlert(message: "Harap mengisi 'Berat'")
        }
        else if lblBMINumberStep4.text == "" || lblBMINumberStep4.text == "00.0"{
            self.displayAlert(message: "Harap klik tombol ‘Hitung BMI’ untuk mendapatkan hasil perhitungan BMI")
        }
        else if txtTekananDarahStep4.text == "" || txtTekananDarah2Step4.text == ""{
            self.displayAlert(message: "Harap mengisi Tekanan Darah")
        }
        else if txtParasTitleStep4.text == ""{
            self.displayAlert(message: "Harap mengisi Kadar Gula Darah")
        }
        else if model.smoker != "N" && model.smoker != "Y"{
            self.displayAlert(message: "Harap memilih Status Merokok")
        }
        else{
            self.showMessageConfirmSubmit()
        }
    }
    
    func showMessageConfirmSubmit(){
        let alertController = UIAlertController(title: "Peringatan", message: "Harap pastikan informasi yang Anda berikan sudah benar.\n Klik tombol “Submit” untuk mengirimkan formulir atau klik “Cancel” untuk meninjau informasi sebelum mengirimkan formulir.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default,handler: nil)
        let okAction = UIAlertAction(title: "Submit", style: .default) {_ in
            self.updateStepByStepHealthRiskAssessmentService()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showMessageCompletedSave(message: String){
        let newMessage = message.replacingOccurrences(of: "<br/>", with: "\n")
        let alertController = UIAlertController(title: "", message: newMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Continue", style: .default) {_ in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthyMindScreeningBeginStoryboardID") as! HealthyMindScreeningBeginViewController
            vc.cardNo = self.cardNo
            vc.className = self.className
            vc.model = self.model
            vc.isULangBorang = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.lblBMINumberStep4.text = "00.0"
    }
    
    //End step 4
    
    func showConfirmProceedButton1(){
        let alertController = UIAlertController(title: "", message: "Apakah Anda ingin memulai penilaian kesehatan baru?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){_ in
            self.navigationController?.popViewController(animated: true)
        }
        let okAction = UIAlertAction(title: "Proceed", style: .default) {_ in
            self.updateStepByStepHealthRiskAssessmentService()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func design(){
        self.btnNextStep1.layer.cornerRadius = self.btnNextStep1.layer.frame.height/2
        self.btnNext.layer.cornerRadius = self.btnNext.layer.frame.height/2
        self.btnBack.layer.cornerRadius = self.btnBack.layer.frame.height/2
        self.btnNextStep3.layer.cornerRadius = self.btnNextStep3.layer.frame.height/2
        self.btnBackStep3.layer.cornerRadius = self.btnBackStep3.layer.frame.height/2
        self.btnNextStep4.layer.cornerRadius = self.btnNextStep4.layer.frame.height/2
        self.btnBackStep4.layer.cornerRadius = self.btnBackStep4.layer.frame.height/2
        self.btnCalculateBMIStep4.layer.cornerRadius = self.btnCalculateBMIStep4.layer.frame.height/2
        
        self.txtTinggiStep4.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.txtBeratStep4.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func controlStep(){
        self.step1View.isHidden = true
        self.step2View.isHidden = true
        self.step3View.isHidden = true
        self.step4View.isHidden = true
        self.lblStepTitle.text = "\(self.stepNumber)/4"
        if stepNumber == 1{
            self.step1View.isHidden = false
        }else if stepNumber == 2{
            step2View.isHidden = false
        }else if stepNumber == 3{
            step3View.isHidden = false
        }else if stepNumber == 4{
            step4View.isHidden = false
        }
    }
    
    func setFormRequire(){
        //Step 1
        setFirstTextRequireForForm(lblName: lblHeader, strName: "*Harap periksa kembali semua poin sebelum menekan tombol “Next”")
        
        setTextRequireForForm(lblName: lblNoTelefonTitle, strName: "No Handphone*")
        //Step 2
        setFirstTextRequireForForm(lblName: lblHeaderStep2, strName: "*Harap periksa kembali semua poin sebelum menekan tombol “Next”")
        setTextRequireForForm(lblName: lblQuestion1, strName: "1) Diabetes - kencing Manis*")
        setTextRequireForForm(lblName: lblQuestion2, strName: "2) Hipertensi - Tekanan Darah Tinggi*")
        setTextRequireForForm(lblName: lblQuestion3, strName: "3) Sakit Jantung*")
        setTextRequireForForm(lblName: lblQuestion4, strName: "4) Stroke - Angin Duduk*")
        //Step 3
        setFirstTextRequireForForm(lblName: lblHeaderStep3, strName: "*Harap periksa kembali semua poin sebelum menekan tombol “Next”")
        setTextRequireForForm(lblName: lblQuestion5, strName: "5) Penyakit Mental*")
        setTextRequireForForm(lblName: lblQuestion6, strName: "6) Kanker*")
        setTextRequireForForm(lblName: lblQuestion7, strName: "7) Asma*")
        //Step 4
        setFirstTextRequireForForm(lblName: lblHeaderStep4, strName: "*Harap lengkapi setiap butiran")
        setTextRequireForForm(lblName: lblTinggiTitleStep4, strName: "Tinggi (cm)*")
        setTextRequireForForm(lblName: lblBeratTitleStep4, strName: "Berat (kg)*")
        setTextRequireForForm(lblName: lblBMITitleStep4, strName: "BMI (Body Mass Index)*")
        setPositionTextRequireForForm(lblName: lblTekananDarahStep4, strName: "Tekanan Darah*\n(Normal: < 140/90)", start: "Tekanan Darah*".count - 1, length: 1)
        setPositionTextRequireForForm(lblName: lblParasTitleStep4, strName: "Tingkat gula darah*\n(Normal: < 100mg/dL)", start: "Tingkat gula darah*".count - 1, length: 1)
        setTextRequireForForm(lblName: lblStatusTitleStep4, strName: "Status Merokok*")
    }
    
    func setData(){
        //Step 1
        self.lblNameText.text = self.model.PatientNm
        self.lblNoPekerjaText.text = self.model.payor_member_id
        self.lblUmurText.text = self.model.Age
        self.txtUmur.text = self.model.Age
        self.lblJantinaText.text = self.model.Gender
        self.txtJantina.text = self.model.Gender
        self.lblBangsaText.text = self.model.race
        self.txtBangsa.text = self.model.race
        self.lblJawatanText.text = self.model.designation
        self.txtJawatan.text = self.model.designation
        self.lblStesenText.text = self.model.personnelareatex
        self.txtStesen.text = self.model.personnelareatex
        self.lblBahagianText.text = self.model.division_desc
        self.txtBahagian.text = self.model.division_desc
        self.txtNoTelefon.text = self.model.mobile
        //Step 2
        if model.diabetes_self == "Y"{
            self.yesDiabetesDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noDiabetesDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.diabetes_self == "N"{
            self.yesDiabetesDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noDiabetesDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        if model.diabetes_family == "Y"{
            self.yesDiabetesIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noDiabetesIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.diabetes_family == "N"{
            self.yesDiabetesIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noDiabetesIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.hypertension_self == "Y"{
            self.yesHypertensionDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noHypertensionDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.hypertension_self == "N"{
            self.yesHypertensionDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noHypertensionDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.hypertension_family == "Y"{
            self.yesHypertensionIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noHypertensionIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.hypertension_family == "N"{
            self.yesHypertensionIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noHypertensionIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        if model.heart_procedur == "Y"{
            self.yesHeartProsedurStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noHeartProsedurStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.heart_procedur == "N"{
            self.yesHeartProsedurStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noHeartProsedurStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.heart_self == "Y"{
            self.yesHeartDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noHeartDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.heart_self == "N"{
            self.yesHeartDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noHeartDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        if model.heart_family == "Y"{
            self.yesHeartIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noHeartIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.heart_family == "N"{
            self.yesHeartIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noHeartIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.stroke_self == "Y"{
            self.yesStrokeDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noStrokeDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.stroke_self == "N"{
            self.yesStrokeDiriStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noStrokeDiriStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.stroke_family == "Y"{
            self.yesStrokeIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noStrokeIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.stroke_family == "N"{
            self.yesStrokeIbuStep2.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noStrokeIbuStep2.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        //Step 3
        txtJenisKanserStep3.text = model.cancer
        txtOthersStep3.text = model.others
        if model.mental_self == "Y"{
            self.yesMentalDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noMentalDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.mental_self == "N"{
            self.yesMentalDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noMentalDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.mental_family == "Y"{
            self.yesMentalIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noMentalIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.mental_family == "N"{
            self.yesMentalIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noMentalIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        if model.cancer_self == "Y"{
            self.yesCancerDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noCancerDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.cancer_self == "N"{
            self.yesCancerDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noCancerDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.cancer_family == "Y"{
            self.yesCancerIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noCancerIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.cancer_family == "N"{
            self.yesCancerIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noCancerIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.asthma_self == "Y"{
            self.yesAsthmaDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noAsthmaDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.asthma_self == "N"{
            self.yesAsthmaDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noAsthmaDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.asthma_family == "Y"{
            self.yesAsthmaIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noAsthmaIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.asthma_family == "N"{
            self.yesAsthmaIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noAsthmaIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.others_self == "Y"{
            self.yesOthersDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noOthersDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.others_self == "N"{
            self.yesOthersDiriStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noOthersDiriStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }

        if model.others_family == "Y"{
            self.yesOthersIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noOthersIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.others_family == "N"{
            self.yesOthersIbuStep3.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noOthersIbuStep3.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        //Step 4
        txtTinggiStep4.text = model.height
        txtBeratStep4.text = model.weight
        lblBMINumberStep4.text = model.bmi
        txtKolesterolStep4.text = model.cholesterol
        txtTekananDarahStep4.text = model.bloodpressure_systolic
        txtTekananDarah2Step4.text = model.bloodpressure_diastolic
        txtParasTitleStep4.text = model.bloodglucose
        
        if model.smoker == "Y"{
            self.yesStatusStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noStatusStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.smoker == "N"{
            self.yesStatusStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noStatusStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        if model.smoker_quitsmoking == "Y"{
            self.yesBersediaStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.smoker_quitsmoking == "N"{
            self.yesBersediaStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noBersediaStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
        
        if model.smoker_referclinic == "Y"{
            self.yesDirujukStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
            self.noDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
        }else if model.smoker_referclinic == "N"{
            self.yesDirujukStep4.setImage(UIImage(named: "uncheck_box.png"), for: .normal)
            self.noDirujukStep4.setImage(UIImage(named: "checked_box.png"), for: .normal)
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if stepNumber == 1{
            if txtNoTelefon.text == "" {
                self.displayAlert(message: "Harap mengisi No Handphone")
            }else if self.model.Mhid == ""{
                self.showConfirmProceedButton1()
            }else{
                self.updateStepByStepHealthRiskAssessmentService()
            }
        }
        else {
            if ((model.diabetes_self != "Y" && model.diabetes_self != "N")
                || (model.diabetes_family != "Y" && model.diabetes_family != "N")
                || (model.hypertension_self != "Y" && model.hypertension_self != "N")
                || (model.hypertension_family != "Y" && model.hypertension_family != "N")
                || (model.heart_procedur != "Y" && model.heart_procedur != "N")
                || (model.heart_self != "Y" && model.heart_self != "N")
                || (model.heart_family != "Y" && model.heart_family != "N")
                || (model.stroke_self != "Y" && model.stroke_self != "N")
                || (model.stroke_family != "Y" && model.stroke_family != "N"))
                && stepNumber == 2
            {
                self.displayAlert(message: "Silahkan lengkapi semua jawaban")
            }
            else if ((model.mental_self != "Y" && model.mental_self != "N")
                     || (model.mental_family != "Y" && model.mental_family != "N")
                     || (model.cancer_self != "Y" && model.cancer_self != "N")
                     || (model.cancer_family != "Y" && model.cancer_family != "N")
                     || (model.asthma_self != "Y" && model.asthma_self != "N")
                     || (model.asthma_family != "Y" && model.asthma_family != "N"))
                        && stepNumber == 3
            {
                self.displayAlert(message: "Silahkan lengkapi semua jawaban")
            }
            else if ((model.cancer_self == "Y" || model.cancer_family == "Y") && txtJenisKanserStep3.text == "") && stepNumber == 3
            {
                self.displayAlert(message: "Harap mengisi Jenis Kanser")
            }
            else{
                self.updateStepByStepHealthRiskAssessmentService()
            }
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.stepNumber = self.stepNumber - 1
        self.controlStep()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Service Call
    func getHraBmiService(){
        let parameters = HealthScreeningParameters()
        parameters.pstHeight = txtTinggiStep4.text
        parameters.pstWeight = txtBeratStep4.text
        AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.getHraBmiService(param: parameters) {
            (result,bmi_category) in
            self.lblBMINumberStep4.text = result
            self.model.bmi_category = bmi_category
            AppConstant.hideHUD()
          } onFailure: { (error) in
            self.displayAlert(title: "Alert", message: error.localizedDescription)
              AppConstant.hideHUD()
        } onFailToken: {
            AppConstant.hideHUD()
            self.getHraBmiService()
        }
    }
    
    func updateStepByStepHealthRiskAssessmentService(){
        if self.stepNumber == 1{
            model.Age = self.txtUmur.text
            model.Gender = self.txtJantina.text
            model.race = self.txtBangsa.text
            model.designation = self.txtJawatan.text
            model.personnelareatex = self.txtStesen.text
            model.division_desc = self.txtBahagian.text
            model.mobile = self.txtNoTelefon.text
            model.Section = "1"
            model.Step = "1"
        }
        else if self.stepNumber == 2{
            model.Section = "1"
            model.Step = "2"
        }
        else if self.stepNumber == 3{
            model.Section = "1"
            model.Step = "3"
            model.cancer = txtJenisKanserStep3.text
            model.others = txtOthersStep3.text
        }
        else if self.stepNumber == 4{
            model.Section = "1"
            model.Step = "4"
            model.height = txtTinggiStep4.text!.replacingOccurrences(of: ",", with: ".")
            model.weight = txtBeratStep4.text!.replacingOccurrences(of: ",", with: ".")
            model.bloodpressure_systolic = txtTekananDarahStep4.text
            model.bloodpressure_diastolic = txtTekananDarah2Step4.text
            model.bloodglucose = txtParasTitleStep4.text!.replacingOccurrences(of: ",", with: ".")
            model.cholesterol = txtKolesterolStep4.text!.replacingOccurrences(of: ",", with: ".")
        }
        AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.updateStepByStepHealthRiskAssessmentService(param: model) {
            (result, message) in
            self.model = result
            AppConstant.hideHUD()
            if self.stepNumber == 4{
                var message = "Pengisian Formulir Kondisi Kesehatan Berhasil.\nKlik 'Continue' untuk melanjutkan pengisian \nFormulir Penilaian Kesehatan Mental (DASS21)."
                self.showMessageCompletedSave(message: message)
            }else{
                self.stepNumber = self.stepNumber + 1
                self.controlStep()
            }
          } onFailure: { (error) in
            self.displayAlert(title: "Alert", message: error.localizedDescription)
              AppConstant.hideHUD()
        } onFailToken: {
            AppConstant.hideHUD()
            self.updateStepByStepHealthRiskAssessmentService()
        }
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
