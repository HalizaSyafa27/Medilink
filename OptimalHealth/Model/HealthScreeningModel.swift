//
//  HealthScreeningModel.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import SwiftyJSON

class HealthScreeningModel {
    
    enum Key:String{
        case Section = "Section"
        case Step = "Step"
        case Status = "Status"
        case UlangDass21btnStatus = "UlangDass21btnStatus"
        case Langkah1Flag = "Langkah1Flag"
        case Langkah1FlagColor = "Langkah1FlagColor"
        case Mhid = "Mhid"
        case Langkah2Flag = "Langkah2Flag"
        case Langkah2FlagColor = "Langkah2FlagColor"
        case MemId = "MemId"
        case EmpId = "EmpId"
        case DepId = "DepId"
        case MemCtlNo = "MemCtlNo"
        case CardNo = "CardNo"
        case PayorCd = "PayorCd"
        case CorpCd = "CorpCd"
        case PatientNm = "PatientNm"
        case IcNo = "IcNo"
        case Gender = "Gender"
        case Age = "Age"
        case Dob = "Dob"
        case payor_member_id = "payor_member_id"
        case race = "race"
        case designation = "designation"
        case personnelareatex = "personnelareatex"
        case division_desc = "division_desc"
        case mobile = "mobile"
        case maritalsts = "maritalsts"
        case diabetes_self = "diabetes_self"
        case diabetes_family = "diabetes_family"
        case hypertension_self = "hypertension_self"
        case hypertension_family = "hypertension_family"
        case heart_procedur = "heart_procedur"
        case heart_self = "heart_self"
        case heart_family = "heart_family"
        case stroke_self = "stroke_self"
        case stroke_family = "stroke_family"
        case mental_self = "mental_self"
        case mental_family = "mental_family"
        case cancer = "cancer"
        case cancer_self = "cancer_self"
        case cancer_family = "cancer_family"
        case asthma_self = "asthma_self"
        case asthma_family = "asthma_family"
        case others = "others"
        case others_self = "others_self"
        case others_family = "others_family"
        case height = "height"
        case weight = "weight"
        case bmi = "bmi"
        case bmi_category = "bmi_category"
        case bloodpressure_systolic = "bloodpressure_systolic"
        case bloodpressure_diastolic = "bloodpressure_diastolic"
        case bloodpressure_category = "bloodpressure_category"
        case bloodglucose = "bloodglucose"
        case bloodglucose_category = "bloodglucose_category"
        case cholesterol = "cholesterol"
        case smoker = "smoker"
        case smoker_quitsmoking = "smoker_quitsmoking"
        case smoker_referclinic = "smoker_referclinic"
        case dass21_q1 = "dass21_q1"
        case dass21_q2 = "dass21_q2"
        case dass21_q3 = "dass21_q3"
        case dass21_q4 = "dass21_q4"
        case dass21_q5 = "dass21_q5"
        case dass21_q6 = "dass21_q6"
        case dass21_q7 = "dass21_q7"
        case dass21_q8 = "dass21_q8"
        case dass21_q9 = "dass21_q9"
        case dass21_q10 = "dass21_q10"
        case dass21_q11 = "dass21_q11"
        case dass21_q12 = "dass21_q12"
        case dass21_q13 = "dass21_q13"
        case dass21_q14 = "dass21_q14"
        case dass21_q15 = "dass21_q15"
        case dass21_q16 = "dass21_q16"
        case dass21_q17 = "dass21_q17"
        case dass21_q18 = "dass21_q18"
        case dass21_q19 = "dass21_q19"
        case dass21_q20 = "dass21_q20"
        case dass21_q21 = "dass21_q21"
        case ulangDass21 = "UlangDass21"
        case dateSubmitted = "DateSubmitted"
        case hid = "Hid"
    }
    
    var Section:String?
    var Step:String?
    var Status:String?
    var UlangDass21btnStatus:String?
    var Langkah1Flag:String?
    var Langkah1FlagColor:String?
    var Mhid:String?
    var Langkah2Flag:String?
    var Langkah2FlagColor:String?
    var MemId:String?
    var EmpId:String?
    var DepId:String?
    var MemCtlNo:String?
    var CardNo:String?
    var PayorCd:String?
    var CorpCd:String?
    var PatientNm:String?
    var IcNo:String?
    var Gender:String?
    var Age:String?
    var Dob:String?
    var payor_member_id:String?
    var race:String?
    var designation:String?
    var personnelareatex:String?
    var division_desc:String?
    var mobile:String?
    var maritalsts:String?
    var diabetes_self:String?
    var diabetes_family:String?
    var hypertension_self:String?
    var hypertension_family:String?
    var heart_procedur:String?
    var heart_self:String?
    var heart_family:String?
    var stroke_self:String?
    var stroke_family:String?
    var mental_self:String?
    var mental_family:String?
    var cancer:String?
    var cancer_self:String?
    var cancer_family:String?
    var asthma_self:String?
    var asthma_family:String?
    var others:String?
    var others_self:String?
    var others_family:String?
    var height:String?
    var weight:String?
    var bmi:String?
    var bmi_category:String?
    var bloodpressure_systolic:String?
    var bloodpressure_diastolic:String?
    var bloodpressure_category:String?
    var bloodglucose:String?
    var bloodglucose_category:String?
    var cholesterol:String?
    var smoker:String?
    var smoker_quitsmoking:String?
    var smoker_referclinic:String?
    var dass21_q1:String?
    var dass21_q2:String?
    var dass21_q3:String?
    var dass21_q4:String?
    var dass21_q5:String?
    var dass21_q6:String?
    var dass21_q7:String?
    var dass21_q8:String?
    var dass21_q9:String?
    var dass21_q10:String?
    var dass21_q11:String?
    var dass21_q12:String?
    var dass21_q13:String?
    var dass21_q14:String?
    var dass21_q15:String?
    var dass21_q16:String?
    var dass21_q17:String?
    var dass21_q18:String?
    var dass21_q19:String?
    var dass21_q20:String?
    var dass21_q21:String?
    var isULangBorang:Bool?
    var ulangDass21:String?
    var dateSubmitted:String?
    var hid:String?
    
    public static func parseJSON(json:JSON)->HealthScreeningModel{
        let model = HealthScreeningModel()
        model.Section = json[Key.Section.rawValue].stringValue
        model.Step = json[Key.Step.rawValue].stringValue
        model.Status = json[Key.Status.rawValue].stringValue
        model.UlangDass21btnStatus = json[Key.UlangDass21btnStatus.rawValue].stringValue
        model.Langkah1Flag = json[Key.Langkah1Flag.rawValue].stringValue
        model.Langkah1FlagColor = json[Key.Langkah1FlagColor.rawValue].stringValue
        model.Mhid = json[Key.Mhid.rawValue].stringValue
        model.Langkah2Flag = json[Key.Langkah2Flag.rawValue].stringValue
        model.Langkah2FlagColor = json[Key.Langkah2FlagColor.rawValue].stringValue
        model.MemId = json[Key.MemId.rawValue].stringValue
        model.EmpId = json[Key.EmpId.rawValue].stringValue
        model.DepId = json[Key.DepId.rawValue].stringValue
        model.MemCtlNo = json[Key.MemCtlNo.rawValue].stringValue
        model.CardNo = json[Key.CardNo.rawValue].stringValue
        model.PayorCd = json[Key.PayorCd.rawValue].stringValue
        model.CorpCd = json[Key.CorpCd.rawValue].stringValue
        model.PatientNm = json[Key.PatientNm.rawValue].stringValue
        model.IcNo = json[Key.IcNo.rawValue].stringValue
        model.Gender = json[Key.Gender.rawValue].stringValue
        model.Age = json[Key.Age.rawValue].stringValue
        model.Dob = json[Key.Dob.rawValue].stringValue
        model.payor_member_id = json[Key.payor_member_id.rawValue].stringValue
        model.race = json[Key.race.rawValue].stringValue
        model.designation = json[Key.designation.rawValue].stringValue
        model.personnelareatex = json[Key.personnelareatex.rawValue].stringValue
        model.division_desc = json[Key.division_desc.rawValue].stringValue
        model.mobile = json[Key.mobile.rawValue].stringValue
        model.maritalsts = json[Key.maritalsts.rawValue].stringValue
        model.diabetes_self = json[Key.diabetes_self.rawValue].stringValue
        model.diabetes_family = json[Key.diabetes_family.rawValue].stringValue
        model.hypertension_self = json[Key.hypertension_self.rawValue].stringValue
        model.hypertension_family = json[Key.hypertension_family.rawValue].stringValue
        model.heart_procedur = json[Key.heart_procedur.rawValue].stringValue
        model.heart_self = json[Key.heart_self.rawValue].stringValue
        model.heart_family = json[Key.heart_family.rawValue].stringValue
        model.stroke_self = json[Key.stroke_self.rawValue].stringValue
        model.stroke_family = json[Key.stroke_family.rawValue].stringValue
        model.mental_self = json[Key.mental_self.rawValue].stringValue
        model.mental_family = json[Key.mental_family.rawValue].stringValue
        model.cancer = json[Key.cancer.rawValue].stringValue
        model.cancer_self = json[Key.cancer_self.rawValue].stringValue
        model.cancer_family = json[Key.cancer_family.rawValue].stringValue
        model.asthma_self = json[Key.asthma_self.rawValue].stringValue
        model.asthma_family = json[Key.asthma_family.rawValue].stringValue
        model.others = json[Key.others.rawValue].stringValue
        model.others_self = json[Key.others_self.rawValue].stringValue
        model.others_family = json[Key.others_family.rawValue].stringValue
        model.height = json[Key.height.rawValue].stringValue
        model.weight = json[Key.weight.rawValue].stringValue
        model.bmi = json[Key.bmi.rawValue].stringValue
        model.bmi_category = json[Key.bmi_category.rawValue].stringValue
        model.bloodpressure_systolic = json[Key.bloodpressure_systolic.rawValue].stringValue
        model.bloodpressure_diastolic = json[Key.bloodpressure_diastolic.rawValue].stringValue
        model.bloodpressure_category = json[Key.bloodpressure_category.rawValue].stringValue
        model.bloodglucose = json[Key.bloodglucose.rawValue].stringValue
        model.bloodglucose_category = json[Key.bloodglucose_category.rawValue].stringValue
        model.cholesterol = json[Key.cholesterol.rawValue].stringValue
        model.smoker = json[Key.smoker.rawValue].stringValue
        model.smoker_quitsmoking = json[Key.smoker_quitsmoking.rawValue].stringValue
        model.smoker_referclinic = json[Key.smoker_referclinic.rawValue].stringValue
        model.dass21_q1 = json[Key.dass21_q1.rawValue].stringValue
        model.dass21_q2 = json[Key.dass21_q2.rawValue].stringValue
        model.dass21_q3 = json[Key.dass21_q3.rawValue].stringValue
        model.dass21_q4 = json[Key.dass21_q4.rawValue].stringValue
        model.dass21_q5 = json[Key.dass21_q5.rawValue].stringValue
        model.dass21_q6 = json[Key.dass21_q6.rawValue].stringValue
        model.dass21_q7 = json[Key.dass21_q7.rawValue].stringValue
        model.dass21_q8 = json[Key.dass21_q8.rawValue].stringValue
        model.dass21_q9 = json[Key.dass21_q9.rawValue].stringValue
        model.dass21_q10 = json[Key.dass21_q10.rawValue].stringValue
        model.dass21_q11 = json[Key.dass21_q11.rawValue].stringValue
        model.dass21_q12 = json[Key.dass21_q12.rawValue].stringValue
        model.dass21_q13 = json[Key.dass21_q13.rawValue].stringValue
        model.dass21_q14 = json[Key.dass21_q14.rawValue].stringValue
        model.dass21_q15 = json[Key.dass21_q15.rawValue].stringValue
        model.dass21_q16 = json[Key.dass21_q16.rawValue].stringValue
        model.dass21_q17 = json[Key.dass21_q17.rawValue].stringValue
        model.dass21_q18 = json[Key.dass21_q18.rawValue].stringValue
        model.dass21_q19 = json[Key.dass21_q19.rawValue].stringValue
        model.dass21_q20 = json[Key.dass21_q20.rawValue].stringValue
        model.dass21_q21 = json[Key.dass21_q21.rawValue].stringValue
        model.ulangDass21 = json[Key.ulangDass21.rawValue].stringValue
        model.dateSubmitted = json[Key.dateSubmitted.rawValue].stringValue
        model.hid = json[Key.hid.rawValue].stringValue
        return model
    }
    
    static func createQuestionList() -> [QuestionHealthScreeningModel]{
        let questionList:[QuestionHealthScreeningModel] = [
            QuestionHealthScreeningModel.init(id:1, title: "1) Saya merasa sulit untuk tenang"),
            QuestionHealthScreeningModel.init(id:2, title: "2) Saya menyadari mulut saya terasa kering"),
            QuestionHealthScreeningModel.init(id:3, title: "3) Saya tidak dapat merasakan perasaan positif"),
            QuestionHealthScreeningModel.init(id:4, title: "4) Saya mengalami kesulitan bernafas (contohnya: bernafas terlalu cepat, terengah-engah walaupun tidak melakukan aktivitas fisik)"),
            QuestionHealthScreeningModel.init(id:5, title: "5) Saya sulit bersemangat ketika melakukan pekerjaan"),
            QuestionHealthScreeningModel.init(id:6, title: "6) Saya cenderung bertindak berlebihan dalam suatu situasi"),
            QuestionHealthScreeningModel.init(id:7, title: "7) Saya merasa gemetar (contohnya: pada tangan)"),
            QuestionHealthScreeningModel.init(id:8, title: "8) Saya merasa menggunakan banyak energi ketika merasa cemas atau gelisah"),
            QuestionHealthScreeningModel.init(id:9, title: "9) Saya khawatir saya akan terlalu panik dan melakukan kesalahan di beberapa keadaan."),
            QuestionHealthScreeningModel.init(id:10, title: "10) Saya merasa putus asa atau tidak memiliki harapan akan sesuatu"),
            QuestionHealthScreeningModel.init(id:11, title: "11) Saya merasa semakin gelisah"),
            QuestionHealthScreeningModel.init(id:12, title: "12) Saya merasa sulit untuk rileks"),
            QuestionHealthScreeningModel.init(id:13, title: "13) Saya merasa sedih dan murung"),
            QuestionHealthScreeningModel.init(id:14, title: "14) Saya merasa sulit untuk sabar ketika ada halangan yang menghambat saya dalam melakukan aktivitas"),
            QuestionHealthScreeningModel.init(id:15, title: "15) Saya merasa panik/cemas"),
            QuestionHealthScreeningModel.init(id:16, title: "16) Saya tidak bersemangat dengan apa saja yang saya kerjakan"),
            QuestionHealthScreeningModel.init(id:17, title: "17) Saya merasa tidak berharga"),
            QuestionHealthScreeningModel.init(id:18, title: "18) Saya merasa mudah tersinggung"),
            QuestionHealthScreeningModel.init(id:19, title: "19) Saya merasa jantung saya berdetak lebih cepat atau lebih lambat, meskipun tidak sedang melakukan aktivitas fisik"),
            QuestionHealthScreeningModel.init(id:20, title: "20) Saya merasa takut tanpa sebab"),
            QuestionHealthScreeningModel.init(id:21, title: "21) Saya merasa hidup ini tidak bermakna/tidak berarti lagi"),
        ]
        return questionList
    }
    
}

class QuestionHealthScreeningModel {
    
    var id:Int?
    var title:String?
    
    init(id:Int, title:String) {
        self.id = id
        self.title = title
    }
}
