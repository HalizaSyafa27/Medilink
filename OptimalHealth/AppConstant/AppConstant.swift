//
//  AppConstant.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/6/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication
//import Quickblox
//import QuickbloxWebRTC
import PushKit
import WebKit
import CommonCrypto

class AppConstant: NSObject {
    

    // PRODUCTION
//    static var server = "https://app.medilink.co.id/MobileApiv2"
    
    // UAT INDO (AWS)
    static var server = "https://uat.medilink.co.id/MobileapiV2"
    
    //UAT MALAY
//    static var server = "https://medilinkuatext.medibridgeasia.tech/mdindmobileapi"
    
    //LOCAL
//    static var server = "http://192.168.1.54:55789"
    
    static var baseUrl : String = server + "/api/OptimalHealthv2/"
    
    static var getTokenUrl : String = server + "/GetTokenV2"
    //@ade: start
    static var getTokenByJWTUrl : String = server + "/GetTokenByJWT"
    static var getToken3dPartyUrl : String = baseUrl + "/PostToken3dParty"
    //@ade: end
    
    static var validateTokenUrl : String = server + "/ValidateToken"
    
    static var baseUrl2: String = "https://medilinkoptimal.medibridgeasia.tech/api/";

//    static var baseUrl2: String = "http://69.164.206.173/crm/webservice/"
    
    static var signInUrl : String = baseUrl + "PostAuthenticateMember"
    static var member_registration_url : String = baseUrl + "PostRegisterMember"
    static var member_registrationwithmobile_url : String = baseUrl + "PostRegistrationWithMobile"
    static var postMemberVerifyForgotPasswordUrl : String = baseUrl + "PostMemberVerifyForgotPassword"
    static var postVerifyOTPForForgotPasswordUrl : String = baseUrl + "PostVerifyOTPForForgotPassword"
    static var postForgotPasswordUrl : String = baseUrl + "PostForgotPasswordWithMobile"
    static var non_member_registration_url : String = baseUrl + "RegisterNonMember"
    static var agent_registration_url : String = baseUrl + "RegisterAgent"
    static var update_device_token_url : String = baseUrl + "PostDeviceInfo"
    static var policy_details_url : String = baseUrl + "PostPolicyDetails"
    static var policy_detailsv2_url : String = baseUrl + "PostPolicyDetailsv2"
    static var get_dynamic_menu_url : String = baseUrl + "PostMemberMenu"
    static var get_dynamic_menuForAgentandCorporate_url : String = baseUrl + "MenuForAgentandCorporate"
    static var getMemberDependentDetailsForSPGLRequestUrl : String = baseUrl + "PostDependentListForGLRequest"
    static var getMemberDependentDetailsUrl : String = baseUrl + "PostMemberDependentDetails"
    static var getPolicyInfoUrl : String = baseUrl + "PostPolicyInfo"
    static var getMemberSearchPanelProviderUrl : String = baseUrl + "PostPanelProviderForMember"
    static var getMemberNearestSearchPanelProviderUrl : String = baseUrl + "PostNearestPanelProviderForMember"
    static var getCorporateSearchPanelProviderUrl : String = baseUrl + "SearchProvider5"
    static var getCorporateNearestSearchPanelProviderUrl : String = baseUrl + "SearchNearestProvider5"
    static var getAgentSearchPanelProviderUrl : String = baseUrl + "PanelProviderForAgent"
    static var getAgentNearestSearchPanelProviderUrl : String = baseUrl + "SearchNearestPanelProviderForAgent"
    static var changePasswordUrl : String = baseUrl + "PostUpdatePassword"
    static var getPolicyUserCafrdUrl : String = baseUrl + "PostUserCard"
    static var getMemberEntitlementForGoldmemberUrl : String = baseUrl + "GetMemberEntitlementForGoldmember"
    static var getMyTodayGLStatusUrl : String = baseUrl + "PostCurrentAdmissionStatus"
    static var getProviderForreimbursementClaimUrl : String = baseUrl + "GetProviderForreimbursementClaim"
    static var getHospitalUrl : String = baseUrl + "PostHospital"
    static var getPharmacyUrl : String = baseUrl + "PostPharmacy"
    static var getDiagnosisUrl : String = baseUrl + "PostDiagnosis"
    static var getDiagnosisFromSPUrl : String = baseUrl + "PostDiagnosisFromSP"
    static var postDiagnosisbyCoverage : String = baseUrl + "PostDiagnosisbyCoverage"
    static var getDeliveryTypeUrl : String = baseUrl + "GetDeliveryType"
    static var getCoverageUrl : String = baseUrl + "PostCoverage"
    static var getCoverageRelatedClaimsUrl : String = baseUrl + "PostCoverageRelatedClaims"
    static var getPhysicianUrl : String = baseUrl + "PostPhysician"
    static var getGlDocumentUrl : String = baseUrl + "PostGlDocument"
    static var getGlLetterListUrl : String = baseUrl + "PostGLLetter"
    static var getGlDocumentOnClaimsIdUrl : String = baseUrl + "PostGlDocumentOnClaimsId"
    static var savePostedFileUrl : String = baseUrl + "PostOnlineClaimFile"
    static var submitGLRequestUrl : String = baseUrl + "PostOnlineGlRequest"
    static var submitPharmacyRequestUrl : String = baseUrl + "PostPharmacyClaim"
    static var submitReimbursementClaimUrl : String = baseUrl + "PostReimbursementClaim"
    static var forgotPasswordUrl : String = baseUrl + "PostForgotPassword"
    static var verifyForgotPasswordUrl : String = baseUrl + "PostVerifyForgotPassword"
    static var postPasswordRecoveryUrl : String = baseUrl + "PostPasswordRecovery"
    static var postUpdateQAandPasswordRecoveryUrl : String = baseUrl + "PostUpdateQAandPasswordRecovery"
    static var getMedicalVisitClaimsForGoldmemberUrl : String = baseUrl + "PostMedicalVisitClaimsForGoldmember"
    static var getMedicalVisitPharmacyUrl : String = baseUrl + "PostMedicalVisitPharmacy"
    static var getMedicalVisitOPSPUrl : String = baseUrl + "PostMedicalVisitOPSP"
    static var getMedicalVisitGPUrl : String = baseUrl + "PostMedicalVisitGP"
    static var getMedicalVisitIPUrl : String = baseUrl + "PostMedicalVisitIP"
    static var getStatusUrl : String = baseUrl + "PostOnlineClaimRecords"
    static var QRMobileInquiryUrl : String = baseUrl + "PostQRMobileInquiry"
    static var QRMobileRegistrationUrl : String = baseUrl + "PostQRMobileRegistration"
    static var aboutUsUrl : String = baseUrl + "GetAboutus"
    static var disclaimerUrl : String = baseUrl + "GetDisclaimer"
    static var termsUrl : String = baseUrl + "GetTerms"
    static var contactUsUrl : String = baseUrl2 + "contact.php"
    //static var healthAdvisoryUrl : String = baseUrl2 + "healthadvisory.php"
    static var healthAdvisoryUrl : String = "https://crm.e-medilink.com/crm/webservice/healthadvisory.php"
    static var logOutUrl : String = baseUrl2 + "delete_device_user.php"
    static var getChatListUrl : String = baseUrl2 + "chatMessage.php"
    static var getAddChatUrl : String = baseUrl2 + "chat.php"
    static var productAndSericesUrl : String = "http://medilink-global.com/business-overview"
    static var deleteChatMessageUrl : String = baseUrl2 + "deleteChatMessage.php"
    static var getHospitalGuideUrl : String = baseUrl + "GetHospitalGuide"
    static var updateProfilePicUrl : String = baseUrl + "PostProfilePic"
    static var downloadClaimFormsUrl : String = baseUrl + "GetDownloadClaimForms"
    static var getMedicalVisitClaimsUrl : String = baseUrl + "PostMedicalVisitClaims"
    static var getMedicalVisitGLUrl : String = baseUrl + "PostMedicalVisitGL"
    static var getMemberEntitlementForSilverMemberUrl : String = baseUrl + "GetMemberEntitlement2"
    static var touchIdRegistrationUrl : String = baseUrl + "PostTouchidRegistration"
    static var touchIdLoginUrl : String = baseUrl + "PostTouchIDLogin"
    static var removeTouchIDUrl : String = baseUrl + "GetRemoveTouchID"
    static var updateTouchIDUrl : String = baseUrl + "PostUpdateTouchID"
    static var getVirtualCardUrl : String = baseUrl + "PostVirtualCardImage"
    static var getHealthTipsUrl : String = baseUrl + "GetHealthTips"
    static var getMemberEntitlementUrl : String = baseUrl + "PostMemberEntitlement"
    static var updateDashboardHealthDataUrl : String = baseUrl + "PostDashboardData"
    static var getInsuredMemberGLStatusUrl : String = baseUrl + "GetInsuredMemberGLStatus"
    static var getInsuredMemberGLStatus_CorporateUrl : String = baseUrl + "GetInsuredMemberGLStatusByCorp"
    static var getSecurityQuestionUrl : String = baseUrl + "GetSecurityQuestion"
    static var getAccountTypeUrl : String = baseUrl + "GetAccountType"
    static var medicalChitUrl : String = baseUrl + "PostMedicalChit"
    static var claimListForMedicalChitUrl : String = baseUrl + "PostClaimListforMedicalChit"
    static var uploadMedicalChitUrl : String = baseUrl + "PostMedicalChit"
    static var dashboardVirtualCardUrl : String = baseUrl + "PostVirtualCardDashboard"
    static var postMedicalChitOnClaimIdUrl : String = baseUrl + "PostMedicalChitOnClaimsId"
    static var getAdmissionTypeUrl : String = baseUrl + "GetAdmissionType"
    static var postOnlineHosAdmGLRequestUrl : String = baseUrl + "PostOnlineHospitalAdmissionGlRequest"
    static var postDeactivateClaimUrl : String = baseUrl + "PostDeactivateIclaim"
    static var postInvalidateTokenUrl : String = baseUrl + "InValidateToken"
    static var postRateProviderUrl : String = baseUrl + "PostUserProviderRating"
    static var postSettingMenuUrl : String = baseUrl + "PostSettingsMenu"
    static var postPlanCodeUrl : String = baseUrl + "PostPlanCode"
    static var postDependentListForGLRequestUrl : String = baseUrl + "PostDependentListForGLRequest"
    static var postPlanCodeForHospitalGLRequestUrl : String = baseUrl + "PostPlanCodeForHospitalGLRequest"
    static var postPlanCodeForPharmacyRequestUrl : String = baseUrl + "PostPlanCodeForPharmacyRequest"
    static var postPlanCodeForSPGLRequestUrl : String = baseUrl + "PostPlanCodeForSPGLRequest"
    static var contactUsCRMUrl : String = "https://crm.e-medilink.com/crm/webservice/contact.php"
    static var postFeedback : String = baseUrl + "PostFeedback"
    static var postDisplayNameUrl : String = baseUrl + "PostDisplayName"
    static var postRemoveProfilePicUrl : String = baseUrl + "PostRemoveProfilePic"
    static var postTeleConsultUrl : String = baseUrl + "PostTeleHealthRequest"
    static var rssNewsUrl : String = "https://www.who.int/rss-feeds/news-english.xml"
    static var covid19Url : String = "https://covid19.who.int/"
    static var fitnessUrl : String = "https://www.health.com/fitness/feed"
    static var doctorListUrl : String = "https://doctors-meet-api.kalpvaig.com/api/doctor"
    static var rateAppUrl : String = "https://itunes.apple.com/us/app/optimal-health/id6444691018?mt=8"
    static var webmdFitnessUrl : String = "https://www.webmd.com/fitness-exercise/default.htm"
    static var webmdHealthMagazineUrl : String = baseUrl + "GetWebMDHealthMagazine"
    static var webmdSymptomCheckerUrl : String = "https://symptoms.webmd.com/default.htm"
    static var dashBoardListUrl : String = baseUrl + "PostDashboardList"
    static var postAdvisory : String = baseUrl + "PostAdvisoryFromOptimalHealthMobile"
    static var e_marketPlaceUrl : String = "https://medilink-global.com/special?sg_type_pg=all_products"
    static var getListClaimFormFileUrl : String = baseUrl + "GetListClaimFormFile"
    static var getClaimFormFileUrl : String = baseUrl + "GetClaimFormFile"
    static var postViewRatingbyClaimId = "\(baseUrl)PostViewRatingbyClaimid"
    static var postRatingbyClaimId = "\(baseUrl)PostRatingbyClaimid"
    static var postSaveRatingDoc = "\(baseUrl)PostSaveRatingDoc"
    static var postViewRatingbyProvider = "\(baseUrl)PostViewRatingbyProvider"
    static var postViewRatingDocbyProvider = "\(baseUrl)PostViewRatingDocbyProvider"
    static var postRatingbyProvider = "\(baseUrl)PostRatingbyProvider"
    static var postDashboardHistory = "\(baseUrl)PostDashboardHistory"
    
    //SelfDoctor
    static var selfDoctorUrl : String = "https://actionalmd.com/"
    static var getAgeUrl : String = baseUrl + "AgeGroup"
    static var getPregnancyUrl: String = baseUrl + "Pregnancy"
    static var getCountryUrl: String = baseUrl + "Country"
    static var getPredictiveTextUrl: String = baseUrl + "PredictiveText"
    static var diagnosesUrl: String = baseUrl + "Diagnoses"
    static var triageResultUrl: String = baseUrl + "Triage"
    
    //TeleConsult
    static var teleAppoinmentsUrl: String = baseUrl + "PostTeleAppoinments"
    static var telePrescriptionUrl: String = baseUrl + "PostTelePrescription"
    static var teleLabUrl: String = baseUrl + "PostTeleLab"
    static var teleReferralUrl: String = baseUrl + "PostTeleReferral"
    static var teleDocumentbyIclaimidUrl: String = baseUrl + "PostTeleDocumentbyIclaimid"
    
    static var postProfileImageUrl: String = baseUrl + "PostProfileImage"
    static var getCountryV2Url : String = baseUrl + "GetCountry"
    static var getProviderTypeUrl : String = baseUrl + "GetProviderType"
    static var getSpecialityUrl : String = baseUrl + "GetSpeciality"
    static var postStateUrl : String = baseUrl + "PostState"
    static var getChatInfoUrl : String = baseUrl + "GetChatInfo"
    static var postQRCoveragebyProviderUrl : String = baseUrl + "PostQRCoveragebyProvider"
    static var postDischargeAlertUrl : String = baseUrl + "PostDischargeList"
    static var postDischargeNotificationUrl : String = baseUrl + "PostDischargeNotification"
    static var postClaimDocumentByClaimIdUrl : String = baseUrl + "PostClaimDocumentByClaimId"
    static var downloadDocumentByTypeAndFileNameAndClaimsIdUrl : String = baseUrl + "DownloadDocumentByTypeAndFileNameAndClaimsId"
    static var postBenefitUrl : String = baseUrl + "PostBenefit"
    static var postHealthRiskAssessmentByCardNoUrl : String = baseUrl + "CheckAndGetHealthRiskAssessmentByCardNo"
    static var postAddHealthRiskAssessmentUrl : String = baseUrl + "AddHealthRiskAssessment"
    static var postUpdateStepByStepHealthRiskAssessmentUrl : String = baseUrl + "UpdateStepByStepHealthRiskAssessment"
    static var downloadDocumentHealthHistoryQuestionnaireUrl : String = baseUrl + "DownloadDocumentHealthHistoryQuestionnaire"
    static var postCalculateBmiIndexUrl : String = baseUrl + "PostCalculateBmiIndex"
    static var getBMIIndexUrl : String = baseUrl + "GetBMIIndex"
    static var getHealthRiskAssessmentByCardNoV2Url = "\(baseUrl)GetHealthRiskAssessmentByCardNoV2"
    static var postHraBmiUrl = "\(baseUrl)PostHraBmi"
    static var updateStepByStepHealthRiskAssessmentV2Url = "\(baseUrl)UpdateStepByStepHealthRiskAssessmentV2"
    static var updateStepByStepUlangDass21AssessmentUrl = "\(baseUrl)UpdateStepByStepUlangDass21Assessment"
    static var postViewHraReportListUrl = "\(baseUrl)PostViewHraReportList"
    static var postViewHraReportDataUrl = "\(baseUrl)PostViewHraReportData"
    static var getYearUrl = "\(baseUrl)GetYear"
    static var getMonthUrl = "\(baseUrl)GetMonth"
    static var getIDTypeUrl = "\(baseUrl)GetIDType"
    
    static var isSlidingMenu : Bool = false
    static var timeout: Int = 240
    static var totalImagestoUpload: Int = 0
    static var currImageCount: Int = 0
    static var navBarHeight:CGFloat = AppConstant.screenSize.height >= 852 ? 100 : 92
    
    //member Details
    static var memberType : String = ""
    static var screenSize = UIScreen.main.bounds.size
    static var selectedPanelProvider = PanelProvidersBo()
    static var currClassName : String = ""
    static var requestPopupMsg : String = ""
    static var selectedViewTag : String = ""
    static var requestParams: Parameters = [:]
    static var strClaimId : String = ""
    static var strMemId : String = ""
    static var imageUploadStartTime : Date? = nil
    static var imageUploadEndTime : Date? = nil
    static var strUploadTime: String = ""
    static var isClaimSubmitted: Bool = false
    
    //QR Popup
    static var intPopupTag: Int = 0
    static var strQRPopupValue: String = ""
    static var strQRPopupCardNo: String = ""
    static var strQRPopupProviderCode: String = ""
    
    static var TOKEN_EXPIRED: Int = 401
    
    //Virtual card
    //static var virtualCardHeightRatio: CGFloat = 0.6410 //0.5915 1.56 ratio 0.6410
    //0.6387 now
    static var virtualCardHeightRatio: CGFloat = 1.57
    
    //Color
    static var themeGreenColor = UIColor.init(red: 43.0/255.0, green: 99.0/255.0, blue: 109.0/255.0, alpha: 1.0)
    static var placeHolderColor = UIColor.init(red: 43.0/255.0, green: 99.0/255.0, blue: 109.0/255.0, alpha: 1.0)
    static var themeRedColor = UIColor(red: 0/255, green: 85/255, blue: 136/255, alpha: 1)
    static var themeGrayColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    static var themeLightGrayColor = UIColor.init(hexString: "#D9D9D9")
    static var themeDarkGrayColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    static var themeSeparatorGrayColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
    static var readMsgBgColor = UIColor.init(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    static var unreadMsgBgColor = UIColor.init(red: 255.0/255.0, green: 190.0/255.0, blue: 190/255.0, alpha: 1.0)
    static var color1 = UIColor.init(red: 1/255.0, green: 49/255.0, blue: 124/255.0, alpha: 1.0)
    static var colorButton = UIColor(red: 0/255, green: 81/255, blue: 129/255, alpha: 1)
    static var darkColor = UIColor.init(hexString: "#333333")
    static var lightGrayColor = UIColor.init(hexString: "#808080")
    static var themeYellowBgColor = UIColor.init(hexString: "#FEF6DD")
    static var themeYellowTextColor = UIColor.init(hexString: "#957D32")
    static var borderButton:Double = 0.2
    //Google Map Key
//    static var GoogleMapApiKey: String = "AIzaSyBYm_JbaHbjE7DAj9aAMC23MMvj5oF1pOI"
    static var GoogleMapApiKey: String = "AIzaSyDhi_mNb5-7iflNxoEfQKxXJkbJAXMYtDA"
    static var hud = MBProgressHUD()
    
    //JITSI
    static var Jitsi_token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdmF0YXIiOiJodHRwczovL2RlbW8ub29sby5jb20vc3RvcmFnZS9hcHAvdXBsb2Fkcy9wdWJsaWMvNWExL2Q3YS9hOTkvdGh1bWJfMjRfMTAwXzEwMF8wXzBfY3JvcC5qcGciLCJuYW1lIjoiUFQgVklDS1kiLCJlbWFpbCI6IklWQU5OT1ZJQU5AR01BSUwuQ09NIiwiaXNzdWVkRGF0ZSI6IjIwMDkyMDIzMTQwMiIsImlkIjoianRpIiwiZ3JvdXAiOiIzYzRiNjY2Zi1kNjE3LTQxM2UtODc2Yy1mOWI4YmRlYjUyMGUiLCJzdWIiOiJ2Yy5tZWRpbGluay5jby5pZCIsInJvb20iOiJNZWRpbGlua1RlbGVDb25zdWx0LTQ5MSIsImV4cCI6MTY5NTI3OTcxNywiaXNzIjoidmMiLCJhdWQiOiJ2YyJ9.3Ud_uTH2b9CvW0Xb4n2f5fYBRrnaGvruSvUgP3HwWec"
    static var Jitsi_room: String = "MedilinkTeleConsult-491"
    static var Jitsi_caller: String = "Doctor"
    static var isAppOpenedFromCallReceived: Bool = false
    
    class func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
    
    class func showAlertAppConstant(strTitle: String,delegate: AnyObject?) {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: strTitle, message:"", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in

            }))
            alert.view.tintColor = themeRedColor
            let window :UIWindow = UIApplication.shared.keyWindow!
            window.rootViewController?.alert(message: "", title: strTitle)
        }
    }

    class func showAlertAppConstant(strTitle: String,strDescription: String,delegate: AnyObject?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: strTitle, message: strDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            alert.view.tintColor = themeRedColor
            let window :UIWindow = UIApplication.shared.keyWindow!
            window.rootViewController?.alert(message: strDescription, title: strTitle)
        }
    }
    
    class func showAlertWithOkAction(strTitle: String, strDescription: String, delegate: AnyObject?, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: strTitle, message: strDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion()
        }))
        alert.view.tintColor = themeRedColor
        
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController?.alert(message: strDescription, title: strTitle)
    }
    
    //Show custom alert for photos
    class func showAlertToAddProfilePic(){
        let alert = UIAlertController(title: StringConstant.noProfilePicTitle, message: StringConstant.noProfilePicMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium), NSAttributedString.Key.foregroundColor : themeRedColor]), forKey: "attributedMessage")
        alert.view.tintColor = themeRedColor
        
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    //Show Custom Network Connection Message
    class func showNetworkAlertMessage(apiName: String) {
        DispatchQueue.main.async {
            let time = formattedDate(date: Date(), withFormat: StringConstant.dateFormatterUTC, ToFormat: StringConstant.dateFormatter6)
            
            var apiNames = apiName.replacingOccurrences(of: baseUrl, with: "")
            apiNames = apiNames.replacingOccurrences(of: "https://medilinkoptimal.medibridgeasia.tech/", with: "")
            
            let alert = UIAlertController(title: "Connection Error", message: "Unable to process request, please try again.\n\(apiNames)  \n\(time!)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            alert.view.tintColor = themeRedColor
//            let window :UIWindow = UIApplication.shared.keyWindow!
            let window :UIWindow = (UIApplication.shared.delegate?.window!)!
            window.rootViewController?.alert(message: "Unable to process request, please try again.\n\(apiNames)  \n\(time!)", title: "Connection Error")
        }
    }
    
    class func showHUD() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(appDelegate.isHudShowing == false){
            print("Loader Main Showing")
            appDelegate.isHudShowing = true
            //  let window :UIWindow = UIApplication.shared.keyWindow!
            let hud = MBProgressHUD.showAdded(to: appDelegate.window, animated: true)
            hud?.mode = MBProgressHUDMode.indeterminate
            hud?.labelText = "Loading..."
            hud?.dimBackground = true
        }
    }
    
    class func showHUD(title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        hud = MBProgressHUD.showAdded(to: appDelegate.window, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.dimBackground = true
        if(appDelegate.isHudShowing == false){
            appDelegate.isHudShowing = true
            //  let window :UIWindow = UIApplication.shared.keyWindow!
            
        }
        hud.labelText = title
    }
    
    class func setHudTitle(title: String){
        hud.labelText = title
        print("Loader === \(String(describing: hud.labelText))")
    }
    
    class func hideHUD() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(appDelegate.isHudShowing == true){
            print("Loader Hidden")
            appDelegate.isHudShowing = false
            //MBProgressHUD.hide(for: appDelegate.window, animated:true)
            MBProgressHUD.hideAllHUDs(for: appDelegate.window, animated: true)
        }
    }
    
    class func showHUDSingle() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let hud = MBProgressHUD.showAdded(to: appDelegate.window, animated: true)
        hud?.mode = MBProgressHUDMode.indeterminate
        hud?.labelText = "Loading..."
        hud?.dimBackground = true
    }
    
    class func hideHUDSingle() {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           MBProgressHUD.hide(for: appDelegate.window, animated:true)
    }
    
    func showHUDInView(view:UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.mode = MBProgressHUDMode.indeterminate
        hud?.labelText = "Loading..."
        hud?.dimBackground = true
    }
    
    func hideHUDInView(view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    class func isValidEmail(emailId:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailId)
    }
    
    class func validatePassword(phrase:String) -> Bool{
        let letters = NSCharacterSet.letters
        let range = phrase.rangeOfCharacter(from: letters, options: String.CompareOptions.caseInsensitive)
        if(range == nil){
            return false
        }
        
        let digits = NSCharacterSet.decimalDigits
        let range1 = phrase.rangeOfCharacter(from: digits, options: String.CompareOptions.caseInsensitive)
        if(range1 == nil){
            return false
        }
        
        if((phrase.count) < 8){
            return false
        }
        return true
        
    }
    
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
                return ["parseError":error.localizedDescription]
            }
        }
        return nil
    }
    
    class func convertToArray(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    class func convertToJSONString(value: AnyObject) -> String? {
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch{
            }
        }
        return nil
    }
    
    class func saveInDefaults(key: String,value: String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func retrievFromDefaults(key: String) -> String {
        if let returnValue = UserDefaults.standard.object(forKey: key) as? String{
            return returnValue
        }
        return ""
        
    }
    
    class func removeFromDefaults(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func urlEncode(with originalString: String?) -> String? {
        let customAllowedSet = NSCharacterSet.init(charactersIn: "=\"#%/<>?@\\^`{|}").inverted
        let escapedString = originalString?.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        
        print("escapedString: \(String(describing: escapedString))")
        return escapedString
    }
    
    class func apicall(param:[String:Any], url: String){
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        print("url string is \(url)")
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: url)! as URL
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody  = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        let dataTask = session.dataTask(with: request as URLRequest)
        {
            ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode)
            {
            case 200:
                let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                
                if response == "SUCCESS"
                {
                    
                }
                
            default:
                print("save profile POST request got response \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
        
    }
    
//    class func logOut(){
//        serviceCallToLogout()
//    }
    
    class func removeSavedDataAndNavigateToLandingPage(){
        AppConstant.removeFromDefaults(key: StringConstant.isLoggedIn)
        AppConstant.removeFromDefaults(key: StringConstant.policyBackUpData)
        AppConstant.removeFromDefaults(key: StringConstant.email)
        //AppConstant.removeFromDefaults(key: StringConstant.password)
        //AppConstant.removeFromDefaults(key: StringConstant.roleDesc) //Manas
        AppConstant.removeFromDefaults(key: StringConstant.profileImageUrl)
        //AppConstant.removeFromDefaults(key: StringConstant.name)
        AppConstant.removeFromDefaults(key: StringConstant.lastVisited)
        AppConstant.removeFromDefaults(key: StringConstant.appToken)
        AppConstant.removeFromDefaults(key: StringConstant.appTokenType)
        AppConstant.removeFromDefaults(key: StringConstant.isVOIPTokenUpdated)
        //AppConstant.removeFromDefaults(key: StringConstant.hasTouchIdRegistered)
        AppConstant.removeFromDefaults(key: StringConstant.cardImageBase64)
        AppConstant.removeFromDefaults(key: StringConstant.virtualCardImageBase64)
        AppConstant.removeFromDefaults(key: StringConstant.virtualCardBackImageBase64)
        AppConstant.removeFromDefaults(key: StringConstant.virtualQrCode)
        AppConstant.removeFromDefaults(key: StringConstant.virtualQRName)
        AppConstant.removeFromDefaults(key: StringConstant.virtualQRCardNo)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoLandingScreen()
    }
    
    class func removeSavedDataAndNavigateToLoginPage(){
        AppConstant.removeFromDefaults(key: StringConstant.isLoggedIn)
        AppConstant.removeFromDefaults(key: StringConstant.policyBackUpData)
        AppConstant.removeFromDefaults(key: StringConstant.email)
        //AppConstant.removeFromDefaults(key: StringConstant.password)
        //AppConstant.removeFromDefaults(key: StringConstant.roleDesc) //Manas
        AppConstant.removeFromDefaults(key: StringConstant.profileImageUrl)
        //AppConstant.removeFromDefaults(key: StringConstant.name)
        AppConstant.removeFromDefaults(key: StringConstant.lastVisited)
        AppConstant.removeFromDefaults(key: StringConstant.appToken)
        AppConstant.removeFromDefaults(key: StringConstant.appTokenType)
        AppConstant.removeFromDefaults(key: StringConstant.isVOIPTokenUpdated)
        //AppConstant.removeFromDefaults(key: StringConstant.hasTouchIdRegistered)
        AppConstant.removeFromDefaults(key: StringConstant.cardImageBase64)
        AppConstant.removeFromDefaults(key: StringConstant.virtualCardImageBase64)
        AppConstant.removeFromDefaults(key: StringConstant.virtualCardBackImageBase64)
        AppConstant.removeFromDefaults(key: StringConstant.virtualQrCode)
        AppConstant.removeFromDefaults(key: StringConstant.virtualQRName)
        AppConstant.removeFromDefaults(key: StringConstant.virtualQRCardNo)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoLoginScreen()
    }
    
    class func colorWithHexString(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    class func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    class func convertDateToString(strDate: String, currDateFormat: String, requiredDateFormat: String)-> String{
        var strNewDate: String = ""
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        formatter.dateFormat = currDateFormat
        if let date = formatter.date(from: strDate){
            let formatter1 = DateFormatter()
            formatter1.timeZone = NSTimeZone.local
            formatter1.dateFormat = requiredDateFormat
            strNewDate = formatter1.string(from: date)
        }
        return strNewDate
    }
    
    class func formattedDateFromString(dateString: String, withFormat format: String, ToFormat newFormat: String) -> String {
        //yyyy-MM-dd'T'HH:mm:ss
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
//        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = newFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
    
    class func formattedDate(date: Date, withFormat format: String, ToFormat newFormat: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
//        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateString = inputFormatter.string(from: date)
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            outputFormatter.dateFormat = newFormat
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    //MARK: QR Code
    class func generateQRCodeImage(QrCode: String) -> CIImage?{
          print("QR code===\(QrCode)")
        let data = QrCode.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        return filter?.outputImage
          
      }
    
    class func GetSignature() -> String{
        let oldToken = AppConstant.retrievFromDefaults(key: StringConstant.appToken)
        let hashStr = StringConstant.appID + ";" + oldToken + ";" + StringConstant.mobileSecretKey
        return hashStr.sha256()
    }
    
    //MARK: Service Call
    class func isTokenVerified(completion: @escaping (_ isTknVerified : Bool) -> ()) {
        var appTokenType: String = ""
        var appToken: String = ""
        if AppConstant.hasConnectivity() {
            AppConstant.showHUD()
            let params: Parameters = [
                "pstToken": AppConstant.retrievFromDefaults(key: StringConstant.appToken),
                "pstAppID":StringConstant.appID,
                "pstSignature": GetSignature(),
            ]
            print("params===\(params)")
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.validateTokenUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if let dict = response.result.value as? [String: Any]{
                            if let status = dict["status"] as? String {
                                if(status == "1"){//success
                                    if let tokenArray = dict["Token"] as? [[String:AnyObject]]{
                                        if let token = tokenArray[0]["Token"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.appToken, value: token)
                                            appToken = token
                                        }
                                        if let tokenType = tokenArray[0]["Token_type"] as? String{
                                            AppConstant.saveInDefaults(key: StringConstant.appTokenType, value: tokenType)
                                            appTokenType = tokenType
                                        }
                                        AppConstant.saveInDefaults(key: StringConstant.authorization, value: appTokenType + " " + appToken)
                                        AppConstant.saveInDefaults(key: StringConstant.isTokenVerified, value: StringConstant.YES)
                                        completion(true)
                                    }
                                }else {
                                    completion(false)
                                    if let msg = dict["Message"] as? String{
                                        AppConstant.showAlertAppConstant(strTitle: "Error", strDescription: msg, delegate: nil)
                                    }
                                }
                            }else{
                                completion(false)
                                if let msg = dict["Message"] as? String{
                                    AppConstant.showAlertAppConstant(strTitle: "Error", strDescription: msg, delegate: nil)
                                    if msg == StringConstant.autoLogoutMsg{
                                        //Logout
                                        self.removeSavedDataAndNavigateToLoginPage()
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        completion(false)
//                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.validateTokenUrl)
                        break
                    }
            }
        }else{
            AppConstant.showAlertAppConstant(strTitle: "Please check your internet connection.", delegate: self)
            //Return False
            completion(false)
        }
    }
    
    class func setTimeOut(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 180 // seconds
        configuration.timeoutIntervalForResource = 180 //seconds
        AFManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //MARK: Touch Id Authentication
//    class func isTouchIdSupportedOnDevice()-> Bool{
//        let context = LAContext()
//
//        var error: NSError?
//
//        if context.canEvaluatePolicy(
//            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
//            error: &error) {
//            // Biometry is available on the device
//            if #available(iOS 11.0, *) {
//                if context.biometryType == LABiometryType.touchID {
//                    // Device supports Touch ID
//                    return true
//                } else {
//                    // Device has no biometric support
//                    AppConstant.showAlert(strTitle: StringConstant.touchIDValidationMsg, delegate: self)
//                    return false
//                }
//            }
//            return true
//        } else {
//            // Biometry is not available on the device
//            // No hardware support or user has not set up biometric auth
//
//            if let err = error {
//                print(err.code)
//                print(err.description)
//                if #available(iOS 11.0, *) {
//                    switch err.code{
//                    case LAError.Code.biometryNotEnrolled.rawValue:
//                        AppConstant.showAlert(strTitle: StringConstant.userNotEnrolledMsg, delegate: self)
//
//                    case LAError.Code.passcodeNotSet.rawValue:
//                        AppConstant.showAlert(strTitle: StringConstant.passcodeNotSetMsg, delegate: self)
//
//
//                    case LAError.Code.biometryNotAvailable.rawValue:
//                        AppConstant.showAlert(strTitle: StringConstant.touchIDValidationMsg, delegate: self)
//                    default://Unknown error
//                        //AppConstant.showAlert(strTitle: err.description, delegate: self)
//                        let reason:String = "TouchID has been locked out due to too many fail attempt. Enter iPhone passcode to enable TouchID again.";
//                        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,
//                                               localizedReason: reason,
//                                               reply: { (success, error) in
//                                                if success{
//                                                    AppConstant.showAlert(strTitle: "TouchID is now available to use.", delegate: self)
//                                                }
//                                                //return false
//
//                        })
//
//                        return true
//                    }
//                } else {
//                    // Fallback on earlier versions
//                    AppConstant.showAlert(strTitle: StringConstant.touchIDValidationMsg, delegate: self)
//                }
//            }
//
//            return false
//        }
//    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func webviewConfig() -> WKWebViewConfiguration{
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        return wkWebConfig
    }
    
    class func isCallKitSupport() -> Bool {
        let userLocale = NSLocale.current

        if userLocale.regionCode?.contains("CN") != nil ||
            userLocale.regionCode?.contains("CHN") != nil {

            return true
        } else {
            return false
        }
    }
    
    //@ade: start
    class func decodeHeader(token: String) -> String {
        let items = token.split(separator: ".")
        if items.count != 3 {
            return ""
        }
        let header = String(items[0])
        guard let decoded = Data(base64Encoded: header) else {
            return ""
        }
        return String(data: decoded, encoding: String.Encoding.utf8) ?? ""
    }
    
    class func decodePayload(token: String) -> String {
        let items = token.components(separatedBy: ".")
        if items.count != 3 {
            return ""
        }
        let payloadSegment = items[1]
        guard let decoded = base64decode(payloadSegment) else {
              return ""
            }
        return String(data: decoded, encoding: String.Encoding.utf8) ?? ""
    }
    
    class func isExternalUser(userId: String) -> Bool {
        if let _ = userId.firstIndex(of: ":") {
            return true
        }
        return false
    }
    // URI Safe base64 encode
    class func base64encode(_ input: Data) -> String {
      let data = input.base64EncodedData()
      let string = String(data: data, encoding: .utf8)!
      return string
        .replacingOccurrences(of: "+", with: "-")
        .replacingOccurrences(of: "/", with: "_")
        .replacingOccurrences(of: "=", with: "")
    }

    /// URI Safe base64 decode
    class func base64decode(_ input: String) -> Data? {
      let rem = input.count % 4

      var ending = ""
      if rem > 0 {
        let amount = 4 - rem
        ending = String(repeating: "=", count: amount)
      }

      let base64 = input.replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/") + ending

      return Data(base64Encoded: base64)
    }
    
    //@ade: end
}

public extension UIColor {
    class func color(_ hexString: String) -> UIColor? {
        if (hexString.count > 7 || hexString.count < 7) {
            return nil
        } else {
            let hexInt = Int(String(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...]), radix: 16)
            if let hex = hexInt {
                let components = (
                    R: CGFloat((hex >> 16) & 0xff) / 255,
                    G: CGFloat((hex >> 08) & 0xff) / 255,
                    B: CGFloat((hex >> 00) & 0xff) / 255
                )
                return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
            } else {
                return nil
            }
        }
    }
}
extension UIColor {
    static var placeholderGray: UIColor {
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }
}
extension UIAlertController {
     
    private static var globalPresentationWindow: UIWindow?
     
    func presentGlobally(animated: Bool, completion: (() -> Void)?) {
        UIAlertController.globalPresentationWindow = UIWindow(frame: UIScreen.main.bounds)
        UIAlertController.globalPresentationWindow?.rootViewController = UIViewController()
        UIAlertController.globalPresentationWindow?.windowLevel = UIWindow.Level.alert + 1
        UIAlertController.globalPresentationWindow?.backgroundColor = .clear
        UIAlertController.globalPresentationWindow?.makeKeyAndVisible()
        UIAlertController.globalPresentationWindow?.rootViewController?.present(self, animated: animated, completion: completion)
    }
     
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIAlertController.globalPresentationWindow?.isHidden = true
        UIAlertController.globalPresentationWindow = nil
    }
     
}

extension UITextField {
    func setplaceHolderColor(placeholder: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
    }
    
}

extension UIImagePickerController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

//extension UIViewController {
//    func showAlert(alertTitle: String, alertMessage: String) {
//        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        alert.view.tintColor = AppConstant.themeRedColor
//        self.present(alert, animated: true, completion: nil)
//    }
//}

extension String {
    var numbers: String {
        return filter { "0"..."9" ~= $0 }
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var monthh: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.monthh != monthh
    }
}

extension Date {
    
    func startOfMonth() -> Date? {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .hour], from: Calendar.current.startOfDay(for: self))
        return Calendar.current.date(from: comp)!
    }

    func endOfMonth() -> Date? {
        var comp: DateComponents = Calendar.current.dateComponents([.month, .day, .hour], from: Calendar.current.startOfDay(for: self))
        comp.month = 1
        comp.day = -1
        return Calendar.current.date(byAdding: comp, to: self.startOfMonth()!)
    }
}

extension Calendar {

func dayOfWeek(_ date: Date) -> Int {
    var dayOfWeek = self.component(.weekday, from: date) + 1 - self.firstWeekday

    if dayOfWeek <= 0 {
        dayOfWeek += 7
    }

    return dayOfWeek
}

func startOfWeek(_ date: Date) -> Date {
    return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date) + 1), to: date)!
}

func endOfWeek(_ date: Date) -> Date {
    return self.date(byAdding: DateComponents(day: 6), to: self.startOfWeek(date))!
}

func startOfMonth(_ date: Date) -> Date {
    return self.date(from: self.dateComponents([.year, .month], from: date))!
}

func endOfMonth(_ date: Date) -> Date {
    return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date))!
}

func startOfQuarter(_ date: Date) -> Date {
    let quarter = (self.component(.month, from: date) - 1) / 3 + 1
    return self.date(from: DateComponents(year: self.component(.year, from: date), month: (quarter - 1) * 3 + 1))!
}

func endOfQuarter(_ date: Date) -> Date {
    return self.date(byAdding: DateComponents(month: 3, day: -1), to: self.startOfQuarter(date))!
}

func startOfYear(_ date: Date) -> Date {
    return self.date(from: self.dateComponents([.year], from: date))!
}

func endOfYear(_ date: Date) -> Date {
    return self.date(from: DateComponents(year: self.component(.year, from: date), month: 12, day: 31))!
}
}

extension Date {
    static func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())

        var arrDates = [String]()

        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        print(arrDates)
        return arrDates
    }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
extension Date {
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
}
extension UITableView {
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
}
extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    //@ade: start
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
    //@ade: end
}
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
extension Data{
    public func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
