//
//  CustomObject.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 07/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import HealthKit

class CustomObject: NSObject {
    var name: String?
    var code: String?
    var index: Int?
    var conceive: Bool? //For AgeGroupId in SelfDoctor
}

class StateBo: NSObject {
    var name: String?
    var code: String?
}
class PolicyDetailsBo: NSObject {
    var policyNo: String = ""
    var newIC: String = ""
    var cardNo: String = ""
    var planCode: String = ""
    var shortName: String = ""
    var planVersion: String = ""
    var payorCode: String = ""
    var corpCode: String = ""
    var empPlanId: String = ""
    var role: String = ""
    var roleDesc: String = ""
}

class MemberBo: NSObject {
    var cardNo: String?
    var dependentId: String?
    var dependentStatus: String?
    var employeeId: String?
    var gender: String?
    var memberType: String?
    var name: String?
    var nationalId: String?
    var PAYOR_MEMBER_ID: String?
    var policyNo: String?
    var dateOfBirth: String?
    var memberControlNo: String?
    var corpCode: String?
    var payorCode: String?
    var dependentArray = [DependentBo]()
}

class DependentBo: NSObject {
    var cardNo: String?
    var dependentId: String?
    var dependentStatus: String?
    var employeeId: String?
    var gender: String?
    var memberType: String?
    var name: String?
    var nationalId: String?
    var PAYOR_MEMBER_ID: String?
    var policyNo: String?
    var dateOfBirth: String?
    var memberControlNo: String?
    var corpCode: String?
    var payorCode: String?
}

class MainMenuBo:NSObject {
    var apiName: String = ""
    var FDESC: String = ""
    var Image: String = ""
    var OBJID: String = ""
    var ORDSEQ: String = ""
    var frame: String = ""
    var arrSubMenu = [SubMenuBo]()
}

class SubMenuBo:NSObject {
    var apiName: String = ""
    var FDESC: String = ""
    var Image: String = ""
    var OBJID: String = ""
    var ORDSEQ: String = ""
}

class MagazineBo:NSObject {
    var filename: String = ""
    var desc: String = ""
}

class PanelProvidersBo: NSObject {
    var providerName: String = ""
    var providerCode: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var postCode: String = ""
    var phoneNo1: String = ""
    var phoneNo2: String = ""
    var faxNo: String = ""
    var workingHours: String = ""
    var providerTypeCode: String = ""
    var providerTypeDesc: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var distance: String = ""
    var providerUrl: String = ""
    var logoUrl: String = ""
    var likeStatus: Int = 2 //1 - Like /0 - Disappoint /2 - No like No Disappoint
    var likeCount: Int = 0
    var disappointCount: Int = 0
    var star: Int = 0
    var rating: String = ""
    var ratingCnt: Int = 0
    var ratingRemarks: String = ""
    var userID: String = ""
    var publishDt: String = ""
    var ratingID: String = ""
    var fileName: String = ""
    var fileData: String = ""
}

class ViewBenefitGoldMemberBo: NSObject {
    var codeName: String = ""
    var familyLimit: String = ""
    var annualLimit: String = ""
    var jobGrade: String = ""
    var annualLimitLabelName: String = ""
    var conditions: String = ""
}

class HospitalBo: NSObject {
    var name: String = ""
    var providerCode: String = ""
}
class DiagnosysBo: NSObject {
    var name: String = ""
    var diagnosysCode: String = ""
}
class DeliveryAddressBo: NSObject {
    var name: String = ""
    var deliveryId: String = ""
}
class CoverageBo: NSObject {
    var desc: String = ""
    var coverageCode: String = ""
}
class PhysicianBo: NSObject {
    var physicianName: String = ""
    var physicianId: String = ""
}
class AdmissionTypeBo: NSObject {
    var admissionTypeName: String = ""
    var admissionTypeId: String = ""
}
class UploadImageBo: NSObject {
    var name: String?
    var image: UIImage?
    var isUploaded: String?
    var size: String?
    var imgData: NSData?
}
class ClaimBo: NSObject {
    var claimId: String = ""
    var providerName: String = ""
    var admissionDate: String = ""
    var payeeCode: String = ""
    var payeeName: String = ""
    var payeeType: String = ""
    var paymentMode: String = ""
    var disbursementAmount: String = ""
    var paymentDate: String = ""
    var chequeNo: String = ""
    var bankCode: String = ""
    var FDESC: String = ""
    var insertBy: String = ""
    var insertDate: String = ""
    var bankName: String = ""
    var claimStatus: String = ""
    var totalAmount: String = ""
    var approvedAmount: String = ""
    var noncoveredAmount: String = ""
    var remarks: String = ""
    var bankAccountNo: String = ""
    var dischargableDate: String = ""
    var primaryDiagnosys: String = ""
    var coverageId: String = ""
    var admissionType: String = ""
    var rating: Int = 0
    var star: Int = 0
    var ratingID: String = ""
    var providerCode: String = ""
}
class StatusBo: NSObject {
    var GLRequestId: String = ""
    var consultationDate: String = ""
    var status: String = ""
    var remarks: String = ""
    var GLClaimNo: String = ""
    var hospitalName: String = ""
    var doctor: String = ""
    var insertDate: String = ""
    var symptoms: String = ""
    var pastMedicalHistory: String = ""
    var BP: String = ""
    var temp: String = ""
    var pulse: String = ""
    var drugAlergies: String = ""
    var approvedRemarks: String = ""
    
    var coverageID: String = ""
    var modeofConsult: String = ""
    var existingillness: String = ""
    var caseNote: String = ""
    var advicetoPatient: String = ""
    var providerName: String = ""
    var dischargeDate: String = ""
}
class MessageBo: NSObject {
    var text: String?
    var readStatus: String?
    var sender: String?
    var date: String?
    var name: String?
    var messageId: String?
    var userId: String = ""
    var type: String = ""
    var isMedilinkSupport: Bool = false
}
class UserHealthProfile {
    var cardNo: String = ""
    var captureDate: String = ""
    
    var age: Int = 0
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double = 0.0
    var weightInKilograms: Double = 0.0
    var tempInCelcius: Double = 0.0
    var bodyFatPercentage: Double = 0.0
    var heartRate: Int = 0
    var heartRateVariability: Int = 0
    var bpSystolic: Int = 0
    var bpDiastolic: Int = 0
    var caloriesBurned: Double = 0.0
    var stepsToday: Int = 0
    var flightClimbToday: Int = 0
    var totalSleepTime: String = "0h 0m"
    var lightSleepTime: String = "0h 0m"
    var deepSleepTime: String = "0h 0m"
    var walkingRunningDistance: Double = 0.0
    //var bodyMassIndex: Double = 0.0
    
    var bodyMassIndex: Double? {
        return heightInMeters == 0 ? 0.0 : (weightInKilograms/(heightInMeters*heightInMeters))
    }
}
class HealthTipsBo: NSObject {
    var htmlPath: String?
    var lastEditDate: String?
    var title: String?
    var shortDesc: String?
    var imagePath: String?
}

class CoverageAllDataBo: NSObject {
    var coverageInfo: String?
    var limits: String?
    var exclusion: String?
    var arrCoverageData = [CoverageDataBo]()
    var DISPLAYBENEFIT:String?
    var YTDCONSUMP:String?
    var NOTE:String?
}

class CoverageDataBo: NSObject {
    var benefits: String = ""
    var limits: String = ""
    var exclusion: String = ""
    var code: String = ""
    var name: String = ""
    var start_date: String = ""
    var end_date: String = ""
    var ytdconsump: String = ""
    var remainingYearlyLimeTime: String = ""
    var conditions: String = ""
    var AVAILABLELIMIT: String = ""
    var NOTE: String = ""
    var benefit:String = ""
}

class GLStatusBo: NSObject {
    var patientName: String?
    var policyNo: String?
    var providerName: String?
    var providerId: String?
    var admissionDate: String?
    var glStatus: String?
}
class SecurityQuestion: NSObject {
    var name: String = ""
    var id: String = ""
}

class ViewGlBo: NSObject {
    var claimId: String = ""
    var admissionDate: String = ""
    var CovId: String = ""
    var patientName: String = ""
    var admType: String = ""
    var newIc: String = ""
    var claimStatus: String = ""
    var payorRemarks: String = ""
    var docReceivedDate: String = ""
    var glStatus: String = ""
    var glPrintDate: String = ""
    var transactionDate: String = ""
    var glImage: String = ""
}

class ClaimAmountBo: NSObject {
    var claimId: String = ""
    var admissionDate: String = ""
    var durTotal: String = ""
    var paidtoClaimAmt: String = ""
    var primaryDiagnosis: String = ""
    var providerID: String = ""
    var providerName: String = ""
}
class BottomMenuBo: NSObject {
    var title: String = ""
    var image: String = ""
}

class VirtualCardBo: NSObject {
    var value1: String = ""
    var value2: String = ""
    var memberSince: String = ""
    var name: String = ""
    var cardNo: String = ""
    var qrCode: String = ""
    var cardBgUrl: String = ""
    var foregroundColor: String = ""
}

class AdvisoryDropdownBo: NSObject {
    var id: String = ""
    var type: String = ""
    var desc: String = ""
    var index: Int = 0
}

class InputFileUpload: NSObject {
    var pstFile: String = ""
    var pstFileName: String = ""
}

class HelthTipsDealsOffresBo: NSObject {
    var title: String = ""
    var image: String = ""
    var desc: String = ""
    var offer: String = ""
    var price: String = ""
    
}
class PlanCodeBo: NSObject {
    var planCode: String = ""
    var FDESC: String = ""
}

class News: NSObject{
    var title: String = ""
    var desc: String = ""
    var pubDate: String = ""
}

class Doctors: NSObject{
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var id: Int = 0
    var isActive: Bool = false
}
class StepsBO: NSObject{
    var startDate: String = ""
    var endDate: String = ""
    var valueTitle: String = ""
    var value: Int = 0
}
class WalkingRunningDistanceBO: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var distanceInKm: Double = 0.0
}
class HeartRateBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var heartRate: Int = 0
}
class HeartRateVariabilityBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var heartRateVariability: Int = 0
}
class FlightClimbCountBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var flightClimb: Int = 0
}
class BodyTemperatureBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var temperature: Int = 0
}
class BloodPressureBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var bpSystolic: Int = 0
    var bpDiastolic: Int = 0
}
class BodyFatBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var bodyFatPercentage: Double = 0.0
}
class EnergyBurnedBo: NSObject{
    var startDate: Date? = nil
    var endDate: Date? = nil
    var energyBurned: Double = 0.0
}
class AgeGroupDetailsBo: NSObject{
    var ageGroup_id: String = ""
    var ordinal: String = ""
    var name: String = ""
    var yr_From: String = ""
    var yr_To: String = ""
    var branch: String = ""
    var can_conceive: Bool = false
}
class PregnancyStatusBo: NSObject{
    var pregnancyId: String = ""
    var pregnancyName: String = ""
}
class CountryListBo: NSObject{
    var countryId: String = ""
    var countryName: String = ""
    var abbreviation: String = ""
    var regionId: String = ""
}
class SymptomsListBo: NSObject{
    
}
class DiagnosesListBo: NSObject{
    var diagnosisId: String = ""
    var diagnosisName: String = ""
    var knowledgeWindow_url: String = ""
    var redFlag: String = ""
    var gender: String = ""
    var specialty: String = ""
    var commonDiagnosis: String = ""
    var snomed_diagnosisID: String = ""
    var icd9_diagnosisID: String = ""
    var icd10_diagnosisID: String = ""
}
class QusAnsListBo: NSObject{
    var arrAnsList = [AnsListBo]()
    var ans: String = ""
}
class AnsListBo: NSObject{
    var answer: String = ""
    var answerId: String = ""
    var isSelected: Bool = false
}
class ClaimDocumentListing: NSObject{
    var DATEUPLOAD: String = ""
    var FILENAME: String = ""
    var FILESIZE: String = ""
    var ID: String = ""
    var KEY1: String = ""
    var REMARKS: String = ""
    var UPLBY: String = ""
}
class HealthRiskAssessmentBo: NSObject {
    var cardNo: String?
    var dependentId: String?
    var dependentStatus: String?
    var employeeId: String?
    var gender: String?
    var memberType: String?
    var name: String?
    var nationalId: String?
    var payorMemberId: String?
    var policyNo: String?
    var dateOfBirth: String?
    var memberControlNo: String?
    var corpCode: String?
    var payorCode: String?
}

class HealthRiskAssessmentModel: NSObject {
    var HRAID: String = ""
    var INSBY: String = ""
    var INSDT: String = ""
    var UPDBY: String = ""
    var UPDDT: String = ""
    var MEMID: String = ""
    var EMPID: String = ""
    var DEPID: String = ""
    var MEMCTLNO: String = ""
    var CARDNO: String = ""
    var PAYORCD: String = ""
    var CORPCD: String = ""
    var CLAIMSTS: String = ""
    var ICNO: String = ""
    var PATIENTNM: String = ""
    var GENDER: String = ""
    var DOB: String = ""
    var AGE: String = ""
    var MARITALSTS: String = ""
    var NOOFCHILDREN: String = ""
    var NOOFCHILDRENLWY: String = ""
    var OCCUPATIONCUR: String = ""
    var OCCUPATIONPRV: String = ""
    var CHILDHDILLNESS_MEASLES: String = ""
    var CHILDHDILLNESS_MUMPS: String = ""
    var CHILDHDILLNESS_RUB: String = ""
    var CHILDHDILLNESS_CHKPOX: String = ""
    var CHILDHDILLNESS_RTFEVER: String = ""
    var CHILDHDILLNESS_POLIO: String = ""
    var CHILDHDILLNESS_NONE: String = ""
    var IMM_TETANUS: String = ""
    var IMM_TETANUSDT: String = ""
    var IMM_PNEUMONIA: String = ""
    var IMM_PNEUMONIADT: String = ""
    var IMM_HEPATITISA: String = ""
    var IMM_HEPATITISADT: String = ""
    var IMM_HEPATITISB: String = ""
    var IMM_HEPATITISBDT: String = ""
    var IMM_CHICKENPOX: String = ""
    var IMM_CHICKENPOXDT: String = ""
    var IMM_INFLUENZA: String = ""
    var IMM_INFLUENZADT: String = ""
    var IMM_MUMPS: String = ""
    var IMM_MUMPSDT: String = ""
    var IMM_RUBELLA: String = ""
    var IMM_RUBELLADT: String = ""
    var IMM_MENINGOCOCCAL: String = ""
    var IMM_MENINGOCOCCALDT: String = ""
    var IMM_NONE: String = ""
    var SCR_EYEEXAM: String = ""
    var SCR_EYEEXAMDT: String = ""
    var SCR_COLONOSCOPY: String = ""
    var SCR_COLONOSCOPYDT: String = ""
    var SCR_DEXA_SCAN: String = ""
    var SCR_DEXA_SCANDT: String = ""
    var SCR_NONE: String = ""
    var SURGERY1: String = ""
    var SURGERY1_YEAR: String = ""
    var SURGERY1_REASON: String = ""
    var SURGERY1_PROV: String = ""
    var SURGERY2: String = ""
    var SURGERY2_YEAR: String = ""
    var SURGERY2_REASON: String = ""
    var SURGERY2_PROV: String = ""
    var SURGERY3: String = ""
    var SURGERY3_YEAR: String = ""
    var SURGERY3_REASON: String = ""
    var SURGERY3_PROV: String = ""
    var SURGERY4: String = ""
    var SURGERY4_YEAR: String = ""
    var SURGERY4_REASON: String = ""
    var SURGERY4_PROV: String = ""
    var SURGERY5: String = ""
    var SURGERY5_YEAR: String = ""
    var SURGERY5_REASON: String = ""
    var SURGERY5_PROV: String = ""
    var SURGERY_DONEBF: String = ""
    var HOSP1: String = ""
    var HOSP1_YEAR: String = ""
    var HOSP1_REASON: String = ""
    var HOSP1_PROV: String = ""
    var HOSP2: String = ""
    var HOSP2_YEAR: String = ""
    var HOSP2_REASON: String = ""
    var HOSP2_PROV: String = ""
    var HOSP3: String = ""
    var HOSP3_YEAR: String = ""
    var HOSP3_REASON: String = ""
    var HOSPY3_PROV: String = ""
    var HOSP4: String = ""
    var HOSP4_YEAR: String = ""
    var HOSP4_REASON: String = ""
    var HOSP4_PROV: String = ""
    var HOSP5: String = ""
    var HOSP5_YEAR: String = ""
    var HOSP5_REASON: String = ""
    var HOSP5_PROV: String = ""
    var HOSPY_DONEBF: String = ""
    var DOCVST1: String = ""
    var DOCVST1_YEAR: String = ""
    var DOCVST1_REASON: String = ""
    var DOCVST1_PROV: String = ""
    var DOCVST2: String = ""
    var DOCVST2_YEAR: String = ""
    var DOCVST2_REASON: String = ""
    var DOCVST2_PROV: String = ""
    var DOCVST3: String = ""
    var DOCVST3_YEAR: String = ""
    var DOCVST3_REASON: String = ""
    var DOCVST3_PROV: String = ""
    var DOCVST4: String = ""
    var DOCVST4_YEAR: String = ""
    var DOCVST4_REASON: String = ""
    var DOCVST4_PROV: String = ""
    var DOCVST5: String = ""
    var DOCVST5_YEAR: String = ""
    var DOCVST5_REASON: String = ""
    var DOCVST5_PROV: String = ""
    var DOCVST_DONEBF: String = ""
    var MEDICALHISTORYCD: String = ""
    var PASTMEDHIST: String = ""
    var PREVREFDOC: String = ""
    var PHYSICALEXAMDT: String = ""
    var BLOODTRANSFUSION: String = ""
    var MEDICATION1_DRUG: String = ""
    var MEDICATION1_NAME: String = ""
    var MEDICATION1_DOSAGE: String = ""
    var MEDICATION2_DRUG: String = ""
    var MEDICATION2_NAME: String = ""
    var MEDICATION2_DOSAGE: String = ""
    var MEDICATION3_DRUG: String = ""
    var MEDICATION3_NAME: String = ""
    var MEDICATION3_DOSAGE: String = ""
    var MEDICATION4_DRUG: String = ""
    var MEDICATION4_NAME: String = ""
    var MEDICATION4_DOSAGE: String = ""
    var MEDICATION5_DRUG: String = ""
    var MEDICATION5_NAME: String = ""
    var MEDICATION5_DOSAGE: String = ""
    var MEDICATION_NONE: String = ""
    var ALERGY1: String = ""
    var ALERGY1_NAME: String = ""
    var ALERGY1_REACTION: String = ""
    var ALERGY2: String = ""
    var ALERGY2_NAME: String = ""
    var ALERGY2_REACTION: String = ""
    var ALERGY3: String = ""
    var ALERGY3_NAME: String = ""
    var ALERGY3_REACTION: String = ""
    var ALERGY_NONE: String = ""
    var FMEDICALHISTORYCD: String = ""
    var SC_EXERCISE: String = ""
    var SC_EXERCISEDUR: String = ""
    var SC_DIET: String = ""
    var SC_DIETPHY: String = ""
    var SC_MEALPRDAY: String = ""
    var SC_SALTINTAKE: String = ""
    var SC_FATINTAKE: String = ""
    var SC_CAFFINE: String = ""
    var SC_CAFFINEINTAKE: String = ""
    var SC_RANKFATINTAKE: String = ""
    var SC_CAFFINEPERDAY: String = ""
    var SC_ALCOHOL: String = ""
    var SC_ALCOHOLTYP: String = ""
    var SC_ALCOHOLPWK: String = ""
    var SC_ALCOHOLCN: String = ""
    var SC_ALCOHOLCN_DES: String = ""
    var SC_ALCOHOLSTOP: String = ""
    var SC_ALCOHOLSTOP_DES: String = ""
    var SC_ALCOHOLBO: String = ""
    var SC_ALCOHOLBO_DES: String = ""
    var SC_ALCOHOLBG: String = ""
    var SC_ALCOHOLBG_DES: String = ""
    var SC_ALCOHOLDR: String = ""
    var SC_ALCOHOLDR_DES: String = ""
    var SC_TOBACCO: String = ""
    var SC_TOBACCO_DES: String = ""
    var SC_TOBACCOCIG: String = ""
    var SC_TOBACCOPKSDAY: String = ""
    var SC_TOBACCOPKSWEEK: String = ""
    var SC_TOBACCOCHW: String = ""
    var SC_TOBACCOCHW_DES: String = ""
    var SC_TOBACCOCPP: String = ""
    var SC_TOBACCOCPP_DES: String = ""
    var SC_TOBACCOCCG: String = ""
    var SC_TOBACCOCCG_DES: String = ""
    var SC_TOBACCOYRS: String = ""
    var SC_TOBACCOYRS_DES: String = ""
    var SC_TOBACCOYRSQT: String = ""
    var SC_TOBACCOYRSQT_DES: String = ""
    var SC_DRUGRCST: String = ""
    var SC_DRUGRCST_DES: String = ""
    var SC_DRUGRCSTNDL: String = ""
    var SC_DRUGRCSTNDL_DES: String = ""
    var SC_DRUGPHY: String = ""
    var SC_SEX: String = ""
    var SC_SEXPREG: String = ""
    var SC_SEXCONTRA: String = ""
    var SC_SEXDISCOM: String = ""
    var SC_SEXILLNESSPHY: String = ""
    var SC_MENTALSTRESS: String = ""
    var SC_MENTALDEPRESS: String = ""
    var SC_MENTALPANIC: String = ""
    var SC_MENTALEAT: String = ""
    var SC_MENTALCRY: String = ""
    var SC_MENTALSUICIDE: String = ""
    var SC_MENTALSLEEP: String = ""
    var SC_MENTALCOUNSEL: String = ""
    var SC_PSAFETYALONE: String = ""
    var SC_PSAFETYFALL: String = ""
    var SC_PSAFETYVISION: String = ""
    var SC_PSAFETYABUSE: String = ""
    var SC_PSAFETYSUNBURN: String = ""
    var SC_PSAFETYSUNEXP: String = ""
    var SC_PSAFETYSEATBLT: String = ""
    var WH_MENSTAG: String = ""
    var WH_MENSTLASTDT: String = ""
    var WH_MENSTDAYS: String = ""
    var WH_HEAVYPERIODS: String = ""
    var WH_PREGCOUNT: String = ""
    var WH_LIVEBIRTH: String = ""
    var WH_PREGBRFEED: String = ""
    var WH_INFECTION: String = ""
    var WH_CESAREAN: String = ""
    var WH_PROC: String = ""
    var WH_URINEBLOOD: String = ""
    var WH_FLASHSWEAT: String = ""
    var WH_MENSTSYMPTOM: String = ""
    var WH_BREASTSELFEXM: String = ""
    var WH_BREASTSYMPTOM: String = ""
    var WH_PELPEPSMEAR: String = ""
    var MH_URINATE: String = ""
    var MH_URINATEBURN: String = ""
    var MH_URINATEBLOOD: String = ""
    var MH_URINATEDISCHARGE: String = ""
    var MH_URINATEFORCE: String = ""
    var MH_KDBLDPROSINF: String = ""
    var MH_EMPTYBLADDER: String = ""
    var MH_ERECTION: String = ""
    var MH_TESTICLEPN: String = ""
    var MH_PROSRECEXAM: String = ""
    var DIABETES_MELLITUS: String = ""
    var DIABETES_MED_DET: String = ""
    var DIABETES_SINCE_WHEN: String = ""
    var HYPERTENSION: String = ""
    var HYPERTENSION_MED_DET: String = ""
    var HYPERTENSION_SINCE_WHEN: String = ""
    var SC_AD: String = ""
    var SC_ADDETAILS: String = ""
    var SC_RELIGIONBELIEF: String = ""
    var SC_RELIGIONBELREM: String = ""
    var SC_INFO: String = ""
    var SC_EDUCATION: String = ""
    var SC_ENGLISH: String = ""
    var SC_LANGUAGE: String = ""
    var SYMPTOMCD: String = ""
    var OTHSYMPTOM: String = ""
    var HEALTHMGRCD: String = ""
    var HEALTHMGRNM: String = ""
    var HEALTHMGRUPDDT: String = ""
    var HEALTHMGRNOTE: String = ""
    var PATIENTRATING: String = ""
    var ADVISETOPATIENT: String = ""
    var SHOWADVISETOPATIENT: String = ""
    var ADVISETOPATIENTDT: String = ""
}

class DashboardHistoryModel: NSObject {
    var Weight: String = ""
    var Bmi: String = ""
    var Fat: String = ""
    var DataCaptureDt: String = ""
    var Age: String = ""
    var Height: String = ""
    var WalkingDistanceToday: String = ""
    var Temperature: String = ""
    var CalBurnied: String = ""
    var BloodPressure: String = ""
    var TotalSleep: String = ""
    var LightSleep: String = ""
    var DeepSleep: String = ""
    var FlightsClimbToday: String = ""
    var StepsToday: String = ""
    var HeartRate: String = ""
    var HeartRateVariability: String = ""
    var BloodGlucose: String = ""
    var CardNo: String = ""
}
