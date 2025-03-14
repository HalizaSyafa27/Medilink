//
//  StringConstant.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/7/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class StringConstant: NSObject {
    //User Default Constants
    static var isTokenVerified: String = "isTokenVerified"
    static var chatUserName: String = "chatUserName"
    static var chatEmail: String = "chatEmail"
    static var chatName: String = "chatName"
    static var isTandCAcceprted : String = "isTermsAndConditionAccepted"
    static var YES : String = "YES"
    static var NO : String = "NO"
    static var deviceToken : String = "APNID"
    static var voip_Token : String = "VOIPTOKEN"
    static var email : String = "email"
    static var password : String = "Password"
    static var emailAddress : String = "emailAddress"
    static var currencySymbol : String = "currencySymbol"
    static var emergencyNo : String = "emergencyNo"
    static var nationalId : String = "NationalID"
    static var cardNo : String = "CardNo"
    static var memberType : String = "MemberType"
    static var userType: String = "UserType"
    static var agentId : String = "agentId"
    static var iOS : String = "iOS"
    static var isTokenSaved : String = "isDeviceTokenSavedinRemote"
    static var isLoggedIn : String = "isLoggedIn"
    static var policyDetails : String = "policyDetails"
    static var policyNumber : String = "POLICY_NO"
    static var planCode : String = "PLAN_CODE"
    static var roleDesc : String = "ROLE_DESC"
    static var corpDesc : String = "CORP_CODE"
    static var policyBackUpData : String = "policyBackUpData"
    static var latitude : String = "latitude"
    static var longitude : String = "longitude"
    static var name : String = "Name"
    static var displayName : String = "DisplayName"
    static var profileImageUrl : String = "profileImageUrl"
    static var lastVisited : String = "lastVisited"
    static var state : String = "state"
    static var postCode : String = "postCode"
    static var memberSince : String = "memberSince"
    static var mobileNo : String = "mobileNo"
    static var policyNo : String = "policyNo"
    static var payorCode : String = "payorCode"
    static var role : String = "role"
    static var memId : String = "memId"
    static var hasTouchIdRegistered : String = "hasTouchIdRegistered"
    static var appToken : String = "appToken"
    static var appTokenType : String = "appTokenType"
    static var appID : String = "zaT6gP3gVYxp0V4iH3gd54mYSreNcZTe"
    static var mobileSecretKey : String = "5gdCLOHzF+15hYDOMHn1suQS88Y8jydM"
    static var secretKey : String = "c99o0867994f4ttt63f55b727cdd3cb8"
    static var iv : String = "c99o0867994f4ttt"
    static var encryptedUserId : String = "encryptedUserId"
    static var encryptedPassword : String = "encryptedPassword"
    static var authorization : String = "authorization"
    static var isVOIPTokenUpdated : String = "isVOIPTokenUpdayed"
    static var activityCurrentDate: String = "activityCurrentDate"
    static var cardImageBase64: String = "CardImageBase64"
    static var virtualCardImageBase64: String = "VirtualCardImageBase64"
    static var virtualCardBackImageBase64: String = "VirtualCardBackImageBase64"
    static var virtualQrCode: String = "VirtualQrCode"
    static var virtualQRName: String = "VirtualQRName"
    static var virtualQRCardNo: String = "VirtualQRCardNo"
    //@ade: start
    static var externalUserLabel: String = "ExternalUserLabel"
    //@ade: end
    
    //login
    static var userNameBlankValidation : String = "Username is required"
    static var passwordBlankValidation : String = "Password is required"
    static var touchIDValidationMsg : String = "Your device does not support for touch id"
    static var passcodeNotSetMsg : String = "A passcode has not been set in your device"
    static var userNotEnrolledMsg : String = "Touch ID has not been set in your device"
    
    //Registration
    static var nameBlankValidation : String = "Name is required"
    static var cardNoBlankValidation : String = "Card No is required"
    static var postCodeBlankValidation : String = "Postcode is required"
    static var cityBlankValidation : String = "City is required"
    static var stateBlankValidation : String = "State is required"
    static var mobileBlankValidation : String = "Mobile number is required"
    static var userIdValidation : String = "User ID is required"
    static var addressBlankValidation : String = "Address is required"
    static var emailBlankValidation : String = "Email is required"
    static var emailValidation : String = "Please input a valid email address"
    static var displayNameBlankValidation : String = "Display name is required"
    static var addressValidation : String = "Address is required"
    static var passwordValidation : String = "Password is required"
    static var displayNameValidation : String = "Password is required"
    static var cnfPasswordValidation : String = "Confirm password is required"
    static var passwordNotMatchValidation : String = "Password and confirm password doesn't match"
    static var nationalIdBlankValidation : String = "NIK is required"
    static var memberSinceBlankValidation : String = "Member Since is required"
    static var agreeToTCValidation : String = "Please agree to the term & conditions"
    static var genderValidation : String = "Gender is required"
    static var dobValidation : String = "Date of Birth is required"
    static var agentIDValidation : String = "Agent Id is required"
    static var ans1Validation : String = "Security answer1 is required"
    static var ans2Validation : String = "Security answer2 is required"
    static var ans3Validation : String = "Security answer3 is required"
    static var phoneBlankValidation : String = "Phone number is required"
    static var mobileIsNumberValidation : String = "Please input a valid phone number"
    static var maximumDateValidation : String = "Please input a valid brithday"
    static var idTypeBlankValidation : String = "ID Type is required" //ini kalo id type kosong
    //Change Password
    static var enterOldPwdMsg : String = "Enter Old Password"
    static var enterNewPwdMsg : String = "Enter New password"
    static var enterCnfPwdMsg : String = "Enter Confirm password"
    
    //Change Pin
    static var enterOldpinMsg : String = "Enter Old pin"
    static var enterNewPinMsg : String = "Enter New pin"
    static var enterCnfPinMsg : String = "Enter Confirm pin"
    
    //Member Menu Home Controller
    static var outPatientSPGLRequest : String = "MMWA0190"
    static var penelProvider : String = "MMWA0020"
    static var pharmacyRequest : String = "MMWA0191"
    static var reimbersmentClaimRequest : String = "MMWA0022"
    static var myEmployeeEntitlementBenefit : String = "MMWA0013"
    static var myTodayGLStatus : String = "MMWA0169"
    static var viewGLLetter : String = "MMWA0170"
    static var viewReimbursementClaim : String = "MMWARC"
    static var InPatient : String = "MMWAIP"
    static var GP : String = "MMWAGP"
    static var OPSP : String = "MMWAOPSP"
    static var Pharmacy : String = "PHAR"
    static var QRCode : String = "QRCODE"
    static var HAG : String = "MMWA0180"
    
    static var Settings : String = "MMSETTINGS"
    static var changePassword : String = "MCHANGEPWD"
    static var cashLessClaim : String = "MMWACASHLESS"
    static var uploadPhoto : String = "MMUPHOTO"
    static var dashboard : String = "MEMBERDASHBOARD"
    static var downloadClaimForms : String = "MMDOWNLOADFORMS"
    static var viewClaimsRecord : String = "MMWA0100"
    static var gl : String = "MMWAGL"
    static var claim : String = "MMWACLAIM"
    static var myPolicyEntitlement : String = "MMWA0012"
    static var changePinForTouchId : String = "MMCHANGEPIN"
    static var removeTouchId : String = "MMREMOVETOUCHID"
    static var registerTouchId : String = "MMREGISTERTOUCHID"
    static var others : String = "MMOTHERS"
    static var logOff : String = "MMLOGOFF"
    static var virtualCard : String = "MMVIRTUALCARD"
    static var healthTips : String = "TIPS"
    static var chat : String = "CHAT"
    static var uploadMedicalChit : String = "MMUPMC"
    static var hospitalAdmissionGLRequest : String = "MMWA0192"
    static var contactUs : String = "CONTACTUS"
    static var rate : String = "RATE"
    static var disclaimer : String = "DISCLAIMER"
    static var terms : String = "TERMS"
    static var aboutus : String = "ABOUTUS"
    static var removePin : String = "MMREMOVEPIN"
    static var registerPin : String = "MMREGISTERPIN"
    static var personalInfo : String = "MMWAINFO"
    static var BMICALCULATOR : String = "MMWA0230V2"
    static var HEALTHSCREENING : String = "MMWA0240V2"
    /////////////////// KODE DOKTERIN
//    static var Dokterin : String = "Dokterin"
    
    //TeleConsult ObjID
//    static var teleconsult : String = "MMWA0193"
    static var teleconsult : String = "MMMEDISEHAT"
    static var teleconsultRequest : String = "MMWATELREQ"
    static var teleconsultAppoinments : String = "MMWATELAPP"
    static var teleconsultHistory : String = "MMWATELEHIS"
    static var teleconsultE_Prescription : String = "MMWAEPREC"
    static var teleconsultE_Lab : String = "MMWAELAB"
    static var teleconsultE_Referral : String = "MMWAEREF"
    static var teleconsultE_Delivery : String = "MMWAEDEL"
    static var HealthRiskAssessment : String = "MMHEALTHASS"
    
    
    static var covid19 : String = "covid19"
    static var webMDHealth : String = "webMDHealth"
    static var selfDoctor : String = "Self Doctor"
    
    //Corporate Menu Home Controller
    static var penelProviderCoorperate : String = "MBAM0010"
    static var myTodayHospitalAdmissionDischargeCoorperate : String = "MBAM0020"
    static var policyHolderCoorperate : String = "MBAM0030"
    static var policyHolderHealthRecordCoorperate : String = "MBAM0040"
    static var messagesCoorperate : String = "MBMA0070"
    static var HAGCoorperate : String = "MBMA0080"
    static var GLpolicyHolderHealthRecordCoorperate : String = "gl_policy_holder_health_record"
    static var ClaimspolicyHolderHealthRecordCoorperate : String = "claims_policy_holder_health_record"
    
    static var healthAdvisory : String = "ADVISORY"//health_advisory
    static var healthOptimizationTips : String = "health_optimization_tips"
    
    //Agent Menu Home Controller
    static var penelProviderAgent : String = "MBAM0010"
    static var myTodayHospitalAdmissionDischargeAgent : String = "MBAM0020"
    static var policyHolderAgent : String = "MBAM0030"
    static var policyHolderHealthRecordAgent : String = "MBAM0040"
    static var messagesAgent : String = "MBMA0070"
    static var HAGAgent : String = "MBMA0080"
    static var GLpolicyHolderHealthRecordAgent : String = "gl_policy_holder_health_record"
    static var ClaimspolicyHolderHealthRecordAgent : String = "claims_policy_holder_health_record"
    static var WebMDSymptomChecker : String = "MMWAWSC"
    static var WebMDHealthMagazine : String = "MMWAWHM"
    static var E_marketplace : String = "MMWAWEM"
    static var DisChargeAlert : String = "MMDISCHARGE"
    
    //request Controller
    static var hospitalInfoMsg : String = "To search provider please key in first three letter of the provider name in the textbox; Provider list will display in the dropdown.If Provider Not Found, key in 'Non Panel' in the hospital name field and update provider name."
    static var outPatientSPGLMsg : String = "- Referal Letter from Panel Clinic required for First Time Visit to Specialist.\n- Appointment Card with diagnosis required for Follow up Visit to Specialist."
    static var pharmacyRequestMsg : String = "- Prescription from Panel Doctor required."
//    static var reimbursementClaimMsg : String = "- To indicate \"Submitted to Optimal Health\" on Original Bill.\n- Original Bill should be acknowledge by Line Manager"
    static var reimbursementClaimMsg : String = "- Please ensure to upload the full bill including any medical reports and receipts as evidence of payment.\n- Original bill should be submitted to your HR for verification and further action."
    static var requestReceivedNotification : String = "requestReceived"
    static var hideBackButtonNotification : String = "hidebackButton"
    static var diagnosisvalidationMsg : String = "Event date or consultation date is required before selecting diagnosis"
    static var diagnosisvalidationTimeMsg : String = "Event time or consultation time is required before selecting diagnosis"
    
    //ViewMap Controller
    static var mapLocationMsg : String = "Location Not Available"
    
    //QR Code scanner
    static var noCameraMsg : String = "Seems that your device has no camera"
    static var invalidQrCode : String = "Invalid QR Code Format."
    static var approvalCode : String = "000000"
    
    //Contact Us
    static var nameBlankValidationMsg : String = "Please enter name"
    static var emailBlankValidationMsg : String = "Please enter email"
    static var messageBlankValidationMsg : String = "Please enter message"
    static var subjectBlankValidationMsg : String = "Please select a subject"
    
    //Health Advisory
    static var questionBlankValidationMsg : String = "Please submit your question"
    
    //Logout
    static var tryAgainLaterMsg : String = "Try Again Later"
    
    //Panel Provider
    static var noLocationTitleMsg : String = "No Location Found"
    static var noLocationDescMsg : String = "Please allow Optimal Health to access your location. Do you want to go to settings menu?"
    static var locationNotEnabledTitleMsg : String = "Location Not Enabled"
    
    //Chat controller
    static var noRecordTitleMsg : String = "No record found"
    static var noChatDescMsg : String = "There is no recent conversation."
    static var blankChatMsg : String = "Please enter a message to send"
    static var chatReceivedNotification : String = "chat_recieve"
    static var deleteMsg : String = "Are you sure you want to delete?"
    static var deleteAllMsg : String = "Are you sure you want to delete all messages?"
    static var deleteHeaderMsg : String = "Delete Message"
    static var updateNotificationCount : String = "update_notification_count"
    
    //Upload Photo
    static var uploadPhotoValidationMsg : String = "Internet connectivity is required to add photo"
    
    //Date Formatter
    static var dateFormatter1 : String = "yyyyMMddHHmmss"
    static var dateFormatter2 : String = "EEEE, dd MMMM yyyy"
    static var dateFormatter3 : String = "HH:mm:ss"
    static var dateFormatter4 : String = "dd MMMM yyyy, HH:mm:ss"
    static var dateFormatter5 : String = "hh:mm:ss a"
    static var dateFormatter6 : String = "dd MMM yyyy hh:mm:ss a"
    static var dateFormatter7 : String = "MM/dd/yyyy hh:mm:ss a"
    static var dateFormatter8 : String = "dd-MMM-yyyy"
    static var dateFormatter9 : String = "yyyy-MM-dd"
    static var dateFormatterUTC : String = "yyyy-MM-dd'T'HH:mm:ss"
    static var dateFormatter10 : String = "EEE, dd MMM yyyy HH:mm:ss z"
    static var dateFormatter11 : String = "EEE, dd MMMM yyyy"
    static var dateFormatter12 : String = "EEE"
    static var dateFormatter13 : String = "yyyy-MM-dd HH:mm:ss zzzz"
    static var dateFormatter14 : String = "dd/MM/yyyy hh:mm:ss a"
    
    //Logout
    static var hideLogoutPopupNotification : String = "hideLogoutPopup"
    
    //Biometric
    static var acceptTermsAndConditionMsg : String = "Please accept terms and conditions"
    static var pinValidation : String = "Pin is required"
    static var cnfPinValidation : String = "Confirm pin is required"
    static var pinNotMatchValidation : String = "pin and confirm pin doesn't match"
    static var fourDigitPinValidation : String = "Pin must be 4 digit"
    
    //Security Question
    static var securityQuestionHeader : String = "\nAnswer all these security questions correctly and your password will be reset."
    static var autoLogoutMsg : String = "Invalid Username/password"
    
    static var noProfilePicMsg: String = "There is no photo to view, you may add photo in settings."
    static var noProfilePicTitle: String = "Photo!"
    
    //TextField ValidationMessage for ActivitiesMeasurement
    static var dateValidationMsg: String = "Please Select Activity Date"
    static var ageValidationMsg: String = "Please Enter Age"
    static var weightValidationMsg: String = "Please Enter Weight"
    static var heightValidationMsg: String = "Please Enter Height"
    static var genderValidationMsg: String = "Please Select Gender"
    
    static var ageGroupValidationMsg: String = "Please Select Age"
    static var pregnancyStatusValidationMsg: String = "Please Select Pregnancy Status"
    static var countryValidationMsg: String = "Please Select Country"
    static var symptomsValidationMsg: String = "Please Select Symptoms"
    
    static var messageAlert: String = "messageAlert"
    
//    static var ChatAppID : String = "nihwf-13agebkicrijyew"
    
    static var nricSymbol: String = "NRIC"
    static var chatUrl: String = "ChatUrl"
    static var chatAppId: String = "ChatAppId"
    static var chatChannelId: String = "ChatChannelId"
    static var avatarUrl = "https://d1edrlpyc25xu0.cloudfront.net/kiwari-prod/image/upload/wMWsDZP6ta/1516689726-ic_qiscus_client.png"
    static var countryCode: String = "countryCode"
    static var dependentStoryboard: String = "DependentStoryboard"
    static var countryCodeByLocation: String = "countryCodeByLocation"
}

