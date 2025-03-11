//
//  HealthScreeningService.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HealthScreeningService:BaseApiServices {
    
    static let healthScreeningInstance = HealthScreeningService()
    
    func getHealthRiskAssessmentByCardNoService(param:HealthScreeningParameters ,onSuccess:@escaping(HealthScreeningModel)->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        let parameters = [
            "pstMemID": param.pstMemID,
            "pstCardNo": param.pstCardNo
        ]
        let headers = self.createJsonTokenHeader()
        debugPrint(parameters)
        AFManager.request(AppConstant.getHealthRiskAssessmentByCardNoV2Url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            let Status = json["Status"].stringValue
                            if Status == "1" {
                                var model = HealthScreeningModel()
                                if json["HRAData"].count > 0{
                                    let data = json["HRAData"]
                                    model = HealthScreeningModel.parseJSON(json: data)
                                }
                                onSuccess(model)
                            }else{
                                let message = json["Message"].stringValue
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func postViewHraReportListService(param:HealthScreeningParameters ,onSuccess:@escaping([HealthScreeningModel])->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        
        let parameters = [
            "pstCardNo": param.pstCardNo ?? "",
            "pstMemID": param.pstMemID ?? "",
            "pstYear": param.pstYear ?? "",
            "pstMonth": param.pstMonth ?? "",
            "pstPageNo": param.pstPageNo ?? "",
            "pstPageSize": param.pstPageSize ?? ""
        ] as [String : Any]
        let headers = self.createJsonTokenHeader()
        debugPrint(parameters)
       AFManager.request(AppConstant.postViewHraReportListUrl, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            let Status = json["Status"].stringValue
                            if Status == "1" {
                                var modelList = [HealthScreeningModel]()
                                let array = json["HraAssessmentReportData"].arrayValue
                                for item in array {
                                    modelList.append(HealthScreeningModel.parseJSON(json: item))
                                }
                                onSuccess(modelList)
                            }else{
                                let message = json["Message"].stringValue
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getHraBmiService(param:HealthScreeningParameters ,onSuccess:@escaping(String, String)->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        
        let height = param.pstHeight!.replacingOccurrences(of: ",", with: ".")
        let weight = param.pstWeight!.replacingOccurrences(of: ",", with: ".")
        let parameters = [
            "pstHeight": height,
            "pstWeight": weight
        ]
        let headers = self.createJsonTokenHeader()
        debugPrint(parameters)
       AFManager.request(AppConstant.postHraBmiUrl, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            let Status = json["Status"].stringValue
                            if Status == "1" {
                                let bmi_category = json["BmiData"]["BMI_Category"].stringValue
                                let bmi = json["BmiData"]["BMI"].stringValue
                                onSuccess(bmi, bmi_category)
                            }else{
                                let message = json["Message"].stringValue
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func postViewHraReportDataService(param:HealthScreeningParameters ,onSuccess:@escaping(String)->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        
        let parameters = [
            "pstHid": param.pstHid
        ]
        let headers = self.createJsonTokenHeader()
        debugPrint(parameters)
       AFManager.request(AppConstant.postViewHraReportDataUrl, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            let Status = json["Status"].stringValue
                            if Status == "1" {
                                let base64Str = json["ReportData"].stringValue
                                onSuccess(base64Str)
                            }else{
                                let message = json["Message"].stringValue
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func updateStepByStepHealthRiskAssessmentService(param:HealthScreeningModel ,onSuccess:@escaping(HealthScreeningModel, String)->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        
        let headers = self.createJsonTokenHeader()
        let parameters = createParameters(param: param)
        debugPrint(parameters)
        var url:String = AppConstant.updateStepByStepHealthRiskAssessmentV2Url
        if param.isULangBorang == true{
            url = AppConstant.updateStepByStepUlangDass21AssessmentUrl
        }
        print("Url is:\(url)")
       AFManager.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            var Status = json["Status"].stringValue
                            if Status == "1" {
                                var model = HealthScreeningModel()
                                if param.isULangBorang == true{
                                    if json["Dass21Data"].count > 0{
                                        model = HealthScreeningModel.parseJSON(json: json["Dass21Data"])
                                    }
                                }else{
                                    if json["HRAData"].count > 0{
                                        model = HealthScreeningModel.parseJSON(json: json["HRAData"])
                                    }
                                }
                                let message = json["Message"].stringValue
                                onSuccess(model, message)
                            }else{
                                let message = json["Message"].stringValue
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getYearService(onSuccess:@escaping([ProviderTypeModel])->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        
        let headers = self.createJsonTokenHeader()
        
        AFManager.request(AppConstant.getYearUrl, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            let Status = json["Status"].stringValue
                            if Status == "1" {
                                var modelList = [ProviderTypeModel]()
                                let result = json["ReferenceDetailsList"].arrayValue
                                for item in result {
                                    modelList.append(ProviderTypeModel.parseJSON(json: item))
                                }
                                onSuccess(modelList)
                            }else{
                                let message = json["Message"].stringValue
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getMonthService(onSuccess:@escaping([ProviderTypeModel])->Void,onFailure:@escaping(Error)->Void,onFailToken:@escaping()->Void){
        
        let headers = self.createJsonTokenHeader()
        
        AFManager.request(AppConstant.getMonthUrl, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON{
            response in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    let headerStatusCode:Int = (response.response?.statusCode)!
                    if(headerStatusCode == AppConstant.TOKEN_EXPIRED){//Session expired
                        AppConstant.isTokenVerified(){ (Bool) in
                            if Bool{
                                onFailToken()
                            }
                        }
                    }else{
                        do{
                            let json = JSON(data)
                            let message = json["systemInformation"]["errorMessage"].stringValue
                            if message == "" {
                                var modelList = [ProviderTypeModel]()
                                let result = json["ReferenceDetailsList"].arrayValue
                                for item in result {
                                    modelList.append(ProviderTypeModel.parseJSON(json: item))
                                }
                                onSuccess(modelList)
                            }else{
                                let error = NSError(domain: "medilink", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
                                onFailure(error)
                            }
                        }catch let error{
                            onFailure(error)
                        }
                    }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    
    func createParameters(param: HealthScreeningModel) -> [String:String?]{
        let parameters = [
            "Section": param.Section,
            "Step": param.Step,
            "Status": param.Status,
            "UlangDass21btnStatus": param.UlangDass21btnStatus,
            "Langkah1Flag": param.Langkah1Flag,
            "Langkah1FlagColor": param.Langkah1FlagColor,
            "Mhid": param.Mhid,
            "Langkah2Flag": param.Langkah2Flag,
            "Langkah2FlagColor": param.Langkah2FlagColor,
            "MemId": param.MemId,
            "EmpId": param.EmpId,
            "DepId": param.DepId,
            "MemCtlNo": param.MemCtlNo,
            "CardNo": param.CardNo,
            "PayorCd": param.PayorCd,
            "CorpCd": param.CorpCd,
            "PatientNm": param.PatientNm,
            "IcNo": param.IcNo,
            "Gender": param.Gender,
            "Age": param.Age,
            "Dob": param.Dob,
            "payor_member_id": param.payor_member_id,
            "race": param.race,
            "designation": param.designation,
            "personnelareatex": param.personnelareatex,
            "division_desc": param.division_desc,
            "mobile": param.mobile,
            "maritalsts": param.maritalsts,
            "diabetes_self": param.diabetes_self,
            "diabetes_family": param.diabetes_family,
            "hypertension_self": param.hypertension_self,
            "hypertension_family": param.hypertension_family,
            "heart_procedur": param.heart_procedur,
            "heart_self": param.heart_self,
            "heart_family": param.heart_family,
            "stroke_self": param.stroke_self,
            "stroke_family": param.stroke_family,
            "mental_self": param.mental_self,
            "mental_family": param.mental_family,
            "cancer": param.cancer,
            "cancer_self": param.cancer_self,
            "cancer_family": param.cancer_family,
            "asthma_self": param.asthma_self,
            "asthma_family": param.asthma_family,
            "others": param.others,
            "others_self": param.others_self,
            "others_family": param.others_family,
            "height": param.height,
            "weight": param.weight,
            "bmi": param.bmi,
            "bmi_category": param.bmi_category,
            "bloodpressure_systolic": param.bloodpressure_systolic,
            "bloodpressure_diastolic": param.bloodpressure_diastolic,
            "bloodpressure_category": param.bloodpressure_category,
            "bloodglucose": param.bloodglucose,
            "bloodglucose_category": param.bloodglucose_category,
            "cholesterol": param.cholesterol,
            "smoker": param.smoker,
            "smoker_quitsmoking": param.smoker_quitsmoking,
            "smoker_referclinic": param.smoker_referclinic,
            "dass21_q1": param.dass21_q1,
            "dass21_q2": param.dass21_q2,
            "dass21_q3": param.dass21_q3,
            "dass21_q4": param.dass21_q4,
            "dass21_q5": param.dass21_q5,
            "dass21_q6": param.dass21_q6,
            "dass21_q7": param.dass21_q7,
            "dass21_q8": param.dass21_q8,
            "dass21_q9": param.dass21_q9,
            "dass21_q10": param.dass21_q10,
            "dass21_q11": param.dass21_q11,
            "dass21_q12": param.dass21_q12,
            "dass21_q13": param.dass21_q13,
            "dass21_q14": param.dass21_q14,
            "dass21_q15": param.dass21_q15,
            "dass21_q16": param.dass21_q16,
            "dass21_q17": param.dass21_q17,
            "dass21_q18": param.dass21_q18,
            "dass21_q19": param.dass21_q19,
            "dass21_q20": param.dass21_q20,
            "dass21_q21": param.dass21_q21,
        ]
        return parameters
    }

}

class HealthScreeningParameters{
    var pstHid:String?
    var pstMemID:String?
    var pstCardNo:String?
    var pstHeight:String?
    var pstWeight:String?
    var pstYear:String?
    var pstMonth:String?
    var pstPageNo:Int?
    var pstPageSize:Int?
}
