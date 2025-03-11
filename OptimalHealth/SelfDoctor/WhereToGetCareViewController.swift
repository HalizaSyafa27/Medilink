//
//  WhereToGetCareViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 30/11/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class WhereToGetCareViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var tblViewQusAnsList: UITableView!
    @IBOutlet weak var imgViewGender: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    var pageTitle = ""
    var strCardNo = ""
    var strPayorMemberId = ""
    
    var arrQuestionList = [QusAnsListBo]()
    var triageUrl: String = ""
    var triageScore: String = ""
    var gender: String = ""
    var symptomHeader = ""
    var selectedAgeFormat1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        lblPageTitle.text = pageTitle
        
        if gender == "f" {
            if (selectedAgeFormat1 == "newborn" || selectedAgeFormat1 == "infant") {
                imgViewGender.image = UIImage.init(named: "child_female")
            }else{
                imgViewGender.image = UIImage.init(named: "female")
            }
        }else{
            if (selectedAgeFormat1 == "newborn" || selectedAgeFormat1 == "infant") {
                imgViewGender.image = UIImage.init(named: "child_male")
            }else{
                imgViewGender.image = UIImage.init(named: "male")
            }
        }
        
        lblDesc.text = symptomHeader
        
        tblViewQusAnsList.delegate = self
        tblViewQusAnsList.dataSource = self
        tblViewQusAnsList.tableFooterView = UIView()
        
        setData()
    }
    
    func setData(){
        var questionBo = QusAnsListBo()
        var ansBo = AnsListBo()
        ansBo.answer = "HOW QUICKLY DID YOUR SYMPTOMS DEVELOP? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "OVER MINUTES/HOURS"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "OVER DAYS"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "3"
        ansBo.answer = "OVER WEEKS"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "4"
        ansBo.answer = "OVER MONTHS"
        questionBo.arrAnsList.append(ansBo)
        
        arrQuestionList.append(questionBo)
        
        questionBo = QusAnsListBo()
        ansBo = AnsListBo()
        ansBo.answer = "HOW LONG HAVE YOU HAD YOUR SYMPTOMS? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "0-6 DAYS"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "WEEKS"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "3"
        ansBo.answer = "MONTHS"
        questionBo.arrAnsList.append(ansBo)
        self.arrQuestionList.append(questionBo)
        
        questionBo = QusAnsListBo()
        ansBo = AnsListBo()
        ansBo.answer = "HOW HAVE YOUR SYMPTOMS CHANGED OVER THE LAST FEW HOURS/DAYS? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "BETTER"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "SAME"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "3"
        ansBo.answer = "WORSE"
        questionBo.arrAnsList.append(ansBo)
        arrQuestionList.append(questionBo)
        
        questionBo = QusAnsListBo()
        ansBo = AnsListBo()
        ansBo.answer = "HOW MUCH PAIN OR DISCOMFORT ARE YOU IN? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "NONE"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "MILD DISCOMFORT"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "3"
        ansBo.answer = "VERY UNCOMFORTABLE"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "4"
        ansBo.answer = "UNBEARABLE"
        questionBo.arrAnsList.append(ansBo)
        arrQuestionList.append(questionBo)
        
        questionBo = QusAnsListBo()
        ansBo = AnsListBo()
        ansBo.answer = "HOW ARE YOUR SYMPTOMS AFFECTING YOUR DAILY ACTIVITIES? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "NO EFFECT"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "STRUGGLING TO CARRY OUT USUAL ACTIVITIES"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "3"
        ansBo.answer = "UNABLE TO CARRY OUT USUAL ACTIVITIES"
        questionBo.arrAnsList.append(ansBo)
        arrQuestionList.append(questionBo)
        
        questionBo = QusAnsListBo()
        ansBo = AnsListBo()
        ansBo.answer = "DO YOU FEEL BETTER AFTER TAKING MEDICATION FOR YOUR SYMPTOMS? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "NOT TAKING ANY"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "YES"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "3"
        ansBo.answer = "NO"
        questionBo.arrAnsList.append(ansBo)
        self.arrQuestionList.append(questionBo)
        
        questionBo = QusAnsListBo()
        ansBo = AnsListBo()
        ansBo.answer = "DO YOU HAVE ANY OTHER SERIOUS, LONG TERM CONDITIONS SUCH AS DIABETES, CANCER, HEART CONDITION ETC? "
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "1"
        ansBo.answer = "NO"
        questionBo.arrAnsList.append(ansBo)
        ansBo = AnsListBo()
        ansBo.answerId = "2"
        ansBo.answer = "YES"
        questionBo.arrAnsList.append(ansBo)
        arrQuestionList.append(questionBo)
    }
    
    //MARK: Tableview Delegate & Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrQuestionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuestionList[section].arrAnsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "questionList", for: indexPath) as! QuestionListTableViewCell
            cell.selectionStyle = .none
            
            let qusListBo = arrQuestionList[indexPath.section].arrAnsList[indexPath.row]
            let qusName = "\(indexPath.section + 1). \(qusListBo.answer)"
            
            let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : AppConstant.themeDarkGrayColor]

            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : AppConstant.themeRedColor]

            let attributedString1 = NSMutableAttributedString(string:qusName, attributes:attrs1)
            let attributedString2 = NSMutableAttributedString(string:"*", attributes:attrs2)

            attributedString1.append(attributedString2)
            cell.lblQuestion.attributedText = attributedString1
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerList", for: indexPath) as! AnswerListTableViewCell
            cell.selectionStyle = .none
            
            let ansListBo = arrQuestionList[indexPath.section].arrAnsList[indexPath.row]
            cell.lblAnswer.text = ansListBo.answer
            
            cell.btnAnswer.isSelected = ansListBo.isSelected
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            let selectedQstnBo = self.arrQuestionList[indexPath.section]
            let selectedBo = self.arrQuestionList[indexPath.section].arrAnsList[indexPath.row]
            for item in  self.arrQuestionList[indexPath.section].arrAnsList{
                item.isSelected = false
            }
            
            selectedQstnBo.ans = selectedBo.answerId
            selectedBo.isSelected = true
            
            self.tblViewQusAnsList.reloadData()
        }
        
    }
    
    //MARK: Button Actions
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if (validationForQusAns()){
            self.serviceCallToGetTriageResult()
        }
    }
    
    //MARK: Validation Method
    func validationForQusAns() -> Bool {
        for item in arrQuestionList{
            if (item.ans == "") {
                self.displayAlert(message: "Please select all answers")
                return false
            }
        }
        return true
    }
    
    //MARK: Service Call
    func serviceCallToGetTriageResult(){
        if AppConstant.hasConnectivity() {//true connected
            AppConstant.showHUD()
            
            let params: Parameters = ["templateUrl": self.triageUrl,
                                      "q1": self.arrQuestionList[0].ans,
                                      "q2": self.arrQuestionList[1].ans,
                                      "q3": self.arrQuestionList[2].ans,
                                      "q4": self.arrQuestionList[3].ans,
                                      "q5": self.arrQuestionList[4].ans,
                                      "q6": self.arrQuestionList[5].ans,
                                      "q7": self.arrQuestionList[6].ans]
            
            let url = "\(AppConstant.triageResultUrl)?cardNo=\(strCardNo)&memberControlNo=\(strPayorMemberId)"
            
            print("params===\(params)")
            print("URL===\(url)")
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            Alamofire.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                AppConstant.hideHUD()
                debugPrint(response)
                
                switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetTriageResult()
                                }
                            })
                        }else{
                            let dict = response.result.value! as! [String: Any]
                            if let success = dict["success"] as? Bool{
                                if success == true{
                                    if let dataDict = dict["data"] as? [String: Any]{
                                        if let triage_score = dataDict["triage_score"] as? String{
                                            self.triageScore = triage_score
                                        }
                                    }
                                    self.performSegue(withIdentifier: "getCareResult", sender: self)
                                }
                            }
                        }
                        
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getCareResult"{
            let vc = segue.destination as! GetCareResultViewController
            vc.triageScore = self.triageScore
            vc.gender = self.gender
            vc.symptomHeader = self.symptomHeader
            vc.selectedAgeFormat1 = self.selectedAgeFormat1
            vc.pageTitle = self.pageTitle
            vc.strCardNo = self.strCardNo
            vc.strPayorMemberId = self.strPayorMemberId
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
