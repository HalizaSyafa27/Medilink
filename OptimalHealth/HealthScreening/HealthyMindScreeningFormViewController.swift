//
//  HealthyMindScreeningFormViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit

class HealthyMindScreeningFormViewController: BaseViewController {

    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblStepNumber: UILabel!
    @IBOutlet weak var txtQuestion: UILabel!
    @IBOutlet weak var answerView0: UIView!
    @IBOutlet weak var answerView1: UIView!
    @IBOutlet weak var answerView2: UIView!
    @IBOutlet weak var answerView3: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var btnAnswer0: UIButton!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    
    var cardNo:String = ""
    var className:String = ""
    var model = HealthScreeningModel()
    var stepNumber:Int = 0
    var isULangBorang:Bool = false
    var questionList = [QuestionHealthScreeningModel]()
    var answer:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.setData()
        
        self.answerView0.layer.cornerRadius = 8
        self.answerView0.layer.masksToBounds = true
        self.answerView0.layer.borderWidth = 2
        self.answerView0.layer.borderColor = UIColor.darkGray.cgColor
        
        self.answerView1.layer.cornerRadius = 8
        self.answerView1.layer.masksToBounds = true
        self.answerView1.layer.borderWidth = 2
        self.answerView1.layer.borderColor = UIColor.darkGray.cgColor
        
        self.answerView2.layer.cornerRadius = 8
        self.answerView2.layer.masksToBounds = true
        self.answerView2.layer.borderWidth = 2
        self.answerView2.layer.borderColor = UIColor.darkGray.cgColor
        
        self.answerView3.layer.cornerRadius = 8
        self.answerView3.layer.masksToBounds = true
        self.answerView3.layer.borderWidth = 2
        self.answerView3.layer.borderColor = UIColor.darkGray.cgColor
        
        self.infoView.layer.cornerRadius = 8
        self.infoView.layer.masksToBounds = true
    }
    
    @IBAction func answer0Action(_ sender: UIButton) {
        self.btnAnswer0.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        self.btnAnswer1.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer2.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer3.setImage(UIImage(named: "no.png"), for: .normal)
        self.answer = "0"
        self.updateStepByStepHealthRiskAssessmentService()
    }
    
    @IBAction func answer1Action(_ sender: UIButton) {
        self.btnAnswer1.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        self.btnAnswer0.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer2.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer3.setImage(UIImage(named: "no.png"), for: .normal)
        self.answer = "1"
        self.updateStepByStepHealthRiskAssessmentService()
    }
    
    @IBAction func answer2Action(_ sender: UIButton) {
        self.btnAnswer2.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        self.btnAnswer0.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer1.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer3.setImage(UIImage(named: "no.png"), for: .normal)
        self.answer = "2"
        self.updateStepByStepHealthRiskAssessmentService()
    }
    
    @IBAction func answer3Action(_ sender: UIButton) {
        self.btnAnswer3.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        self.btnAnswer0.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer1.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer2.setImage(UIImage(named: "no.png"), for: .normal)
        self.answer = "3"
        self.updateStepByStepHealthRiskAssessmentService()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func nextQuestion(){
        self.stepNumber = self.stepNumber + 1
        if stepNumber <= 21{
            self.setData()
        }
    }
    
    func showMessageCompletedSave(message: String){
        let newMessage = message.replacingOccurrences(of: "<br/>", with: "\n")
        let alertController = UIAlertController(title: "", message: newMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Finish", style: .default) {_ in
            for controller in self.navigationController!.viewControllers as Array
            {
                if controller.isKind(of: HealthScreeningViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setData(){
        
        self.lblStepNumber.text = "\(stepNumber)/21"
        print("Question:\(self.questionList.count)")
        print("Step Number:\(self.stepNumber)")
        if self.questionList.count >= stepNumber{
            self.txtQuestion.text = self.questionList[stepNumber - 1].title
        }else{
            self.txtQuestion.text = ""
        }
        self.btnAnswer0.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer1.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer2.setImage(UIImage(named: "no.png"), for: .normal)
        self.btnAnswer3.setImage(UIImage(named: "no.png"), for: .normal)
        if (model.dass21_q1 == "0" && self.stepNumber == 1)
            || (model.dass21_q2 == "0" && self.stepNumber == 2)
            || (model.dass21_q3 == "0" && self.stepNumber == 3)
            || (model.dass21_q4 == "0" && self.stepNumber == 4)
            || (model.dass21_q5 == "0" && self.stepNumber == 5)
            || (model.dass21_q6 == "0" && self.stepNumber == 6)
            || (model.dass21_q7 == "0" && self.stepNumber == 7)
            || (model.dass21_q8 == "0" && self.stepNumber == 8)
            || (model.dass21_q9 == "0" && self.stepNumber == 9)
            || (model.dass21_q10 == "0" && self.stepNumber == 10)
            || (model.dass21_q11 == "0" && self.stepNumber == 11)
            || (model.dass21_q12 == "0" && self.stepNumber == 12)
            || (model.dass21_q13 == "0" && self.stepNumber == 13)
            || (model.dass21_q14 == "0" && self.stepNumber == 14)
            || (model.dass21_q15 == "0" && self.stepNumber == 15)
            || (model.dass21_q16 == "0" && self.stepNumber == 16)
            || (model.dass21_q17 == "0" && self.stepNumber == 17)
            || (model.dass21_q18 == "0" && self.stepNumber == 18)
            || (model.dass21_q19 == "0" && self.stepNumber == 19)
            || (model.dass21_q20 == "0" && self.stepNumber == 20)
            || (model.dass21_q21 == "0" && self.stepNumber == 21)
        {
            self.btnAnswer0.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        }
        else if (model.dass21_q1 == "1" && self.stepNumber == 1)
            || (model.dass21_q2 == "1" && self.stepNumber == 2)
            || (model.dass21_q3 == "1" && self.stepNumber == 3)
            || (model.dass21_q4 == "1" && self.stepNumber == 4)
            || (model.dass21_q5 == "1" && self.stepNumber == 5)
            || (model.dass21_q6 == "1" && self.stepNumber == 6)
            || (model.dass21_q7 == "1" && self.stepNumber == 7)
            || (model.dass21_q8 == "1" && self.stepNumber == 8)
            || (model.dass21_q9 == "1" && self.stepNumber == 9)
            || (model.dass21_q10 == "1" && self.stepNumber == 10)
            || (model.dass21_q11 == "1" && self.stepNumber == 11)
            || (model.dass21_q12 == "1" && self.stepNumber == 12)
            || (model.dass21_q13 == "1" && self.stepNumber == 13)
            || (model.dass21_q14 == "1" && self.stepNumber == 14)
            || (model.dass21_q15 == "1" && self.stepNumber == 15)
            || (model.dass21_q16 == "1" && self.stepNumber == 16)
            || (model.dass21_q17 == "1" && self.stepNumber == 17)
            || (model.dass21_q18 == "1" && self.stepNumber == 18)
            || (model.dass21_q19 == "1" && self.stepNumber == 19)
            || (model.dass21_q20 == "1" && self.stepNumber == 20)
            || (model.dass21_q21 == "1" && self.stepNumber == 21)
        {
            self.btnAnswer1.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        }
        else if (model.dass21_q1 == "2" && self.stepNumber == 1)
            || (model.dass21_q2 == "2" && self.stepNumber == 2)
            || (model.dass21_q3 == "2" && self.stepNumber == 3)
            || (model.dass21_q4 == "2" && self.stepNumber == 4)
            || (model.dass21_q5 == "2" && self.stepNumber == 5)
            || (model.dass21_q6 == "2" && self.stepNumber == 6)
            || (model.dass21_q7 == "2" && self.stepNumber == 7)
            || (model.dass21_q8 == "2" && self.stepNumber == 8)
            || (model.dass21_q9 == "2" && self.stepNumber == 9)
            || (model.dass21_q10 == "2" && self.stepNumber == 10)
            || (model.dass21_q11 == "2" && self.stepNumber == 11)
            || (model.dass21_q12 == "2" && self.stepNumber == 12)
            || (model.dass21_q13 == "2" && self.stepNumber == 13)
            || (model.dass21_q14 == "2" && self.stepNumber == 14)
            || (model.dass21_q15 == "2" && self.stepNumber == 15)
            || (model.dass21_q16 == "2" && self.stepNumber == 16)
            || (model.dass21_q17 == "2" && self.stepNumber == 17)
            || (model.dass21_q18 == "2" && self.stepNumber == 18)
            || (model.dass21_q19 == "2" && self.stepNumber == 19)
            || (model.dass21_q20 == "2" && self.stepNumber == 20)
            || (model.dass21_q21 == "2" && self.stepNumber == 21)
        {
            self.btnAnswer2.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        }
        else if (model.dass21_q1 == "3" && self.stepNumber == 1)
            || (model.dass21_q2 == "3" && self.stepNumber == 2)
            || (model.dass21_q3 == "3" && self.stepNumber == 3)
            || (model.dass21_q4 == "3" && self.stepNumber == 4)
            || (model.dass21_q5 == "3" && self.stepNumber == 5)
            || (model.dass21_q6 == "3" && self.stepNumber == 6)
            || (model.dass21_q7 == "3" && self.stepNumber == 7)
            || (model.dass21_q8 == "3" && self.stepNumber == 8)
            || (model.dass21_q9 == "3" && self.stepNumber == 9)
            || (model.dass21_q10 == "3" && self.stepNumber == 10)
            || (model.dass21_q11 == "3" && self.stepNumber == 11)
            || (model.dass21_q12 == "3" && self.stepNumber == 12)
            || (model.dass21_q13 == "3" && self.stepNumber == 13)
            || (model.dass21_q14 == "3" && self.stepNumber == 14)
            || (model.dass21_q15 == "3" && self.stepNumber == 15)
            || (model.dass21_q16 == "3" && self.stepNumber == 16)
            || (model.dass21_q17 == "3" && self.stepNumber == 17)
            || (model.dass21_q18 == "3" && self.stepNumber == 18)
            || (model.dass21_q19 == "3" && self.stepNumber == 19)
            || (model.dass21_q20 == "3" && self.stepNumber == 20)
            || (model.dass21_q21 == "3" && self.stepNumber == 21)
        {
            self.btnAnswer3.setImage(UIImage(named: "tick_blue.png"), for: .normal)
        }
    }
    
    func updateStepByStepHealthRiskAssessmentService(){
        model.Section = "2"
        model.isULangBorang = self.isULangBorang
        if self.stepNumber == 1{
            model.dass21_q1 =  self.answer
            model.Step = "1"
        }
        else if self.stepNumber == 2{
            model.dass21_q2 =  self.answer
            model.Step = "2"
        }
        else if self.stepNumber == 3{
            model.dass21_q3 =  self.answer
            model.Step = "3"
        }
        else if self.stepNumber == 4{
            model.dass21_q4 =  self.answer
            model.Step = "4"
        }
        else if self.stepNumber == 5{
            model.dass21_q5 =  self.answer
            model.Step = "5"
        }
        else if self.stepNumber == 6{
            model.dass21_q6 =  self.answer
            model.Step = "6"
        }
        else if self.stepNumber == 7{
            model.dass21_q7 =  self.answer
            model.Step = "7"
        }
        else if self.stepNumber == 8{
            model.dass21_q8 =  self.answer
            model.Step = "8"
        }
        else if self.stepNumber == 9{
            model.dass21_q9 =  self.answer
            model.Step = "9"
        }
        else if self.stepNumber == 10{
            model.dass21_q10 =  self.answer
            model.Step = "10"
        }
        else if self.stepNumber == 11{
            model.dass21_q11 =  self.answer
            model.Step = "11"
        }
        else if self.stepNumber == 12{
            model.dass21_q12 =  self.answer
            model.Step = "12"
        }
        else if self.stepNumber == 13{
            model.dass21_q13 =  self.answer
            model.Step = "13"
        }
        else if self.stepNumber == 14{
            model.dass21_q14 =  self.answer
            model.Step = "14"
        }
        else if self.stepNumber == 15{
            model.dass21_q15 =  self.answer
            model.Step = "15"
        }
        else if self.stepNumber == 16{
            model.dass21_q16 =  self.answer
            model.Step = "16"
        }
        else if self.stepNumber == 17{
            model.dass21_q17 =  self.answer
            model.Step = "17"
        }
        else if self.stepNumber == 18{
            model.dass21_q18 =  self.answer
            model.Step = "18"
        }
        else if self.stepNumber == 19{
            model.dass21_q19 =  self.answer
            model.Step = "19"
        }
        else if self.stepNumber == 20{
            model.dass21_q20 =  self.answer
            model.Step = "20"
        }
        else if self.stepNumber == 21{
            model.dass21_q21 =  self.answer
            model.Step = "21"
        }
        AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.updateStepByStepHealthRiskAssessmentService(param: model) {
            (result, message) in
            self.model = result
            if self.stepNumber == 21{
                let message = "Hasil Pemeriksaan Kesehatan Mental sudah selesai. Klik ‘Finish’ untuk kembali ke halaman utama."
                self.showMessageCompletedSave(message: message)
            }else{
                self.nextQuestion()
            }
            AppConstant.hideHUD()
          } onFailure: { (error) in
            self.displayAlert(message: error.localizedDescription)
            AppConstant.hideHUD()
        } onFailToken: {
            AppConstant.hideHUD()
            self.updateStepByStepHealthRiskAssessmentService()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print(segue.identifier)
    }
    

}
