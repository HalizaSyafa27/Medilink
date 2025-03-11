//
//  TeleConsultRequestViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 26/05/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import DatePickerDialog

class TeleConsultRequestViewController: BaseViewController, ChooseDelegate {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var txtFldDateOfConsultation: UITextField!
    @IBOutlet var txtFldTime: UITextField!
    @IBOutlet var txtFldPlanCode: UITextField!
    @IBOutlet var txtFldSymptom: UITextField!
    @IBOutlet var txtFldMedicalHistory: UITextField!
    @IBOutlet var txtFldBloodPressure: UITextField!
    @IBOutlet var txtFldDrugAlergies: UITextField!
    @IBOutlet var txtFldTemp: UITextField!
    @IBOutlet var txtFldHeartRate: UITextField!
    @IBOutlet var txtFldMobile: UITextField!
    @IBOutlet var btnRadioAudio: UIButton!
    @IBOutlet var btnRadioVideo: UIButton!
    @IBOutlet var lbldateofConsulation: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblMobile: UILabel!
    @IBOutlet var lblSymptom: UILabel!
    @IBOutlet var lblDateOfConsultationWidthConstraint: NSLayoutConstraint!
    
    var separatorColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
    var strHeaderImageName = ""
    var className = ""
    var pageTitle = ""
    var strCardNo = ""
    var strPlanCode = ""
    var strPolicyNo = ""
    var strName = ""
    var dateFormated = ""
    var timeFormated = ""
    var dataSource = [CustomObject]()
    var arrPlanCode = [PlanCodeBo]()
    var params: Parameters = [:]
    var modeOfConsult = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        txtFldDateOfConsultation.placeholder = "Select Date"
        txtFldTime.placeholder = "Select Time"
        
//        self.lblPagetitle.text = pageTitle.uppercased()
//        imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        
        self.lblName.text = strName
        self.txtFldPlanCode.text = strPlanCode
        
        let strDate = NSMutableAttributedString(string: "Date of Consultation*")
        strDate.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 20, length: 1))
        lbldateofConsulation.attributedText = strDate
        
        let strTime = NSMutableAttributedString(string: "Time(hh:mm)*")
        strTime.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 11, length: 1))
        lblTime.attributedText = strTime
        
        self.btnRadioAudio.isSelected = true
        self.btnRadioVideo.isSelected = false
        
        let strMobile = NSMutableAttributedString(string: "Mobile Number*")
        strMobile.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 13, length: 1))
        lblMobile.attributedText = strMobile
        
        let strSymptom = NSMutableAttributedString(string: "Symptom*")
        strSymptom.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 7, length: 1))
        lblSymptom.attributedText = strSymptom
        
        lblDateOfConsultationWidthConstraint.constant = 160.0
    }
      
    //MARK: Validation Methods
    func isValidated()-> Bool{
         if (txtFldDateOfConsultation.text == "") {
            self.displayAlert(message: "Please enter date of consultation")
            return false
         }else if (txtFldTime.text == "") {
            self.displayAlert(message: "Please enter time of consultation")
            return false
         }else if (txtFldSymptom.text == "") {
            self.displayAlert(message: "Please enter symptom")
            return false
         }else if (txtFldMobile.text == "") {
            self.displayAlert(message: "Please enter mobile number")
            return false
         }else if (((txtFldMobile.text?.count)! < 10) || ((txtFldMobile.text?.count)! > 12) ) {
            self.displayAlert(message: "Invalid mobile number")
            return false
         }
        return true
    }
    
    //MARK: - Button Action
    @IBAction func btnPlanCodeAction(_ sender: Any) {
        self.performSegue(withIdentifier: "select_plancode", sender: self)
    }
    
    @IBAction func btnDateAction(_ sender: Any) {
        self.dateButtonClicked()
    }
    
    @IBAction func btnTimeAction(_ sender: Any) {
        self.timeButtonClicked()
    }
    
    @IBAction func btnModeAction(_ sender: UIButton) {
        if sender.tag == 111{
            modeOfConsult = "1"
            self.btnRadioAudio.isSelected = true
            self.btnRadioVideo.isSelected = false
        }else{
            modeOfConsult = "2"
            self.btnRadioAudio.isSelected = false
            self.btnRadioVideo.isSelected = true
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let strDocTcvDt = self.dateFormated + " " + self.timeFormated
        
        if self.isValidated() == true {
            params = [
                "fstCardNo": strCardNo,
                "fstPolicyNo": strPolicyNo,
                "fstPlan": strPlanCode,
                "fstDateofConsult": strDocTcvDt,
                "fstModeofConsult": modeOfConsult,
                "fstSymptoms": txtFldSymptom.text!,
                "fstDrugAllergy": txtFldDrugAlergies.text!,
                //"fstBP": txtFldBloodPressure.text!,
                //"fstTemp": txtFldTemp.text!,
                //"fstPulse": txtFldHeartRate.text!,
                "fstPastmedicalHistory": txtFldMedicalHistory.text!,
                "fstMobileNo": txtFldMobile.text!

            ]
            
            AppConstant.selectedViewTag = "2"
            AppConstant.requestParams = params
            //serviceCallToRequest()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.requestReceivedNotification), object: nil)
        }
    }
    
    @objc func dateButtonClicked(){
        self.view.endEditing(true)
        let title = "Date of Consultation"
        
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",defaultDate: Date(), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.txtFldDateOfConsultation.text = formatter.string(from: dt)
                formatter.dateFormat = "yyyy-MM-dd"
                self.dateFormated = formatter.string(from: dt)
                print("new date : \(self.dateFormated)")
                
            }
        }
    }
    
    @objc func timeButtonClicked(){
        self.view.endEditing(true)
        let title = "Time of Consultation"
        
        DatePickerDialog(locale: Locale(identifier: "en_US")).show(title, doneButtonTitle: "Done",defaultDate: Date(), datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                self.txtFldTime.text = formatter.string(from: dt)
                formatter.dateFormat = "HH:mm:ss"
                self.timeFormated = formatter.string(from: dt)
                print("new time : \(self.timeFormated)")
            }
        }
    }
    
    func setDataSource(type: String) -> [CustomObject]{
        //States
        dataSource.removeAll()
        if type == "select_plancode" {
            self.dataSource.removeAll()
            for item in self.arrPlanCode{
                let customObj = CustomObject()
                customObj.name = item.FDESC
                customObj.code = item.planCode
                self.dataSource.append(customObj)
            }
        }
        return dataSource
    }
    
    //MARK: Delegate Methods
    func selectedObject(obj: CustomObject,type: String){
        if type == "select_plancode"{
            strPlanCode = obj.code!
            txtFldPlanCode.text = obj.name
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "select_coverage"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: segue.identifier!)
            vc.type = segue.identifier!
            return
        }else if (segue.identifier == "select_plancode"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: segue.identifier!)
            vc.type = segue.identifier!
            return
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
