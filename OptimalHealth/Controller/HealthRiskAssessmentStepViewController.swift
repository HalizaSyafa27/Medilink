//
//  HealthRiskAssessmentStepViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 03/07/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import DatePickerDialog
import DropDown
class HealthRiskAssessmentStepViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTopBar: NSLayoutConstraint!
    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var heightConstraintContentStepView: NSLayoutConstraint!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var btnBackHeader: UIButton!
    
    //Start Step 1
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var contentStepImage: UIImageView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var DobView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDOBDate: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var lblMaritialStatusTitle: UILabel!
    @IBOutlet weak var lblMaritialStatus: UILabel!
    @IBOutlet weak var txtNumberOfChildren: UITextField!
    @IBOutlet weak var txtNumberOfChildrenLive: UITextField!
    @IBOutlet weak var txtCurrentOccupation: UITextField!
    @IBOutlet weak var txtPreviousAccupation: UITextField!
    //End Step 1
    
    //Start Step 2
    @IBOutlet weak var step2View: UIView!

    @IBOutlet weak var yesMeaslesImgView: UIImageView!
    @IBOutlet weak var noMeaslesImgView: UIImageView!
    @IBOutlet weak var yesMumpsImgView: UIImageView!
    @IBOutlet weak var noMumpsImgView: UIImageView!
    @IBOutlet weak var yesRubelleImgView: UIImageView!
    @IBOutlet weak var noRubelleImgView: UIImageView!
    @IBOutlet weak var yesChickenpoxImgView: UIImageView!
    @IBOutlet weak var noChickenpoxImgView: UIImageView!
    @IBOutlet weak var yesRheumaticFeverImgView: UIImageView!
    @IBOutlet weak var noRheumaticFeverImgView: UIImageView!
    @IBOutlet weak var yesPolioImgView: UIImageView!
    @IBOutlet weak var noPolioImgView: UIImageView!
    @IBOutlet weak var yesNoneImgView: UIImageView!
    @IBOutlet weak var noNoneImgView: UIImageView!
    //End Step 2
    
    //Start Step 3
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var yesTetanusImgView: UIImageView!
    @IBOutlet weak var noTetanusImgView: UIImageView!
    @IBOutlet weak var txtTetanusDate: UITextField!
    @IBOutlet weak var yesPneumoniaImgView: UIImageView!
    @IBOutlet weak var noPneumoniaImgView: UIImageView!
    @IBOutlet weak var txtPneumoniaDate: UITextField!
    @IBOutlet weak var yesHepatitisAImgView: UIImageView!
    @IBOutlet weak var noHepatitisAImgView: UIImageView!
    @IBOutlet weak var txtHepatitisADate: UITextField!
    @IBOutlet weak var yesHepatitisBImgView: UIImageView!
    @IBOutlet weak var noHepatitisBImgView: UIImageView!
    @IBOutlet weak var txtHepatitisBDate: UITextField!
    @IBOutlet weak var yesChickenpoxStep3ImgView: UIImageView!
    @IBOutlet weak var noChickenpoxStep3ImgView: UIImageView!
    @IBOutlet weak var txtChickenpoxStep3Date: UITextField!
    @IBOutlet weak var yesInfluenzaImgView: UIImageView!
    @IBOutlet weak var noInfluenzaImgView: UIImageView!
    @IBOutlet weak var txtInfluenzaDate: UITextField!
    @IBOutlet weak var yesMumpsStep3ImgView: UIImageView!
    @IBOutlet weak var noMumpsStep3ImgView: UIImageView!
    @IBOutlet weak var txtMumpsStep3Date: UITextField!
    @IBOutlet weak var yesRubellaImgView: UIImageView!
    @IBOutlet weak var noRubellaImgView: UIImageView!
    @IBOutlet weak var txtRubellaDate: UITextField!
    @IBOutlet weak var yesMeningococcalImgView: UIImageView!
    @IBOutlet weak var noMeningococcalImgView: UIImageView!
    @IBOutlet weak var txtMeningococcalDate: UITextField!
    @IBOutlet weak var yesNoneStep3ImgView: UIImageView!
    @IBOutlet weak var noNoneStep3ImgView: UIImageView!
    
    //End Step 3
    
    //Start Step 4
    @IBOutlet weak var step4View: UIView!
    @IBOutlet weak var yesEyeExamImgView: UIImageView!
    @IBOutlet weak var noEyeExamImgView: UIImageView!
    @IBOutlet weak var txtEyeExamDate: UITextField!
    @IBOutlet weak var yesColonoscopImgView: UIImageView!
    @IBOutlet weak var noColonoscopImgView: UIImageView!
    @IBOutlet weak var txtColonoscopDate: UITextField!
    @IBOutlet weak var yesDexaScanImgView: UIImageView!
    @IBOutlet weak var noDexaScanImgView: UIImageView!
    @IBOutlet weak var txtDexaScanDate: UITextField!
    @IBOutlet weak var yesNoneStep4ImgView: UIImageView!
    @IBOutlet weak var noNoneStep4ImgView: UIImageView!
    @IBOutlet weak var txtNoneStep4Date: UITextField!
    //End Step 4
    
    //Start Step 5
    @IBOutlet weak var step5View: UIView!
    @IBOutlet weak var yesSurgery1Step5ImgView: UIImageView!
    @IBOutlet weak var noSurgery1Step5ImgView: UIImageView!
    @IBOutlet weak var txtYear1Step5: UITextField!
    @IBOutlet weak var txtHospitalName1Step5: UITextField!
    @IBOutlet weak var txtReasonSurgery1Step5: UITextField!
    @IBOutlet weak var viewSurgery1Step5: UIView!
    @IBOutlet weak var viewReason1Step5: UIView!
    @IBOutlet weak var viewHeightConstraintSurgery1Step5: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason1Step5: NSLayoutConstraint!
    
    @IBOutlet weak var yesSurgery2Step5ImgView: UIImageView!
    @IBOutlet weak var noSurgery2Step5ImgView: UIImageView!
    @IBOutlet weak var txtYear2Step5: UITextField!
    @IBOutlet weak var txtHospitalName2Step5: UITextField!
    @IBOutlet weak var txtReasonSurgery2Step5: UITextField!
    @IBOutlet weak var viewSurgery2Step5: UIView!
    @IBOutlet weak var viewReason2Step5: UIView!
    @IBOutlet weak var viewHeightConstraintSurgery2Step5: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason2Step5: NSLayoutConstraint!
    
    @IBOutlet weak var yesSurgery3Step5ImgView: UIImageView!
    @IBOutlet weak var noSurgery3Step5ImgView: UIImageView!
    @IBOutlet weak var txtYear3Step5: UITextField!
    @IBOutlet weak var txtHospitalName3Step5: UITextField!
    @IBOutlet weak var txtReasonSurgery3Step5: UITextField!
    @IBOutlet weak var viewSurgery3Step5: UIView!
    @IBOutlet weak var viewReason3Step5: UIView!
    @IBOutlet weak var viewHeightConstraintSurgery3Step5: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason3Step5: NSLayoutConstraint!
    
    @IBOutlet weak var yesSurgery4Step5ImgView: UIImageView!
    @IBOutlet weak var noSurgery4Step5ImgView: UIImageView!
    @IBOutlet weak var txtYear4Step5: UITextField!
    @IBOutlet weak var txtHospitalName4Step5: UITextField!
    @IBOutlet weak var txtReasonSurgery4Step5: UITextField!
    @IBOutlet weak var viewSurgery4Step5: UIView!
    @IBOutlet weak var viewReason4Step5: UIView!
    @IBOutlet weak var viewHeightConstraintSurgery4Step5: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason4Step5: NSLayoutConstraint!
    
    @IBOutlet weak var yesSurgery5Step5ImgView: UIImageView!
    @IBOutlet weak var noSurgery5Step5ImgView: UIImageView!
    @IBOutlet weak var txtYear5Step5: UITextField!
    @IBOutlet weak var txtHospitalName5Step5: UITextField!
    @IBOutlet weak var txtReasonSurgery5Step5: UITextField!
    @IBOutlet weak var viewSurgery5Step5: UIView!
    @IBOutlet weak var viewReason5Step5: UIView!
    @IBOutlet weak var viewHeightConstraintSurgery5Step5: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason5Step5: NSLayoutConstraint!
    
    @IBOutlet weak var yesNoSurgeryStep5ImgView: UIImageView!
    @IBOutlet weak var noNoSurgeryStep5ImgView: UIImageView!
    //End Step 5
    
    //Start Step 6
    @IBOutlet weak var step6View: UIView!
    @IBOutlet weak var yesHospitilization1Step6ImgView: UIImageView!
    @IBOutlet weak var noHospitilization1Step6ImgView: UIImageView!
    @IBOutlet weak var txtYear1Step6: UITextField!
    @IBOutlet weak var txtHospitalName1Step6: UITextField!
    @IBOutlet weak var txtReasonHospitilization1Step6: UITextField!
    @IBOutlet weak var viewHosp1Step6: UIView!
    @IBOutlet weak var viewReason1Step6: UIView!
    @IBOutlet weak var viewHeightConstraintHosp1Step6: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason1Step6: NSLayoutConstraint!
    
    @IBOutlet weak var yesHospitilization2Step6ImgView: UIImageView!
    @IBOutlet weak var noHospitilization2Step6ImgView: UIImageView!
    @IBOutlet weak var txtYear2Step6: UITextField!
    @IBOutlet weak var txtHospitalName2Step6: UITextField!
    @IBOutlet weak var txtReasonHospitilization2Step6: UITextField!
    @IBOutlet weak var viewHosp2Step6: UIView!
    @IBOutlet weak var viewReason2Step6: UIView!
    @IBOutlet weak var viewHeightConstraintHosp2Step6: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason2Step6: NSLayoutConstraint!
    
    @IBOutlet weak var yesHospitilization3Step6ImgView: UIImageView!
    @IBOutlet weak var noHospitilization3Step6ImgView: UIImageView!
    @IBOutlet weak var txtYear3Step6: UITextField!
    @IBOutlet weak var txtHospitalName3Step6: UITextField!
    @IBOutlet weak var txtReasonHospitilization3Step6: UITextField!
    @IBOutlet weak var viewHosp3Step6: UIView!
    @IBOutlet weak var viewReason3Step6: UIView!
    @IBOutlet weak var viewHeightConstraintHosp3Step6: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason3Step6: NSLayoutConstraint!
    
    @IBOutlet weak var yesHospitilization4Step6ImgView: UIImageView!
    @IBOutlet weak var noHospitilization4Step6ImgView: UIImageView!
    @IBOutlet weak var txtYear4Step6: UITextField!
    @IBOutlet weak var txtHospitalName4Step6: UITextField!
    @IBOutlet weak var txtReasonHospitilization4Step6: UITextField!
    @IBOutlet weak var viewHosp4Step6: UIView!
    @IBOutlet weak var viewReason4Step6: UIView!
    @IBOutlet weak var viewHeightConstraintHosp4Step6: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason4Step6: NSLayoutConstraint!
    
    @IBOutlet weak var yesHospitilization5Step6ImgView: UIImageView!
    @IBOutlet weak var noHospitilization5Step6ImgView: UIImageView!
    @IBOutlet weak var txtYear5Step6: UITextField!
    @IBOutlet weak var txtHospitalName5Step6: UITextField!
    @IBOutlet weak var txtReasonHospitilization5Step6: UITextField!
    @IBOutlet weak var viewHosp5Step6: UIView!
    @IBOutlet weak var viewReason5Step6: UIView!
    @IBOutlet weak var viewHeightConstraintHosp5Step6: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason5Step6: NSLayoutConstraint!
    
    @IBOutlet weak var yesNoHospitilizationStep6ImgView: UIImageView!
    @IBOutlet weak var noNoHospitilizationStep6ImgView: UIImageView!
    //End Step 6
    
    //Start Step 7
    @IBOutlet weak var step7View: UIView!
    @IBOutlet weak var yesVisit1Step7ImgView: UIImageView!
    @IBOutlet weak var noVisit1Step7ImgView: UIImageView!
    @IBOutlet weak var txtMonth1Step7: UITextField!
    @IBOutlet weak var txtProviderName1Step7: UITextField!
    @IBOutlet weak var txtReasonVisit1Step7: UITextField!
    @IBOutlet weak var viewName1Step7: UIView!
    @IBOutlet weak var viewReason1Step7: UIView!
    @IBOutlet weak var viewHeightConstraintName1Step7: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason1Step7: NSLayoutConstraint!
    
    @IBOutlet weak var yesVisit2Step7ImgView: UIImageView!
    @IBOutlet weak var noVisit2Step7ImgView: UIImageView!
    @IBOutlet weak var txtMonth2Step7: UITextField!
    @IBOutlet weak var txtProviderName2Step7: UITextField!
    @IBOutlet weak var txtReasonVisit2Step7: UITextField!
    @IBOutlet weak var viewName2Step7: UIView!
    @IBOutlet weak var viewReason2Step7: UIView!
    @IBOutlet weak var viewHeightConstraintName2Step7: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason2Step7: NSLayoutConstraint!
    
    @IBOutlet weak var yesVisit3Step7ImgView: UIImageView!
    @IBOutlet weak var noVisit3Step7ImgView: UIImageView!
    @IBOutlet weak var txtMonth3Step7: UITextField!
    @IBOutlet weak var txtProviderName3Step7: UITextField!
    @IBOutlet weak var txtReasonVisit3Step7: UITextField!
    @IBOutlet weak var viewName3Step7: UIView!
    @IBOutlet weak var viewReason3Step7: UIView!
    @IBOutlet weak var viewHeightConstraintName3Step7: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason3Step7: NSLayoutConstraint!
    
    @IBOutlet weak var yesVisit4Step7ImgView: UIImageView!
    @IBOutlet weak var noVisit4Step7ImgView: UIImageView!
    @IBOutlet weak var txtMonth4Step7: UITextField!
    @IBOutlet weak var txtProviderName4Step7: UITextField!
    @IBOutlet weak var txtReasonVisit4Step7: UITextField!
    @IBOutlet weak var viewName4Step7: UIView!
    @IBOutlet weak var viewReason4Step7: UIView!
    @IBOutlet weak var viewHeightConstraintName4Step7: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason4Step7: NSLayoutConstraint!
    
    @IBOutlet weak var yesVisit5Step7ImgView: UIImageView!
    @IBOutlet weak var noVisit5Step7ImgView: UIImageView!
    @IBOutlet weak var txtMonth5Step7: UITextField!
    @IBOutlet weak var txtProviderName5Step7: UITextField!
    @IBOutlet weak var txtReasonVisit5Step7: UITextField!
    @IBOutlet weak var viewName5Step7: UIView!
    @IBOutlet weak var viewReason5Step7: UIView!
    @IBOutlet weak var viewHeightConstraintName5Step7: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReason5Step7: NSLayoutConstraint!
    
    @IBOutlet weak var yesNoVisitStep7ImgView: UIImageView!
    @IBOutlet weak var noNoVisitStep7ImgView: UIImageView!
    //End Step 7
    
    //Start Step 8
    @IBOutlet weak var step8View: UIView!
    @IBOutlet weak var alcoholAbuseStep8ImgView: UIImageView!
    @IBOutlet weak var diabetesStep8ImgView: UIImageView!
    @IBOutlet weak var anemiaStep8ImgView: UIImageView!
    @IBOutlet weak var migrainesStep8ImgView: UIImageView!
    @IBOutlet weak var anestheticComplicationStep8ImgView: UIImageView!
    @IBOutlet weak var osteoporosisStep8ImgView: UIImageView!
    @IBOutlet weak var anxietyDisorderStep8ImgView: UIImageView!
    @IBOutlet weak var prostateCancerStep8ImgView: UIImageView!
    @IBOutlet weak var arthritis1Step8ImgView: UIImageView!
    @IBOutlet weak var rectalCancerStep8ImgView: UIImageView!
    @IBOutlet weak var asthmaStep8ImgView: UIImageView!
    @IBOutlet weak var refluxGERDStep8ImgView: UIImageView!
    @IBOutlet weak var autoimmuneProblemsStep8ImgView: UIImageView!
    @IBOutlet weak var seizuresConvulsionsStep8ImgView: UIImageView!
    @IBOutlet weak var birthDefectsStep8ImgView: UIImageView!
    @IBOutlet weak var severeAllergyStep8ImgView: UIImageView!
    @IBOutlet weak var bladderProblemsStep8ImgView: UIImageView!
    @IBOutlet weak var sexuallyTransmittedDiseaseStep8ImgView: UIImageView!
    @IBOutlet weak var bleedingDiseaseStep8ImgView: UIImageView!
    @IBOutlet weak var skinCancerStep8ImgView: UIImageView!
    @IBOutlet weak var bloodClotsStep8ImgView: UIImageView!
    @IBOutlet weak var strokeCVAoftheBrainStep8ImgView: UIImageView!
    @IBOutlet weak var bloodTransfusionStep8ImgView: UIImageView!
    @IBOutlet weak var suicideAttemptStep8ImgView: UIImageView!
    @IBOutlet weak var bowelDiseaseStep8ImgView: UIImageView!
    @IBOutlet weak var thyroidProblemsStep8ImgView: UIImageView!
    @IBOutlet weak var breastCancerStep8ImgView: UIImageView!
    @IBOutlet weak var ulcerStep8ImgView: UIImageView!
    @IBOutlet weak var cervicalCancerStep8ImgView: UIImageView!
    @IBOutlet weak var visualImpairmentStep8ImgView: UIImageView!
    @IBOutlet weak var colonCancerStep8ImgView: UIImageView!
    @IBOutlet weak var otherStep8ImgView: UIImageView!
    @IBOutlet weak var depressionStep8ImgView: UIImageView!
    @IBOutlet weak var noneOfTheAboveStep8ImgView: UIImageView!
    //End Step 8
    
    //Start Step 9
    @IBOutlet weak var step9View: UIView!
    @IBOutlet weak var txtmedicalProblemsStep9: UITextField!
    @IBOutlet weak var txtReferringDoctorStep9: UITextField!
    @IBOutlet weak var txtDatePhysicalExamStep9: UITextField!
    @IBOutlet weak var btnYesBloodTransfusionStep9: UIButton!
    @IBOutlet weak var btnNoBloodTransfusionStep9: UIButton!
    //End Step 9
    
    //Start Step 10
    @IBOutlet weak var step10View: UIView!
    @IBOutlet weak var yesDrug1Step10ImgView: UIImageView!
    @IBOutlet weak var noDrug1Step10ImgView: UIImageView!
    @IBOutlet weak var txtName1Step10: UITextField!
    @IBOutlet weak var txtDosageFrequency1Step10: UITextField!
    @IBOutlet weak var viewName1Step10: UIView!
    @IBOutlet weak var viewDosage1Step10: UIView!
    @IBOutlet weak var viewHeightConstraintName1Step10: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintDosage1Step10: NSLayoutConstraint!
    
    @IBOutlet weak var yesDrug2Step10ImgView: UIImageView!
    @IBOutlet weak var noDrug2Step10ImgView: UIImageView!
    @IBOutlet weak var txtName2Step10: UITextField!
    @IBOutlet weak var txtDosageFrequency2Step10: UITextField!
    @IBOutlet weak var viewName2Step10: UIView!
    @IBOutlet weak var viewDosage2Step10: UIView!
    @IBOutlet weak var viewHeightConstraintName2Step10: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintDosage2Step10: NSLayoutConstraint!
    
    @IBOutlet weak var yesDrug3Step10ImgView: UIImageView!
    @IBOutlet weak var noDrug3Step10ImgView: UIImageView!
    @IBOutlet weak var txtName3Step10: UITextField!
    @IBOutlet weak var txtDosageFrequency3Step10: UITextField!
    @IBOutlet weak var viewName3Step10: UIView!
    @IBOutlet weak var viewDosage3Step10: UIView!
    @IBOutlet weak var viewHeightConstraintName3Step10: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintDosage3Step10: NSLayoutConstraint!
    
    @IBOutlet weak var yesDrug4Step10ImgView: UIImageView!
    @IBOutlet weak var noDrug4Step10ImgView: UIImageView!
    @IBOutlet weak var txtName4Step10: UITextField!
    @IBOutlet weak var txtDosageFrequency4Step10: UITextField!
    @IBOutlet weak var viewName4Step10: UIView!
    @IBOutlet weak var viewDosage4Step10: UIView!
    @IBOutlet weak var viewHeightConstraintName4Step10: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintDosage4Step10: NSLayoutConstraint!
    
    @IBOutlet weak var yesDrug5Step10ImgView: UIImageView!
    @IBOutlet weak var noDrug5Step10ImgView: UIImageView!
    @IBOutlet weak var txtName5Step10: UITextField!
    @IBOutlet weak var txtDosageFrequency5Step10: UITextField!
    @IBOutlet weak var viewName5Step10: UIView!
    @IBOutlet weak var viewDosage5Step10: UIView!
    @IBOutlet weak var viewHeightConstraintName5Step10: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintDosage5Step10: NSLayoutConstraint!
    
    @IBOutlet weak var yesOtherStep10ImgView: UIImageView!
    @IBOutlet weak var noOtherStep10ImgView: UIImageView!
    //End Step 10
    
    //Start Step 11
    @IBOutlet weak var step11View: UIView!
    @IBOutlet weak var yesAlergy1Step11ImgView: UIImageView!
    @IBOutlet weak var noAlergy1Step11ImgView: UIImageView!
    @IBOutlet weak var txtName1Step11: UITextField!
    @IBOutlet weak var txtReactionYouHad1Step11: UITextField!
    @IBOutlet weak var viewName1Step11: UIView!
    @IBOutlet weak var viewReaction1Step11: UIView!
    @IBOutlet weak var viewHeightConstraintName1Step11: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReaction1Step11: NSLayoutConstraint!
    
    @IBOutlet weak var yesAlergy2Step11ImgView: UIImageView!
    @IBOutlet weak var noAlergy2Step11ImgView: UIImageView!
    @IBOutlet weak var txtName2Step11: UITextField!
    @IBOutlet weak var txtReactionYouHad2Step11: UITextField!
    @IBOutlet weak var viewName2Step11: UIView!
    @IBOutlet weak var viewReaction2Step11: UIView!
    @IBOutlet weak var viewHeightConstraintName2Step11: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReaction2Step11: NSLayoutConstraint!
    
    @IBOutlet weak var yesAlergy3Step11ImgView: UIImageView!
    @IBOutlet weak var noAlergy3Step11ImgView: UIImageView!
    @IBOutlet weak var txtName3Step11: UITextField!
    @IBOutlet weak var txtReactionYouHad3Step11: UITextField!
    @IBOutlet weak var viewName3Step11: UIView!
    @IBOutlet weak var viewReaction3Step11: UIView!
    @IBOutlet weak var viewHeightConstraintName3Step11: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraintReaction3Step11: NSLayoutConstraint!
    
    @IBOutlet weak var yesOtherStep11ImgView: UIImageView!
    @IBOutlet weak var noOtherStep11ImgView: UIImageView!
    //End Step 11
    
    //Start Step 12
    @IBOutlet weak var step12View: UIView!
    @IBOutlet weak var iAmAdoptedStep12ImgView: UIImageView!
    @IBOutlet weak var leukemiaStep12ImgView: UIImageView!
    @IBOutlet weak var familyHistoryUnknownStep12ImgView: UIImageView!
    @IBOutlet weak var lungRespiratoryDiseaseStep12ImgView: UIImageView!
    @IBOutlet weak var alcoholAbuseStep12ImgView: UIImageView!
    @IBOutlet weak var migrainesStep12ImgView: UIImageView!
    @IBOutlet weak var AnemiaStep12ImgView: UIImageView!
    @IBOutlet weak var osteoporosisStep12ImgView: UIImageView!
    @IBOutlet weak var anestheticComplicationStep12ImgView: UIImageView!
    @IBOutlet weak var otherCancerStep12ImgView: UIImageView!
    @IBOutlet weak var arthritisStep12ImgView: UIImageView!
    @IBOutlet weak var rectalCancerStep12ImgView: UIImageView!
    @IBOutlet weak var asthmaStep12ImgView: UIImageView!
    @IBOutlet weak var seizuresConvulsionsStep12ImgView: UIImageView!
    @IBOutlet weak var bladderProblemsStep12ImgView: UIImageView!
    @IBOutlet weak var severeAllergyStep12ImgView: UIImageView!
    @IBOutlet weak var bleedingDiseaseStep12ImgView: UIImageView!
    @IBOutlet weak var strokeCVAoftheBrainStep12ImgView: UIImageView!
    @IBOutlet weak var breastCancerStep12ImgView: UIImageView!
    @IBOutlet weak var thyroidProblemsStep12ImgView: UIImageView!
    @IBOutlet weak var colonCancerStep12ImgView: UIImageView!
    @IBOutlet weak var motherStep12ImgView: UIImageView!
    @IBOutlet weak var depressionStep12ImgView: UIImageView!
    @IBOutlet weak var fatherStep12ImgView: UIImageView!
    @IBOutlet weak var diabetesStep12ImgView: UIImageView!
    @IBOutlet weak var heartDiseaseStep12ImgView: UIImageView!
    @IBOutlet weak var highBloodPressureStep12ImgView: UIImageView!
    @IBOutlet weak var highCholesterolStep12ImgView: UIImageView!
    @IBOutlet weak var kidneyDiseaseStep12ImgView: UIImageView!
    @IBOutlet weak var noneOfTheAboveStep12ImgView: UIImageView!
    //End Step 12
    
    //Start Step 13
    @IBOutlet weak var step13View: UIView!
    @IBOutlet weak var yesDoYouExerciseStep13ImgView: UIImageView!
    @IBOutlet weak var noDoYouExerciseStep13ImgView: UIImageView!
    @IBOutlet weak var txtMinutesStep13: UITextField!
    @IBOutlet weak var viewMinutesStep13: UIView!
    @IBOutlet weak var viewHeightConstraintMinutesStep13: NSLayoutConstraint!

    @IBOutlet weak var yesAreYouDietingStep13ImgView: UIImageView!
    @IBOutlet weak var noAreYouDietingStep13ImgView: UIImageView!
    @IBOutlet weak var yesPhysicianPrescribedStep13ImgView: UIImageView!
    @IBOutlet weak var noPhysicianPrescribedStep13ImgView: UIImageView!
    @IBOutlet weak var viewPhysicianPrescribedStep13: UIView!
    @IBOutlet weak var viewHeightConstraintPhysicianPrescribedStep13: NSLayoutConstraint!
    
    @IBOutlet weak var txtMealsEatAverageDayStep13: UITextField!
    @IBOutlet weak var txtRankSaltIntakeStep13: UITextField!
    @IBOutlet weak var txtRankFatIntake1Step13: UITextField!
    
    @IBOutlet weak var yesIntakeofCaffeineStep13ImgView: UIImageView!
    @IBOutlet weak var noIntakeofCaffeineStep13ImgView: UIImageView!
    
    @IBOutlet weak var txtpreferredDrinkStep13: UITextField!
    @IBOutlet weak var viewPreferredDrinkStep13: UIView!
    @IBOutlet weak var viewHeightConstraintPreferredDrinkStep13: NSLayoutConstraint!
    
    @IBOutlet weak var txtRankFatIntake2Step13: UITextField!
    @IBOutlet weak var viewCupsPerDayStep13: UIView!
    @IBOutlet weak var viewHeightConstraintCupsPerDayStep13: NSLayoutConstraint!
    //End Step 13
    
    //Start Step 14
    @IBOutlet weak var step14View: UIView!
    @IBOutlet weak var yesDoYouDrinkAlcoholStep14ImgView: UIImageView!
    @IBOutlet weak var noDoYouDrinkAlcoholStep14ImgView: UIImageView!
    @IBOutlet weak var txtWhatKindStep14: UITextField!
    @IBOutlet weak var viewWhatKindStep14: UIView!
    @IBOutlet weak var viewHeightConstraintWhatKindStep14: NSLayoutConstraint!
    @IBOutlet weak var txtDrinksPerWeekStep14: UITextField!
    @IBOutlet weak var viewDrinksPerWeekStep14: UIView!
    @IBOutlet weak var viewHeightConstraintDrinksPerWeekStep14: NSLayoutConstraint!
    
    @IBOutlet weak var yesTheAmountYouDrinkStep14ImgView: UIImageView!
    @IBOutlet weak var noTheAmountYouDrinkStep14ImgView: UIImageView!
    @IBOutlet weak var viewTheAmountYouDrinkStep14: UIView!
    @IBOutlet weak var viewHeightConstraintTheAmountYouDrinkStep14: NSLayoutConstraint!
    
    @IBOutlet weak var yesHaveYouConsideredStoppingStep14ImgView: UIImageView!
    @IBOutlet weak var noHaveYouConsideredStoppingStep14ImgView: UIImageView!
    @IBOutlet weak var viewHaveYouConsideredStoppingStep14: UIView!
    @IBOutlet weak var viewHeightConstraintHaveYouConsideredStoppingStep14: NSLayoutConstraint!
    
    @IBOutlet weak var yesBlackoutsStep14ImgView: UIImageView!
    @IBOutlet weak var noBlackoutsStep14ImgView: UIImageView!
    @IBOutlet weak var viewBlackoutsStep14: UIView!
    @IBOutlet weak var viewHeightConstraintBlackoutsStep14: NSLayoutConstraint!
    
    @IBOutlet weak var yesBingeDrinkingStep14ImgView: UIImageView!
    @IBOutlet weak var noBingeDrinkingStep14ImgView: UIImageView!
    @IBOutlet weak var viewBingeDrinkingStep14: UIView!
    @IBOutlet weak var viewHeightConstraintBingeDrinkingStep14: NSLayoutConstraint!
    
    @IBOutlet weak var yesDriveAfterDrinkingStep14ImgView: UIImageView!
    @IBOutlet weak var noDriveAfterDrinkingStep14ImgView: UIImageView!
    @IBOutlet weak var viewDriveAfterDrinkingStep14: UIView!
    @IBOutlet weak var viewHeightConstraintDriveAfterDrinkingStep14: NSLayoutConstraint!
    //End Step 14
    
    //Start Step 15
    @IBOutlet weak var step15View: UIView!
    @IBOutlet weak var yesDoYouUseTobaccoStep15ImgView: UIImageView!
    @IBOutlet weak var noDoYouUseTobaccoStep15ImgView: UIImageView!

    @IBOutlet weak var btnCigarettesStep15: UIButton!
    @IBOutlet weak var chkCigarettesStep15ImgView: UIImageView!
    @IBOutlet weak var viewCigarettesStep15: UIView!
    @IBOutlet weak var viewHeightConstraintCigarettesStep15: NSLayoutConstraint!
    
    @IBOutlet weak var txtpksDayStep15: UITextField!
    @IBOutlet weak var viewKsDayStep15: UIView!
    @IBOutlet weak var viewHeightConstraintKsDayStep15: NSLayoutConstraint!
    
    @IBOutlet weak var txtPksWeekStep15: UITextField!
    @IBOutlet weak var viewPksWeekStep15: UIView!
    @IBOutlet weak var viewHeightConstraintPksWeekStep15: NSLayoutConstraint!
    
    @IBOutlet weak var btnChewDayStep15: UIButton!
    @IBOutlet weak var txtChewDayStep15: UITextField!
    @IBOutlet weak var chkChewDayStep15ImgView: UIImageView!
    @IBOutlet weak var viewChewDayStep15: UIView!
    @IBOutlet weak var viewHeightConstraintChewDayStep15: NSLayoutConstraint!
    
    @IBOutlet weak var btnPipeDayStep15: UIButton!
    @IBOutlet weak var txtPipeDayStep15: UITextField!
    @IBOutlet weak var chkPipeDayStep15ImgView: UIImageView!
    @IBOutlet weak var viewPipeDayStep15: UIView!
    @IBOutlet weak var viewHeightConstraintPipeDayStep15: NSLayoutConstraint!
    
    @IBOutlet weak var btnCigarsDayStep15: UIButton!
    @IBOutlet weak var txtCigarsDayStep15: UITextField!
    @IBOutlet weak var chkBtnCigarsDayStep15ImgView: UIImageView!
    @IBOutlet weak var viewCigarsDayStep15: UIView!
    @IBOutlet weak var viewHeightConstraintCigarsDayStep15: NSLayoutConstraint!
    
    @IBOutlet weak var btnOfYearsInTobaccoStep15: UIButton!
    @IBOutlet weak var txtOfYearsInTobaccoStep15: UITextField!
    @IBOutlet weak var chkOfYearsInTobaccoStep15ImgView: UIImageView!
    @IBOutlet weak var viewOfYearsInTobaccoStep15: UIView!
    @IBOutlet weak var viewHeightConstraintOfYearsInTobaccoStep15: NSLayoutConstraint!
    
    @IBOutlet weak var btnNumberOfYearsQuitStep15: UIButton!
    @IBOutlet weak var txtNumberOfYearsQuitStep15: UITextField!
    @IBOutlet weak var chkNumberOfYearsQuitStep15ImgView: UIImageView!
    @IBOutlet weak var viewNumberOfYearsQuitStep15: UIView!
    @IBOutlet weak var viewHeightConstraintNumberOfYearsQuitStep15: NSLayoutConstraint!
    @IBOutlet weak var viewtxtNumberOfYearsQuitStep15: UIView!
    @IBOutlet weak var viewHeightConstrainttxtNumberOfYearsQuitStep15: NSLayoutConstraint!
    //End Step 15
    
    //Start Step 16
    @IBOutlet weak var step16View: UIView!
    @IBOutlet weak var yesRecreationalOrStreetDrugsStep16: UIImageView!
    @IBOutlet weak var noRecreationalOrStreetDrugsStep16: UIImageView!
    
    @IBOutlet weak var yesGivenYourselfStreetDrugsStep16: UIImageView!
    @IBOutlet weak var noGivenYourselfStreetDrugsStep16: UIImageView!
    
    @IBOutlet weak var iPreferToDiscussWithThePhysicianStep16ImgView: UIImageView!
    
    //End Step 16
    
    //Start Step 17
    @IBOutlet weak var step17View: UIView!
    @IBOutlet weak var yesAreYouSexuallyActiveStep17: UIImageView!
    @IBOutlet weak var noAreYouSexuallyActiveStep17: UIImageView!
    
    @IBOutlet weak var yesTryPregnancyStep17: UIImageView!
    @IBOutlet weak var noTryPregnancyStep17: UIImageView!
    @IBOutlet weak var viewTryPregnancyStep17: UIView!
    @IBOutlet weak var viewHeightConstraintTryPregnancyStep17: NSLayoutConstraint!
    
    @IBOutlet weak var txtListContraceptiveStep17: UITextField!
    @IBOutlet weak var viewListContraceptiveStep17: UIView!
    @IBOutlet weak var viewHeightConstraintListContraceptiveStep17: NSLayoutConstraint!
    
    @IBOutlet weak var yesAnyDiscomfortWithIntercourseStep17: UIImageView!
    @IBOutlet weak var noAnyDiscomfortWithIntercourseStep17: UIImageView!
    @IBOutlet weak var viewAnyDiscomfortWithIntercourseStep17: UIView!
    @IBOutlet weak var viewHeightConstraintAnyDiscomfortWithIntercourseStep17: NSLayoutConstraint!
    
    @IBOutlet weak var yesWouldYouLikeToSpeakStep17: UIImageView!
    @IBOutlet weak var noWouldYouLikeToSpeakStep17: UIImageView!
    //End Step 17
    
    //Start Step 18
    @IBOutlet weak var step18View: UIView!
    @IBOutlet weak var YesIsStressAmajorProblemForYouStep18ImgView: UIImageView!
    @IBOutlet weak var NoIsStressAmajorProblemForYouStep18ImgView: UIImageView!
    @IBOutlet weak var YesDoYouFeelDepressedStep18ImgView: UIImageView!
    @IBOutlet weak var NoDoYouFeelDepressedStep18ImgView: UIImageView!
    @IBOutlet weak var YesDoYouPanicStep18ImgView: UIImageView!
    @IBOutlet weak var NoDoYouPanicStep18ImgView: UIImageView!
    @IBOutlet weak var YesProblemsWithEatingStep18ImgView: UIImageView!
    @IBOutlet weak var NoProblemsWithEatingStep18ImgView: UIImageView!
    @IBOutlet weak var YesCryFrequentlyStep18ImgView: UIImageView!
    @IBOutlet weak var NoCryFrequentlyStep18ImgView: UIImageView!
    @IBOutlet weak var YesAttemptedSuicideStep18ImgView: UIImageView!
    @IBOutlet weak var NoAttemptedSuicideStep18ImgView: UIImageView!
    @IBOutlet weak var YesTroubleSleepingStep18ImgView: UIImageView!
    @IBOutlet weak var NoTroubleSleepingStep18ImgView: UIImageView!
    @IBOutlet weak var YesBeenToCounselorStep18ImgView: UIImageView!
    @IBOutlet weak var NoBeenToCounselorStep18ImgView: UIImageView!
    //End Step 18
    
    //Start Step 19
    @IBOutlet weak var step19View: UIView!
    @IBOutlet weak var yesDoYouLiveAloneStep19ImgView: UIImageView!
    @IBOutlet weak var noDoYouLiveAloneStep19Step19ImgView: UIImageView!
    @IBOutlet weak var yesDoYouHaveFrequentFallsStep19ImgView: UIImageView!
    @IBOutlet weak var noDoYouHaveFrequentFallsStep19Step19ImgView: UIImageView!
    @IBOutlet weak var yesVisionOrHearingLossStep19ImgView: UIImageView!
    @IBOutlet weak var noVisionOrHearingLoss19Step19ImgView: UIImageView!
    @IBOutlet weak var yesWouldYouLikeToDiscussStep19ImgView: UIImageView!
    @IBOutlet weak var noWouldYouLikeToDiscussStep19ImgView: UIImageView!
    @IBOutlet weak var yesSunburnStep19ImgView: UIImageView!
    @IBOutlet weak var noSunburnStep19ImgView: UIImageView!
    @IBOutlet weak var occasionallySunExposureStep19ImgView: UIImageView!
    @IBOutlet weak var frequentlySunExposureStep19ImgView: UIImageView!
    @IBOutlet weak var rarelySunExposureStep19ImgView: UIImageView!
    @IBOutlet weak var occasionallySeatbeltStep19ImgView: UIImageView!
    @IBOutlet weak var frequentlySeatbeltStep19ImgView: UIImageView!
    @IBOutlet weak var rarelySeatbeltStep19ImgView: UIImageView!
    //End Step 19
    
    //Start Step 20
    @IBOutlet weak var step20View: UIView!
    @IBOutlet weak var txtAgeAtOnsetOfMenstruationStep20: UITextField!
    @IBOutlet weak var txtDateOfLastMenstruationStep20: UITextField!
    @IBOutlet weak var txtPeriodDaysStep20: UITextField!
    @IBOutlet weak var yesHeavyperiodsStep20ImgView: UIImageView!
    @IBOutlet weak var noHeavyperiodsStep20ImgView: UIImageView!
    @IBOutlet weak var txtNumberOfPregnanciesStep20: UITextField!
    @IBOutlet weak var txtNumberOfLiveBirthsStep20: UITextField!
    @IBOutlet weak var yesPregnantOrBreastfeedingStep20ImgView: UIImageView!
    @IBOutlet weak var noPregnantOrBreastfeedingStep20ImgView: UIImageView!
    @IBOutlet weak var yesAnyUrinaryTractBladderKidneyStep20ImgView: UIImageView!
    @IBOutlet weak var noAnyUrinaryTractBladderKidneyStep20ImgView: UIImageView!
    @IBOutlet weak var yesDCHysterectomyCesareanStep20ImgView: UIImageView!
    @IBOutlet weak var noDCHysterectomyCesareanStep20ImgView: UIImageView!
    @IBOutlet weak var yesUrinationStep20ImgView: UIImageView!
    @IBOutlet weak var noUrinationStep20ImgView: UIImageView!
    @IBOutlet weak var yesBloodInUrineStep20ImgView: UIImageView!
    @IBOutlet weak var noBloodInUrineStep20ImgView: UIImageView!
    @IBOutlet weak var yesHotFlashesSweatingAtNightStep20ImgView: UIImageView!
    @IBOutlet weak var noHotFlashesSweatingAtNightStep20ImgView: UIImageView!
    @IBOutlet weak var yesMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView: UIImageView!
    @IBOutlet weak var noMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView: UIImageView!
    @IBOutlet weak var yesPerformMonthlyBreastStep20ImgView: UIImageView!
    @IBOutlet weak var noPerformMonthlyBreastStep20ImgView: UIImageView!
    @IBOutlet weak var yesExperiencedAnyRecentBreastTendernessStep20ImgView: UIImageView!
    @IBOutlet weak var noExperiencedAnyRecentBreastTendernessStep20ImgView: UIImageView!
    @IBOutlet weak var txtDateOfLastPapSmearPelvicStep20: UITextField!
    //End Step 20
    
    //Start Step 21
    @IBOutlet weak var step21View: UIView!
    @IBOutlet weak var yesToUrinateStep21ImgView: UIImageView!
    @IBOutlet weak var noToUrinateStep21ImgView: UIImageView!
    @IBOutlet weak var yesUrineBurnStep21ImgView: UIImageView!
    @IBOutlet weak var noUrineBurnStep21ImgView: UIImageView!
    @IBOutlet weak var yesBloodInUrineStep21ImgView: UIImageView!
    @IBOutlet weak var noBloodInUrineStep21ImgView: UIImageView!
    @IBOutlet weak var yesBurningDischargePenisStep21ImgView: UIImageView!
    @IBOutlet weak var noBurningDischargePenisStep21ImgView: UIImageView!
    @IBOutlet weak var yesUrinationDecreasedStep21ImgView: UIImageView!
    @IBOutlet weak var noUrinationDecreasedStep21ImgView: UIImageView!
    @IBOutlet weak var yesAnyKidneyBladderProstrateInfectionsStep21ImgView: UIImageView!
    @IBOutlet weak var noAnyKidneyBladderProstrateInfectionsStep21ImgView: UIImageView!
    @IBOutlet weak var yesAnyProblemsEmptyingBladderCompletelyStep21ImgView: UIImageView!
    @IBOutlet weak var noAnyProblemsEmptyingBladderCompletelyStep21ImgView: UIImageView!
    @IBOutlet weak var yesDifficultyErectionEjaculationStep21ImgView: UIImageView!
    @IBOutlet weak var nDifficultyErectionEjaculationStep21ImgView: UIImageView!
    @IBOutlet weak var yesTesticlePainSwellingStep21ImgView: UIImageView!
    @IBOutlet weak var noTesticlePainSwellingStep21ImgView: UIImageView!
    @IBOutlet weak var txtDateLastProstateRectalExamStep21: UITextField!
    //End Step 21
    
    //Start Step 22
    @IBOutlet weak var step22View: UIView!
    @IBOutlet weak var yesDiabetesStep22ImgView: UIImageView!
    @IBOutlet weak var noDiabetesStep22ImgView: UIImageView!
    
    @IBOutlet weak var txtShareMedicationDetailsStep22: UITextField!
    @IBOutlet weak var viewShareMedication1Step22: UIView!
    @IBOutlet weak var viewHeightConstraintShareMedication1Step22: NSLayoutConstraint!
    
    @IBOutlet weak var txtSinceWhenStep22: UITextField!
    @IBOutlet weak var viewSinceWhen1Step22: UIView!
    @IBOutlet weak var viewHeightConstraintSinceWhen1Step22: NSLayoutConstraint!
    
    @IBOutlet weak var yesHypertensionStep22ImgView: UIImageView!
    @IBOutlet weak var noHypertensionStep22ImgView: UIImageView!
    
    @IBOutlet weak var txtShareMedicationDetails2Step22: UITextField!
    @IBOutlet weak var viewShareMedication2Step22: UIView!
    @IBOutlet weak var viewHeightConstraintShareMedication2Step22: NSLayoutConstraint!
    
    @IBOutlet weak var txtSinceWhen2Step22: UITextField!
    @IBOutlet weak var viewSinceWhen2Step22: UIView!
    @IBOutlet weak var viewHeightConstraintSinceWhen2Step22: NSLayoutConstraint!
    
    @IBOutlet weak var yesAdvancedDirectivesStep22ImgView: UIImageView!
    @IBOutlet weak var noAdvancedDirectivesStep22ImgView: UIImageView!
    @IBOutlet weak var yesLikeAdditionalDetailsStep22ImgView: UIImageView!
    @IBOutlet weak var noLikeAdditionalDetailsStep22ImgView: UIImageView!
    @IBOutlet weak var viewLikeAdditionalStep22: UIView!
    @IBOutlet weak var viewHeightConstraintLikeAdditionalStep22: NSLayoutConstraint!
    
    @IBOutlet weak var yesReligiousCulturalBeliefsImpactHealthcareStep22ImgView: UIImageView!
    @IBOutlet weak var noReligiousCulturalBeliefsImpactHealthcareStep22ImgView: UIImageView!
    @IBOutlet weak var txtDescribeStep22: UITextField!
    @IBOutlet weak var viewDescribeStep22: UIView!
    @IBOutlet weak var viewHeightConstraintDescribeStep22: NSLayoutConstraint!
    
    @IBOutlet weak var chkVerbalInstructionsStep22ImgView: UIImageView!
    @IBOutlet weak var chkWrittenInstructionsStep22ImgView: UIImageView!
    @IBOutlet weak var chkPicturesStep22ImgView: UIImageView!
    @IBOutlet weak var chkLessThanHighSchoolStep22ImgView: UIImageView!
    @IBOutlet weak var chkHighSchoolOrGEDStep22ImgView: UIImageView!
    @IBOutlet weak var chk1_4YearsStep22ImgView: UIImageView!
    @IBOutlet weak var chk4YearsStep22ImgView: UIImageView!
    
    @IBOutlet weak var yesUnderstandEnglishWellStep22ImgView: UIImageView!
    @IBOutlet weak var noUnderstandEnglishWellStep22ImgView: UIImageView!
    @IBOutlet weak var txtPreferLanguageStep22: UITextField!
    @IBOutlet weak var viewPreferLanguageStep22: UIView!
    @IBOutlet weak var viewHeightConstraintPreferLanguageStep22: NSLayoutConstraint!
    
    var chkVerbalInstructionsStep22: Bool = false
    var chkWrittenInstructionsStep22: Bool = false
    var chkPicturesStep22: Bool = false
    var chkLessThanHighSchoolStep22: Bool = false
    var chkHighSchoolOrGEDStep22: Bool = false
    var chk1_4YearsStep22: Bool = false
    var chk4YearsStep22: Bool = false
    //End Step 22
    
    //Start Step 23
    @IBOutlet weak var step23View: UIView!
    @IBOutlet weak var chkFeverStep23ImgView: UIImageView!
    @IBOutlet weak var chkConvulsionsSeizuresStep23ImgView: UIImageView!
    @IBOutlet weak var chkChillsStep23ImgView: UIImageView!
    @IBOutlet weak var chkSuicidalStep23ImgView: UIImageView!
    @IBOutlet weak var chkEyePainStep23ImgView: UIImageView!
    @IBOutlet weak var chkSleepDisturbancesStep23ImgView: UIImageView!
    @IBOutlet weak var chkRedEyesStep23ImgView: UIImageView!
    @IBOutlet weak var chkDecreasedLibidoSexualDesireStep23ImgView: UIImageView!
    @IBOutlet weak var chkEaracheStep23ImgView: UIImageView!
    @IBOutlet weak var chkEasyBleedingBruisingStep23ImgView: UIImageView!
    @IBOutlet weak var chkChestPainStep23ImgView: UIImageView!
    @IBOutlet weak var chkFeelingPoorlyStep23ImgView: UIImageView!
    @IBOutlet weak var chkPalpitationsStep23ImgView: UIImageView!
    @IBOutlet weak var chkFeelingTiredFatiguedStep23ImgView: UIImageView!
    @IBOutlet weak var chkShortnessBreathStep23ImgView: UIImageView!
    @IBOutlet weak var chkEyesightProblemsStep23ImgView: UIImageView!
    @IBOutlet weak var chkWheezingStep23ImgView: UIImageView!
    @IBOutlet weak var chkDischargeEyesStep23ImgView: UIImageView!
    @IBOutlet weak var chkAbdominalPainStep23ImgView: UIImageView!
    @IBOutlet weak var chkNosebleedsStep23ImgView: UIImageView!
    @IBOutlet weak var chkVomitingStep23ImgView: UIImageView!
    @IBOutlet weak var chkDischargeNoseStep23ImgView: UIImageView!
    @IBOutlet weak var chkPainUrinationStep23ImgView: UIImageView!
    @IBOutlet weak var chkFastSlowHeartbeatStep23ImgView: UIImageView!
    @IBOutlet weak var chkUrinaryIncontinenceStep23ImgView: UIImageView!
    @IBOutlet weak var chkColdHandsFeetStep23ImgView: UIImageView!
    @IBOutlet weak var chkMuscleJointPainStep23ImgView: UIImageView!
    @IBOutlet weak var chkCoughStep23ImgView: UIImageView!
    @IBOutlet weak var chkSkinLesionsStep23ImgView: UIImageView!
    @IBOutlet weak var chkShortnessBreathActivityStep23ImgView: UIImageView!
    @IBOutlet weak var chkSkinWoundStep23ImgView: UIImageView!
    @IBOutlet weak var chkConstipationStep23ImgView: UIImageView!
    @IBOutlet weak var chkConfusionStep23ImgView: UIImageView!
    @IBOutlet weak var chkDiarrheaStep23ImgView: UIImageView!
    @IBOutlet weak var txtOtherSymptomsStep23: UITextField!
    @IBOutlet weak var noteStep23View: UILabel!
    @IBOutlet weak var constraintsNoteStep23View: NSLayoutConstraint!
    
    var chkFeverStep23: Bool = false
    var chkConvulsionsSeizuresStep23: Bool = false
    var chkChillsStep23: Bool = false
    var chkSuicidalStep23: Bool = false
    var chkEyePainStep23: Bool = false
    var chkSleepDisturbancesStep23: Bool = false
    var chkRedEyesStep23: Bool = false
    var chkDecreasedLibidoSexualDesireStep23: Bool = false
    var chkEaracheStep23: Bool = false
    var chkEasyBleedingBruisingStep23: Bool = false
    var chkChestPainStep23: Bool = false
    var chkFeelingPoorlyStep23: Bool = false
    var chkPalpitationsStep23: Bool = false
    var chkFeelingTiredFatiguedStep23: Bool = false
    var chkShortnessBreathStep23: Bool = false
    var chkEyesightProblemsStep23: Bool = false
    var chkWheezingStep23: Bool = false
    var chkDischargeEyesStep23: Bool = false
    var chkAbdominalPainStep23: Bool = false
    var chkNosebleedsStep23: Bool = false
    var chkVomitingStep23: Bool = false
    var chkDischargeNoseStep23: Bool = false
    var chkPainUrinationStep23: Bool = false
    var chkFastSlowHeartbeatStep23: Bool = false
    var chkUrinaryIncontinenceStep23: Bool = false
    var chkColdHandsFeetStep23: Bool = false
    var chkMuscleJointPainStep23: Bool = false
    var chkCoughStep23: Bool = false
    var chkSkinLesionsStep23: Bool = false
    var chkShortnessBreathActivityStep23: Bool = false
    var chkSkinWoundStep23: Bool = false
    var chkConstipationStep23: Bool = false
    var chkConfusionStep23: Bool = false
    var chkDiarrheaStep23: Bool = false
    //End Step 23
    
    @IBOutlet weak var succesView: UIView!
    @IBOutlet weak var maritialStatusView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblStepCount: UILabel!
    
    var healthRiskAssessmentBo = HealthRiskAssessmentBo()
    var healthRiskAssessmentModel = HealthRiskAssessmentModel()
    var stepNumber: Int = 0
    var stepNumberDisplay: Int = 0
    var heightView: CGFloat = 0
    var headerImageStr: String = ""
    var pageTitle: String = ""
    var strSelected: String = ""
    var pleaseSelect: String = "--- Silahkan Pilih ---"
    var color:UIColor = UIColor(red:238/255, green:238/255, blue:238/255, alpha: 1)
    let formatDate: String = "dd/MM/yyyy"
    let male:String = "Laki-Laki"
    let female:String = "Perempuan"
    let menuMaritialStatus: DropDown = {
        let menu = DropDown()
        return menu
    }()
    
    let menuRankSalt: DropDown = {
        let menu = DropDown()
        return menu
    }()
    
    let menuRankFat: DropDown = {
        let menu = DropDown()
        return menu
    }()
    
    let menuRankNumber: DropDown = {
        let menu = DropDown()
        return menu
    }()
    
    let menuCupsCansPerDay: DropDown = {
        let menu = DropDown()
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        requireMaxlength()
    }
    
    func initDesign(){
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
            heightConstraintTopBar.constant = AppConstant.navBarHeight
        }
        //dashboard_white
        self.headerImage.image = UIImage.init(named: self.headerImageStr)
        self.headerTitle.text = pageTitle
        self.genderView.addViewBorder(borderColor: color.cgColor, borderWith: 1, borderCornerRadius: 4)
        self.DobView.addViewBorder(borderColor: color.cgColor, borderWith: 1, borderCornerRadius: 4)
        self.maritialStatusView.addViewBorder(borderColor: color.cgColor, borderWith: 1, borderCornerRadius: 4)
        btnNext.layer.cornerRadius = btnNext.frame.size.height / 2
        btnNext.clipsToBounds = true
        lblStepCount.layer.cornerRadius = lblStepCount.frame.size.height / 2
        lblStepCount.clipsToBounds = true
        let strName = NSMutableAttributedString(string: "Nama *")
        strName.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 5, length: 1))
        lblName.attributedText = strName
        let strMaritialSts = NSMutableAttributedString(string: "Status Pernikahan *")
        strMaritialSts.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 18, length: 1))
        lblMaritialStatusTitle.attributedText = strMaritialSts
        
        DropDown.appearance().cellHeight = 35
        maritialStatusList()
        rankSaltList()
        rankFatList()
        rankNumberList()
        cupsCansPerDayList()
        controlStep()
    }
    
    func maritialStatusList(){
        var options:[String] = []
        options.append(pleaseSelect)
        options.append("Single")
        options.append("Menikah")
        self.menuMaritialStatus.dataSource = options
        changeSelectMaritialStatus()
    }
    
    func rankSaltList(){
        var options:[String] = []
        options.append(pleaseSelect)
        options.append("HI")
        options.append("MED")
        options.append("LOW")
        self.menuRankSalt.dataSource = options
        changeSelectRankSalt()
    }
    
    func rankFatList(){
        var options:[String] = []
        options.append(pleaseSelect)
        options.append("HI")
        options.append("MED")
        options.append("LOW")
        self.menuRankFat.dataSource = options
        changeSelectRankFat()
    }
    
    func rankNumberList(){
        var options:[String] = []
        options.append(pleaseSelect)
        options.append("1")
        options.append("2")
        options.append("3")
        options.append("4")
        options.append("5")
        options.append("6")
        options.append("7")
        options.append("8")
        options.append("9")
        options.append("10")
        self.menuRankNumber.dataSource = options
        changeSelectRankNumber()
    }
    
    func cupsCansPerDayList(){
        var options:[String] = []
        options.append(pleaseSelect)
        options.append("1")
        options.append("2")
        options.append("3")
        options.append("4")
        options.append("5")
        options.append("6")
        options.append("7")
        options.append("8")
        options.append("9")
        options.append("10")
        self.menuCupsCansPerDay.dataSource = options
        changeSelectCupsCansPerDay()
    }
    
    func changeSelectRankSalt(){
        self.menuRankSalt.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtRankSaltIntakeStep13.text = item
            self.healthRiskAssessmentModel.SC_SALTINTAKE = item
        }
    }
    
    func changeSelectRankFat(){
        self.menuRankFat.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtRankFatIntake1Step13.text = item
            self.healthRiskAssessmentModel.SC_FATINTAKE = item
        }
    }
    
    func changeSelectRankNumber(){
        self.menuRankNumber.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtMealsEatAverageDayStep13.text = item
            self.healthRiskAssessmentModel.SC_MEALPRDAY = item
        }
    }
    
    func changeSelectCupsCansPerDay(){
        self.menuCupsCansPerDay.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtRankFatIntake2Step13.text = item
            self.healthRiskAssessmentModel.SC_CAFFINEPERDAY = item
        }
    }
    
    func controlStep(){
        self.btnBackHeader.isHidden = false
        self.btnBack.isHidden = false
        self.btnCancel.isHidden = false
        self.lblStepCount.isHidden = false
        self.btnNext.setTitle("Next", for: .normal)
        self.myScrollView.setContentOffset(CGPoint.zero, animated: true)
        self.noteStep23View.isHidden = true
        self.constraintsNoteStep23View.constant = 0;
        self.step1View.isHidden = true
        self.step2View.isHidden = true
        self.step3View.isHidden = true
        self.step4View.isHidden = true
        self.step5View.isHidden = true
        self.step6View.isHidden = true
        self.step7View.isHidden = true
        self.step8View.isHidden = true
        self.step9View.isHidden = true
        self.step10View.isHidden = true
        self.step11View.isHidden = true
        self.step12View.isHidden = true
        self.step13View.isHidden = true
        self.step14View.isHidden = true
        self.step15View.isHidden = true
        self.step16View.isHidden = true
        self.step17View.isHidden = true
        self.step18View.isHidden = true
        self.step19View.isHidden = true
        self.step20View.isHidden = true
        self.step21View.isHidden = true
        self.step22View.isHidden = true
        self.step23View.isHidden = true
        self.succesView.isHidden = true
        self.lblStepCount.text = "\(stepNumberDisplay)/22"
        if(stepNumber == 1){
            self.heightView = 750
            self.stepTitle.text = "Informasi Umum"
            self.stepImage.image = UIImage.init(named: "Basic_Information")
            self.contentStepImage.image = UIImage.init(named: "Basic_Information")
            self.step1View.isHidden = false
            self.btnBack.isHidden = true
            self.btnBackHeader.isHidden = true
        }
        else{
            if(stepNumber == 2){
                self.heightView = 480
                self.stepTitle.text = "Penyakit Masa Kecil"
                self.stepImage.image = UIImage.init(named: "Childhood_illness")
                self.contentStepImage.image = UIImage.init(named: "Childhood_illness")
                self.step2View.isHidden = false
            }else if(stepNumber == 3){
                self.heightView = 700
                self.stepTitle.text = "Riwayat Imunisasi"
                self.stepImage.image = UIImage.init(named: "Immunization")
                self.contentStepImage.image = UIImage.init(named: "Immunization")
                self.step3View.isHidden = false
            }else if(stepNumber == 4){
                self.heightView = 400
                self.stepTitle.text = "Riwayat Tes dan Screenings"
                self.stepImage.image = UIImage.init(named: "Test_&_Screenings")
                self.contentStepImage.image = UIImage.init(named: "Test_&_Screenings")
                self.step4View.isHidden = false
            }else if(stepNumber == 5){
                self.heightView = 500
                self.stepTitle.text = "Riwayat Operasi"
                self.stepImage.image = UIImage.init(named: "My_Surgeries")
                self.contentStepImage.image = UIImage.init(named: "My_Surgeries")
                self.step5View.isHidden = false
            }else if(stepNumber == 6){
                self.heightView = 500
                self.stepTitle.text = "Riwayat Rawat Inap"
                self.stepImage.image = UIImage.init(named: "Hospitalization")
                self.contentStepImage.image = UIImage.init(named: "Hospitalization")
                self.step6View.isHidden = false
            }else if(stepNumber == 7){
                self.heightView = 510
                self.stepTitle.text = "Riwayat Pemeriksaan Dokter"
                self.stepImage.image = UIImage.init(named: "Latest_Visit_To_Doctor")
                self.contentStepImage.image = UIImage.init(named: "Latest_Visit_To_Doctor")
                self.step7View.isHidden = false
            }else if(stepNumber == 8){
                self.heightView = 950
                self.stepTitle.text = "Riwayat Penyakit"
                self.stepImage.image = UIImage.init(named: "Medical_History")
                self.contentStepImage.image = UIImage.init(named: "Medical_History")
                self.step8View.isHidden = false
            }else if(stepNumber == 9){
                self.heightView = 450
                self.stepTitle.text = "Riwayat Penyakit (Bagian 2)"
                self.stepImage.image = UIImage.init(named: "Basic_Information")
                self.contentStepImage.image = UIImage.init(named: "Basic_Information")
                self.step9View.isHidden = false
            }else if(stepNumber == 10){
                self.heightView = 550
                self.stepTitle.text = "Riwayat Kesehatan Keluarga"
                self.stepImage.image = UIImage.init(named: "Medical_History")
                self.contentStepImage.image = UIImage.init(named: "Medical_History")
                self.step10View.isHidden = false
            }else if(stepNumber == 11){
                self.heightView = 410
                self.stepTitle.text = "Alergi"
                self.stepImage.image = UIImage.init(named: "Allergy")
                self.contentStepImage.image = UIImage.init(named: "Allergy")
                self.step11View.isHidden = false
            }else if(stepNumber == 12){
                self.heightView = 1000
                self.stepTitle.text = "Riwayat Medis Keluarga"
                self.stepImage.image = UIImage.init(named: "Family_Medical_History")
                self.contentStepImage.image = UIImage.init(named: "Family_Medical_History")
                self.step12View.isHidden = false
            }else if(stepNumber == 13){
                self.heightView = 600
                self.stepTitle.text = "Riwayat Sosial"
                self.stepImage.image = UIImage.init(named: "Social_History")
                self.contentStepImage.image = UIImage.init(named: "Social_History")
                self.step13View.isHidden = false
            }else if(stepNumber == 14){
                self.heightView = 200
                self.stepTitle.text = "Riwayat Sosial - Alkohol"
                self.stepImage.image = UIImage.init(named: "Social_History")
                self.contentStepImage.image = UIImage.init(named: "Social_History")
                self.step14View.isHidden = false
                
            }else if(stepNumber == 15){
                self.heightView = 350
                self.stepTitle.text = "Riwayat Sosial - Tembakau"
                self.stepImage.image = UIImage.init(named: "Social_History")
                self.contentStepImage.image = UIImage.init(named: "Social_History")
                self.step15View.isHidden = false
            }else if(stepNumber == 16){
                self.heightView = 350
                self.stepTitle.text = "Riwayat Sosial - Narkoba"
                self.stepImage.image = UIImage.init(named: "Social_History")
                self.contentStepImage.image = UIImage.init(named: "Social_History")
                self.step16View.isHidden = false
            }else if(stepNumber == 17){
                self.heightView = 450
                self.stepTitle.text = "Riwayat Sosial - Seksual"
                self.stepImage.image = UIImage.init(named: "Social_History")
                self.contentStepImage.image = UIImage.init(named: "Social_History")
                self.step17View.isHidden = false
            }else if(stepNumber == 18){
                self.heightView = 620
                self.stepTitle.text = "Kesehatan Mental"
                self.stepImage.image = UIImage.init(named: "Mental_Health")
                self.contentStepImage.image = UIImage.init(named: "Mental_Health")
                self.step18View.isHidden = false
            }else if(stepNumber == 19){
                self.heightView = 700
                self.stepTitle.text = "Keamanan Pribadi"
                self.stepImage.image = UIImage.init(named: "Personal_Safety")
                self.contentStepImage.image = UIImage.init(named: "Personal_Safety")
                self.step19View.isHidden = false
            }else if(stepNumber == 20){
                self.heightView = 1300
                self.stepTitle.text = "Kesehatan Perempuan"
                self.stepImage.image = UIImage.init(named: "Personal_Health")
                self.contentStepImage.image = UIImage.init(named: "Personal_Health")
                self.step20View.isHidden = false
            }else if(stepNumber == 21){
                self.heightView = 750
                self.stepTitle.text = "Kesehatan Pria"
                self.stepImage.image = UIImage.init(named: "Personal_Health")
                self.contentStepImage.image = UIImage.init(named: "Personal_Health")
                self.step21View.isHidden = false
            }else if(stepNumber == 22){
                self.heightView = 900
                self.stepTitle.text = "Informasi Lainnya"
                self.stepImage.image = UIImage.init(named: "Personal_Health")
                self.contentStepImage.image = UIImage.init(named: "Personal_Health")
                self.step22View.isHidden = false
            }else if(stepNumber == 23){
                self.heightView = 1010
                self.stepTitle.text = "Gejala-Gejala"
                self.stepImage.image = UIImage.init(named: "Test_&_Screenings")
                self.contentStepImage.image = UIImage.init(named: "Test_&_Screenings")
                self.step23View.isHidden = false
                self.btnNext.setTitle("Submit", for: .normal)
                self.noteStep23View.isHidden = false
                self.constraintsNoteStep23View.constant = 60;
            }else if(stepNumber == 24){
                self.heightView = 300
                self.stepTitle.text = "Success"
                self.stepImage.image = UIImage.init(named: "success_icon")
                self.contentStepImage.image = UIImage.init(named: "success_icon")
                self.succesView.isHidden = false
                self.btnBack.isHidden = true
                self.btnBackHeader.isHidden = true
                self.btnCancel.isHidden = true
                self.lblStepCount.isHidden = true
                self.btnNext.setTitle("OK", for: .normal)
            }
        }
        self.heightConstraintContentStepView.constant = self.heightView
        setDataStepByStep(data: self.healthRiskAssessmentModel)
    }
    
    func getAgeFromBirthday(strBirthday: String) -> Int{
        lazy var dateFormatter : DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MMM-yyyy"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                return formatter
            }()

        let birthday = dateFormatter.date(from: strBirthday)
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        return age;
    }
   
    //Start Step 1
    
    @IBAction func btnSelectMaritialStatusAction(_ sender: UIButton) {
        menuMaritialStatus.anchorView = self.maritialStatusView
        menuMaritialStatus.bottomOffset = CGPoint(x: 0, y:(menuMaritialStatus.anchorView?.plainView.bounds.height)!)
        menuMaritialStatus.show()
    }
    
    func changeSelectMaritialStatus(){
        self.menuMaritialStatus.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblMaritialStatus.text = item
            self.healthRiskAssessmentModel.MARITALSTS = item
        }
    }
    
    @IBAction func btnDOBDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done", maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtDOBDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.DOB = self.txtDOBDate.text!
            }
        }
    }
    
    //End Step 1
    
    //Start Step 2
    @IBAction func yesMeaslesAction(_ sender: UIButton) {
        yesMeaslesImgView.image = UIImage.init(named: "radioBtn-checked")
        noMeaslesImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_MEASLES = "Y"
        self.yesNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = ""
    }
    
    @IBAction func noMeaslesAction(_ sender: UIButton) {
        yesMeaslesImgView.image = UIImage.init(named: "radioBtn")
        noMeaslesImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_MEASLES = "N"
    }
    
    @IBAction func yesMumpsAction(_ sender: UIButton) {
        yesMumpsImgView.image = UIImage.init(named: "radioBtn-checked")
        noMumpsImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_MUMPS = "Y"
        self.yesNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = ""
    }
    
    @IBAction func noMumpsAction(_ sender: UIButton) {
        yesMumpsImgView.image = UIImage.init(named: "radioBtn")
        noMumpsImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_MUMPS = "N"
    }
    
    @IBAction func yesRubelleAction(_ sender: UIButton) {
        yesRubelleImgView.image = UIImage.init(named: "radioBtn-checked")
        noRubelleImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_RUB = "Y"
        self.yesNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = ""
    }
    
    @IBAction func noRubelleAction(_ sender: UIButton) {
        yesRubelleImgView.image = UIImage.init(named: "radioBtn")
        noRubelleImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_RUB = "N"
    }
    
    @IBAction func yesChickenpoxAction(_ sender: UIButton) {
        yesChickenpoxImgView.image = UIImage.init(named: "radioBtn-checked")
        noChickenpoxImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_CHKPOX = "Y"
        self.yesNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = ""
    }
    
    @IBAction func noChickenpoxAction(_ sender: UIButton) {
        yesChickenpoxImgView.image = UIImage.init(named: "radioBtn")
        noChickenpoxImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_CHKPOX = "N"
    }
    
    @IBAction func yesRheumaticFeverAction(_ sender: UIButton) {
        yesRheumaticFeverImgView.image = UIImage.init(named: "radioBtn-checked")
        noRheumaticFeverImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_RTFEVER = "Y"
        self.yesNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = ""
    }
    
    @IBAction func noRheumaticFeverAction(_ sender: UIButton) {
        yesRheumaticFeverImgView.image = UIImage.init(named: "radioBtn")
        noRheumaticFeverImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_RTFEVER = "N"
    }
    
    @IBAction func yesPolioAction(_ sender: UIButton) {
        yesPolioImgView.image = UIImage.init(named: "radioBtn-checked")
        noPolioImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_POLIO = "Y"
        self.yesNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = ""
    }
    
    @IBAction func noPolioAction(_ sender: UIButton) {
        yesPolioImgView.image = UIImage.init(named: "radioBtn")
        noPolioImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_POLIO = "N"
    }
    
    @IBAction func yesNoneAction(_ sender: UIButton) {
        yesNoneImgView.image = UIImage.init(named: "radioBtn-checked")
        noNoneImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = "Y"
        
        yesMeaslesImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_MEASLES = ""
        
        yesMumpsImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_MUMPS = ""
        
        yesRubelleImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_RUB = ""
        
        yesChickenpoxImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_CHKPOX = ""
        
        yesRheumaticFeverImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_RTFEVER = ""
        
        yesPolioImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_POLIO = ""
    }
    
    @IBAction func noNoneAction(_ sender: UIButton) {
        yesNoneImgView.image = UIImage.init(named: "radioBtn")
        noNoneImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.CHILDHDILLNESS_NONE = "N"
    }
    
    //End Step 2
    
    //Start Step 3
    @IBAction func yesTetanusAction(_ sender: UIButton) {
        yesTetanusImgView.image = UIImage.init(named: "radioBtn-checked")
        noTetanusImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_TETANUS != "Y"{
            self.txtTetanusDate.isHidden = false
            self.btnDate1Step1.isHidden = false
            self.txtTetanusDate.text = ""
            self.healthRiskAssessmentModel.IMM_TETANUSDT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_TETANUS = "Y"
    }
    
    @IBAction func noTetanusAction(_ sender: UIButton) {
        yesTetanusImgView.image = UIImage.init(named: "radioBtn")
        noTetanusImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_TETANUS != "N" && self.healthRiskAssessmentModel.IMM_TETANUS != ""{
            self.txtTetanusDate.isHidden = true
            self.btnDate1Step1.isHidden = true
            self.txtTetanusDate.text = ""
            self.healthRiskAssessmentModel.IMM_TETANUSDT = ""
        }
        self.healthRiskAssessmentModel.IMM_TETANUS = "N"
    }
    
    @IBOutlet weak var btnDate1Step1: UIButton!
    
    @IBAction func btnTetanusDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done", maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtTetanusDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_TETANUSDT = self.txtTetanusDate.text!
            }
        }
    }
    
    @IBAction func yesPneumoniaAction(_ sender: UIButton) {
        yesPneumoniaImgView.image = UIImage.init(named: "radioBtn-checked")
        noPneumoniaImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_PNEUMONIA != "Y"{
            self.txtPneumoniaDate.isHidden = false
            self.btnDate2Step1.isHidden = false
            self.txtPneumoniaDate.text = ""
            self.healthRiskAssessmentModel.IMM_PNEUMONIADT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_PNEUMONIA = "Y"
    }
    
    @IBAction func noPneumoniaAction(_ sender: UIButton) {
        yesPneumoniaImgView.image = UIImage.init(named: "radioBtn")
        noPneumoniaImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_PNEUMONIA != "N" && self.healthRiskAssessmentModel.IMM_PNEUMONIA != ""{
            self.txtPneumoniaDate.isHidden = true
            self.btnDate2Step1.isHidden = true
            self.txtPneumoniaDate.text = ""
            self.healthRiskAssessmentModel.IMM_PNEUMONIADT = ""
        }
        self.healthRiskAssessmentModel.IMM_PNEUMONIA = "N"
    }
    
    @IBOutlet weak var btnDate2Step1: UIButton!
    
    @IBAction func btnPneumoniaDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtPneumoniaDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_PNEUMONIADT = self.txtPneumoniaDate.text!
            }
        }
    }
    
    @IBAction func yesHepatitisAAction(_ sender: UIButton) {
        yesHepatitisAImgView.image = UIImage.init(named: "radioBtn-checked")
        noHepatitisAImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_HEPATITISA != "Y"{
            self.txtHepatitisADate.isHidden = false
            self.btnDate3Step1.isHidden = false
            self.txtHepatitisADate.text = ""
            self.healthRiskAssessmentModel.IMM_HEPATITISADT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_HEPATITISA = "Y"
    }
    
    @IBAction func noHepatitisAAction(_ sender: UIButton) {
        yesHepatitisAImgView.image = UIImage.init(named: "radioBtn")
        noHepatitisAImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_HEPATITISA != "N" && self.healthRiskAssessmentModel.IMM_HEPATITISA != ""{
            self.txtHepatitisADate.isHidden = true
            self.btnDate3Step1.isHidden = true
            self.txtHepatitisADate.text = ""
            self.healthRiskAssessmentModel.IMM_HEPATITISADT = ""
        }
        self.healthRiskAssessmentModel.IMM_HEPATITISA = "N"
    }
    
    @IBOutlet weak var btnDate3Step1: UIButton!
    
    @IBAction func btnHepatitisADateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtHepatitisADate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_HEPATITISADT = self.txtHepatitisADate.text!
            }
        }
    }
    
    @IBAction func yesHepatitisBAction(_ sender: UIButton) {
        yesHepatitisBImgView.image = UIImage.init(named: "radioBtn-checked")
        noHepatitisBImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_HEPATITISB != "Y"{
            self.txtHepatitisBDate.isHidden = false
            self.btnDate4Step1.isHidden = false
            self.txtHepatitisBDate.text = ""
            self.healthRiskAssessmentModel.IMM_HEPATITISBDT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_HEPATITISB = "Y"
    }
    
    @IBAction func noHepatitisBAction(_ sender: UIButton) {
        yesHepatitisBImgView.image = UIImage.init(named: "radioBtn")
        noHepatitisBImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_HEPATITISB != "N" && self.healthRiskAssessmentModel.IMM_HEPATITISB != ""{
            self.txtHepatitisBDate.isHidden = true
            self.btnDate4Step1.isHidden = true
            self.txtHepatitisBDate.text = ""
            self.healthRiskAssessmentModel.IMM_HEPATITISBDT = ""
        }
        self.healthRiskAssessmentModel.IMM_HEPATITISB = "N"
    }
    
    @IBOutlet weak var btnDate4Step1: UIButton!
    
    @IBAction func btnHepatitisBDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtHepatitisBDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_HEPATITISBDT = self.txtHepatitisBDate.text!
            }
        }
    }
    
    @IBAction func yesChickenpoxStep3Action(_ sender: UIButton) {
        yesChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
        noChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_CHICKENPOX != "Y"{
            self.txtChickenpoxStep3Date.isHidden = false
            self.btnDate5Step1.isHidden = false
            self.txtChickenpoxStep3Date.text = ""
            self.healthRiskAssessmentModel.IMM_CHICKENPOXDT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_CHICKENPOX = "Y"
    }
    
    @IBAction func noChickenpoxStep3Action(_ sender: UIButton) {
        yesChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn")
        noChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_CHICKENPOX != "N" && self.healthRiskAssessmentModel.IMM_CHICKENPOX != ""{
            self.txtChickenpoxStep3Date.isHidden = true
            self.btnDate5Step1.isHidden = true
            self.txtChickenpoxStep3Date.text = ""
            self.healthRiskAssessmentModel.IMM_CHICKENPOXDT = ""
        }
        self.healthRiskAssessmentModel.IMM_CHICKENPOX = "N"
    }
    
    @IBOutlet weak var btnDate5Step1: UIButton!
    
    @IBAction func btnChickenpoxStep3DateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtChickenpoxStep3Date.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_CHICKENPOXDT = self.txtChickenpoxStep3Date.text!
            }
        }
    }
    
    @IBAction func yesInfluenzaAction(_ sender: UIButton) {
        yesInfluenzaImgView.image = UIImage.init(named: "radioBtn-checked")
        noInfluenzaImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_INFLUENZA != "Y"{
            self.txtInfluenzaDate.isHidden = false
            self.btnDate6Step1.isHidden = false
            self.txtInfluenzaDate.text = ""
            self.healthRiskAssessmentModel.IMM_INFLUENZADT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_INFLUENZA = "Y"
    }
    
    @IBAction func noInfluenzaAction(_ sender: UIButton) {
        yesInfluenzaImgView.image = UIImage.init(named: "radioBtn")
        noInfluenzaImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_INFLUENZA != "N" && self.healthRiskAssessmentModel.IMM_INFLUENZA != ""{
            self.txtInfluenzaDate.isHidden = true
            self.btnDate6Step1.isHidden = true
            self.txtInfluenzaDate.text = ""
            self.healthRiskAssessmentModel.IMM_INFLUENZADT = ""
        }
        self.healthRiskAssessmentModel.IMM_INFLUENZA = "N"
    }
    @IBOutlet weak var btnDate6Step1: UIButton!
    
    @IBAction func btnInfluenzaDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtInfluenzaDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_INFLUENZADT = self.txtInfluenzaDate.text!
            }
        }
    }
    
    @IBAction func yesMumpsStep3Action(_ sender: UIButton) {
        yesMumpsStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
        noMumpsStep3ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_MUMPS != "Y"{
            self.txtMumpsStep3Date.isHidden = false
            self.btnDate7Step3.isHidden = false
            self.txtMumpsStep3Date.text = ""
            self.healthRiskAssessmentModel.IMM_MUMPSDT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_MUMPS = "Y"
    }
    
    @IBAction func noMumpsStep3Action(_ sender: UIButton) {
        yesMumpsStep3ImgView.image = UIImage.init(named: "radioBtn")
        noMumpsStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_MUMPS != "N" && self.healthRiskAssessmentModel.IMM_MUMPS != ""{
            self.txtMumpsStep3Date.isHidden = true
            self.btnDate7Step3.isHidden = true
            self.txtMumpsStep3Date.text = ""
            self.healthRiskAssessmentModel.IMM_MUMPSDT = ""
        }
        self.healthRiskAssessmentModel.IMM_MUMPS = "N"
    }
    
    @IBOutlet weak var btnDate7Step3: UIButton!
    
    @IBAction func btnMumpsStep3DateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtMumpsStep3Date.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_MUMPSDT = self.txtMumpsStep3Date.text!
            }
        }
    }
    
    @IBAction func yesRubellaAction(_ sender: UIButton) {
        yesRubellaImgView.image = UIImage.init(named: "radioBtn-checked")
        noRubellaImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_RUBELLA != "Y"{
            self.txtRubellaDate.isHidden = false
            self.btnDate8Step3.isHidden = false
            self.txtRubellaDate.text = ""
            self.healthRiskAssessmentModel.IMM_RUBELLADT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_RUBELLA = "Y"
    }
    
    @IBAction func noRubellaAction(_ sender: UIButton) {
        yesRubellaImgView.image = UIImage.init(named: "radioBtn")
        noRubellaImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_RUBELLA != "N" && self.healthRiskAssessmentModel.IMM_RUBELLA != ""{
            self.txtRubellaDate.isHidden = true
            self.btnDate8Step3.isHidden = true
            self.txtRubellaDate.text = ""
            self.healthRiskAssessmentModel.IMM_RUBELLADT = ""
        }
        self.healthRiskAssessmentModel.IMM_RUBELLA = "N"
    }
    
    @IBOutlet weak var btnDate8Step3: UIButton!
    
    @IBAction func btnRubellaDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtRubellaDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_RUBELLADT = self.txtRubellaDate.text!
            }
        }
    }
    
    @IBAction func yesMeningococcalAction(_ sender: UIButton) {
        yesMeningococcalImgView.image = UIImage.init(named: "radioBtn-checked")
        noMeningococcalImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL != "Y"{
            self.txtMeningococcalDate.isHidden = false
            self.btnDate9Step3.isHidden = false
            self.txtMeningococcalDate.text = ""
            self.healthRiskAssessmentModel.IMM_MENINGOCOCCALDT = ""
            yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.IMM_NONE = ""
        }
        self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL = "Y"
    }
    
    @IBAction func noMeningococcalAction(_ sender: UIButton) {
        yesMeningococcalImgView.image = UIImage.init(named: "radioBtn")
        noMeningococcalImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL != "N" && self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL != ""{
            self.txtMeningococcalDate.isHidden = true
            self.btnDate9Step3.isHidden = true
            self.txtMeningococcalDate.text = ""
            self.healthRiskAssessmentModel.IMM_MENINGOCOCCALDT = ""
        }
        self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL = "N"
    }
    
    @IBOutlet weak var btnDate9Step3: UIButton!
    
    @IBAction func btnMeningococcalDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtMeningococcalDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.IMM_MENINGOCOCCALDT = self.txtMeningococcalDate.text!
            }
        }
    }
    
    @IBAction func yesNoneStep3Action(_ sender: UIButton) {
        yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
        noNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_NONE = "Y"
        
        yesTetanusImgView.image = UIImage.init(named: "radioBtn")
        noTetanusImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_TETANUS = ""
        self.txtTetanusDate.isHidden = true
        self.btnDate1Step1.isHidden = true
        self.txtTetanusDate.text = ""
        self.healthRiskAssessmentModel.IMM_TETANUSDT = ""
        
        yesPneumoniaImgView.image = UIImage.init(named: "radioBtn")
        noPneumoniaImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_PNEUMONIA = ""
        self.txtPneumoniaDate.isHidden = true
        self.btnDate2Step1.isHidden = true
        self.txtPneumoniaDate.text = ""
        self.healthRiskAssessmentModel.IMM_PNEUMONIADT = ""
        
        yesHepatitisAImgView.image = UIImage.init(named: "radioBtn")
        noHepatitisAImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_HEPATITISA = ""
        self.txtHepatitisADate.isHidden = true
        self.btnDate3Step1.isHidden = true
        self.txtHepatitisADate.text = ""
        self.healthRiskAssessmentModel.IMM_HEPATITISADT = ""
        
        yesHepatitisBImgView.image = UIImage.init(named: "radioBtn")
        noHepatitisBImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_HEPATITISB = ""
        self.txtHepatitisBDate.isHidden = true
        self.btnDate4Step1.isHidden = true
        self.txtHepatitisBDate.text = ""
        self.healthRiskAssessmentModel.IMM_HEPATITISBDT = ""
        
        yesChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn")
        noChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_CHICKENPOX = ""
        self.txtChickenpoxStep3Date.isHidden = true
        self.btnDate5Step1.isHidden = true
        self.txtChickenpoxStep3Date.text = ""
        self.healthRiskAssessmentModel.IMM_CHICKENPOXDT = ""
        
        yesInfluenzaImgView.image = UIImage.init(named: "radioBtn")
        noInfluenzaImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_INFLUENZA = ""
        self.txtInfluenzaDate.isHidden = true
        self.btnDate6Step1.isHidden = true
        self.txtInfluenzaDate.text = ""
        self.healthRiskAssessmentModel.IMM_INFLUENZADT = ""
        
        yesMumpsStep3ImgView.image = UIImage.init(named: "radioBtn")
        noMumpsStep3ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_MUMPS = ""
        self.txtMumpsStep3Date.isHidden = true
        self.btnDate7Step3.isHidden = true
        self.txtMumpsStep3Date.text = ""
        self.healthRiskAssessmentModel.IMM_MUMPSDT = ""
        
        yesRubellaImgView.image = UIImage.init(named: "radioBtn")
        noRubellaImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_RUBELLA = ""
        self.txtRubellaDate.isHidden = true
        self.btnDate8Step3.isHidden = true
        self.txtRubellaDate.text = ""
        self.healthRiskAssessmentModel.IMM_RUBELLADT = ""
        
        yesMeningococcalImgView.image = UIImage.init(named: "radioBtn")
        noMeningococcalImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL = ""
        self.txtMeningococcalDate.isHidden = true
        self.btnDate9Step3.isHidden = true
        self.txtMeningococcalDate.text = ""
        self.healthRiskAssessmentModel.IMM_MENINGOCOCCALDT = ""
        
        yesMeningococcalImgView.image = UIImage.init(named: "radioBtn")
        noMeningococcalImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.IMM_MENINGOCOCCAL = ""
        self.txtMeningococcalDate.isHidden = true
        self.btnDate9Step3.isHidden = true
        self.txtMeningococcalDate.text = ""
        self.healthRiskAssessmentModel.IMM_MENINGOCOCCALDT = ""
    }
    
    @IBAction func noNoneStep3Action(_ sender: UIButton) {
        yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn")
        noNoneStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.IMM_NONE = "N"
    }
    //End Step 3
    
    //Start Step 4
    @IBAction func yesEyeExamAction(_ sender: UIButton) {
        yesEyeExamImgView.image = UIImage.init(named: "radioBtn-checked")
        noEyeExamImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SCR_EYEEXAM != "Y"{
            self.txtEyeExamDate.isHidden = false
            self.btnDate1Step4.isHidden = false
            self.txtEyeExamDate.text = ""
            self.healthRiskAssessmentModel.SCR_EYEEXAMDT = ""
            yesNoneStep4ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SCR_NONE = ""
        }
        self.healthRiskAssessmentModel.SCR_EYEEXAM = "Y"
    }
    
    @IBAction func noEyeExamAction(_ sender: UIButton) {
        yesEyeExamImgView.image = UIImage.init(named: "radioBtn")
        noEyeExamImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SCR_EYEEXAM != "N" && self.healthRiskAssessmentModel.SCR_EYEEXAM != ""{
            self.txtEyeExamDate.isHidden = true
            self.btnDate1Step4.isHidden = true
            self.txtEyeExamDate.text = ""
            self.healthRiskAssessmentModel.SCR_EYEEXAMDT = ""
        }
        self.healthRiskAssessmentModel.SCR_EYEEXAM = "N"
    }
    
    @IBOutlet weak var btnDate1Step4: UIButton!
    
    @IBAction func btnEyeExamDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtEyeExamDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.SCR_EYEEXAMDT = self.txtEyeExamDate.text!
            }
        }
    }
    
    @IBAction func yesColonoscopAction(_ sender: UIButton) {
        yesColonoscopImgView.image = UIImage.init(named: "radioBtn-checked")
        noColonoscopImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SCR_COLONOSCOPY != "Y"{
            self.txtColonoscopDate.isHidden = false
            self.btnDate2Step4.isHidden = false
            self.txtColonoscopDate.text = ""
            self.healthRiskAssessmentModel.SCR_COLONOSCOPYDT = ""
            yesNoneStep4ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SCR_NONE = ""
        }
        self.healthRiskAssessmentModel.SCR_COLONOSCOPY = "Y"
    }
    
    @IBAction func noColonoscopAction(_ sender: UIButton) {
        yesColonoscopImgView.image = UIImage.init(named: "radioBtn")
        noColonoscopImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SCR_COLONOSCOPY != "N" && self.healthRiskAssessmentModel.SCR_COLONOSCOPY != ""{
            self.txtColonoscopDate.isHidden = true
            self.btnDate2Step4.isHidden = true
            self.txtColonoscopDate.text = ""
            self.healthRiskAssessmentModel.SCR_COLONOSCOPYDT = ""
        }
        self.healthRiskAssessmentModel.SCR_COLONOSCOPY = "N"
    }
    
    @IBOutlet weak var btnDate2Step4: UIButton!
    
    @IBAction func btnColonoscopDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtColonoscopDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.SCR_COLONOSCOPYDT = self.txtColonoscopDate.text!
            }
        }
    }
    
    @IBAction func yesDexaScanAction(_ sender: UIButton) {
        yesDexaScanImgView.image = UIImage.init(named: "radioBtn-checked")
        noDexaScanImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SCR_DEXA_SCAN != "Y"{
            self.txtDexaScanDate.isHidden = false
            self.btnDate3Step4.isHidden = false
            self.txtDexaScanDate.text = ""
            self.healthRiskAssessmentModel.SCR_DEXA_SCANDT = ""
            yesNoneStep4ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SCR_NONE = ""
        }
        self.healthRiskAssessmentModel.SCR_DEXA_SCAN = "Y"
    }
    
    @IBAction func noDexaScanAction(_ sender: UIButton) {
        yesDexaScanImgView.image = UIImage.init(named: "radioBtn")
        noDexaScanImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SCR_DEXA_SCAN != "N" && self.healthRiskAssessmentModel.SCR_DEXA_SCAN != ""{
            self.txtDexaScanDate.isHidden = true
            self.btnDate3Step4.isHidden = true
            self.txtDexaScanDate.text = ""
            self.healthRiskAssessmentModel.SCR_DEXA_SCANDT = ""
        }
        self.healthRiskAssessmentModel.SCR_DEXA_SCAN = "N"
    }
    
    @IBOutlet weak var btnDate3Step4: UIButton!
    @IBAction func btnDexaScanDateAction(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtDexaScanDate.text = dateFormatter.string(from: dt)
                self.healthRiskAssessmentModel.SCR_DEXA_SCANDT = self.txtDexaScanDate.text!
            }
        }
    }
    
    @IBAction func yesNoneStep4Action(_ sender: UIButton) {
        yesNoneStep4ImgView.image = UIImage.init(named: "radioBtn-checked")
        noNoneStep4ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SCR_NONE = "Y"
        
        yesEyeExamImgView.image = UIImage.init(named: "radioBtn")
        noEyeExamImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SCR_EYEEXAM = ""
        self.txtEyeExamDate.isHidden = true
        self.btnDate1Step4.isHidden = true
        self.txtEyeExamDate.text = ""
        self.healthRiskAssessmentModel.SCR_EYEEXAMDT = ""
        
        yesColonoscopImgView.image = UIImage.init(named: "radioBtn")
        noColonoscopImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SCR_COLONOSCOPY = ""
        self.txtColonoscopDate.isHidden = true
        self.btnDate2Step4.isHidden = true
        self.txtColonoscopDate.text = ""
        self.healthRiskAssessmentModel.SCR_COLONOSCOPYDT = ""
  
        yesDexaScanImgView.image = UIImage.init(named: "radioBtn")
        noDexaScanImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SCR_DEXA_SCAN = ""
        self.txtDexaScanDate.isHidden = true
        self.btnDate3Step4.isHidden = true
        self.txtDexaScanDate.text = ""
        self.healthRiskAssessmentModel.SCR_DEXA_SCANDT = ""
    }
    
    @IBAction func noNoneStep4Action(_ sender: UIButton) {
        yesNoneStep4ImgView.image = UIImage.init(named: "radioBtn")
        noNoneStep4ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SCR_NONE = "N"
    }
    
    //End Step 4
    
    //Start Step 5
    @IBAction func yesSurgery1Step5Action(_ sender: UIButton) {
        yesSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        noSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SURGERY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.SURGERY_DONEBF = ""
        }
        if self.healthRiskAssessmentModel.SURGERY1 != "Y"{
            self.healthRiskAssessmentModel.SURGERY1 = "Y"
            self.viewHeightConstraintSurgery1Step5.constant = 60
            self.viewHeightConstraintReason1Step5.constant = 60
            self.viewSurgery1Step5.isHidden = false
            self.viewReason1Step5.isHidden = false
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear1Step5.text = ""
            self.txtHospitalName1Step5.text = ""
            self.txtReasonSurgery1Step5.text = ""
            self.yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noSurgery1Step5Action(_ sender: UIButton) {
        yesSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn")
        noSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SURGERY1 != "N" && self.healthRiskAssessmentModel.SURGERY1 != ""{
            self.healthRiskAssessmentModel.SURGERY1 = "N"
            self.viewHeightConstraintSurgery1Step5.constant = 0
            self.viewHeightConstraintReason1Step5.constant = 0
            self.viewSurgery1Step5.isHidden = true
            self.viewReason1Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear1Step5.text = ""
            self.txtHospitalName1Step5.text = ""
            self.txtReasonSurgery1Step5.text = ""
        }
    }
    
    @IBAction func yesSurgery2Step5Action(_ sender: UIButton) {
        yesSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        noSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SURGERY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.SURGERY_DONEBF = ""
        }
        if self.healthRiskAssessmentModel.SURGERY2 != "Y"{
            self.healthRiskAssessmentModel.SURGERY2 = "Y"
            self.viewHeightConstraintSurgery2Step5.constant = 60
            self.viewHeightConstraintReason2Step5.constant = 60
            self.viewSurgery2Step5.isHidden = false
            self.viewReason2Step5.isHidden = false
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear2Step5.text = ""
            self.txtHospitalName2Step5.text = ""
            self.txtReasonSurgery2Step5.text = ""
            self.yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noSurgery2Step5Action(_ sender: UIButton) {
        yesSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn")
        noSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SURGERY2 != "N" && self.healthRiskAssessmentModel.SURGERY2 != ""{
            self.healthRiskAssessmentModel.SURGERY2 = "N"
            self.viewHeightConstraintSurgery2Step5.constant = 0
            self.viewHeightConstraintReason2Step5.constant = 0
            self.viewSurgery2Step5.isHidden = true
            self.viewReason2Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear2Step5.text = ""
            self.txtHospitalName2Step5.text = ""
            self.txtReasonSurgery2Step5.text = ""
        }
    }
    
    @IBAction func yesSurgery3Step5Action(_ sender: UIButton) {
        yesSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        noSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SURGERY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.SURGERY_DONEBF = ""
        }
        if self.healthRiskAssessmentModel.SURGERY3 != "Y"{
            self.healthRiskAssessmentModel.SURGERY3 = "Y"
            self.viewHeightConstraintSurgery3Step5.constant = 60
            self.viewHeightConstraintReason3Step5.constant = 60
            self.viewSurgery3Step5.isHidden = false
            self.viewReason3Step5.isHidden = false
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear3Step5.text = ""
            self.txtHospitalName3Step5.text = ""
            self.txtReasonSurgery3Step5.text = ""
            self.yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noSurgery3Step5Action(_ sender: UIButton) {
        yesSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn")
        noSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SURGERY3 != "N" && self.healthRiskAssessmentModel.SURGERY3 != ""{
            self.healthRiskAssessmentModel.SURGERY3 = "N"
            self.viewHeightConstraintSurgery3Step5.constant = 0
            self.viewHeightConstraintReason3Step5.constant = 0
            self.viewSurgery3Step5.isHidden = true
            self.viewReason3Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear3Step5.text = ""
            self.txtHospitalName3Step5.text = ""
            self.txtReasonSurgery3Step5.text = ""
        }
    }
    
    @IBAction func yesSurgery4Step5Action(_ sender: UIButton) {
        yesSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        noSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SURGERY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.SURGERY_DONEBF = ""
        }
        if self.healthRiskAssessmentModel.SURGERY4 != "Y"{
            self.healthRiskAssessmentModel.SURGERY4 = "Y"
            self.viewHeightConstraintSurgery4Step5.constant = 60
            self.viewHeightConstraintReason4Step5.constant = 60
            self.viewSurgery4Step5.isHidden = false
            self.viewReason4Step5.isHidden = false
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear4Step5.text = ""
            self.txtHospitalName4Step5.text = ""
            self.txtReasonSurgery4Step5.text = ""
            self.yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noSurgery4Step5Action(_ sender: UIButton) {
        yesSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn")
        noSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SURGERY4 != "N" && self.healthRiskAssessmentModel.SURGERY4 != ""{
            self.healthRiskAssessmentModel.SURGERY4 = "N"
            self.viewHeightConstraintSurgery4Step5.constant = 0
            self.viewHeightConstraintReason4Step5.constant = 0
            self.viewSurgery4Step5.isHidden = true
            self.viewReason4Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear4Step5.text = ""
            self.txtHospitalName4Step5.text = ""
            self.txtReasonSurgery4Step5.text = ""
        }
    }
    
    @IBAction func yesSurgery5Step5Action(_ sender: UIButton) {
        yesSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        noSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SURGERY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.SURGERY_DONEBF = ""
        }
        if self.healthRiskAssessmentModel.SURGERY5 != "Y"{
            self.healthRiskAssessmentModel.SURGERY5 = "Y"
            self.viewHeightConstraintSurgery5Step5.constant = 60
            self.viewHeightConstraintReason5Step5.constant = 60
            self.viewSurgery5Step5.isHidden = false
            self.viewReason5Step5.isHidden = false
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear5Step5.text = ""
            self.txtHospitalName5Step5.text = ""
            self.txtReasonSurgery5Step5.text = ""
            self.yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noSurgery5Step5Action(_ sender: UIButton) {
        yesSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn")
        noSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SURGERY5 != "N" && self.healthRiskAssessmentModel.SURGERY5 != ""{
            self.healthRiskAssessmentModel.SURGERY5 = "N"
            self.viewHeightConstraintSurgery5Step5.constant = 0
            self.viewHeightConstraintReason5Step5.constant = 0
            self.viewSurgery5Step5.isHidden = true
            self.viewReason5Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear5Step5.text = ""
            self.txtHospitalName5Step5.text = ""
            self.txtReasonSurgery5Step5.text = ""
        }
    }
    
    @IBAction func yesNoSurgeryStep5Action(_ sender: UIButton) {
        yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn-checked")
        noNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SURGERY_DONEBF = "Y"
        
        if self.healthRiskAssessmentModel.SURGERY1 == "Y" {
            self.yesSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SURGERY1 = ""
            self.viewHeightConstraintSurgery1Step5.constant = 0
            self.viewHeightConstraintReason1Step5.constant = 0
            self.viewSurgery1Step5.isHidden = true
            self.viewReason1Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear1Step5.text = ""
            self.txtHospitalName1Step5.text = ""
            self.txtReasonSurgery1Step5.text = ""
        }
        
        if self.healthRiskAssessmentModel.SURGERY2 == "Y" {
            self.yesSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SURGERY2 = ""
            self.viewHeightConstraintSurgery2Step5.constant = 0
            self.viewHeightConstraintReason2Step5.constant = 0
            self.viewSurgery2Step5.isHidden = true
            self.viewReason2Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear2Step5.text = ""
            self.txtHospitalName2Step5.text = ""
            self.txtReasonSurgery2Step5.text = ""
        }
        
        if self.healthRiskAssessmentModel.SURGERY3 == "Y" {
            self.yesSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SURGERY3 = ""
            self.viewHeightConstraintSurgery3Step5.constant = 0
            self.viewHeightConstraintReason3Step5.constant = 0
            self.viewSurgery3Step5.isHidden = true
            self.viewReason3Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear3Step5.text = ""
            self.txtHospitalName3Step5.text = ""
            self.txtReasonSurgery3Step5.text = ""
        }
        
        if self.healthRiskAssessmentModel.SURGERY4 == "Y" {
            self.yesSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SURGERY4 = ""
            self.viewHeightConstraintSurgery4Step5.constant = 0
            self.viewHeightConstraintReason4Step5.constant = 0
            self.viewSurgery4Step5.isHidden = true
            self.viewReason4Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear4Step5.text = ""
            self.txtHospitalName4Step5.text = ""
            self.txtReasonSurgery4Step5.text = ""
        }
        
        if self.healthRiskAssessmentModel.SURGERY5 == "Y" {
            self.yesSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SURGERY5 = ""
            self.viewHeightConstraintSurgery5Step5.constant = 0
            self.viewHeightConstraintReason5Step5.constant = 0
            self.viewSurgery5Step5.isHidden = true
            self.viewReason5Step5.isHidden = true
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear5Step5.text = ""
            self.txtHospitalName5Step5.text = ""
            self.txtReasonSurgery5Step5.text = ""
        }
    }
    
    @IBAction func noNoSurgeryStep5Action(_ sender: UIButton) {
        yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn")
        noNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SURGERY_DONEBF = "N"
    }
    
    //End Step 5
    
    //Start Step 6
    @IBAction func yesHospitilization1Step6Action(_ sender: UIButton) {
        yesHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.HOSPY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.HOSPY_DONEBF = ""
        }
        if self.healthRiskAssessmentModel.HOSP1 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
            self.txtYear1Step6.text = ""
            self.txtHospitalName1Step6.text = ""
            self.txtReasonHospitilization1Step6.text = ""
            self.viewHeightConstraintHosp1Step6.constant = 60
            self.viewHeightConstraintReason1Step6.constant = 60
            self.viewHosp1Step6.isHidden = false
            self.viewReason1Step6.isHidden = false
        }
        self.healthRiskAssessmentModel.HOSP1 = "Y"
    }
    
    @IBAction func noHospitilization1Step6Action(_ sender: UIButton) {
        yesHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn")
        noHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.HOSP1 != "N" && self.healthRiskAssessmentModel.HOSP1 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear1Step6.text = ""
            self.txtHospitalName1Step6.text = ""
            self.txtReasonHospitilization1Step6.text = ""
            self.viewHeightConstraintHosp1Step6.constant = 0
            self.viewHeightConstraintReason1Step6.constant = 0
            self.viewHosp1Step6.isHidden = true
            self.viewReason1Step6.isHidden = true
        }
        self.healthRiskAssessmentModel.HOSP1 = "N"
    }
    
    @IBAction func yesHospitilization2Step6Action(_ sender: UIButton) {
        yesHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.HOSP2 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
            self.txtYear2Step6.text = ""
            self.txtHospitalName2Step6.text = ""
            self.txtReasonHospitilization2Step6.text = ""
            self.viewHeightConstraintHosp2Step6.constant = 60
            self.viewHeightConstraintReason2Step6.constant = 60
            self.viewHosp2Step6.isHidden = false
            self.viewReason2Step6.isHidden = false
        }
        if self.healthRiskAssessmentModel.HOSPY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.HOSPY_DONEBF = ""
        }
        self.healthRiskAssessmentModel.HOSP2 = "Y"
    }
    
    @IBAction func noHospitilization2Step6Action(_ sender: UIButton) {
        yesHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn")
        noHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.HOSP2 != "N" && self.healthRiskAssessmentModel.HOSP2 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear2Step6.text = ""
            self.txtHospitalName2Step6.text = ""
            self.txtReasonHospitilization2Step6.text = ""
            self.viewHeightConstraintHosp2Step6.constant = 0
            self.viewHeightConstraintReason2Step6.constant = 0
            self.viewHosp2Step6.isHidden = true
            self.viewReason2Step6.isHidden = true
        }
        self.healthRiskAssessmentModel.HOSP2 = "N"
    }
    
    @IBAction func yesHospitilization3Step6Action(_ sender: UIButton) {
        yesHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.HOSP3 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear3Step6.text = ""
            self.txtHospitalName3Step6.text = ""
            self.txtReasonHospitilization3Step6.text = ""
            self.viewHeightConstraintHosp3Step6.constant = 60
            self.viewHeightConstraintReason3Step6.constant = 60
            self.viewHosp3Step6.isHidden = false
            self.viewReason3Step6.isHidden = false
            self.yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.HOSPY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.HOSPY_DONEBF = ""
        }
        self.healthRiskAssessmentModel.HOSP3 = "Y"
    }
    
    @IBAction func noHospitilization3Step6Action(_ sender: UIButton) {
        yesHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn")
        noHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.HOSP3 != "N" && self.healthRiskAssessmentModel.HOSP3 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear3Step6.text = ""
            self.txtHospitalName3Step6.text = ""
            self.txtReasonHospitilization3Step6.text = ""
            self.viewHeightConstraintHosp3Step6.constant = 0
            self.viewHeightConstraintReason3Step6.constant = 0
            self.viewHosp3Step6.isHidden = true
            self.viewReason3Step6.isHidden = true
        }
        self.healthRiskAssessmentModel.HOSP3 = "N"
    }
    
    @IBAction func yesHospitilization4Step6Action(_ sender: UIButton) {
        yesHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.HOSP4 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear4Step6.text = ""
            self.txtHospitalName4Step6.text = ""
            self.txtReasonHospitilization4Step6.text = ""
            self.viewHeightConstraintHosp4Step6.constant = 60
            self.viewHeightConstraintReason4Step6.constant = 60
            self.viewHosp4Step6.isHidden = false
            self.viewReason4Step6.isHidden = false
            self.yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.HOSPY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.HOSPY_DONEBF = ""
        }
        self.healthRiskAssessmentModel.HOSP4 = "Y"
    }
    
    @IBAction func noHospitilization4Step6Action(_ sender: UIButton) {
        yesHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn")
        noHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.HOSP4 != "N" && self.healthRiskAssessmentModel.HOSP4 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear4Step6.text = ""
            self.txtHospitalName4Step6.text = ""
            self.txtReasonHospitilization4Step6.text = ""
            self.viewHeightConstraintHosp4Step6.constant = 0
            self.viewHeightConstraintReason4Step6.constant = 0
            self.viewHosp4Step6.isHidden = true
            self.viewReason4Step6.isHidden = true
        }
        self.healthRiskAssessmentModel.HOSP4 = "N"
    }
    
    @IBAction func yesHospitilization5Step6Action(_ sender: UIButton) {
        yesHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.HOSP5 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear5Step6.text = ""
            self.txtHospitalName5Step6.text = ""
            self.txtReasonHospitilization5Step6.text = ""
            self.viewHeightConstraintHosp5Step6.constant = 60
            self.viewHeightConstraintReason5Step6.constant = 60
            self.viewHosp5Step6.isHidden = false
            self.viewReason5Step6.isHidden = false
            self.yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.HOSPY_DONEBF == "Y"{
            self.healthRiskAssessmentModel.HOSPY_DONEBF = ""
        }
        self.healthRiskAssessmentModel.HOSP5 = "Y"
    }
    
    @IBAction func noHospitilization5Step6Action(_ sender: UIButton) {
        yesHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn")
        noHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.HOSP5 != "N" && self.healthRiskAssessmentModel.HOSP5 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtYear5Step6.text = ""
            self.txtHospitalName5Step6.text = ""
            self.txtReasonHospitilization5Step6.text = ""
            self.viewHeightConstraintHosp5Step6.constant = 0
            self.viewHeightConstraintReason5Step6.constant = 0
            self.viewHosp5Step6.isHidden = true
            self.viewReason5Step6.isHidden = true
        }
        self.healthRiskAssessmentModel.HOSP5 = "N"
    }
    
    @IBAction func yesNoHospitilizationStep6Action(_ sender: UIButton) {
        yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn-checked")
        noNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.HOSPY_DONEBF = "Y"
        
        if self.healthRiskAssessmentModel.HOSP1 != "N" && self.healthRiskAssessmentModel.HOSP1 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.HOSP1 = ""
            self.txtYear1Step6.text = ""
            self.txtHospitalName1Step6.text = ""
            self.txtReasonHospitilization1Step6.text = ""
            self.viewHeightConstraintHosp1Step6.constant = 0
            self.viewHeightConstraintReason1Step6.constant = 0
            self.viewHosp1Step6.isHidden = true
            self.viewReason1Step6.isHidden = true
            self.yesHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.HOSP2 != "N" && self.healthRiskAssessmentModel.HOSP2 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.HOSP2 = ""
            self.txtYear2Step6.text = ""
            self.txtHospitalName2Step6.text = ""
            self.txtReasonHospitilization2Step6.text = ""
            self.viewHeightConstraintHosp2Step6.constant = 0
            self.viewHeightConstraintReason2Step6.constant = 0
            self.viewHosp2Step6.isHidden = true
            self.viewReason2Step6.isHidden = true
            self.yesHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.HOSP3 != "N" && self.healthRiskAssessmentModel.HOSP3 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.HOSP3 = ""
            self.txtYear3Step6.text = ""
            self.txtHospitalName3Step6.text = ""
            self.txtReasonHospitilization3Step6.text = ""
            self.viewHeightConstraintHosp3Step6.constant = 0
            self.viewHeightConstraintReason3Step6.constant = 0
            self.viewHosp3Step6.isHidden = true
            self.viewReason3Step6.isHidden = true
            self.yesHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.HOSP4 != "N" && self.healthRiskAssessmentModel.HOSP4 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.HOSP4 = ""
            self.txtYear4Step6.text = ""
            self.txtHospitalName4Step6.text = ""
            self.txtReasonHospitilization4Step6.text = ""
            self.viewHeightConstraintHosp4Step6.constant = 0
            self.viewHeightConstraintReason4Step6.constant = 0
            self.viewHosp4Step6.isHidden = true
            self.viewReason4Step6.isHidden = true
            self.yesHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.HOSP5 != "N" && self.healthRiskAssessmentModel.HOSP5 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.HOSP5 = ""
            self.txtYear5Step6.text = ""
            self.txtHospitalName5Step6.text = ""
            self.txtReasonHospitilization5Step6.text = ""
            self.viewHeightConstraintHosp5Step6.constant = 0
            self.viewHeightConstraintReason5Step6.constant = 0
            self.viewHosp5Step6.isHidden = true
            self.viewReason5Step6.isHidden = true
            self.yesHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noNoHospitilizationStep6Action(_ sender: UIButton) {
        yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn")
        noNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.HOSPY_DONEBF = "N"
    }
    //End Step 6
    
    //Start Step 7
    @IBAction func yesVisit1Step7Action(_ sender: UIButton) {
        yesVisit1Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        noVisit1Step7ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.DOCVST1 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth1Step7.text = ""
            self.txtProviderName1Step7.text = ""
            self.txtReasonVisit1Step7.text = ""
            self.viewHeightConstraintName1Step7.constant = 60
            self.viewHeightConstraintReason1Step7.constant = 60
            self.viewName1Step7.isHidden = false
            self.viewReason1Step7.isHidden = false
            self.yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.DOCVST_DONEBF == "Y"{
            self.healthRiskAssessmentModel.DOCVST_DONEBF = ""
        }
        self.healthRiskAssessmentModel.DOCVST1 = "Y"
    }
    
    @IBAction func noVisit1Step7Action(_ sender: UIButton) {
        yesVisit1Step7ImgView.image = UIImage.init(named: "radioBtn")
        noVisit1Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.DOCVST1 != "N" && self.healthRiskAssessmentModel.DOCVST1 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth1Step7.text = ""
            self.txtProviderName1Step7.text = ""
            self.txtReasonVisit1Step7.text = ""
            self.viewHeightConstraintName1Step7.constant = 0
            self.viewHeightConstraintReason1Step7.constant = 0
            self.viewName1Step7.isHidden = true
            self.viewReason1Step7.isHidden = true
        }
        self.healthRiskAssessmentModel.DOCVST1 = "N"
    }
    
    @IBAction func yesVisit2Step7Action(_ sender: UIButton) {
        yesVisit2Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        noVisit2Step7ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.DOCVST2 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth2Step7.text = ""
            self.txtProviderName2Step7.text = ""
            self.txtReasonVisit2Step7.text = ""
            self.viewHeightConstraintName2Step7.constant = 60
            self.viewHeightConstraintReason2Step7.constant = 60
            self.viewName2Step7.isHidden = false
            self.viewReason2Step7.isHidden = false
            self.yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.DOCVST_DONEBF == "Y"{
            self.healthRiskAssessmentModel.DOCVST_DONEBF = ""
        }
        self.healthRiskAssessmentModel.DOCVST2 = "Y"
    }
    
    @IBAction func noVisit2Step7Action(_ sender: UIButton) {
        yesVisit2Step7ImgView.image = UIImage.init(named: "radioBtn")
        noVisit2Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.DOCVST2 != "N" && self.healthRiskAssessmentModel.DOCVST2 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth2Step7.text = ""
            self.txtProviderName2Step7.text = ""
            self.txtReasonVisit2Step7.text = ""
            self.viewHeightConstraintName2Step7.constant = 0
            self.viewHeightConstraintReason2Step7.constant = 0
            self.viewName2Step7.isHidden = true
            self.viewReason2Step7.isHidden = true
        }
        self.healthRiskAssessmentModel.DOCVST2 = "N"
    }
    
    @IBAction func yesVisit3Step7Action(_ sender: UIButton) {
        yesVisit3Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        noVisit3Step7ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.DOCVST3 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth3Step7.text = ""
            self.txtProviderName3Step7.text = ""
            self.txtReasonVisit3Step7.text = ""
            self.viewHeightConstraintName3Step7.constant = 60
            self.viewHeightConstraintReason3Step7.constant = 60
            self.viewName3Step7.isHidden = false
            self.viewReason3Step7.isHidden = false
            self.yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.DOCVST_DONEBF == "Y"{
            self.healthRiskAssessmentModel.DOCVST_DONEBF = ""
        }
        self.healthRiskAssessmentModel.DOCVST3 = "Y"
    }
    
    @IBAction func noVisit3Step7Action(_ sender: UIButton) {
        yesVisit3Step7ImgView.image = UIImage.init(named: "radioBtn")
        noVisit3Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.DOCVST3 != "N" && self.healthRiskAssessmentModel.DOCVST3 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth3Step7.text = ""
            self.txtProviderName3Step7.text = ""
            self.txtReasonVisit3Step7.text = ""
            self.viewHeightConstraintName3Step7.constant = 0
            self.viewHeightConstraintReason3Step7.constant = 0
            self.viewName3Step7.isHidden = true
            self.viewReason3Step7.isHidden = true
        }
        self.healthRiskAssessmentModel.DOCVST3 = "N"
    }
    
    @IBAction func yesVisit4Step7Action(_ sender: UIButton) {
        yesVisit4Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        noVisit4Step7ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.DOCVST4 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth4Step7.text = ""
            self.txtProviderName4Step7.text = ""
            self.txtReasonVisit4Step7.text = ""
            self.viewHeightConstraintName4Step7.constant = 60
            self.viewHeightConstraintReason4Step7.constant = 60
            self.viewName4Step7.isHidden = false
            self.viewReason4Step7.isHidden = false
            self.yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.DOCVST_DONEBF == "Y"{
            self.healthRiskAssessmentModel.DOCVST_DONEBF = ""
        }
        self.healthRiskAssessmentModel.DOCVST4 = "Y"

    }
    
    @IBAction func noVisit4Step7Action(_ sender: UIButton) {
        yesVisit4Step7ImgView.image = UIImage.init(named: "radioBtn")
        noVisit4Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.DOCVST4 != "N" && self.healthRiskAssessmentModel.DOCVST4 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth4Step7.text = ""
            self.txtProviderName4Step7.text = ""
            self.txtReasonVisit4Step7.text = ""
            self.viewHeightConstraintName4Step7.constant = 0
            self.viewHeightConstraintReason4Step7.constant = 0
            self.viewName4Step7.isHidden = true
            self.viewReason4Step7.isHidden = true
        }
        self.healthRiskAssessmentModel.DOCVST4 = "N"
    }
    
    @IBAction func yesVisit5Step7Action(_ sender: UIButton) {
        yesVisit5Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        noVisit5Step7ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.DOCVST5 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth5Step7.text = ""
            self.txtProviderName5Step7.text = ""
            self.txtReasonVisit5Step7.text = ""
            self.viewHeightConstraintName5Step7.constant = 60
            self.viewHeightConstraintReason5Step7.constant = 60
            self.viewName5Step7.isHidden = false
            self.viewReason5Step7.isHidden = false
            self.yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        }
        if self.healthRiskAssessmentModel.DOCVST_DONEBF == "Y"{
            self.healthRiskAssessmentModel.DOCVST_DONEBF = ""
        }
        self.healthRiskAssessmentModel.DOCVST5 = "Y"
    }
    
    @IBAction func noVisit5Step7Action(_ sender: UIButton) {
        yesVisit5Step7ImgView.image = UIImage.init(named: "radioBtn")
        noVisit5Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.DOCVST5 != "N" && self.healthRiskAssessmentModel.DOCVST5 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMonth5Step7.text = ""
            self.txtProviderName5Step7.text = ""
            self.txtReasonVisit5Step7.text = ""
            self.viewHeightConstraintName5Step7.constant = 0
            self.viewHeightConstraintReason5Step7.constant = 0
            self.viewName5Step7.isHidden = true
            self.viewReason5Step7.isHidden = true
        }
        self.healthRiskAssessmentModel.DOCVST5 = "N"
    }
    
    @IBAction func yesNoVisitStep7Action(_ sender: UIButton) {
        yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn-checked")
        noNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.DOCVST_DONEBF = "Y"
        
        if self.healthRiskAssessmentModel.DOCVST1 != "N" && self.healthRiskAssessmentModel.DOCVST1 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.DOCVST1 = ""
            self.txtMonth1Step7.text = ""
            self.txtProviderName1Step7.text = ""
            self.txtReasonVisit1Step7.text = ""
            self.viewHeightConstraintName1Step7.constant = 0
            self.viewHeightConstraintReason1Step7.constant = 0
            self.viewName1Step7.isHidden = true
            self.viewReason1Step7.isHidden = true
            yesVisit1Step7ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.DOCVST2 != "N" && self.healthRiskAssessmentModel.DOCVST2 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.DOCVST2 = ""
            self.txtMonth2Step7.text = ""
            self.txtProviderName2Step7.text = ""
            self.txtReasonVisit2Step7.text = ""
            self.viewHeightConstraintName2Step7.constant = 0
            self.viewHeightConstraintReason2Step7.constant = 0
            self.viewName2Step7.isHidden = true
            self.viewReason2Step7.isHidden = true
            yesVisit2Step7ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.DOCVST3 != "N" && self.healthRiskAssessmentModel.DOCVST3 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.DOCVST3 = ""
            self.txtMonth3Step7.text = ""
            self.txtProviderName3Step7.text = ""
            self.txtReasonVisit3Step7.text = ""
            self.viewHeightConstraintName3Step7.constant = 0
            self.viewHeightConstraintReason3Step7.constant = 0
            self.viewName3Step7.isHidden = true
            self.viewReason3Step7.isHidden = true
            yesVisit3Step7ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.DOCVST4 != "N" && self.healthRiskAssessmentModel.DOCVST4 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.DOCVST4 = ""
            self.txtMonth4Step7.text = ""
            self.txtProviderName4Step7.text = ""
            self.txtReasonVisit4Step7.text = ""
            self.viewHeightConstraintName4Step7.constant = 0
            self.viewHeightConstraintReason4Step7.constant = 0
            self.viewName4Step7.isHidden = true
            self.viewReason4Step7.isHidden = true
            yesVisit4Step7ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.DOCVST5 != "N" && self.healthRiskAssessmentModel.DOCVST5 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.DOCVST5 = ""
            self.txtMonth5Step7.text = ""
            self.txtProviderName5Step7.text = ""
            self.txtReasonVisit5Step7.text = ""
            self.viewHeightConstraintName5Step7.constant = 0
            self.viewHeightConstraintReason5Step7.constant = 0
            self.viewName5Step7.isHidden = true
            self.viewReason5Step7.isHidden = true
            yesVisit5Step7ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noNoVisitStep7Action(_ sender: UIButton) {
        yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn")
        noNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.DOCVST_DONEBF = "N"
    }
    //End Step 7
    
    //Start Step 8
    
    var alcoholAbuseStep8:Bool = false
    @IBAction func alcoholAbuseStep8Action(_ sender: UIButton) {
        alcoholAbuseStep8 = !alcoholAbuseStep8
        alcoholAbuseStep8ImgView.image = alcoholAbuseStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if alcoholAbuseStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var diabetesStep8: Bool = false
    @IBAction func diabetesStep8Action(_ sender: UIButton) {
        diabetesStep8 = !diabetesStep8
        diabetesStep8ImgView.image = diabetesStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if diabetesStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var anemiaStep8: Bool = false
    @IBAction func anemiaStep8Action(_ sender: UIButton) {
        anemiaStep8 = !anemiaStep8
        anemiaStep8ImgView.image = anemiaStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if anemiaStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var migrainesStep8: Bool = false
    @IBAction func migrainesStep8Action(_ sender: UIButton) {
        migrainesStep8 = !migrainesStep8
        migrainesStep8ImgView.image = migrainesStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if migrainesStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var anestheticComplicationStep8: Bool = false
    @IBAction func anestheticComplicationStep8Action(_ sender: UIButton) {
        anestheticComplicationStep8 = !anestheticComplicationStep8
        anestheticComplicationStep8ImgView.image = anestheticComplicationStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if anestheticComplicationStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var osteoporosisStep8: Bool = false
    @IBAction func osteoporosisStep8Action(_ sender: UIButton) {
        osteoporosisStep8 = !osteoporosisStep8
        osteoporosisStep8ImgView.image = osteoporosisStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if osteoporosisStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var anxietyDisorderStep8: Bool = false
    @IBAction func anxietyDisorderStep8Action(_ sender: UIButton) {
        anxietyDisorderStep8 = !anxietyDisorderStep8
        anxietyDisorderStep8ImgView.image = anxietyDisorderStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if anxietyDisorderStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var prostateCancerStep8: Bool = false
    @IBAction func prostateCancerStep8Action(_ sender: UIButton) {
        prostateCancerStep8 = !prostateCancerStep8
        prostateCancerStep8ImgView.image = prostateCancerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if prostateCancerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var arthritis1Step8: Bool = false
    @IBAction func arthritis1Step8Action(_ sender: UIButton) {
        arthritis1Step8 = !arthritis1Step8
        arthritis1Step8ImgView.image = arthritis1Step8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if arthritis1Step8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var rectalCancerStep8: Bool = false
    @IBAction func rectalCancerStep8Action(_ sender: UIButton) {
        rectalCancerStep8 = !rectalCancerStep8
        rectalCancerStep8ImgView.image = rectalCancerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if rectalCancerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var asthmaStep8: Bool = false
    @IBAction func asthmaStep8Action(_ sender: UIButton) {
        asthmaStep8 = !asthmaStep8
        asthmaStep8ImgView.image = asthmaStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if asthmaStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var refluxGERDStep8: Bool = false
    @IBAction func refluxGERDStep8Action(_ sender: UIButton) {
        refluxGERDStep8 = !refluxGERDStep8
        refluxGERDStep8ImgView.image = refluxGERDStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if refluxGERDStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var autoimmuneProblemsStep8: Bool = false
    @IBAction func autoimmuneProblemsStep8Action(_ sender: UIButton) {
        autoimmuneProblemsStep8 = !autoimmuneProblemsStep8
        autoimmuneProblemsStep8ImgView.image = autoimmuneProblemsStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if autoimmuneProblemsStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var seizuresConvulsionsStep8: Bool = false
    @IBAction func seizuresConvulsionsStep8Action(_ sender: UIButton)
    {
        seizuresConvulsionsStep8 = !seizuresConvulsionsStep8
        seizuresConvulsionsStep8ImgView.image = seizuresConvulsionsStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if seizuresConvulsionsStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var birthDefectsStep8: Bool = false
    @IBAction func birthDefectsStep8Action(_ sender: UIButton) {
        birthDefectsStep8 = !birthDefectsStep8
        birthDefectsStep8ImgView.image = birthDefectsStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if birthDefectsStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var severeAllergyStep8: Bool = false
    @IBAction func severeAllergyStep8Action(_ sender: UIButton) {
        severeAllergyStep8 = !severeAllergyStep8
        severeAllergyStep8ImgView.image = severeAllergyStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if severeAllergyStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bladderProblemsStep8: Bool = false
    @IBAction func bladderProblemsStep8Action(_ sender: UIButton) {
        bladderProblemsStep8 = !bladderProblemsStep8
        bladderProblemsStep8ImgView.image = bladderProblemsStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bladderProblemsStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var sexuallyTransmittedDiseaseStep8: Bool = false
    @IBAction func sexuallyTransmittedDiseaseStep8Action(_ sender: UIButton) {
        sexuallyTransmittedDiseaseStep8 = !sexuallyTransmittedDiseaseStep8
        sexuallyTransmittedDiseaseStep8ImgView.image = sexuallyTransmittedDiseaseStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if sexuallyTransmittedDiseaseStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bleedingDiseaseStep8: Bool = false
    @IBAction func bleedingDiseaseStep8Action(_ sender: UIButton) {
        bleedingDiseaseStep8 = !bleedingDiseaseStep8
        bleedingDiseaseStep8ImgView.image = bleedingDiseaseStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bleedingDiseaseStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var skinCancerStep8: Bool = false
    @IBAction func skinCancerStep8Action(_ sender: UIButton) {
        skinCancerStep8 = !skinCancerStep8
        skinCancerStep8ImgView.image = skinCancerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if skinCancerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bloodClotsStep8: Bool = false
    @IBAction func bloodClotsStep8Action(_ sender: UIButton) {
        bloodClotsStep8 = !bloodClotsStep8
        bloodClotsStep8ImgView.image = bloodClotsStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bloodClotsStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var strokeCVAoftheBrainStep8: Bool = false
    @IBAction func strokeCVAoftheBrainStep8Action(_ sender: UIButton) {
        strokeCVAoftheBrainStep8 = !strokeCVAoftheBrainStep8
        strokeCVAoftheBrainStep8ImgView.image = strokeCVAoftheBrainStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if strokeCVAoftheBrainStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bloodTransfusionStep8: Bool = false
    @IBAction func bloodTransfusionStep8Action(_ sender: UIButton) {
        bloodTransfusionStep8 = !bloodTransfusionStep8
        bloodTransfusionStep8ImgView.image = bloodTransfusionStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bloodTransfusionStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var suicideAttemptStep8: Bool = false
    @IBAction func suicideAttemptStep8Action(_ sender: UIButton) {
        suicideAttemptStep8 = !suicideAttemptStep8
        suicideAttemptStep8ImgView.image = suicideAttemptStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if suicideAttemptStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bowelDiseaseStep8: Bool = false
    @IBAction func bowelDiseaseStep8Action(_ sender: UIButton) {
        bowelDiseaseStep8 = !bowelDiseaseStep8
        bowelDiseaseStep8ImgView.image = bowelDiseaseStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bowelDiseaseStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var thyroidProblemsStep8: Bool = false
    @IBAction func thyroidProblemsStep8Action(_ sender: UIButton) {
        thyroidProblemsStep8 = !thyroidProblemsStep8
        thyroidProblemsStep8ImgView.image = thyroidProblemsStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if thyroidProblemsStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var breastCancerStep8: Bool = false
    @IBAction func breastCancerStep8Action(_ sender: UIButton) {
        breastCancerStep8 = !breastCancerStep8
        breastCancerStep8ImgView.image = breastCancerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if breastCancerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var ulcerStep8: Bool = false
    @IBAction func ulcerStep8Action(_ sender: UIButton) {
        ulcerStep8 = !ulcerStep8
        ulcerStep8ImgView.image = ulcerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if ulcerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var cervicalCancerStep8: Bool = false
    @IBAction func cervicalCancerStep8Action(_ sender: UIButton) {
        cervicalCancerStep8 = !cervicalCancerStep8
        cervicalCancerStep8ImgView.image = cervicalCancerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if cervicalCancerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var visualImpairmentStep8: Bool = false
    @IBAction func visualImpairmentStep8Action(_ sender: UIButton) {
        visualImpairmentStep8 = !visualImpairmentStep8
        visualImpairmentStep8ImgView.image = visualImpairmentStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if visualImpairmentStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var colonCancerStep8: Bool = false
    @IBAction func colonCancerStep8Action(_ sender: UIButton) {
        colonCancerStep8 = !colonCancerStep8
        colonCancerStep8ImgView.image = colonCancerStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if colonCancerStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var otherStep8: Bool = false
    @IBAction func otherStep8Action(_ sender: UIButton) {
        otherStep8 = !otherStep8
        otherStep8ImgView.image = otherStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if otherStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var depressionStep8: Bool = false
    @IBAction func depressionStep8Action(_ sender: UIButton) {
        depressionStep8 = !depressionStep8
        depressionStep8ImgView.image = depressionStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if depressionStep8 {
            noneOfTheAboveStep8 = false
            noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var noneOfTheAboveStep8: Bool = false
    @IBAction func noneOfTheAboveStep8Action(_ sender: UIButton) {
        noneOfTheAboveStep8 = !noneOfTheAboveStep8
        noneOfTheAboveStep8ImgView.image = noneOfTheAboveStep8 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if noneOfTheAboveStep8 {
            alcoholAbuseStep8 = false
            alcoholAbuseStep8ImgView.image = UIImage.init(named: "checkbox")
            diabetesStep8 = false
            diabetesStep8ImgView.image = UIImage.init(named: "checkbox")
            anemiaStep8 = false
            anemiaStep8ImgView.image = UIImage.init(named: "checkbox")
            migrainesStep8 = false
            migrainesStep8ImgView.image = UIImage.init(named: "checkbox")
            anestheticComplicationStep8 = false
            anestheticComplicationStep8ImgView.image = UIImage.init(named: "checkbox")
            osteoporosisStep8 = false
            osteoporosisStep8ImgView.image = UIImage.init(named: "checkbox")
            anxietyDisorderStep8 = false
            anxietyDisorderStep8ImgView.image = UIImage.init(named: "checkbox")
            prostateCancerStep8 = false
            prostateCancerStep8ImgView.image = UIImage.init(named: "checkbox")
            arthritis1Step8 = false
            arthritis1Step8ImgView.image = UIImage.init(named: "checkbox")
            rectalCancerStep8 = false
            rectalCancerStep8ImgView.image = UIImage.init(named: "checkbox")
            asthmaStep8 = false
            asthmaStep8ImgView.image = UIImage.init(named: "checkbox")
            refluxGERDStep8 = false
            refluxGERDStep8ImgView.image = UIImage.init(named: "checkbox")
            autoimmuneProblemsStep8 = false
            autoimmuneProblemsStep8ImgView.image = UIImage.init(named: "checkbox")
            seizuresConvulsionsStep8 = false
            seizuresConvulsionsStep8ImgView.image = UIImage.init(named: "checkbox")
            birthDefectsStep8 = false
            birthDefectsStep8ImgView.image = UIImage.init(named: "checkbox")
            severeAllergyStep8 = false
            severeAllergyStep8ImgView.image = UIImage.init(named: "checkbox")
            bladderProblemsStep8 = false
            bladderProblemsStep8ImgView.image = UIImage.init(named: "checkbox")
            sexuallyTransmittedDiseaseStep8 = false
            sexuallyTransmittedDiseaseStep8ImgView.image = UIImage.init(named: "checkbox")
            bleedingDiseaseStep8 = false
            bleedingDiseaseStep8ImgView.image = UIImage.init(named: "checkbox")
            skinCancerStep8 = false
            skinCancerStep8ImgView.image = UIImage.init(named: "checkbox")
            bloodClotsStep8 = false
            bloodClotsStep8ImgView.image = UIImage.init(named: "checkbox")
            strokeCVAoftheBrainStep8 = false
            strokeCVAoftheBrainStep8ImgView.image = UIImage.init(named: "checkbox")
            bloodTransfusionStep8 = false
            bloodTransfusionStep8ImgView.image = UIImage.init(named: "checkbox")
            suicideAttemptStep8 = false
            suicideAttemptStep8ImgView.image = UIImage.init(named: "checkbox")
            bowelDiseaseStep8 = false
            bowelDiseaseStep8ImgView.image = UIImage.init(named: "checkbox")
            thyroidProblemsStep8 = false
            thyroidProblemsStep8ImgView.image = UIImage.init(named: "checkbox")
            breastCancerStep8 = false
            breastCancerStep8ImgView.image = UIImage.init(named: "checkbox")
            ulcerStep8 = false
            ulcerStep8ImgView.image = UIImage.init(named: "checkbox")
            cervicalCancerStep8 = false
            cervicalCancerStep8ImgView.image = UIImage.init(named: "checkbox")
            visualImpairmentStep8 = false
            visualImpairmentStep8ImgView.image = UIImage.init(named: "checkbox")
            colonCancerStep8 = false
            colonCancerStep8ImgView.image = UIImage.init(named: "checkbox")
            otherStep8 = false
            otherStep8ImgView.image = UIImage.init(named: "checkbox")
            depressionStep8 = false
            depressionStep8ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    //End Step 8
    
    //Start Step 9
    @IBAction func btnDatePhysicalExamStep9Action(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtDatePhysicalExamStep9.text = dateFormatter.string(from: dt)
            }
        }
    }
    
    @IBAction func yesBloodTransfusionStep9Action(_ sender: UIButton) {
        btnYesBloodTransfusionStep9.setImage(UIImage(named: "radioBtn-checked.png"), for: .normal)
        btnNoBloodTransfusionStep9.setImage(UIImage(named: "radioBtn.png"), for: .normal)
        self.healthRiskAssessmentModel.BLOODTRANSFUSION = "Y"
    }
    
    @IBAction func noBloodTransfusionStep9Action(_ sender: UIButton) {
        btnYesBloodTransfusionStep9.setImage(UIImage(named: "radioBtn.png"), for: .normal)
        btnNoBloodTransfusionStep9.setImage(UIImage(named: "radioBtn-checked.png"), for: .normal)
        self.healthRiskAssessmentModel.BLOODTRANSFUSION = "N"
    }
    
    //End Step 9
    
    //Start Step 10
    @IBAction func yesDrug1Step10Action(_ sender: UIButton) {
        yesDrug1Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDrug1Step10ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.MEDICATION1_DRUG != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName1Step10.text = ""
            self.txtDosageFrequency1Step10.text = ""
            self.viewHeightConstraintName1Step10.constant = 60
            self.viewHeightConstraintDosage1Step10.constant = 60
            self.viewName1Step10.isHidden = false
            self.viewDosage1Step10.isHidden = false
        }
        if self.healthRiskAssessmentModel.MEDICATION_NONE == "Y"{
            self.healthRiskAssessmentModel.MEDICATION_NONE = ""
        }
        self.healthRiskAssessmentModel.MEDICATION1_DRUG = "Y"
    }
    
    @IBAction func noDrug1Step10Action(_ sender: UIButton) {
        yesDrug1Step10ImgView.image = UIImage.init(named: "radioBtn")
        noDrug1Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.MEDICATION1_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION1_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName1Step10.text = ""
            self.txtDosageFrequency1Step10.text = ""
            self.viewHeightConstraintName1Step10.constant = 0
            self.viewHeightConstraintDosage1Step10.constant = 0
            self.viewName1Step10.isHidden = true
            self.viewDosage1Step10.isHidden = true
        }
        self.healthRiskAssessmentModel.MEDICATION1_DRUG = "N"
    }
    
    @IBAction func yesDrug2Step10Action(_ sender: UIButton) {
        yesDrug2Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDrug2Step10ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.MEDICATION2_DRUG != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName2Step10.text = ""
            self.txtDosageFrequency2Step10.text = ""
            self.viewHeightConstraintName2Step10.constant = 60
            self.viewHeightConstraintDosage2Step10.constant = 60
            self.viewName2Step10.isHidden = false
            self.viewDosage2Step10.isHidden = false
        }
        if self.healthRiskAssessmentModel.MEDICATION_NONE == "Y"{
            self.healthRiskAssessmentModel.MEDICATION_NONE = ""
        }
        self.healthRiskAssessmentModel.MEDICATION2_DRUG = "Y"
    }
    
    @IBAction func noDrug2Step10Action(_ sender: UIButton) {
        yesDrug2Step10ImgView.image = UIImage.init(named: "radioBtn")
        noDrug2Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.MEDICATION2_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION2_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName2Step10.text = ""
            self.txtDosageFrequency2Step10.text = ""
            self.viewHeightConstraintName2Step10.constant = 0
            self.viewHeightConstraintDosage2Step10.constant = 0
            self.viewName2Step10.isHidden = true
            self.viewDosage2Step10.isHidden = true
        }
        self.healthRiskAssessmentModel.MEDICATION2_DRUG = "N"
    }
    
    @IBAction func yesDrug3Step10Action(_ sender: UIButton) {
        yesDrug3Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDrug3Step10ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.MEDICATION3_DRUG != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName3Step10.text = ""
            self.txtDosageFrequency3Step10.text = ""
            self.viewHeightConstraintName3Step10.constant = 60
            self.viewHeightConstraintDosage3Step10.constant = 60
            self.viewName3Step10.isHidden = false
            self.viewDosage3Step10.isHidden = false
        }
        if self.healthRiskAssessmentModel.MEDICATION_NONE == "Y"{
            self.healthRiskAssessmentModel.MEDICATION_NONE = ""
        }
        self.healthRiskAssessmentModel.MEDICATION3_DRUG = "Y"
    }
    
    @IBAction func noDrug3Step10Action(_ sender: UIButton) {
        yesDrug3Step10ImgView.image = UIImage.init(named: "radioBtn")
        noDrug3Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.MEDICATION3_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION3_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName3Step10.text = ""
            self.txtDosageFrequency3Step10.text = ""
            self.viewHeightConstraintName3Step10.constant = 0
            self.viewHeightConstraintDosage3Step10.constant = 0
            self.viewName3Step10.isHidden = true
            self.viewDosage3Step10.isHidden = true
        }
        self.healthRiskAssessmentModel.MEDICATION3_DRUG = "N"
    }
    
    @IBAction func yesDrug4Step10Action(_ sender: UIButton) {
        yesDrug4Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDrug4Step10ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.MEDICATION4_DRUG != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName4Step10.text = ""
            self.txtDosageFrequency4Step10.text = ""
            self.viewHeightConstraintName4Step10.constant = 60
            self.viewHeightConstraintDosage4Step10.constant = 60
            self.viewName4Step10.isHidden = false
            self.viewDosage4Step10.isHidden = false
        }
        if self.healthRiskAssessmentModel.MEDICATION_NONE == "Y"{
            self.healthRiskAssessmentModel.MEDICATION_NONE = ""
        }
        self.healthRiskAssessmentModel.MEDICATION4_DRUG = "Y"
    }
    
    @IBAction func noDrug4Step10Action(_ sender: UIButton) {
        yesDrug4Step10ImgView.image = UIImage.init(named: "radioBtn")
        noDrug4Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.MEDICATION4_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION4_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName4Step10.text = ""
            self.txtDosageFrequency4Step10.text = ""
            self.viewHeightConstraintName4Step10.constant = 0
            self.viewHeightConstraintDosage4Step10.constant = 0
            self.viewName4Step10.isHidden = true
            self.viewDosage4Step10.isHidden = true
        }
        self.healthRiskAssessmentModel.MEDICATION4_DRUG = "N"
    }
    
    @IBAction func yesDrug5Step10Action(_ sender: UIButton) {
        yesDrug5Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDrug5Step10ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.MEDICATION5_DRUG != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName5Step10.text = ""
            self.txtDosageFrequency5Step10.text = ""
            self.viewHeightConstraintName5Step10.constant = 60
            self.viewHeightConstraintDosage5Step10.constant = 60
            self.viewName5Step10.isHidden = false
            self.viewDosage5Step10.isHidden = false
        }
        if self.healthRiskAssessmentModel.MEDICATION_NONE == "Y"{
            self.healthRiskAssessmentModel.MEDICATION_NONE = ""
        }
        self.healthRiskAssessmentModel.MEDICATION5_DRUG = "Y"
    }
    
    @IBAction func noDrug5Step10Action(_ sender: UIButton) {
        yesDrug5Step10ImgView.image = UIImage.init(named: "radioBtn")
        noDrug5Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.MEDICATION5_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION5_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName5Step10.text = ""
            self.txtDosageFrequency5Step10.text = ""
            self.viewHeightConstraintName5Step10.constant = 0
            self.viewHeightConstraintDosage5Step10.constant = 0
            self.viewName5Step10.isHidden = true
            self.viewDosage5Step10.isHidden = true
        }
        self.healthRiskAssessmentModel.MEDICATION5_DRUG = "N"
    }
    
    @IBAction func yesNoOtherStep10Action(_ sender: UIButton) {
        yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn-checked")
        noOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MEDICATION_NONE = "Y"
        
        if self.healthRiskAssessmentModel.MEDICATION1_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION1_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.MEDICATION1_DRUG = ""
            self.txtName1Step10.text = ""
            self.txtDosageFrequency1Step10.text = ""
            self.viewHeightConstraintName1Step10.constant = 0
            self.viewHeightConstraintDosage1Step10.constant = 0
            self.viewName1Step10.isHidden = true
            self.viewDosage1Step10.isHidden = true
            yesDrug1Step10ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.MEDICATION2_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION2_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.MEDICATION2_DRUG = ""
            self.txtName2Step10.text = ""
            self.txtDosageFrequency2Step10.text = ""
            self.viewHeightConstraintName2Step10.constant = 0
            self.viewHeightConstraintDosage2Step10.constant = 0
            self.viewName2Step10.isHidden = true
            self.viewDosage2Step10.isHidden = true
            yesDrug2Step10ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.MEDICATION3_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION3_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.MEDICATION3_DRUG = ""
            self.txtName3Step10.text = ""
            self.txtDosageFrequency3Step10.text = ""
            self.viewHeightConstraintName3Step10.constant = 0
            self.viewHeightConstraintDosage3Step10.constant = 0
            self.viewName3Step10.isHidden = true
            self.viewDosage3Step10.isHidden = true
            yesDrug3Step10ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.MEDICATION4_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION4_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.MEDICATION4_DRUG = ""
            self.txtName4Step10.text = ""
            self.txtDosageFrequency4Step10.text = ""
            self.viewHeightConstraintName4Step10.constant = 0
            self.viewHeightConstraintDosage4Step10.constant = 0
            self.viewName4Step10.isHidden = true
            self.viewDosage4Step10.isHidden = true
            yesDrug4Step10ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.MEDICATION5_DRUG != "N" && self.healthRiskAssessmentModel.MEDICATION5_DRUG != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.MEDICATION5_DRUG = ""
            self.txtName5Step10.text = ""
            self.txtDosageFrequency5Step10.text = ""
            self.viewHeightConstraintName5Step10.constant = 0
            self.viewHeightConstraintDosage5Step10.constant = 0
            self.viewName5Step10.isHidden = true
            self.viewDosage5Step10.isHidden = true
            yesDrug5Step10ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noOtherStep10Action(_ sender: UIButton) {
        yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn")
        noOtherStep10ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MEDICATION_NONE = "N"
    }
    //End Step 10

    //Start Step 11
    @IBAction func yesAlergy1Step11Action(_ sender: UIButton) {
        yesAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.ALERGY1 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep11ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName1Step11.text = ""
            self.txtReactionYouHad1Step11.text = ""
            self.viewHeightConstraintName1Step11.constant = 60
            self.viewHeightConstraintReaction1Step11.constant = 60
            self.viewName1Step11.isHidden = false
            self.viewReaction1Step11.isHidden = false
        }
        if self.healthRiskAssessmentModel.ALERGY_NONE == "Y"{
            self.healthRiskAssessmentModel.ALERGY_NONE = ""
        }
        self.healthRiskAssessmentModel.ALERGY1 = "Y"
    }
    
    @IBAction func noAlergy1Step11Action(_ sender: UIButton) {
        yesAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn")
        noAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.ALERGY1 != "N" && self.healthRiskAssessmentModel.ALERGY1 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName1Step11.text = ""
            self.txtReactionYouHad1Step11.text = ""
            self.viewHeightConstraintName1Step11.constant = 0
            self.viewHeightConstraintReaction1Step11.constant = 0
            self.viewName1Step11.isHidden = true
            self.viewReaction1Step11.isHidden = true
        }
        self.healthRiskAssessmentModel.ALERGY1 = "N"
    }
    
    @IBAction func yesAlergy2Step11Action(_ sender: UIButton) {
        yesAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.ALERGY2 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep11ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName2Step11.text = ""
            self.txtReactionYouHad2Step11.text = ""
            self.viewHeightConstraintName2Step11.constant = 60
            self.viewHeightConstraintReaction2Step11.constant = 60
            self.viewName2Step11.isHidden = false
            self.viewReaction2Step11.isHidden = false
        }
        if self.healthRiskAssessmentModel.ALERGY_NONE == "Y"{
            self.healthRiskAssessmentModel.ALERGY_NONE = ""
        }
        self.healthRiskAssessmentModel.ALERGY2 = "Y"
    }
    
    @IBAction func noAlergy2Step11Action(_ sender: UIButton) {
        yesAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn")
        noAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.ALERGY2 != "N" && self.healthRiskAssessmentModel.ALERGY2 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName2Step11.text = ""
            self.txtReactionYouHad2Step11.text = ""
            self.viewHeightConstraintName2Step11.constant = 0
            self.viewHeightConstraintReaction2Step11.constant = 0
            self.viewName2Step11.isHidden = true
            self.viewReaction2Step11.isHidden = true
        }
        self.healthRiskAssessmentModel.ALERGY2 = "N"
    }
    
    @IBAction func yesAlergy3Step11Action(_ sender: UIButton) {
        yesAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.ALERGY3 != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesOtherStep11ImgView.image = UIImage.init(named: "radioBtn")
            self.txtName3Step11.text = ""
            self.txtReactionYouHad3Step11.text = ""
            self.viewHeightConstraintName3Step11.constant = 60
            self.viewHeightConstraintReaction3Step11.constant = 60
            self.viewName3Step11.isHidden = false
            self.viewReaction3Step11.isHidden = false
        }
        if self.healthRiskAssessmentModel.ALERGY_NONE == "Y"{
            self.healthRiskAssessmentModel.ALERGY_NONE = ""
        }
        self.healthRiskAssessmentModel.ALERGY3 = "Y"
    }
    
    @IBAction func noAlergy3Step11Action(_ sender: UIButton) {
        yesAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn")
        noAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.ALERGY3 != "N" && self.healthRiskAssessmentModel.ALERGY3 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtName3Step11.text = ""
            self.txtReactionYouHad3Step11.text = ""
            self.viewHeightConstraintName3Step11.constant = 0
            self.viewHeightConstraintReaction3Step11.constant = 0
            self.viewName3Step11.isHidden = true
            self.viewReaction3Step11.isHidden = true
        }
        self.healthRiskAssessmentModel.ALERGY3 = "N"
    }
    
    @IBAction func yesNoOtherStep11Action(_ sender: UIButton) {
        yesOtherStep11ImgView.image = UIImage.init(named: "radioBtn-checked")
        noOtherStep11ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.ALERGY_NONE = "Y"
        
        if self.healthRiskAssessmentModel.ALERGY1 != "N" && self.healthRiskAssessmentModel.ALERGY1 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.ALERGY1 = ""
            self.txtName1Step11.text = ""
            self.txtReactionYouHad1Step11.text = ""
            self.viewHeightConstraintName1Step11.constant = 0
            self.viewHeightConstraintReaction1Step11.constant = 0
            self.viewName1Step11.isHidden = true
            self.viewReaction1Step11.isHidden = true
            yesAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.ALERGY2 != "N" && self.healthRiskAssessmentModel.ALERGY2 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.ALERGY2 = ""
            self.txtName2Step11.text = ""
            self.txtReactionYouHad2Step11.text = ""
            self.viewHeightConstraintName2Step11.constant = 0
            self.viewHeightConstraintReaction2Step11.constant = 0
            self.viewName2Step11.isHidden = true
            self.viewReaction2Step11.isHidden = true
            yesAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn")
        }
        
        if self.healthRiskAssessmentModel.ALERGY3 != "N" && self.healthRiskAssessmentModel.ALERGY3 != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.ALERGY3 = ""
            self.txtName3Step11.text = ""
            self.txtReactionYouHad3Step11.text = ""
            self.viewHeightConstraintName3Step11.constant = 0
            self.viewHeightConstraintReaction3Step11.constant = 0
            self.viewName3Step11.isHidden = true
            self.viewReaction3Step11.isHidden = true
            yesAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn")
        }
    }
    
    @IBAction func noOtherStep11Action(_ sender: UIButton) {
        yesOtherStep11ImgView.image = UIImage.init(named: "radioBtn")
        noOtherStep11ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.ALERGY_NONE = "N"
    }
    //End Step 11
    
    //Start Step 12
    var iAmAdoptedStep12: Bool = false
    @IBAction func iAmAdoptedStep12Action(_ sender: UIButton) {
        iAmAdoptedStep12 = !iAmAdoptedStep12
        iAmAdoptedStep12ImgView.image = iAmAdoptedStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if iAmAdoptedStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var leukemiaStep12: Bool = false
    @IBAction func leukemiaStep12Action(_ sender: UIButton) {
        leukemiaStep12 = !leukemiaStep12
        leukemiaStep12ImgView.image = leukemiaStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if leukemiaStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var familyHistoryUnknownStep12: Bool = false
    @IBAction func familyHistoryUnknownStep12Action(_ sender: UIButton) {
        familyHistoryUnknownStep12 = !familyHistoryUnknownStep12
        familyHistoryUnknownStep12ImgView.image = familyHistoryUnknownStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if familyHistoryUnknownStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var lungRespiratoryDiseaseStep12: Bool = false
    @IBAction func lungRespiratoryDiseaseStep12Action(_ sender: UIButton) {
        lungRespiratoryDiseaseStep12 = !lungRespiratoryDiseaseStep12
        lungRespiratoryDiseaseStep12ImgView.image = lungRespiratoryDiseaseStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if lungRespiratoryDiseaseStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var alcoholAbuseStep12: Bool = false
    @IBAction func alcoholAbuseStep12Action(_ sender: UIButton) {
        alcoholAbuseStep12 = !alcoholAbuseStep12
        alcoholAbuseStep12ImgView.image = alcoholAbuseStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if alcoholAbuseStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var migrainesStep12: Bool = false
    @IBAction func migrainesStep12Action(_ sender: UIButton) {
        migrainesStep12 = !migrainesStep12
        migrainesStep12ImgView.image = migrainesStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if migrainesStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var anemiaStep12: Bool = false
    @IBAction func anemiaStep12Action(_ sender: UIButton) {
        anemiaStep12 = !anemiaStep12
        AnemiaStep12ImgView.image = anemiaStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if anemiaStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var osteoporosisStep12: Bool = false
    @IBAction func osteoporosisStep12Action(_ sender: UIButton) {
        osteoporosisStep12 = !osteoporosisStep12
        osteoporosisStep12ImgView.image = osteoporosisStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if osteoporosisStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var anestheticComplicationStep12: Bool = false
    @IBAction func anestheticComplicationStep12Action(_ sender: UIButton) {
        anestheticComplicationStep12 = !anestheticComplicationStep12
        anestheticComplicationStep12ImgView.image = anestheticComplicationStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if anestheticComplicationStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var otherCancerStep12: Bool = false
    @IBAction func otherCancerStep12Action(_ sender: UIButton) {
        otherCancerStep12 = !otherCancerStep12
        otherCancerStep12ImgView.image = otherCancerStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if otherCancerStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var arthritisStep12: Bool = false
    @IBAction func arthritisStep12Action(_ sender: UIButton) {
        arthritisStep12 = !arthritisStep12
        arthritisStep12ImgView.image = arthritisStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if arthritisStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var rectalCancerStep12: Bool = false
    @IBAction func rectalCancerStep12Action(_ sender: UIButton) {
        rectalCancerStep12 = !rectalCancerStep12
        rectalCancerStep12ImgView.image = rectalCancerStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if rectalCancerStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var asthmaStep12: Bool = false
    @IBAction func asthmaStep12Action(_ sender: UIButton) {
        asthmaStep12 = !asthmaStep12
        asthmaStep12ImgView.image = asthmaStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if asthmaStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var seizuresConvulsionsStep12: Bool = false
    @IBAction func seizuresConvulsionsStep12Action(_ sender: UIButton) {
        seizuresConvulsionsStep12 = !seizuresConvulsionsStep12
        seizuresConvulsionsStep12ImgView.image = seizuresConvulsionsStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if seizuresConvulsionsStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bladderProblemsStep12: Bool = false
    @IBAction func bladderProblemsStep12Action(_ sender: UIButton) {
        bladderProblemsStep12 = !bladderProblemsStep12
        bladderProblemsStep12ImgView.image = bladderProblemsStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bladderProblemsStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var severeAllergyStep12: Bool = false
    @IBAction func severeAllergyStep12Action(_ sender: UIButton) {
        severeAllergyStep12 = !severeAllergyStep12
        severeAllergyStep12ImgView.image = severeAllergyStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if severeAllergyStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var bleedingDiseaseStep12: Bool = false
    @IBAction func bleedingDiseaseStep12Action(_ sender: UIButton) {
        bleedingDiseaseStep12 = !bleedingDiseaseStep12
        bleedingDiseaseStep12ImgView.image = bleedingDiseaseStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if bleedingDiseaseStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }

    var strokeCVAoftheBrainStep12: Bool = false
    @IBAction func strokeCVAoftheBrainStep12Action(_ sender: UIButton) {
        strokeCVAoftheBrainStep12 = !strokeCVAoftheBrainStep12
        strokeCVAoftheBrainStep12ImgView.image = strokeCVAoftheBrainStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if strokeCVAoftheBrainStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var breastCancerStep12: Bool = false
    @IBAction func breastCancerStep12Action(_ sender: UIButton) {
        breastCancerStep12 = !breastCancerStep12
        breastCancerStep12ImgView.image = breastCancerStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if breastCancerStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var thyroidProblemsStep12: Bool = false
    @IBAction func thyroidProblemsStep12Action(_ sender: UIButton) {
        thyroidProblemsStep12 = !thyroidProblemsStep12
        thyroidProblemsStep12ImgView.image = thyroidProblemsStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if thyroidProblemsStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var colonCancerStep12: Bool = false
    @IBAction func colonCancerStep12Action(_ sender: UIButton) {
        colonCancerStep12 = !colonCancerStep12
        colonCancerStep12ImgView.image = colonCancerStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if colonCancerStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var motherStep12: Bool = false
    @IBAction func motherStep12Action(_ sender: UIButton) {
        motherStep12 = !motherStep12
        motherStep12ImgView.image = motherStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if motherStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var depressionStep12: Bool = false
    @IBAction func depressionStep12Action(_ sender: UIButton) {
        depressionStep12 = !depressionStep12
        depressionStep12ImgView.image = depressionStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if depressionStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var fatherStep12: Bool = false
    @IBAction func fatherStep12Action(_ sender: UIButton) {
        fatherStep12 = !fatherStep12
        fatherStep12ImgView.image = fatherStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if fatherStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var diabetesStep12: Bool = false
    @IBAction func diabetesStep12Action(_ sender: UIButton) {
        diabetesStep12 = !diabetesStep12
        diabetesStep12ImgView.image = diabetesStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if diabetesStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var heartDiseaseStep12: Bool = false
    @IBAction func heartDiseaseStep12Action(_ sender: UIButton) {
        heartDiseaseStep12 = !heartDiseaseStep12
        heartDiseaseStep12ImgView.image = heartDiseaseStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if heartDiseaseStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var highBloodPressureStep12: Bool = false
    @IBAction func highBloodPressureStep12Action(_ sender: UIButton) {
        highBloodPressureStep12 = !highBloodPressureStep12
        highBloodPressureStep12ImgView.image = highBloodPressureStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if highBloodPressureStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var highCholesterolStep12: Bool = false
    @IBAction func highCholesterolStep12Action(_ sender: UIButton) {
        highCholesterolStep12 = !highCholesterolStep12
        highCholesterolStep12ImgView.image = highCholesterolStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if highCholesterolStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var kidneyDiseaseStep12: Bool = false
    @IBAction func kidneyDiseaseStep12Action(_ sender: UIButton) {
        kidneyDiseaseStep12 = !kidneyDiseaseStep12
        kidneyDiseaseStep12ImgView.image = kidneyDiseaseStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if kidneyDiseaseStep12 {
            noneOfTheAboveStep12 = false
            noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    
    var noneOfTheAboveStep12: Bool = false
    @IBAction func noneOfTheAboveStep12Action(_ sender: UIButton) {
        noneOfTheAboveStep12 = !noneOfTheAboveStep12
        noneOfTheAboveStep12ImgView.image = noneOfTheAboveStep12 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
        if noneOfTheAboveStep12 {
            iAmAdoptedStep12 = false
            iAmAdoptedStep12ImgView.image = UIImage.init(named: "checkbox")
            leukemiaStep12 = false
            leukemiaStep12ImgView.image = UIImage.init(named: "checkbox")
            familyHistoryUnknownStep12 = false
            familyHistoryUnknownStep12ImgView.image = UIImage.init(named: "checkbox")
            lungRespiratoryDiseaseStep12 = false
            lungRespiratoryDiseaseStep12ImgView.image = UIImage.init(named: "checkbox")
            alcoholAbuseStep12 = false
            alcoholAbuseStep12ImgView.image = UIImage.init(named: "checkbox")
            migrainesStep12 = false
            migrainesStep12ImgView.image = UIImage.init(named: "checkbox")
            anemiaStep12 = false
            AnemiaStep12ImgView.image = UIImage.init(named: "checkbox")
            osteoporosisStep12 = false
            osteoporosisStep12ImgView.image = UIImage.init(named: "checkbox")
            anestheticComplicationStep12 = false
            anestheticComplicationStep12ImgView.image = UIImage.init(named: "checkbox")
            otherCancerStep12 = false
            otherCancerStep12ImgView.image = UIImage.init(named: "checkbox")
            arthritisStep12 = false
            arthritisStep12ImgView.image = UIImage.init(named: "checkbox")
            rectalCancerStep12 = false
            rectalCancerStep12ImgView.image = UIImage.init(named: "checkbox")
            asthmaStep12 = false
            asthmaStep12ImgView.image = UIImage.init(named: "checkbox")
            seizuresConvulsionsStep12 = false
            seizuresConvulsionsStep12ImgView.image = UIImage.init(named: "checkbox")
            bladderProblemsStep12 = false
            bladderProblemsStep12ImgView.image = UIImage.init(named: "checkbox")
            severeAllergyStep12 = false
            severeAllergyStep12ImgView.image = UIImage.init(named: "checkbox")
            bleedingDiseaseStep12 = false
            bleedingDiseaseStep12ImgView.image = UIImage.init(named: "checkbox")
            strokeCVAoftheBrainStep12 = false
            strokeCVAoftheBrainStep12ImgView.image = UIImage.init(named: "checkbox")
            breastCancerStep12 = false
            breastCancerStep12ImgView.image = UIImage.init(named: "checkbox")
            thyroidProblemsStep12 = false
            thyroidProblemsStep12ImgView.image = UIImage.init(named: "checkbox")
            colonCancerStep12 = false
            colonCancerStep12ImgView.image = UIImage.init(named: "checkbox")
            motherStep12 = false
            motherStep12ImgView.image = UIImage.init(named: "checkbox")
            depressionStep12 = false
            depressionStep12ImgView.image = UIImage.init(named: "checkbox")
            fatherStep12 = false
            fatherStep12ImgView.image = UIImage.init(named: "checkbox")
            diabetesStep12 = false
            diabetesStep12ImgView.image = UIImage.init(named: "checkbox")
            heartDiseaseStep12 = false
            heartDiseaseStep12ImgView.image = UIImage.init(named: "checkbox")
            highBloodPressureStep12 = false
            highBloodPressureStep12ImgView.image = UIImage.init(named: "checkbox")
            highCholesterolStep12 = false
            highCholesterolStep12ImgView.image = UIImage.init(named: "checkbox")
            kidneyDiseaseStep12 = false
            kidneyDiseaseStep12ImgView.image = UIImage.init(named: "checkbox")
        }
    }
    //End Step 12
    
    //Start Step 13
    @IBAction func yesDoYouExerciseStep13Action(_ sender: UIButton) {
        yesDoYouExerciseStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDoYouExerciseStep13ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_EXERCISE != "Y"{
            self.heightView += 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMinutesStep13.text = ""
            self.viewHeightConstraintMinutesStep13.constant = 60
            self.viewMinutesStep13.isHidden = false
        }
        self.healthRiskAssessmentModel.SC_EXERCISE = "Y"
    }
    
    @IBAction func noDoYouExerciseStep13Action(_ sender: UIButton) {
        yesDoYouExerciseStep13ImgView.image = UIImage.init(named: "radioBtn")
        noDoYouExerciseStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_EXERCISE != "N" && self.healthRiskAssessmentModel.SC_EXERCISE != ""{
            self.heightView -= 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtMinutesStep13.text = ""
            self.viewHeightConstraintMinutesStep13.constant = 0
            self.viewMinutesStep13.isHidden = true
        }
        self.healthRiskAssessmentModel.SC_EXERCISE = "N"
    }

    @IBAction func yesAreYouDietingStep13Action(_ sender: UIButton)
    {
        yesAreYouDietingStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAreYouDietingStep13ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_DIET != "Y"{
            self.heightView += 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.SC_DIETPHY = ""
            yesPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn")
            noPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintPhysicianPrescribedStep13.constant = 60
            self.viewPhysicianPrescribedStep13.isHidden = false
        }
        self.healthRiskAssessmentModel.SC_DIET = "Y"
    }
    
    @IBAction func noAreYouDietingStep13Action(_ sender: UIButton)
    {
        yesAreYouDietingStep13ImgView.image = UIImage.init(named: "radioBtn")
        noAreYouDietingStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_DIET != "N" && self.healthRiskAssessmentModel.SC_DIET != ""{
            self.heightView -= 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.SC_DIETPHY = ""
            yesPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn")
            noPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintPhysicianPrescribedStep13.constant = 0
            self.viewPhysicianPrescribedStep13.isHidden = true
        }
        self.healthRiskAssessmentModel.SC_DIET = "N"
    }
    
    @IBAction func yesPhysicianPrescribedStep13Action(_ sender: UIButton)
    {
        yesPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        noPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_DIETPHY = "Y"
    }
    
    @IBAction func noPhysicianPrescribedStep13Action(_ sender: UIButton)
    {
        yesPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn")
        noPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_DIETPHY = "N"
    }
    
    @IBAction func yesIntakeofCaffeineStep13Action(_ sender: UIButton)
    {
        yesIntakeofCaffeineStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        noIntakeofCaffeineStep13ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_CAFFINE != "Y"{
            self.heightView += 140
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtpreferredDrinkStep13.text = ""
            self.txtRankFatIntake2Step13.text = ""
            self.viewHeightConstraintPreferredDrinkStep13.constant = 80
            self.viewPreferredDrinkStep13.isHidden = false
            self.viewHeightConstraintCupsPerDayStep13.constant = 60
            self.viewCupsPerDayStep13.isHidden = false
        }
        self.healthRiskAssessmentModel.SC_CAFFINE = "Y"
    }
    
    @IBAction func noIntakeofCaffeineStep13Action(_ sender: UIButton)
    {
        yesIntakeofCaffeineStep13ImgView.image = UIImage.init(named: "radioBtn")
        noIntakeofCaffeineStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_CAFFINE != "N" && self.healthRiskAssessmentModel.SC_CAFFINE != ""{
            self.heightView -= 140
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtpreferredDrinkStep13.text = ""
            self.txtRankFatIntake2Step13.text = ""
            self.viewHeightConstraintPreferredDrinkStep13.constant = 0
            self.viewPreferredDrinkStep13.isHidden = true
            self.viewHeightConstraintCupsPerDayStep13.constant = 0
            self.viewCupsPerDayStep13.isHidden = true
        }
        self.healthRiskAssessmentModel.SC_CAFFINE = "N"
    }
    
    @IBAction func mealsDayStep13Action(_ sender: UIButton) {
        
        menuRankNumber.anchorView = self.txtMealsEatAverageDayStep13
        menuRankNumber.bottomOffset = CGPoint(x: 0, y:(menuRankNumber.anchorView?.plainView.bounds.height)!)
        menuRankNumber.show()
    }
    
    @IBAction func cupsCansStep13Action(_ sender: UIButton)
    {
        menuCupsCansPerDay.anchorView = self.txtRankFatIntake2Step13
        menuCupsCansPerDay.bottomOffset = CGPoint(x: 0, y:(menuCupsCansPerDay.anchorView?.plainView.bounds.height)!)
        menuCupsCansPerDay.show()
    }
    
    @IBAction func rankSaltIntakeStep13Action(_ sender: UIButton)
    {
        menuRankSalt.anchorView = self.txtRankSaltIntakeStep13
        menuRankSalt.bottomOffset = CGPoint(x: 0, y:(menuRankSalt.anchorView?.plainView.bounds.height)!)
        menuRankSalt.show()
    }
    
    @IBAction func rankFatIntakeStep13Action(_ sender: UIButton) {
        menuRankFat.anchorView = self.txtRankFatIntake1Step13
        menuRankFat.bottomOffset = CGPoint(x: 0, y:(menuRankFat.anchorView?.plainView.bounds.height)!)
        menuRankFat.show()
    }
    //End Step 13
    
    //Start Step 14
    @IBAction func yesDoYouDrinkAlcoholStep14Action(_ sender: UIButton)
    {
        yesDoYouDrinkAlcoholStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDoYouDrinkAlcoholStep14ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_ALCOHOL != "Y"{
            self.heightView += 420
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtWhatKindStep14.text = ""
            self.viewHeightConstraintWhatKindStep14.constant = 60
            self.viewWhatKindStep14.isHidden = false
            
            self.txtDrinksPerWeekStep14.text = ""
            self.viewHeightConstraintDrinksPerWeekStep14.constant = 60
            self.viewDrinksPerWeekStep14.isHidden = false
            
            self.healthRiskAssessmentModel.SC_ALCOHOLCN = ""
            yesTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn")
            noTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintTheAmountYouDrinkStep14.constant = 60
            self.viewTheAmountYouDrinkStep14.isHidden = false
            
            self.healthRiskAssessmentModel.SC_ALCOHOLSTOP = ""
            yesHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn")
            noHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintHaveYouConsideredStoppingStep14.constant = 60
            self.viewHaveYouConsideredStoppingStep14.isHidden = false
            
            self.healthRiskAssessmentModel.SC_ALCOHOLBO = ""
            yesBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn")
            noBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintBlackoutsStep14.constant = 60
            self.viewBlackoutsStep14.isHidden = false
            
            self.healthRiskAssessmentModel.SC_ALCOHOLBG = ""
            yesBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            noBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintBingeDrinkingStep14.constant = 60
            self.viewBingeDrinkingStep14.isHidden = false
            
            self.healthRiskAssessmentModel.SC_ALCOHOLDR = ""
            yesDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            noDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintDriveAfterDrinkingStep14.constant = 60
            self.viewDriveAfterDrinkingStep14.isHidden = false
        }
        self.healthRiskAssessmentModel.SC_ALCOHOL = "Y"
    }
    
    @IBAction func noDoYouDrinkAlcoholStep14Action(_ sender: UIButton)
    {
        yesDoYouDrinkAlcoholStep14ImgView.image = UIImage.init(named: "radioBtn")
        noDoYouDrinkAlcoholStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_ALCOHOL != "N" && self.healthRiskAssessmentModel.SC_ALCOHOL != ""{
            self.heightView -= 420
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtWhatKindStep14.text = ""
            self.viewHeightConstraintWhatKindStep14.constant = 0
            self.viewWhatKindStep14.isHidden = true
            
            self.txtDrinksPerWeekStep14.text = ""
            self.viewHeightConstraintDrinksPerWeekStep14.constant = 0
            self.viewDrinksPerWeekStep14.isHidden = true
            
            self.healthRiskAssessmentModel.SC_ALCOHOLCN = ""
            yesTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn")
            noTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintTheAmountYouDrinkStep14.constant = 0
            self.viewTheAmountYouDrinkStep14.isHidden = true
            
            self.healthRiskAssessmentModel.SC_ALCOHOLSTOP = ""
            yesHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn")
            noHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintHaveYouConsideredStoppingStep14.constant = 0
            self.viewHaveYouConsideredStoppingStep14.isHidden = true
            
            self.healthRiskAssessmentModel.SC_ALCOHOLBO = ""
            yesBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn")
            noBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintBlackoutsStep14.constant = 0
            self.viewBlackoutsStep14.isHidden = true
            
            self.healthRiskAssessmentModel.SC_ALCOHOLBG = ""
            yesBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            noBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintBingeDrinkingStep14.constant = 0
            self.viewBingeDrinkingStep14.isHidden = true
            
            self.healthRiskAssessmentModel.SC_ALCOHOLDR = ""
            yesDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            noDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
            self.viewHeightConstraintDriveAfterDrinkingStep14.constant = 0
            self.viewDriveAfterDrinkingStep14.isHidden = true
        }
        self.healthRiskAssessmentModel.SC_ALCOHOL = "N"
    }
    
    @IBAction func yesTheAmountYouDrinkStep14Action(_ sender: UIButton)
    {
        yesTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        noTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_ALCOHOLCN = "Y"
    }
    
    @IBAction func noTheAmountYouDrinkStep14Action(_ sender: UIButton)
    {
        yesTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn")
        noTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_ALCOHOLCN = "N"
    }
    
    @IBAction func yesHaveYouConsideredStoppingStep14Action(_ sender: UIButton)
    {
        yesHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_ALCOHOLSTOP = "Y"
    }
    
    @IBAction func noHaveYouConsideredStoppingStep14Action(_ sender: UIButton)
    {
        yesHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn")
        noHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_ALCOHOLSTOP = "N"
    }

    @IBAction func yesBlackoutsStep14Action(_ sender: UIButton)
    {
        yesBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        noBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_ALCOHOLBO = "Y"
    }
    
    @IBAction func noBlackoutsStep14Action(_ sender: UIButton)
    {
        yesBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn")
        noBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_ALCOHOLBO = "N"
    }
    
    @IBAction func yesBingeDrinkingStep14Action(_ sender: UIButton)
    {
        yesBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        noBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_ALCOHOLBG = "Y"
    }
    
    @IBAction func noBingeDrinkingStep14Action(_ sender: UIButton)
    {
        yesBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
        noBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_ALCOHOLBG = "N"
    }
    
    @IBAction func yesDriveAfterDrinkingStep14Action(_ sender: UIButton)
    {
        yesDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_ALCOHOLDR = "Y"
    }
    
    @IBAction func noDriveAfterDrinkingStep14Action(_ sender: UIButton)
    {
        yesDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn")
        noDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_ALCOHOLDR = "N"
    }
    //End Step 14
    
    //Start Step 15
    @IBAction func yesDoYouUseTobaccoStep15Action(_ sender: UIButton)
    {
        yesDoYouUseTobaccoStep15ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDoYouUseTobaccoStep15ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_TOBACCO != "Y"{
            self.heightView += 180
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.SC_TOBACCOCIG = ""
            self.chkCigarettesStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintCigarettesStep15.constant = 40
            self.viewCigarettesStep15.isHidden = false
            
            self.txtpksDayStep15.text = ""
            self.viewHeightConstraintKsDayStep15.constant = 0
            self.viewKsDayStep15.isHidden = true
            
            self.txtPksWeekStep15.text = ""
            self.viewHeightConstraintPksWeekStep15.constant = 0
            self.viewPksWeekStep15.isHidden = true
            
            self.healthRiskAssessmentModel.SC_TOBACCOCHW = ""
            self.txtChewDayStep15.text = ""
            self.chkChewDayStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintChewDayStep15.constant = 35
            self.viewChewDayStep15.isHidden = false
            
            self.healthRiskAssessmentModel.SC_TOBACCOCPP = ""
            self.txtPipeDayStep15.text = ""
            self.chkPipeDayStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintPipeDayStep15.constant = 35
            self.viewPipeDayStep15.isHidden = false
            
            self.healthRiskAssessmentModel.SC_TOBACCOCCG = ""
            self.txtCigarsDayStep15.text = ""
            self.chkBtnCigarsDayStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintCigarsDayStep15.constant = 35
            self.viewCigarsDayStep15.isHidden = false
            
            self.healthRiskAssessmentModel.SC_TOBACCOYRS = ""
            self.txtOfYearsInTobaccoStep15.text = ""
            self.chkOfYearsInTobaccoStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintOfYearsInTobaccoStep15.constant = 40
            self.viewOfYearsInTobaccoStep15.isHidden = false
            
            self.txtChewDayStep15.isHidden = true
            self.txtPipeDayStep15.isHidden = true
            self.txtCigarsDayStep15.isHidden = true
            self.txtOfYearsInTobaccoStep15.isHidden = true
            
            self.cigarettesStep15 = false
            self.chewDayStep15 = false
            self.pipeDayStep15 = false
            self.cigarsDayStep15 = false
            self.ofYearsInTobaccoStep15 = false
        }
        self.healthRiskAssessmentModel.SC_TOBACCO = "Y"
    }
    
    @IBAction func noDoYouUseTobaccoStep15Action(_ sender: UIButton)
    {
        yesDoYouUseTobaccoStep15ImgView.image = UIImage.init(named: "radioBtn")
        noDoYouUseTobaccoStep15ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_TOBACCO != "N" && self.healthRiskAssessmentModel.SC_TOBACCO != ""{
            self.heightView -= 180
            if cigarettesStep15{
                self.heightView -= 160
            }
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.SC_TOBACCOCIG = ""
            self.chkCigarettesStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintCigarettesStep15.constant = 0
            self.viewCigarettesStep15.isHidden = true
            
            self.txtpksDayStep15.text = ""
            self.viewHeightConstraintKsDayStep15.constant = 0
            self.viewKsDayStep15.isHidden = true
            
            self.txtPksWeekStep15.text = ""
            self.viewHeightConstraintPksWeekStep15.constant = 0
            self.viewPksWeekStep15.isHidden = true
            
            self.healthRiskAssessmentModel.SC_TOBACCOCHW = ""
            self.txtChewDayStep15.text = ""
            self.chkChewDayStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintChewDayStep15.constant = 0
            self.viewChewDayStep15.isHidden = true
            
            self.healthRiskAssessmentModel.SC_TOBACCOCPP = ""
            self.txtPipeDayStep15.text = ""
            self.chkPipeDayStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintPipeDayStep15.constant = 0
            self.viewPipeDayStep15.isHidden = true
            
            self.healthRiskAssessmentModel.SC_TOBACCOCCG = ""
            self.txtCigarsDayStep15.text = ""
            self.chkBtnCigarsDayStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintCigarsDayStep15.constant = 0
            self.viewCigarsDayStep15.isHidden = true
            
            self.healthRiskAssessmentModel.SC_TOBACCOYRS = ""
            self.txtOfYearsInTobaccoStep15.text = ""
            self.chkOfYearsInTobaccoStep15ImgView.image = UIImage.init(named: "checkbox")
            self.viewHeightConstraintOfYearsInTobaccoStep15.constant = 0
            self.viewOfYearsInTobaccoStep15.isHidden = true
            
            self.txtChewDayStep15.isHidden = true
            self.txtPipeDayStep15.isHidden = true
            self.txtCigarsDayStep15.isHidden = true
            self.txtOfYearsInTobaccoStep15.isHidden = true
            
            self.cigarettesStep15 = false
            self.chewDayStep15 = false
            self.pipeDayStep15 = false
            self.cigarsDayStep15 = false
            self.ofYearsInTobaccoStep15 = false
        }
        self.healthRiskAssessmentModel.SC_TOBACCO = "N"
    }
    
    var cigarettesStep15: Bool = false
    @IBAction func btnCigarettesStep15Action(_ sender: UIButton) {
       
        cigarettesStep15 = !cigarettesStep15
        chkCigarettesStep15ImgView.image = cigarettesStep15 ? UIImage.init(named: "checkbox_active") : UIImage.init(named: "checkbox")
        self.healthRiskAssessmentModel.SC_TOBACCOCIG = cigarettesStep15 ? "Y" : "N"
        self.txtPksWeekStep15.text = ""
        self.txtpksDayStep15.text = ""
        if cigarettesStep15{
            self.heightView += 160
            self.viewKsDayStep15.isHidden = false
            self.viewPksWeekStep15.isHidden = false
            self.viewHeightConstraintKsDayStep15.constant = 80
            self.viewHeightConstraintPksWeekStep15.constant = 80
        }else{
            self.heightView -= 160
            self.viewKsDayStep15.isHidden = true
            self.viewPksWeekStep15.isHidden = true
            self.viewHeightConstraintKsDayStep15.constant = 0
            self.viewHeightConstraintPksWeekStep15.constant = 0
        }
        self.heightConstraintContentStepView.constant = self.heightView
    }
    
    var chewDayStep15: Bool = false
    @IBAction func btnChewDayStep15Action(_ sender: UIButton) {
        chewDayStep15 = !chewDayStep15
        chkChewDayStep15ImgView.image = chewDayStep15 ? UIImage.init(named: "checkbox_active") : UIImage.init(named: "checkbox")
        self.healthRiskAssessmentModel.SC_TOBACCOCHW = chewDayStep15 ? "Y" : "N"
        self.txtChewDayStep15.text = ""
        if chewDayStep15{
            self.txtChewDayStep15.isHidden = false
        }else{
            self.txtChewDayStep15.isHidden = true
        }
    }
    
    var pipeDayStep15: Bool = false
    @IBAction func btnPipeDayStep15Action(_ sender: UIButton) {
        pipeDayStep15 = !pipeDayStep15
        chkPipeDayStep15ImgView.image = pipeDayStep15 ? UIImage.init(named: "checkbox_active") : UIImage.init(named: "checkbox")
        self.healthRiskAssessmentModel.SC_TOBACCOCPP = pipeDayStep15 ? "Y" : "N"
        self.txtPipeDayStep15.text = ""
        if pipeDayStep15{
            self.txtPipeDayStep15.isHidden = false
        }else{
            self.txtPipeDayStep15.isHidden = true
        }
    }
    
    var cigarsDayStep15: Bool = false
    @IBAction func btnCigarsDayStep15Action(_ sender: UIButton) {
        cigarsDayStep15 = !cigarsDayStep15
        chkBtnCigarsDayStep15ImgView.image = cigarsDayStep15 ? UIImage.init(named: "checkbox_active") : UIImage.init(named: "checkbox")
        self.healthRiskAssessmentModel.SC_TOBACCOCCG = cigarsDayStep15 ? "Y" : "N"
        self.txtCigarsDayStep15.text = ""
        if cigarsDayStep15{
            self.txtCigarsDayStep15.isHidden = false
        }else{
            self.txtCigarsDayStep15.isHidden = true
        }
    }
    
    var ofYearsInTobaccoStep15: Bool = false
    @IBAction func btnOfYearsInTobaccoStep15Action(_ sender: UIButton) {
        ofYearsInTobaccoStep15 = !ofYearsInTobaccoStep15
        chkOfYearsInTobaccoStep15ImgView.image = ofYearsInTobaccoStep15 ? UIImage.init(named: "checkbox_active") : UIImage.init(named: "checkbox")
        self.healthRiskAssessmentModel.SC_TOBACCOYRS = ofYearsInTobaccoStep15 ? "Y" : "N"
        self.txtOfYearsInTobaccoStep15.text = ""
        if ofYearsInTobaccoStep15{
            self.txtOfYearsInTobaccoStep15.isHidden = false
        }else{
            self.txtOfYearsInTobaccoStep15.isHidden = true
        }
    }
    
    var numberOfYearsQuitStep15: Bool = false
    @IBAction func btnNumberOfYearsQuitStep15Action(_ sender: UIButton) {
        numberOfYearsQuitStep15 = !numberOfYearsQuitStep15
        chkNumberOfYearsQuitStep15ImgView.image = numberOfYearsQuitStep15 ? UIImage.init(named: "checkbox_active") : UIImage.init(named: "checkbox")
        self.healthRiskAssessmentModel.SC_TOBACCOYRSQT = numberOfYearsQuitStep15 ? "Y" : "N"
        self.txtNumberOfYearsQuitStep15.text = ""
        if numberOfYearsQuitStep15{
            self.txtNumberOfYearsQuitStep15.isHidden = false
        }else{
            self.txtNumberOfYearsQuitStep15.isHidden = true
            
        }
    }
    //End Step 15
    
    //Start Step 16
    @IBAction func yesRecreationalOrStreetDrugsStep16Action(_ sender: UIButton)
    {
        yesRecreationalOrStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
        noRecreationalOrStreetDrugsStep16.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_DRUGRCST = "Y"
    }
    
    @IBAction func noRecreationalOrStreetDrugsStep16Action(_ sender: UIButton)
    {
        yesRecreationalOrStreetDrugsStep16.image = UIImage.init(named: "radioBtn")
        noRecreationalOrStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_DRUGRCST = "N"
    }

    @IBAction func yesGivenYourselfStreetDrugsStep16Action(_ sender: UIButton)
    {
        yesGivenYourselfStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
        noGivenYourselfStreetDrugsStep16.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_DRUGRCSTNDL = "Y"
    }
    
    @IBAction func noGivenYourselfStreetDrugsStep16Action(_ sender: UIButton)
    {
        yesGivenYourselfStreetDrugsStep16.image = UIImage.init(named: "radioBtn")
        noGivenYourselfStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_DRUGRCSTNDL = "N"
    }
    
    var iPreferToDiscussWithThePhysicianStep16: Bool = false
    @IBAction func btnIPreferToDiscussWithThePhysicianStep16Action(_ sender: UIButton) {
        iPreferToDiscussWithThePhysicianStep16 = !iPreferToDiscussWithThePhysicianStep16
        iPreferToDiscussWithThePhysicianStep16ImgView.image = iPreferToDiscussWithThePhysicianStep16 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
        self.healthRiskAssessmentModel.SC_DRUGPHY = iPreferToDiscussWithThePhysicianStep16 ? "Y" : "N"
    }
    //End Step 16
    
    //Start Step 17
    @IBAction func yesAreYouSexuallyActiveStep17Action(_ sender: UIButton)
    {
        yesAreYouSexuallyActiveStep17.image = UIImage.init(named: "radioBtn-checked")
        noAreYouSexuallyActiveStep17.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_SEX != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            
            self.yesTryPregnancyStep17.image = UIImage.init(named: "radioBtn")
            self.noTryPregnancyStep17.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SC_SEXPREG = ""
            
            self.yesAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn")
            self.noAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SC_SEXDISCOM = ""
            
            self.txtListContraceptiveStep17.text = ""
            self.viewListContraceptiveStep17.isHidden = true
            self.viewHeightConstraintListContraceptiveStep17.constant = 0
        }
        self.healthRiskAssessmentModel.SC_SEX = "Y"
        
        self.viewTryPregnancyStep17.isHidden = false
        self.viewHeightConstraintTryPregnancyStep17.constant = 60
        
        self.viewAnyDiscomfortWithIntercourseStep17.isHidden = false
        self.viewHeightConstraintAnyDiscomfortWithIntercourseStep17.constant = 60
    }
    
    @IBAction func noAreYouSexuallyActiveStep17Action(_ sender: UIButton)
    {
        yesAreYouSexuallyActiveStep17.image = UIImage.init(named: "radioBtn")
        noAreYouSexuallyActiveStep17.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_SEX != "N" && self.healthRiskAssessmentModel.SC_SEX != ""{
            self.heightView -= 120
            if self.healthRiskAssessmentModel.SC_SEXPREG == "N"{
                self.heightView -= 80
            }
            self.heightConstraintContentStepView.constant = self.heightView
            self.yesTryPregnancyStep17.image = UIImage.init(named: "radioBtn")
            self.noTryPregnancyStep17.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SC_SEXPREG = ""
            self.viewTryPregnancyStep17.isHidden = true
            self.viewHeightConstraintTryPregnancyStep17.constant = 0
            
            self.txtListContraceptiveStep17.text = ""
            self.viewListContraceptiveStep17.isHidden = true
            self.viewHeightConstraintListContraceptiveStep17.constant = 0
            
            self.yesAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn")
            self.noAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn")
            self.healthRiskAssessmentModel.SC_SEXDISCOM = ""
            self.viewAnyDiscomfortWithIntercourseStep17.isHidden = true
            self.viewHeightConstraintAnyDiscomfortWithIntercourseStep17.constant = 0
        }
        self.healthRiskAssessmentModel.SC_SEX = "N"
    }
    
    @IBAction func yesTryPregnancyStep17Action(_ sender: UIButton)
    {
        yesTryPregnancyStep17.image = UIImage.init(named: "radioBtn-checked")
        noTryPregnancyStep17.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_SEXPREG != "Y" && self.healthRiskAssessmentModel.SC_SEXPREG != ""{
            self.heightView -= 80
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtListContraceptiveStep17.text = ""
            self.viewListContraceptiveStep17.isHidden = true
            self.viewHeightConstraintListContraceptiveStep17.constant = 0
        }
        self.healthRiskAssessmentModel.SC_SEXPREG = "Y"
    }
    
    @IBAction func noTryPregnancyStep17Action(_ sender: UIButton)
    {
        yesTryPregnancyStep17.image = UIImage.init(named: "radioBtn")
        noTryPregnancyStep17.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_SEXPREG != "N"{
            self.heightView += 80
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtListContraceptiveStep17.text = ""
            self.viewListContraceptiveStep17.isHidden = false
            self.viewHeightConstraintListContraceptiveStep17.constant = 80
        }
        self.healthRiskAssessmentModel.SC_SEXPREG = "N"
    }
    
    @IBAction func yesAnyDiscomfortWithIntercourseStep17Action(_ sender: UIButton)
    {
        yesAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn-checked")
        noAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_SEXDISCOM = "Y"
    }
    
    @IBAction func noAnyDiscomfortWithIntercourseStep17Action(_ sender: UIButton)
    {
        yesAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn")
        noAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_SEXDISCOM = "N"
    }
    
    @IBAction func yesWouldYouLikeToSpeakStep17Action(_ sender: UIButton)
    {
        yesWouldYouLikeToSpeakStep17.image = UIImage.init(named: "radioBtn-checked")
        noWouldYouLikeToSpeakStep17.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_SEXILLNESSPHY = "Y"
    }
    
    @IBAction func noWouldYouLikeToSpeakStep17Action(_ sender: UIButton)
    {
        yesWouldYouLikeToSpeakStep17.image = UIImage.init(named: "radioBtn")
        noWouldYouLikeToSpeakStep17.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_SEXILLNESSPHY = "N"
    }
    //End Step 17
    
    //Start Step 18
    @IBAction func yesIsStressAmajorProblemForYouStep18Action(_ sender: UIButton)
    {
        YesIsStressAmajorProblemForYouStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoIsStressAmajorProblemForYouStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALSTRESS = "Y"
    }
    
    @IBAction func noIsStressAmajorProblemForYouStep18Action(_ sender: UIButton)
    {
        YesIsStressAmajorProblemForYouStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoIsStressAmajorProblemForYouStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALSTRESS = "N"
    }

    @IBAction func yesDoYouFeelDepressedStep18Action(_ sender: UIButton)
    {
        YesDoYouFeelDepressedStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoDoYouFeelDepressedStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALDEPRESS = "Y"
    }
    
    @IBAction func noDoYouFeelDepressedStep18Action(_ sender: UIButton)
    {
        YesDoYouFeelDepressedStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoDoYouFeelDepressedStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALDEPRESS = "N"
    }
    
    @IBAction func yesDoYouPanicStep18Action(_ sender: UIButton)
    {
        YesDoYouPanicStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoDoYouPanicStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALPANIC = "Y"
    }
    
    @IBAction func noDoYouPanicStep18Action(_ sender: UIButton)
    {
        YesDoYouPanicStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoDoYouPanicStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALPANIC = "N"
    }
    
    @IBAction func yesProblemsWithEatingStep18Action(_ sender: UIButton)
    {
        YesProblemsWithEatingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoProblemsWithEatingStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALEAT = "Y"
    }
    
    @IBAction func noProblemsWithEatingStep18Action(_ sender: UIButton)
    {
        YesProblemsWithEatingStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoProblemsWithEatingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALEAT = "N"
    }
    
    @IBAction func yesCryFrequentlyStep18Action(_ sender: UIButton)
    {
        YesCryFrequentlyStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoCryFrequentlyStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALCRY = "Y"
    }
    
    @IBAction func noCryFrequentlyStep18Action(_ sender: UIButton)
    {
        YesCryFrequentlyStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoCryFrequentlyStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALCRY = "N"
    }
    
    @IBAction func yesAttemptedSuicideStep18Action(_ sender: UIButton)
    {
        YesAttemptedSuicideStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoAttemptedSuicideStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALSUICIDE = "Y"
    }
    
    @IBAction func noAttemptedSuicideStep18Action(_ sender: UIButton)
    {
        YesAttemptedSuicideStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoAttemptedSuicideStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALSUICIDE = "N"
    }
    
    @IBAction func yesTroubleSleepingStep18Action(_ sender: UIButton)
    {
        YesTroubleSleepingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoTroubleSleepingStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALSLEEP = "Y"
    }
    
    @IBAction func noTroubleSleepingStep18Action(_ sender: UIButton)
    {
        YesTroubleSleepingStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoTroubleSleepingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALSLEEP = "N"
    }
    
    @IBAction func yesBeenToCounselorStep18Action(_ sender: UIButton)
    {
        YesBeenToCounselorStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        NoBeenToCounselorStep18ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_MENTALCOUNSEL = "Y"
    }
    
    @IBAction func noBeenToCounselorStep18Action(_ sender: UIButton)
    {
        YesBeenToCounselorStep18ImgView.image = UIImage.init(named: "radioBtn")
        NoBeenToCounselorStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_MENTALCOUNSEL = "N"
    }
    //End Step 18
    
    //Start Step 19
    @IBAction func yesDoYouLiveAloneStep19Step19Action(_ sender: UIButton)
    {
        yesDoYouLiveAloneStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDoYouLiveAloneStep19Step19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYALONE = "Y"
    }
    
    @IBAction func noDoYouLiveAloneStep19Step19Action(_ sender: UIButton)
    {
        yesDoYouLiveAloneStep19ImgView.image = UIImage.init(named: "radioBtn")
        noDoYouLiveAloneStep19Step19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYALONE = "N"
    }
    
    @IBAction func yesDoYouHaveFrequentFallsStep19Step19Action(_ sender: UIButton)
    {
        yesDoYouHaveFrequentFallsStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDoYouHaveFrequentFallsStep19Step19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYFALL = "Y"
    }
    
    @IBAction func noDoYouHaveFrequentFallsStep19Step19Action(_ sender: UIButton)
    {
        yesDoYouHaveFrequentFallsStep19ImgView.image = UIImage.init(named: "radioBtn")
        noDoYouHaveFrequentFallsStep19Step19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYFALL = "N"
    }
    
    @IBAction func yesVisionOrHearingLoss19Step19Action(_ sender: UIButton)
    {
        yesVisionOrHearingLossStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        noVisionOrHearingLoss19Step19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYVISION = "Y"
    }
    
    @IBAction func noVisionOrHearingLoss19Step19Action(_ sender: UIButton)
    {
        yesVisionOrHearingLossStep19ImgView.image = UIImage.init(named: "radioBtn")
        noVisionOrHearingLoss19Step19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYVISION = "N"
    }
    
    @IBAction func yesWouldYouLikeToDiscussStep19Action(_ sender: UIButton) {
        yesWouldYouLikeToDiscussStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        noWouldYouLikeToDiscussStep19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYABUSE = "Y"
    }
    
    @IBAction func noWouldYouLikeToDiscussStep19Action(_ sender: UIButton) {
        yesWouldYouLikeToDiscussStep19ImgView.image = UIImage.init(named: "radioBtn")
        noWouldYouLikeToDiscussStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYABUSE = "N"
    }
    
    @IBAction func yesSunburnStep19Action(_ sender: UIButton)
    {
        yesSunburnStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        noSunburnStep19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYSUNBURN = "Y"
    }
    
    @IBAction func noSunburnStep19Action(_ sender: UIButton)
    {
        yesSunburnStep19ImgView.image = UIImage.init(named: "radioBtn")
        noSunburnStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYSUNBURN = "N"
    }
    
    @IBAction func occasionallySunExposureStep19Action(_ sender: UIButton)
    {
        occasionallySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        frequentlySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn")
        rarelySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYSUNEXP = "OCCASIONALLY"
    }
    
    @IBAction func frequentlySunExposureStep19Action(_ sender: UIButton)
    {
        occasionallySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn")
        frequentlySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        rarelySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYSUNEXP = "FREQUENTLY"
    }
    
    @IBAction func rarelySunExposureStep19Action(_ sender: UIButton)
    {
        occasionallySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn")
        frequentlySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn")
        rarelySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYSUNEXP = "RARELY"
    }
    
    @IBAction func occasionallySeatbeltStep19Action(_ sender: UIButton)
    {
        occasionallySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        frequentlySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn")
        rarelySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYSEATBLT = "OCCASIONALLY"
    }
    
    @IBAction func frequentlySeatbeltStep19Action(_ sender: UIButton)
    {
        occasionallySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn")
        frequentlySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        rarelySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_PSAFETYSEATBLT = "FREQUENTLY"
    }
    
    @IBAction func rarelySeatbeltStep19Action(_ sender: UIButton)
    {
        occasionallySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn")
        frequentlySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn")
        rarelySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_PSAFETYSEATBLT = "ALWAYS"
    }
    //End Step 19
    
    //Start Step 20
    @IBAction func btnDateOfLastMenstruationStep20Action(_ sender: Any) {
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtDateOfLastMenstruationStep20.text = dateFormatter.string(from: dt)
            }
        }
    }

    @IBAction func yesHeavyperiodsStep20Action(_ sender: UIButton)
    {
        yesHeavyperiodsStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHeavyperiodsStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_HEAVYPERIODS = "Y"
    }
    
    @IBAction func noHeavyperiodsStep20Action(_ sender: UIButton)
    {
        yesHeavyperiodsStep20ImgView.image = UIImage.init(named: "radioBtn")
        noHeavyperiodsStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_HEAVYPERIODS = "N"
    }
    
    @IBAction func yesPregnantOrBreastfeedingStep20Action(_ sender: UIButton)
    {
        yesPregnantOrBreastfeedingStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noPregnantOrBreastfeedingStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_PREGBRFEED = "Y"
    }
    
    @IBAction func noPregnantOrBreastfeedingStep20Action(_ sender: UIButton)
    {
        yesPregnantOrBreastfeedingStep20ImgView.image = UIImage.init(named: "radioBtn")
        noPregnantOrBreastfeedingStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_PREGBRFEED = "N"
    }
    
    @IBAction func yesAnyUrinaryTractBladderKidneyStep20Action(_ sender: UIButton)
    {
        yesAnyUrinaryTractBladderKidneyStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAnyUrinaryTractBladderKidneyStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_INFECTION = "Y"
    }
    
    @IBAction func noAnyUrinaryTractBladderKidneyStep20Action(_ sender: UIButton)
    {
        yesAnyUrinaryTractBladderKidneyStep20ImgView.image = UIImage.init(named: "radioBtn")
        noAnyUrinaryTractBladderKidneyStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_INFECTION = "N"
    }
    
    @IBAction func yesDCHysterectomyCesareanStep20Action(_ sender: UIButton)
    {
        yesDCHysterectomyCesareanStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDCHysterectomyCesareanStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_CESAREAN = "Y"
    }
    
    @IBAction func noDCHysterectomyCesareanStep20Action(_ sender: UIButton)
    {
        yesDCHysterectomyCesareanStep20ImgView.image = UIImage.init(named: "radioBtn")
        noDCHysterectomyCesareanStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_CESAREAN = "N"
    }
    
    @IBAction func yesUrinationStep20Action(_ sender: UIButton)
    {
        yesUrinationStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noUrinationStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_PROC = "Y"
    }
    
    @IBAction func noUrinationStep20Action(_ sender: UIButton)
    {
        yesUrinationStep20ImgView.image = UIImage.init(named: "radioBtn")
        noUrinationStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_PROC = "N"
    }
    
    @IBAction func yesBloodInUrineStep20Action(_ sender: UIButton)
    {
        yesBloodInUrineStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noBloodInUrineStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_URINEBLOOD = "Y"
    }
    
    @IBAction func noBloodInUrineStep20Action(_ sender: UIButton)
    {
        yesBloodInUrineStep20ImgView.image = UIImage.init(named: "radioBtn")
        noBloodInUrineStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_URINEBLOOD = "N"
    }
    
    @IBAction func yesHotFlashesSweatingAtNightStep20Action(_ sender: UIButton)
    {
        yesHotFlashesSweatingAtNightStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHotFlashesSweatingAtNightStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_FLASHSWEAT = "Y"
    }
    
    @IBAction func noHotFlashesSweatingAtNightStep20Action(_ sender: UIButton)
    {
        yesHotFlashesSweatingAtNightStep20ImgView.image = UIImage.init(named: "radioBtn")
        noHotFlashesSweatingAtNightStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_FLASHSWEAT = "N"
    }
    
    @IBAction func yesMenstrualTensionPainBloatingIrritabilityOtherStep20Action(_ sender: UIButton)
    {
        yesMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_MENSTSYMPTOM = "Y"
    }
    
    @IBAction func noMenstrualTensionPainBloatingIrritabilityOtherStep20Action(_ sender: UIButton)
    {
        yesMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView.image = UIImage.init(named: "radioBtn")
        noMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_MENSTSYMPTOM = "N"
    }
    
    @IBAction func yesPerformMonthlyBreastStep20Action(_ sender: UIButton)
    {
        yesPerformMonthlyBreastStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noPerformMonthlyBreastStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_BREASTSELFEXM = "Y"
    }
    
    @IBAction func noPerformMonthlyBreastStep20Action(_ sender: UIButton)
    {
        yesPerformMonthlyBreastStep20ImgView.image = UIImage.init(named: "radioBtn")
        noPerformMonthlyBreastStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_BREASTSELFEXM = "N"
    }
    
    @IBAction func yesExperiencedAnyRecentBreastTendernessStep20Action(_ sender: UIButton)
    {
        yesExperiencedAnyRecentBreastTendernessStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        noExperiencedAnyRecentBreastTendernessStep20ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.WH_BREASTSYMPTOM = "Y"
    }
    
    @IBAction func noExperiencedAnyRecentBreastTendernessStep20Action(_ sender: UIButton)
    {
        yesExperiencedAnyRecentBreastTendernessStep20ImgView.image = UIImage.init(named: "radioBtn")
        noExperiencedAnyRecentBreastTendernessStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.WH_BREASTSYMPTOM = "N"
    }
    
    @IBAction func btnDateOfLastPapSmearPelvicStep20Action(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done",maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtDateOfLastPapSmearPelvicStep20.text = dateFormatter.string(from: dt)
            }
        }
    }
    //End Step 20
    
    //Start Step 21
    @IBAction func yesToUrinateStep21Action(_ sender: UIButton)
    {
        yesToUrinateStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noToUrinateStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_URINATE = "Y"
    }
    
    @IBAction func noToUrinateStep21Action(_ sender: UIButton)
    {
        yesToUrinateStep21ImgView.image = UIImage.init(named: "radioBtn")
        noToUrinateStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_URINATE = "N"
    }
    
    @IBAction func yesUrineBurnStep21Action(_ sender: UIButton)
    {
        yesUrineBurnStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noUrineBurnStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_URINATEBURN = "Y"
    }
    
    @IBAction func noUrineBurnStep21Action(_ sender: UIButton)
    {
        yesUrineBurnStep21ImgView.image = UIImage.init(named: "radioBtn")
        noUrineBurnStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_URINATEBURN = "N"
    }
    
    @IBAction func yesBloodInUrineStep21Action(_ sender: UIButton)
    {
        yesBloodInUrineStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noBloodInUrineStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_URINATEBLOOD = "Y"
    }
    
    @IBAction func noBloodInUrineStep21Action(_ sender: UIButton)
    {
        yesBloodInUrineStep21ImgView.image = UIImage.init(named: "radioBtn")
        noBloodInUrineStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_URINATEBLOOD = "N"
    }
    
    @IBAction func yesBurningDischargePenisStep21Action(_ sender: UIButton)
    {
        yesBurningDischargePenisStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noBurningDischargePenisStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_URINATEDISCHARGE = "Y"
    }
    
    @IBAction func noBurningDischargePenisStep21Action(_ sender: UIButton)
    {
        yesBurningDischargePenisStep21ImgView.image = UIImage.init(named: "radioBtn")
        noBurningDischargePenisStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_URINATEDISCHARGE = "N"
    }

    @IBAction func yesUrinationDecreasedStep21Action(_ sender: UIButton)
    {
        yesUrinationDecreasedStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noUrinationDecreasedStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_URINATEFORCE = "Y"
    }
    
    @IBAction func noUrinationDecreasedStep21Action(_ sender: UIButton)
    {
        yesUrinationDecreasedStep21ImgView.image = UIImage.init(named: "radioBtn")
        noUrinationDecreasedStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_URINATEFORCE = "N"
    }

    @IBAction func yesAnyKidneyBladderProstrateInfectionsStep21Action(_ sender: UIButton)
    {
        yesAnyKidneyBladderProstrateInfectionsStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAnyKidneyBladderProstrateInfectionsStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_KDBLDPROSINF = "Y"
    }
    
    @IBAction func noAnyKidneyBladderProstrateInfectionsStep21Action(_ sender: UIButton)
    {
        yesAnyKidneyBladderProstrateInfectionsStep21ImgView.image = UIImage.init(named: "radioBtn")
        noAnyKidneyBladderProstrateInfectionsStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_KDBLDPROSINF = "N"
    }
    
    @IBAction func yesAnyProblemsEmptyingBladderCompletelyStep21Action(_ sender: UIButton)
    {
        yesAnyProblemsEmptyingBladderCompletelyStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAnyProblemsEmptyingBladderCompletelyStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_EMPTYBLADDER = "Y"
    }
    
    @IBAction func noAnyProblemsEmptyingBladderCompletelyStep21Action(_ sender: UIButton)
    {
        yesAnyProblemsEmptyingBladderCompletelyStep21ImgView.image = UIImage.init(named: "radioBtn")
        noAnyProblemsEmptyingBladderCompletelyStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_EMPTYBLADDER = "N"
    }
    
    @IBAction func yesDifficultyErectionEjaculationStep21Action(_ sender: UIButton)
    {
        yesDifficultyErectionEjaculationStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        nDifficultyErectionEjaculationStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_ERECTION = "Y"
    }
    
    @IBAction func noDifficultyErectionEjaculationStep21Action(_ sender: UIButton)
    {
        yesDifficultyErectionEjaculationStep21ImgView.image = UIImage.init(named: "radioBtn")
        nDifficultyErectionEjaculationStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_ERECTION = "N"
    }

    @IBAction func yesTesticlePainSwellingStep21Action(_ sender: UIButton)
    {
        yesTesticlePainSwellingStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        noTesticlePainSwellingStep21ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.MH_TESTICLEPN = "Y"
    }
    
    @IBAction func noTesticlePainSwellingStep21Action(_ sender: UIButton)
    {
        yesTesticlePainSwellingStep21ImgView.image = UIImage.init(named: "radioBtn")
        noTesticlePainSwellingStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.MH_TESTICLEPN = "N"
    }
    
    @IBAction func btnDateLastProstateRectalExamStep21Action(_ sender: Any) {
        self.view.endEditing(true)
        let title = "Select Date"
        DatePickerDialog(locale: Locale(identifier: "en_GB")).show(title, doneButtonTitle: "Done", maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.txtDateLastProstateRectalExamStep21.text = dateFormatter.string(from: dt)
            }
        }
    }
    //End Step 21
    
    //Start Step 22
    @IBAction func yesDiabetesStep22Action(_ sender: UIButton)
    {
        yesDiabetesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        noDiabetesStep22ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.DIABETES_MELLITUS != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtShareMedicationDetailsStep22.text = ""
            self.viewShareMedication1Step22.isHidden = false
            self.viewHeightConstraintShareMedication1Step22.constant = 80
            self.txtSinceWhenStep22.text = ""
            self.viewSinceWhen1Step22.isHidden = false
            self.viewHeightConstraintSinceWhen1Step22.constant = 60
        }
        self.healthRiskAssessmentModel.DIABETES_MELLITUS = "Y"
    }
    
    @IBAction func noDiabetesStep22Action(_ sender: UIButton)
    {
        yesDiabetesStep22ImgView.image = UIImage.init(named: "radioBtn")
        noDiabetesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.DIABETES_MELLITUS != "N" && self.healthRiskAssessmentModel.DIABETES_MELLITUS != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtShareMedicationDetailsStep22.text = ""
            self.viewShareMedication1Step22.isHidden = true
            self.viewHeightConstraintShareMedication1Step22.constant = 0
            self.txtSinceWhenStep22.text = ""
            self.viewSinceWhen1Step22.isHidden = true
            self.viewHeightConstraintSinceWhen1Step22.constant = 0
        }
        self.healthRiskAssessmentModel.DIABETES_MELLITUS = "N"
    }
    
    @IBAction func yesHypertensionStep22Action(_ sender: UIButton)
    {
        yesHypertensionStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        noHypertensionStep22ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.HYPERTENSION != "Y"{
            self.heightView += 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtShareMedicationDetails2Step22.text = ""
            self.viewShareMedication2Step22.isHidden = false
            self.viewHeightConstraintShareMedication2Step22.constant = 80
            self.txtSinceWhen2Step22.text = ""
            self.viewSinceWhen2Step22.isHidden = false
            self.viewHeightConstraintSinceWhen2Step22.constant = 60
        }
        self.healthRiskAssessmentModel.HYPERTENSION = "Y"
    }
    
    @IBAction func noHypertensionStep22Action(_ sender: UIButton)
    {
        yesHypertensionStep22ImgView.image = UIImage.init(named: "radioBtn")
        noHypertensionStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.HYPERTENSION != "N" && self.healthRiskAssessmentModel.HYPERTENSION != ""{
            self.heightView -= 120
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtShareMedicationDetails2Step22.text = ""
            self.viewShareMedication2Step22.isHidden = true
            self.viewHeightConstraintShareMedication2Step22.constant = 0
            self.txtSinceWhen2Step22.text = ""
            self.viewSinceWhen2Step22.isHidden = true
            self.viewHeightConstraintSinceWhen2Step22.constant = 0
        }
        self.healthRiskAssessmentModel.HYPERTENSION = "N"
    }
    
    @IBAction func yesAdvancedDirectivesStep22Action(_ sender: UIButton)
    {
        yesAdvancedDirectivesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        noAdvancedDirectivesStep22ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_AD != "Y" && self.healthRiskAssessmentModel.SC_AD != ""{
            self.heightView -= 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.SC_ADDETAILS = ""
            yesLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn")
            noLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn")
            self.viewLikeAdditionalStep22.isHidden = true
            self.viewHeightConstraintLikeAdditionalStep22.constant = 0
        }
        self.healthRiskAssessmentModel.SC_AD = "Y"
    }
    
    @IBAction func noAdvancedDirectivesStep22Action(_ sender: UIButton)
    {
        yesAdvancedDirectivesStep22ImgView.image = UIImage.init(named: "radioBtn")
        noAdvancedDirectivesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_AD != "N"{
            self.heightView += 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.healthRiskAssessmentModel.SC_ADDETAILS = ""
            yesLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn")
            noLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn")
            self.viewLikeAdditionalStep22.isHidden = false
            self.viewHeightConstraintLikeAdditionalStep22.constant = 60
        }
        self.healthRiskAssessmentModel.SC_AD = "N"
    }
    
    @IBAction func yesLikeAdditionalDetailsStep22Action(_ sender: UIButton)
    {
        yesLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        noLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn")
        self.healthRiskAssessmentModel.SC_ADDETAILS = "Y"
    }
    
    @IBAction func noLikeAdditionalDetailsStep22Action(_ sender: UIButton)
    {
        yesLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn")
        noLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        self.healthRiskAssessmentModel.SC_ADDETAILS = "N"
    }
    
    @IBAction func yesReligiousCulturalBeliefsImpactHealthcareStep22Action(_ sender: UIButton)
    {
        yesReligiousCulturalBeliefsImpactHealthcareStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        noReligiousCulturalBeliefsImpactHealthcareStep22ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_RELIGIONBELIEF != "Y"{
            self.heightView += 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtDescribeStep22.text = ""
            self.viewDescribeStep22.isHidden = false
            self.viewHeightConstraintDescribeStep22.constant = 60
        }
        self.healthRiskAssessmentModel.SC_RELIGIONBELIEF = "Y"
    }
    
    @IBAction func noReligiousCulturalBeliefsImpactHealthcareStep22Action(_ sender: UIButton)
    {
        yesReligiousCulturalBeliefsImpactHealthcareStep22ImgView.image = UIImage.init(named: "radioBtn")
        noReligiousCulturalBeliefsImpactHealthcareStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_RELIGIONBELIEF != "N" && self.healthRiskAssessmentModel.SC_RELIGIONBELIEF != ""{
            self.heightView -= 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtDescribeStep22.text = ""
            self.viewDescribeStep22.isHidden = true
            self.viewHeightConstraintDescribeStep22.constant = 0
        }
        self.healthRiskAssessmentModel.SC_RELIGIONBELIEF = "N"
    }
    

    @IBAction func btnVerbalInstructionsStep22Action(_ sender: UIButton) {
        chkVerbalInstructionsStep22 = !chkVerbalInstructionsStep22
        chkVerbalInstructionsStep22ImgView.image = chkVerbalInstructionsStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }
    
    @IBAction func btnWrittenInstructionsStep22Action(_ sender: UIButton) {
        chkWrittenInstructionsStep22 = !chkWrittenInstructionsStep22
        chkWrittenInstructionsStep22ImgView.image = chkWrittenInstructionsStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }

    @IBAction func btnPicturesStep22Action(_ sender: UIButton) {
        chkPicturesStep22 = !chkPicturesStep22
        chkPicturesStep22ImgView.image = chkPicturesStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }
    
    @IBAction func btnLessThanHighSchoolStep22Action(_ sender: UIButton) {
        chkLessThanHighSchoolStep22 = !chkLessThanHighSchoolStep22
        chkLessThanHighSchoolStep22ImgView.image = chkLessThanHighSchoolStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }

    @IBAction func btnHighSchoolOrGEDStep22Action(_ sender: UIButton) {
        chkHighSchoolOrGEDStep22 = !chkHighSchoolOrGEDStep22
        chkHighSchoolOrGEDStep22ImgView.image = chkHighSchoolOrGEDStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }
    
    @IBAction func btn1_4YearsStep22Action(_ sender: UIButton) {
        chk1_4YearsStep22 = !chk1_4YearsStep22
        chk1_4YearsStep22ImgView.image = chk1_4YearsStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }
    
    @IBAction func btn4YearsStep22Action(_ sender: UIButton) {
        chk4YearsStep22 = !chk4YearsStep22
        chk4YearsStep22ImgView.image = chk4YearsStep22 ? UIImage(named: "checkbox_active") : UIImage(named: "checkbox")
    }
    
    @IBAction func yesUnderstandEnglishWellStep22Action(_ sender: UIButton)
    {
        yesUnderstandEnglishWellStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        noUnderstandEnglishWellStep22ImgView.image = UIImage.init(named: "radioBtn")
        if self.healthRiskAssessmentModel.SC_ENGLISH != "Y"{
            self.heightView -= 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtPreferLanguageStep22.text = ""
            self.viewPreferLanguageStep22.isHidden = true
            self.viewHeightConstraintPreferLanguageStep22.constant = 0
        }
        self.healthRiskAssessmentModel.SC_ENGLISH = "Y"
    }
    
    @IBAction func noUnderstandEnglishWellStep22Action(_ sender: UIButton)
    {
        yesUnderstandEnglishWellStep22ImgView.image = UIImage.init(named: "radioBtn")
        noUnderstandEnglishWellStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
        if self.healthRiskAssessmentModel.SC_ENGLISH != "N" {
            self.heightView += 60
            self.heightConstraintContentStepView.constant = self.heightView
            self.txtPreferLanguageStep22.text = ""
            self.viewPreferLanguageStep22.isHidden = false
            self.viewHeightConstraintPreferLanguageStep22.constant = 60
        }
        self.healthRiskAssessmentModel.SC_ENGLISH = "N"
    }
    //End Step 22
    
    //Start Step 23
    @IBAction func chkFeverStep23Action(_ sender: UIButton) {
        chkFeverStep23 = !chkFeverStep23
        chkFeverStep23ImgView.image = chkFeverStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkConvulsionsSeizuresStep23Action(_ sender: UIButton) {
        chkConvulsionsSeizuresStep23 = !chkConvulsionsSeizuresStep23
        chkConvulsionsSeizuresStep23ImgView.image = chkConvulsionsSeizuresStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkChillsStep23Action(_ sender: UIButton) {
        chkChillsStep23 = !chkChillsStep23
        chkChillsStep23ImgView.image = chkChillsStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkSuicidalStep23Action(_ sender: UIButton) {
        chkSuicidalStep23 = !chkSuicidalStep23
        chkSuicidalStep23ImgView.image = chkSuicidalStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkEyePainStep23Action(_ sender: UIButton) {
        chkEyePainStep23 = !chkEyePainStep23
        chkEyePainStep23ImgView.image = chkEyePainStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkSleepDisturbancesStep23Action(_ sender: UIButton) {
        chkSleepDisturbancesStep23 = !chkSleepDisturbancesStep23
        chkSleepDisturbancesStep23ImgView.image = chkSleepDisturbancesStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkRedEyesStep23Action(_ sender: UIButton) {
        chkRedEyesStep23 = !chkRedEyesStep23
        chkRedEyesStep23ImgView.image = chkRedEyesStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkDecreasedLibidoSexualDesireStep23Action(_ sender: UIButton) {
        chkDecreasedLibidoSexualDesireStep23 = !chkDecreasedLibidoSexualDesireStep23
        chkDecreasedLibidoSexualDesireStep23ImgView.image = chkDecreasedLibidoSexualDesireStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkEaracheStep23Action(_ sender: UIButton) {
        chkEaracheStep23 = !chkEaracheStep23
        chkEaracheStep23ImgView.image = chkEaracheStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkEasyBleedingBruisingStep23Action(_ sender: UIButton) {
        chkEasyBleedingBruisingStep23 = !chkEasyBleedingBruisingStep23
        chkEasyBleedingBruisingStep23ImgView.image = chkEasyBleedingBruisingStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkChestPainStep23Action(_ sender: UIButton) {
        chkChestPainStep23 = !chkChestPainStep23
        chkChestPainStep23ImgView.image = chkChestPainStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkFeelingPoorlyStep23Action(_ sender: UIButton) {
        chkFeelingPoorlyStep23 = !chkFeelingPoorlyStep23
        chkFeelingPoorlyStep23ImgView.image = chkFeelingPoorlyStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkPalpitationsStep23Action(_ sender: UIButton) {
        chkPalpitationsStep23 = !chkPalpitationsStep23
        chkPalpitationsStep23ImgView.image = chkPalpitationsStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkFeelingTiredFatiguedStep23Action(_ sender: UIButton) {
        chkFeelingTiredFatiguedStep23 = !chkFeelingTiredFatiguedStep23
        chkFeelingTiredFatiguedStep23ImgView.image = chkFeelingTiredFatiguedStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkShortnessBreathStep23Action(_ sender: UIButton) {
        chkShortnessBreathStep23 = !chkShortnessBreathStep23
        chkShortnessBreathStep23ImgView.image = chkShortnessBreathStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkEyesightProblemsStep23Action(_ sender: UIButton) {
        chkEyesightProblemsStep23 = !chkEyesightProblemsStep23
        chkEyesightProblemsStep23ImgView.image = chkEyesightProblemsStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkWheezingStep23Action(_ sender: UIButton) {
        chkWheezingStep23 = !chkWheezingStep23
        chkWheezingStep23ImgView.image = chkWheezingStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkDischargeEyesStep23Action(_ sender: UIButton) {
        chkDischargeEyesStep23 = !chkDischargeEyesStep23
        chkDischargeEyesStep23ImgView.image = chkDischargeEyesStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkAbdominalPainStep23Action(_ sender: UIButton) {
        chkAbdominalPainStep23 = !chkAbdominalPainStep23
        chkAbdominalPainStep23ImgView.image = chkAbdominalPainStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkNosebleedsStep23Action(_ sender: UIButton) {
        chkNosebleedsStep23 = !chkNosebleedsStep23
        chkNosebleedsStep23ImgView.image = chkNosebleedsStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkVomitingStep23Action(_ sender: UIButton) {
        chkVomitingStep23 = !chkVomitingStep23
        chkVomitingStep23ImgView.image = chkVomitingStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkDischargeNoseStep23Action(_ sender: UIButton) {
        chkDischargeNoseStep23 = !chkDischargeNoseStep23
        chkDischargeNoseStep23ImgView.image = chkDischargeNoseStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkPainUrinationStep23Action(_ sender: UIButton) {
        chkPainUrinationStep23 = !chkPainUrinationStep23
        chkPainUrinationStep23ImgView.image = chkPainUrinationStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkFastSlowHeartbeatStep23Action(_ sender: UIButton) {
        chkFastSlowHeartbeatStep23 = !chkFastSlowHeartbeatStep23
        chkFastSlowHeartbeatStep23ImgView.image = chkFastSlowHeartbeatStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }

    @IBAction func chkUrinaryIncontinenceStep23Action(_ sender: UIButton) {
        chkUrinaryIncontinenceStep23 = !chkUrinaryIncontinenceStep23
        chkUrinaryIncontinenceStep23ImgView.image = chkUrinaryIncontinenceStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkColdHandsFeetStep23Action(_ sender: UIButton) {
        chkColdHandsFeetStep23 = !chkColdHandsFeetStep23
        chkColdHandsFeetStep23ImgView.image = chkColdHandsFeetStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkMuscleJointPainStep23Action(_ sender: UIButton) {
        chkMuscleJointPainStep23 = !chkMuscleJointPainStep23
        chkMuscleJointPainStep23ImgView.image = chkMuscleJointPainStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkCoughStep23Action(_ sender: UIButton) {
        chkCoughStep23 = !chkCoughStep23
        chkCoughStep23ImgView.image = chkCoughStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkSkinLesionsStep23Action(_ sender: UIButton) {
        chkSkinLesionsStep23 = !chkSkinLesionsStep23
        chkSkinLesionsStep23ImgView.image = chkSkinLesionsStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkShortnessBreathActivityStep23Action(_ sender: UIButton) {
        chkShortnessBreathActivityStep23 = !chkShortnessBreathActivityStep23
        chkShortnessBreathActivityStep23ImgView.image = chkShortnessBreathActivityStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func chkSkinWoundStep23Action(_ sender: UIButton) {
        chkSkinWoundStep23 = !chkSkinWoundStep23
        chkSkinWoundStep23ImgView.image = chkSkinWoundStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func ConstipationStep23Action(_ sender: UIButton) {
        chkConstipationStep23 = !chkConstipationStep23
        chkConstipationStep23ImgView.image = chkConstipationStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func ConfusionStep23Action(_ sender: UIButton) {
        chkConfusionStep23 = !chkConfusionStep23
        chkConfusionStep23ImgView.image = chkConfusionStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    
    @IBAction func DiarrheaStep23Action(_ sender: UIButton) {
        chkDiarrheaStep23 = !chkDiarrheaStep23
        chkDiarrheaStep23ImgView.image = chkDiarrheaStep23 ?
        UIImage.init(named: "checkbox_active") :
        UIImage.init(named: "checkbox")
    }
    //End Step 23
    
    // MARK: - Navigation
     @IBAction func btnHomeViewAction(_ sender: Any) {
         self.navigationController?.popToRootViewController(animated: true)
     }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        if stepNumber > 1{
            stepNumberDisplay = stepNumberDisplay - 1
            stepNumber = stepNumber - 1
            if (self.stepNumber == 20 &&
                (self.healthRiskAssessmentModel.GENDER == "Male" || self.healthRiskAssessmentModel.GENDER == self.male)){
                stepNumber = stepNumber - 1
            }else if (self.stepNumber == 21 &&
                (self.healthRiskAssessmentModel.GENDER == "Female" || self.healthRiskAssessmentModel.GENDER == self.female)){
                stepNumber = stepNumber - 1
            }
            controlStep()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
     }
    
    @IBAction func btnNext(_ sender: UIButton) {
        if(stepNumber >= 24){
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is DependentViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }else if stepNumber > 0 && stepNumber < 24{
            getDataStepByStep()
            if stepNumber == 1 && healthRiskAssessmentModel.HRAID == "" {
                if validateInput() {
                    serviceCallAdd()
                }
            }else{
                serviceCallUpdateStepByStep()
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        stepNumber = stepNumber - 1
        stepNumberDisplay = stepNumberDisplay - 1
        if stepNumber == 20 && self.healthRiskAssessmentModel.GENDER == "Male"{
            stepNumber = stepNumber - 1
        }else  if stepNumber == 21 && self.healthRiskAssessmentModel.GENDER == "Female"{
            stepNumber = stepNumber - 1
        }
        controlStep()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is DependentViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }

    func setDataStepByStep(data: HealthRiskAssessmentModel) {
        if stepNumber == 1{
            //Step 1
            txtName.text = data.PATIENTNM
            if data.GENDER == "M"{
                txtGender.text = self.male
            }else  if data.GENDER == "F"{
                txtGender.text = self.female
            }else{
                txtGender.text = data.GENDER
            }
            txtDOBDate.text = data.DOB
            if(data.DOB != ""){
                
                txtAge.text = String(getAgeFromBirthday(strBirthday: data.DOB))
            }
            lblMaritialStatus.text = data.MARITALSTS != "" ? data.MARITALSTS : pleaseSelect
            txtNumberOfChildren.text = data.NOOFCHILDREN
            txtNumberOfChildrenLive.text = data.NOOFCHILDRENLWY
            txtCurrentOccupation.text = data.OCCUPATIONCUR
            txtPreviousAccupation.text = data.OCCUPATIONPRV
        }
        else if stepNumber == 2{
            //Step 2
            if (data.CHILDHDILLNESS_MEASLES == "Y") {
                self.yesMeaslesImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_MEASLES == "N") {
                self.noMeaslesImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.CHILDHDILLNESS_MUMPS == "Y") {
                self.yesMumpsImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_MUMPS == "N") {
                self.noMumpsImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.CHILDHDILLNESS_RUB == "Y") {
                self.yesRubelleImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_RUB == "N") {
                self.noRubelleImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.CHILDHDILLNESS_CHKPOX == "Y") {
                self.yesChickenpoxImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_CHKPOX == "N") {
                self.noChickenpoxImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.CHILDHDILLNESS_RTFEVER == "Y") {
                self.yesRheumaticFeverImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_RTFEVER == "N") {
                self.noRheumaticFeverImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.CHILDHDILLNESS_POLIO == "Y") {
                self.yesPolioImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_POLIO == "N") {
                self.noPolioImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.CHILDHDILLNESS_NONE == "Y") {
                self.yesNoneImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.CHILDHDILLNESS_NONE == "N") {
                self.noNoneImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 3{
            //Step 3
            self.txtTetanusDate.isHidden = true
            self.btnDate1Step1.isHidden = true
            if (data.IMM_TETANUS == "Y") {
                self.yesTetanusImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtTetanusDate.text = data.IMM_TETANUSDT
                self.txtTetanusDate.isHidden = false
                self.btnDate1Step1.isHidden = false
            } else if (data.IMM_TETANUS == "N") {
                self.noTetanusImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtPneumoniaDate.isHidden = true
            self.btnDate2Step1.isHidden = true
            if (data.IMM_PNEUMONIA == "Y") {
                self.yesPneumoniaImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtPneumoniaDate.text = data.IMM_PNEUMONIADT
                self.txtPneumoniaDate.isHidden = false
                self.btnDate2Step1.isHidden = false
            } else if (data.IMM_PNEUMONIA == "N") {
                self.noPneumoniaImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtHepatitisADate.isHidden = true
            self.btnDate3Step1.isHidden = true
            if (data.IMM_HEPATITISA == "Y") {
                self.yesHepatitisAImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtHepatitisADate.text = data.IMM_HEPATITISADT
                self.txtHepatitisADate.isHidden = false
                self.btnDate3Step1.isHidden = false
            } else if (data.IMM_HEPATITISA == "N") {
                self.noHepatitisAImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtHepatitisBDate.isHidden = true
            self.btnDate4Step1.isHidden = true
            if (data.IMM_HEPATITISB == "Y") {
                self.yesHepatitisBImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtHepatitisBDate.text = data.IMM_HEPATITISBDT
                self.txtHepatitisBDate.isHidden = false
                self.btnDate4Step1.isHidden = false
            } else if (data.IMM_HEPATITISB == "N") {
                self.noHepatitisBImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtChickenpoxStep3Date.isHidden = true
            self.btnDate5Step1.isHidden = true
            if (data.IMM_CHICKENPOX == "Y") {
                self.yesChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtChickenpoxStep3Date.text = data.IMM_CHICKENPOXDT
                self.txtChickenpoxStep3Date.isHidden = false
                self.btnDate5Step1.isHidden = false
            } else if (data.IMM_CHICKENPOX == "N") {
                self.noChickenpoxStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtInfluenzaDate.isHidden = true
            self.btnDate6Step1.isHidden = true
            if (data.IMM_INFLUENZA == "Y") {
                self.yesInfluenzaImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtInfluenzaDate.text = data.IMM_INFLUENZADT
                self.txtInfluenzaDate.isHidden = false
                self.btnDate6Step1.isHidden = false
            } else if (data.IMM_INFLUENZA == "N") {
                self.noInfluenzaImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtMumpsStep3Date.isHidden = true
            self.btnDate7Step3.isHidden = true
            if (data.IMM_MUMPS == "Y") {
                self.yesMumpsStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMumpsStep3Date.text = data.IMM_MUMPSDT
                self.txtMumpsStep3Date.isHidden = false
                self.btnDate7Step3.isHidden = false
            } else if (data.IMM_MUMPS == "N") {
                self.noMumpsStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtRubellaDate.isHidden = true
            self.btnDate8Step3.isHidden = true
            if (data.IMM_RUBELLA == "Y") {
                self.yesRubellaImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtRubellaDate.text = data.IMM_RUBELLADT
                self.txtRubellaDate.isHidden = false
                self.btnDate8Step3.isHidden = false
            } else if (data.IMM_RUBELLA == "N") {
                self.noRubellaImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtMeningococcalDate.isHidden = true
            self.btnDate9Step3.isHidden = true
            if (data.IMM_MENINGOCOCCAL == "Y") {
                self.yesMeningococcalImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMeningococcalDate.text = data.IMM_MENINGOCOCCALDT
                self.txtMeningococcalDate.isHidden = false
                self.btnDate9Step3.isHidden = false
            } else if (data.IMM_MENINGOCOCCAL == "N") {
                self.noMeningococcalImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.IMM_NONE == "Y") {
                self.yesNoneStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.IMM_NONE == "N") {
                self.noNoneStep3ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 4{
            //Step 4
            if (data.SCR_EYEEXAM == "Y") {
                self.yesEyeExamImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtEyeExamDate.text = data.SCR_EYEEXAMDT
                self.txtEyeExamDate.isHidden = false
                self.btnDate1Step4.isHidden = false
            } else if (data.SCR_EYEEXAM == "N") {
                self.noEyeExamImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SCR_COLONOSCOPY == "Y") {
                self.yesColonoscopImgView.image = UIImage.init(named: "radioBtn-checked")
                txtColonoscopDate.text = data.SCR_COLONOSCOPYDT
                self.txtColonoscopDate.isHidden = false
                self.btnDate2Step4.isHidden = false
            } else if (data.SCR_COLONOSCOPY == "N") {
                self.noColonoscopImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SCR_DEXA_SCAN == "Y") {
                self.yesDexaScanImgView.image = UIImage.init(named: "radioBtn-checked")
                txtDexaScanDate.text = data.SCR_DEXA_SCANDT
                self.txtDexaScanDate.isHidden = false
                self.btnDate3Step4.isHidden = false
            } else if (data.SCR_DEXA_SCAN == "N") {
                self.noDexaScanImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SCR_NONE == "Y") {
                self.yesNoneStep4ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SCR_NONE == "N") {
                self.noNoneStep4ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 5{
            //Step 5
            self.viewHeightConstraintSurgery1Step5.constant = 0
            self.viewHeightConstraintReason1Step5.constant = 0
            self.viewSurgery1Step5.isHidden = true
            self.viewReason1Step5.isHidden = true
            if (data.SURGERY1 == "Y") {
                self.yesSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear1Step5.text = data.SURGERY1_YEAR
                self.txtHospitalName1Step5.text = data.SURGERY1_PROV
                self.txtReasonSurgery1Step5.text = data.SURGERY1_REASON
                self.viewHeightConstraintSurgery1Step5.constant = 60
                self.viewHeightConstraintReason1Step5.constant = 60
                self.viewSurgery1Step5.isHidden = false
                self.viewReason1Step5.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SURGERY1 == "N"){
                self.noSurgery1Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintSurgery2Step5.constant = 0
            self.viewHeightConstraintReason2Step5.constant = 0
            self.viewSurgery2Step5.isHidden = true
            self.viewReason2Step5.isHidden = true
            if (data.SURGERY2 == "Y") {
                self.yesSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear2Step5.text = data.SURGERY2_YEAR
                self.txtHospitalName2Step5.text = data.SURGERY2_PROV
                self.txtReasonSurgery2Step5.text = data.SURGERY2_REASON
                self.viewHeightConstraintSurgery2Step5.constant = 60
                self.viewHeightConstraintReason2Step5.constant = 60
                self.viewSurgery2Step5.isHidden = false
                self.viewReason2Step5.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SURGERY2 == "N"){
                self.noSurgery2Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintSurgery3Step5.constant = 0
            self.viewHeightConstraintReason3Step5.constant = 0
            self.viewSurgery3Step5.isHidden = true
            self.viewReason3Step5.isHidden = true
            if (data.SURGERY3 == "Y") {
                self.yesSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear3Step5.text = data.SURGERY3_YEAR
                self.txtHospitalName3Step5.text = data.SURGERY3_PROV
                self.txtReasonSurgery3Step5.text = data.SURGERY3_REASON
                self.viewHeightConstraintSurgery3Step5.constant = 60
                self.viewHeightConstraintReason3Step5.constant = 60
                self.viewSurgery3Step5.isHidden = false
                self.viewReason3Step5.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SURGERY3 == "N"){
                self.noSurgery3Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintSurgery4Step5.constant = 0
            self.viewHeightConstraintReason4Step5.constant = 0
            self.viewSurgery4Step5.isHidden = true
            self.viewReason4Step5.isHidden = true
            if (data.SURGERY4 == "Y") {
                self.yesSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear4Step5.text = data.SURGERY4_YEAR
                self.txtHospitalName4Step5.text = data.SURGERY4_PROV
                self.txtReasonSurgery4Step5.text = data.SURGERY4_REASON
                self.viewHeightConstraintSurgery4Step5.constant = 60
                self.viewHeightConstraintReason4Step5.constant = 60
                self.viewSurgery4Step5.isHidden = false
                self.viewReason4Step5.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SURGERY4 == "N"){
                self.noSurgery4Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintSurgery5Step5.constant = 0
            self.viewHeightConstraintReason5Step5.constant = 0
            self.viewSurgery5Step5.isHidden = true
            self.viewReason5Step5.isHidden = true
            if (data.SURGERY5 == "Y") {
                self.yesSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear5Step5.text = data.SURGERY5_YEAR
                self.txtHospitalName5Step5.text = data.SURGERY5_PROV
                self.txtReasonSurgery5Step5.text = data.SURGERY5_REASON
                self.viewHeightConstraintSurgery5Step5.constant = 60
                self.viewHeightConstraintReason5Step5.constant = 60
                self.viewSurgery5Step5.isHidden = false
                self.viewReason5Step5.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SURGERY5 == "N"){
                self.noSurgery5Step5ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SURGERY_DONEBF == "Y") {
                self.yesNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SURGERY_DONEBF == "N"){
                self.noNoSurgeryStep5ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 6{
            //Step 6
            self.viewHeightConstraintHosp1Step6.constant = 0
            self.viewHeightConstraintReason1Step6.constant = 0
            self.viewHosp1Step6.isHidden = true
            self.viewReason1Step6.isHidden = true
            if (data.HOSP1 == "Y") {
                self.yesHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear1Step6.text = data.HOSP1_YEAR
                self.txtHospitalName1Step6.text = data.HOSP1_PROV
                self.txtReasonHospitilization1Step6.text = data.HOSP1_REASON
                self.viewHeightConstraintHosp1Step6.constant = 60
                self.viewHeightConstraintReason1Step6.constant = 60
                self.viewHosp1Step6.isHidden = false
                self.viewReason1Step6.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.HOSP1 == "N"){
                self.noHospitilization1Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintHosp2Step6.constant = 0
            self.viewHeightConstraintReason2Step6.constant = 0
            self.viewHosp2Step6.isHidden = true
            self.viewReason2Step6.isHidden = true
            if (data.HOSP2 == "Y") {
                self.yesHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear2Step6.text = data.HOSP2_YEAR
                self.txtHospitalName2Step6.text = data.HOSP2_PROV
                self.txtReasonHospitilization2Step6.text = data.HOSP2_REASON
                self.viewHeightConstraintHosp2Step6.constant = 60
                self.viewHeightConstraintReason2Step6.constant = 60
                self.viewHosp2Step6.isHidden = false
                self.viewReason2Step6.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.HOSP2 == "N"){
                self.noHospitilization2Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintHosp3Step6.constant = 0
            self.viewHeightConstraintReason3Step6.constant = 0
            self.viewHosp3Step6.isHidden = true
            self.viewReason3Step6.isHidden = true
            if (data.HOSP3 == "Y") {
                self.yesHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear3Step6.text = data.HOSP3_YEAR
                self.txtHospitalName3Step6.text = data.HOSPY3_PROV
                self.txtReasonHospitilization3Step6.text = data.HOSP3_REASON
                self.viewHeightConstraintHosp3Step6.constant = 60
                self.viewHeightConstraintReason3Step6.constant = 60
                self.viewHosp3Step6.isHidden = false
                self.viewReason3Step6.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.HOSP3 == "N"){
                self.noHospitilization3Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintHosp4Step6.constant = 0
            self.viewHeightConstraintReason4Step6.constant = 0
            self.viewHosp4Step6.isHidden = true
            self.viewReason4Step6.isHidden = true
            if (data.HOSP4 == "Y") {
                self.yesHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear4Step6.text = data.HOSP4_YEAR
                self.txtHospitalName4Step6.text = data.HOSP4_PROV
                self.txtReasonHospitilization4Step6.text = data.HOSP4_REASON
                self.viewHeightConstraintHosp4Step6.constant = 60
                self.viewHeightConstraintReason4Step6.constant = 60
                self.viewHosp4Step6.isHidden = false
                self.viewReason4Step6.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.HOSP4 == "N"){
                self.noHospitilization4Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintHosp5Step6.constant = 0
            self.viewHeightConstraintReason5Step6.constant = 0
            self.viewHosp5Step6.isHidden = true
            self.viewReason5Step6.isHidden = true
            if (data.HOSP5 == "Y") {
                self.yesHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtYear5Step6.text = data.HOSP5_YEAR
                self.txtHospitalName5Step6.text = data.HOSP5_PROV
                self.txtReasonHospitilization5Step6.text = data.HOSP5_REASON
                self.viewHeightConstraintHosp5Step6.constant = 60
                self.viewHeightConstraintReason5Step6.constant = 60
                self.viewHosp5Step6.isHidden = false
                self.viewReason5Step6.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.HOSP5 == "N"){
                self.noHospitilization5Step6ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            if (data.HOSPY_DONEBF == "Y") {
                self.yesNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.HOSPY_DONEBF == "N"){
                self.noNoHospitilizationStep6ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 7{
            //Step 7
            self.viewHeightConstraintName1Step7.constant = 0
            self.viewHeightConstraintReason1Step7.constant = 0
            self.viewName1Step7.isHidden = true
            self.viewReason1Step7.isHidden = true
            if (data.DOCVST1 == "Y") {
                self.yesVisit1Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMonth1Step7.text = data.DOCVST1_YEAR
                self.txtProviderName1Step7.text = data.DOCVST1_PROV
                self.txtReasonVisit1Step7.text = data.DOCVST1_REASON
                self.viewHeightConstraintName1Step7.constant = 60
                self.viewHeightConstraintReason1Step7.constant = 60
                self.viewName1Step7.isHidden = false
                self.viewReason1Step7.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.DOCVST1 == "N"){
                self.noVisit1Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName2Step7.constant = 0
            self.viewHeightConstraintReason2Step7.constant = 0
            self.viewName2Step7.isHidden = true
            self.viewReason2Step7.isHidden = true
            if (data.DOCVST2 == "Y") {
                self.yesVisit2Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMonth2Step7.text = data.DOCVST2_YEAR
                self.txtProviderName2Step7.text = data.DOCVST2_PROV
                self.txtReasonVisit2Step7.text = data.DOCVST2_REASON
                self.viewHeightConstraintName2Step7.constant = 60
                self.viewHeightConstraintReason2Step7.constant = 60
                self.viewName2Step7.isHidden = false
                self.viewReason2Step7.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.DOCVST2 == "N"){
                self.noVisit2Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName3Step7.constant = 0
            self.viewHeightConstraintReason3Step7.constant = 0
            self.viewName3Step7.isHidden = true
            self.viewReason3Step7.isHidden = true
            if (data.DOCVST3 == "Y") {
                self.yesVisit3Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMonth3Step7.text = data.DOCVST3_YEAR
                self.txtProviderName3Step7.text = data.DOCVST3_PROV
                self.txtReasonVisit3Step7.text = data.DOCVST3_REASON
                self.viewHeightConstraintName3Step7.constant = 60
                self.viewHeightConstraintReason3Step7.constant = 60
                self.viewName3Step7.isHidden = false
                self.viewReason3Step7.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.DOCVST3 == "N"){
                self.noVisit3Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName4Step7.constant = 0
            self.viewHeightConstraintReason4Step7.constant = 0
            self.viewName4Step7.isHidden = true
            self.viewReason4Step7.isHidden = true
            if (data.DOCVST4 == "Y") {
                self.yesVisit4Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMonth4Step7.text = data.DOCVST4_YEAR
                self.txtProviderName4Step7.text = data.DOCVST4_PROV
                self.txtReasonVisit4Step7.text = data.DOCVST4_REASON
                self.viewHeightConstraintName4Step7.constant = 60
                self.viewHeightConstraintReason4Step7.constant = 60
                self.viewName4Step7.isHidden = false
                self.viewReason4Step7.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.DOCVST4 == "N"){
                self.noVisit4Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName5Step7.constant = 0
            self.viewHeightConstraintReason5Step7.constant = 0
            self.viewName5Step7.isHidden = true
            self.viewReason5Step7.isHidden = true
            if (data.DOCVST5 == "Y") {
                self.yesVisit5Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMonth5Step7.text = data.DOCVST5_YEAR
                self.txtProviderName5Step7.text = data.DOCVST5_PROV
                self.txtReasonVisit5Step7.text = data.DOCVST5_REASON
                self.viewHeightConstraintName5Step7.constant = 60
                self.viewHeightConstraintReason5Step7.constant = 60
                self.viewName5Step7.isHidden = false
                self.viewReason5Step7.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.DOCVST5 == "N"){
                self.noVisit5Step7ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            if (data.DOCVST_DONEBF == "Y") {
                self.yesNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.DOCVST_DONEBF == "N"){
                self.noNoVisitStep7ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 8 && self.healthRiskAssessmentModel.MEDICALHISTORYCD != ""{
            let arrayMedicalHistoryCode = self.healthRiskAssessmentModel.MEDICALHISTORYCD.components(separatedBy: [","])
            if arrayMedicalHistoryCode.contains("MH01") {
                alcoholAbuseStep8 = true
                alcoholAbuseStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH18")  {
                diabetesStep8 = true
                diabetesStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH02") {
                anemiaStep8 = true
                anemiaStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH19") {
                migrainesStep8 = true
                migrainesStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH03") {
                anestheticComplicationStep8 = true
                anestheticComplicationStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH20") {
                osteoporosisStep8 = true
                osteoporosisStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH04") {
                anxietyDisorderStep8 = true
                anxietyDisorderStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH21") {
                prostateCancerStep8 = true
                prostateCancerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH05") {
                arthritis1Step8 = true
                arthritis1Step8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH22") {
                rectalCancerStep8 = true
                rectalCancerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH06") {
                asthmaStep8 = true
                asthmaStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH23") {
                refluxGERDStep8 = true
                refluxGERDStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH07") {
                autoimmuneProblemsStep8 = true
                autoimmuneProblemsStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH24") {
                seizuresConvulsionsStep8 = true
                seizuresConvulsionsStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH08") {
                birthDefectsStep8 = true
                birthDefectsStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH25") {
                severeAllergyStep8 = true
                severeAllergyStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH09") {
                bladderProblemsStep8 = true
                bladderProblemsStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH26") {
                sexuallyTransmittedDiseaseStep8 = true
                sexuallyTransmittedDiseaseStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH10") {
                bleedingDiseaseStep8 = true
                bleedingDiseaseStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH27") {
                skinCancerStep8 = true
                skinCancerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH11") {
                bloodClotsStep8 = true
                bloodClotsStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH28") {
                strokeCVAoftheBrainStep8 = true
                strokeCVAoftheBrainStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH12") {
                bloodTransfusionStep8 = true
                bloodTransfusionStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH29") {
                suicideAttemptStep8 = true
                suicideAttemptStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH13") {
                bowelDiseaseStep8 = true
                bowelDiseaseStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH30") {
                thyroidProblemsStep8 = true
                thyroidProblemsStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH14") {
                breastCancerStep8 = true
                breastCancerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH31") {
                ulcerStep8 = true
                ulcerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH15") {
                cervicalCancerStep8 = true
                cervicalCancerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH32") {
                visualImpairmentStep8 = true
                visualImpairmentStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH16") {
                colonCancerStep8 = true
                colonCancerStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH33") {
                otherStep8 = true
                otherStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH17") {
                depressionStep8 = true
                depressionStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayMedicalHistoryCode.contains("MH34") {
                noneOfTheAboveStep8 = true
                noneOfTheAboveStep8ImgView.image = UIImage.init(named: "checkbox_active")
            }
        }
        else if stepNumber == 9{
            self.txtmedicalProblemsStep9.text = healthRiskAssessmentModel.PASTMEDHIST
            self.txtReferringDoctorStep9.text = healthRiskAssessmentModel.PREVREFDOC
            self.txtDatePhysicalExamStep9.text = healthRiskAssessmentModel.PHYSICALEXAMDT
            if healthRiskAssessmentModel.BLOODTRANSFUSION == "Y"{
                btnYesBloodTransfusionStep9.setImage(UIImage(named: "radioBtn-checked.png"), for: .normal)
                btnNoBloodTransfusionStep9.setImage(UIImage(named: "radioBtn.png"), for: .normal)
            }
            else if healthRiskAssessmentModel.BLOODTRANSFUSION == "N"{
                btnYesBloodTransfusionStep9.setImage(UIImage(named: "radioBtn.png"), for: .normal)
                btnNoBloodTransfusionStep9.setImage(UIImage(named: "radioBtn-checked.png"), for: .normal)
            }
        }
        else if stepNumber == 10{
            //Step 10
            self.viewHeightConstraintName1Step10.constant = 0
            self.viewHeightConstraintDosage1Step10.constant = 0
            self.viewName1Step10.isHidden = true
            self.viewDosage1Step10.isHidden = true
            if (data.MEDICATION1_DRUG == "Y") {
                self.yesDrug1Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName1Step10.text = data.MEDICATION1_NAME
                self.txtDosageFrequency1Step10.text = data.MEDICATION1_DOSAGE
                self.viewHeightConstraintName1Step10.constant = 60
                self.viewHeightConstraintDosage1Step10.constant = 60
                self.viewName1Step10.isHidden = false
                self.viewDosage1Step10.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.MEDICATION1_DRUG == "N"){
                self.noDrug1Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName2Step10.constant = 0
            self.viewHeightConstraintDosage2Step10.constant = 0
            self.viewName2Step10.isHidden = true
            self.viewDosage2Step10.isHidden = true
            if (data.MEDICATION2_DRUG == "Y") {
                self.yesDrug2Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName2Step10.text = data.MEDICATION2_NAME
                self.txtDosageFrequency2Step10.text = data.MEDICATION2_DOSAGE
                self.viewHeightConstraintName2Step10.constant = 60
                self.viewHeightConstraintDosage2Step10.constant = 60
                self.viewName2Step10.isHidden = false
                self.viewDosage2Step10.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.MEDICATION2_DRUG == "N"){
                self.noDrug2Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName3Step10.constant = 0
            self.viewHeightConstraintDosage3Step10.constant = 0
            self.viewName3Step10.isHidden = true
            self.viewDosage3Step10.isHidden = true
            if (data.MEDICATION3_DRUG == "Y") {
                self.yesDrug3Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName3Step10.text = data.MEDICATION3_NAME
                self.txtDosageFrequency3Step10.text = data.MEDICATION3_DOSAGE
                self.viewHeightConstraintName3Step10.constant = 60
                self.viewHeightConstraintDosage3Step10.constant = 60
                self.viewName3Step10.isHidden = false
                self.viewDosage3Step10.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.MEDICATION3_DRUG == "N"){
                self.noDrug3Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName4Step10.constant = 0
            self.viewHeightConstraintDosage4Step10.constant = 0
            self.viewName4Step10.isHidden = true
            self.viewDosage4Step10.isHidden = true
            if (data.MEDICATION4_DRUG == "Y") {
                self.yesDrug4Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName4Step10.text = data.MEDICATION4_NAME
                self.txtDosageFrequency4Step10.text = data.MEDICATION4_DOSAGE
                self.viewHeightConstraintName4Step10.constant = 60
                self.viewHeightConstraintDosage4Step10.constant = 60
                self.viewName4Step10.isHidden = false
                self.viewDosage4Step10.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.MEDICATION4_DRUG == "N"){
                self.noDrug4Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName5Step10.constant = 0
            self.viewHeightConstraintDosage5Step10.constant = 0
            self.viewName5Step10.isHidden = true
            self.viewDosage5Step10.isHidden = true
            if (data.MEDICATION5_DRUG == "Y") {
                self.yesDrug5Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName5Step10.text = data.MEDICATION5_NAME
                self.txtDosageFrequency5Step10.text = data.MEDICATION5_DOSAGE
                self.viewHeightConstraintName5Step10.constant = 60
                self.viewHeightConstraintDosage5Step10.constant = 60
                self.viewName5Step10.isHidden = false
                self.viewDosage5Step10.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.MEDICATION5_DRUG == "N"){
                self.noDrug5Step10ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            if (data.MEDICATION_NONE == "Y") {
                self.yesOtherStep10ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MEDICATION_NONE == "N"){
                self.noOtherStep10ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 11{
            //Step 11
            self.viewHeightConstraintName1Step11.constant = 0
            self.viewHeightConstraintReaction1Step11.constant = 0
            self.viewName1Step11.isHidden = true
            self.viewReaction1Step11.isHidden = true
            if (data.ALERGY1 == "Y") {
                self.yesAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName1Step11.text = data.ALERGY1_NAME
                self.txtReactionYouHad1Step11.text = data.ALERGY1_REACTION
                self.viewHeightConstraintName1Step11.constant = 60
                self.viewHeightConstraintReaction1Step11.constant = 60
                self.viewName1Step11.isHidden = false
                self.viewReaction1Step11.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.ALERGY1 == "N"){
                self.noAlergy1Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName2Step11.constant = 0
            self.viewHeightConstraintReaction2Step11.constant = 0
            self.viewName2Step11.isHidden = true
            self.viewReaction2Step11.isHidden = true
            if (data.ALERGY2 == "Y") {
                self.yesAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName2Step11.text = data.ALERGY2_NAME
                self.txtReactionYouHad2Step11.text = data.ALERGY2_REACTION
                self.viewHeightConstraintName2Step11.constant = 60
                self.viewHeightConstraintReaction2Step11.constant = 60
                self.viewName2Step11.isHidden = false
                self.viewReaction2Step11.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.ALERGY2 == "N"){
                self.noAlergy2Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintName3Step11.constant = 0
            self.viewHeightConstraintReaction3Step11.constant = 0
            self.viewName3Step11.isHidden = true
            self.viewReaction3Step11.isHidden = true
            if (data.ALERGY3 == "Y") {
                self.yesAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtName3Step11.text = data.ALERGY3_NAME
                self.txtReactionYouHad3Step11.text = data.ALERGY3_REACTION
                self.viewHeightConstraintName3Step11.constant = 60
                self.viewHeightConstraintReaction3Step11.constant = 60
                self.viewName3Step11.isHidden = false
                self.viewReaction3Step11.isHidden = false
                self.heightView += 120
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.ALERGY3 == "N"){
                self.noAlergy3Step11ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            if (data.ALERGY_NONE == "Y") {
                self.yesOtherStep11ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.ALERGY_NONE == "N"){
                self.noOtherStep11ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 12 && self.healthRiskAssessmentModel.FMEDICALHISTORYCD != ""{
            let arrayFMedicalHistoryCode = self.healthRiskAssessmentModel.FMEDICALHISTORYCD.components(separatedBy: [","])
            if arrayFMedicalHistoryCode.contains("FH01") {
                iAmAdoptedStep12 = true
                iAmAdoptedStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH18") {
                leukemiaStep12 = true
                leukemiaStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH02") {
                familyHistoryUnknownStep12 = true
                familyHistoryUnknownStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH19") {
                lungRespiratoryDiseaseStep12 = true
                lungRespiratoryDiseaseStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH03") {
                alcoholAbuseStep12 = true
                alcoholAbuseStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH20") {
                migrainesStep12 = true
                migrainesStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH04") {
                anemiaStep12 = true
                AnemiaStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH21") {
                osteoporosisStep12 = true
                osteoporosisStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH05") {
                anestheticComplicationStep12 = true
                anestheticComplicationStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH22") {
                otherCancerStep12 = true
                otherCancerStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH06") {
                arthritisStep12 = true
                arthritisStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH23") {
                rectalCancerStep12 = true
                rectalCancerStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH07") {
                asthmaStep12 = true
                asthmaStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH24") {
                seizuresConvulsionsStep12 = true
                seizuresConvulsionsStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH08") {
                bladderProblemsStep12 = true
                bladderProblemsStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH25") {
                severeAllergyStep12 = true
                severeAllergyStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH09") {
                bleedingDiseaseStep12 = true
                bleedingDiseaseStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH26") {
                strokeCVAoftheBrainStep12 = true
                strokeCVAoftheBrainStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH10") {
                breastCancerStep12 = true
                breastCancerStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH27") {
                thyroidProblemsStep12 = true
                thyroidProblemsStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH11") {
                colonCancerStep12 = true
                colonCancerStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH28") {
                motherStep12 = true
                motherStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH12") {
                depressionStep12 = true
                depressionStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH29") {
                fatherStep12 = true
                fatherStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH13") {
                diabetesStep12 = true
                diabetesStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH14") {
                heartDiseaseStep12 = true
                heartDiseaseStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH15") {
                highBloodPressureStep12 = true
                highBloodPressureStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH16") {
                highCholesterolStep12 = true
                highCholesterolStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH17") {
                kidneyDiseaseStep12 = true
                kidneyDiseaseStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
            if arrayFMedicalHistoryCode.contains("FH30") {
                noneOfTheAboveStep12 = true
                noneOfTheAboveStep12ImgView.image = UIImage.init(named: "checkbox_active")
            }
        }
        else if stepNumber == 13{
            self.viewHeightConstraintMinutesStep13.constant = 0
            self.viewMinutesStep13.isHidden = true
            if (data.SC_EXERCISE == "Y") {
                self.yesDoYouExerciseStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtMinutesStep13.text = data.SC_EXERCISEDUR
                self.viewHeightConstraintMinutesStep13.constant = 60
                self.viewMinutesStep13.isHidden = false
                self.heightView += 60
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SC_EXERCISE == "N"){
                self.noDoYouExerciseStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewHeightConstraintPhysicianPrescribedStep13.constant = 0
            self.viewPhysicianPrescribedStep13.isHidden = true
            if (data.SC_DIET == "Y") {
                self.yesAreYouDietingStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.viewHeightConstraintPhysicianPrescribedStep13.constant = 60
                self.viewPhysicianPrescribedStep13.isHidden = false
                self.heightView += 60
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SC_DIET == "N"){
                self.noAreYouDietingStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            if (data.SC_DIETPHY == "Y") {
                self.yesPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_DIETPHY == "N"){
                self.noPhysicianPrescribedStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.txtMealsEatAverageDayStep13.text = data.SC_MEALPRDAY != "" ? data.SC_MEALPRDAY : pleaseSelect
            self.txtRankSaltIntakeStep13.text = data.SC_SALTINTAKE != "" ? data.SC_SALTINTAKE : pleaseSelect
            self.txtRankFatIntake1Step13.text = data.SC_FATINTAKE != "" ? data.SC_FATINTAKE : pleaseSelect
            
            self.viewHeightConstraintPreferredDrinkStep13.constant = 0
            self.viewPreferredDrinkStep13.isHidden = true
            self.viewHeightConstraintCupsPerDayStep13.constant = 0
            self.viewCupsPerDayStep13.isHidden = true
            if (data.SC_CAFFINE == "Y") {
                self.yesIntakeofCaffeineStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.viewHeightConstraintPreferredDrinkStep13.constant = 80
                self.viewPreferredDrinkStep13.isHidden = false
                self.viewHeightConstraintCupsPerDayStep13.constant = 60
                self.viewCupsPerDayStep13.isHidden = false
                self.txtpreferredDrinkStep13.text = data.SC_CAFFINEINTAKE
                self.txtRankFatIntake2Step13.text = data.SC_CAFFINEPERDAY != "" ? data.SC_CAFFINEPERDAY : pleaseSelect
                self.heightView += 140
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SC_CAFFINE == "N"){
                self.noIntakeofCaffeineStep13ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 14{
            self.viewHeightConstraintWhatKindStep14.constant = 0
            self.viewWhatKindStep14.isHidden = true
            self.viewHeightConstraintDrinksPerWeekStep14.constant = 0
            self.viewDrinksPerWeekStep14.isHidden = true
            self.viewHeightConstraintTheAmountYouDrinkStep14.constant = 0
            self.viewTheAmountYouDrinkStep14.isHidden = true
            self.viewHeightConstraintHaveYouConsideredStoppingStep14.constant = 0
            self.viewHaveYouConsideredStoppingStep14.isHidden = true
            self.viewHeightConstraintBlackoutsStep14.constant = 0
            self.viewBlackoutsStep14.isHidden = true
            self.viewHeightConstraintBingeDrinkingStep14.constant = 0
            self.viewBingeDrinkingStep14.isHidden = true
            self.viewHeightConstraintDriveAfterDrinkingStep14.constant = 0
            self.viewDriveAfterDrinkingStep14.isHidden = true
            if (data.SC_ALCOHOL == "Y") {
                self.yesDoYouDrinkAlcoholStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtWhatKindStep14.text = data.SC_ALCOHOLTYP
                self.txtDrinksPerWeekStep14.text = data.SC_ALCOHOLPWK
                self.viewHeightConstraintWhatKindStep14.constant = 60
                self.viewWhatKindStep14.isHidden = false
                self.viewHeightConstraintDrinksPerWeekStep14.constant = 60
                self.viewDrinksPerWeekStep14.isHidden = false
                self.viewHeightConstraintTheAmountYouDrinkStep14.constant = 60
                self.viewTheAmountYouDrinkStep14.isHidden = false
                self.viewHeightConstraintHaveYouConsideredStoppingStep14.constant = 60
                self.viewHaveYouConsideredStoppingStep14.isHidden = false
                self.viewHeightConstraintBlackoutsStep14.constant = 60
                self.viewBlackoutsStep14.isHidden = false
                self.viewHeightConstraintBingeDrinkingStep14.constant = 60
                self.viewBingeDrinkingStep14.isHidden = false
                self.viewHeightConstraintDriveAfterDrinkingStep14.constant = 60
                self.viewDriveAfterDrinkingStep14.isHidden = false
                self.heightView += 420
                self.heightConstraintContentStepView.constant = self.heightView
                if (data.SC_ALCOHOLCN == "Y") {
                    self.yesTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                } else if (data.SC_ALCOHOLCN == "N"){
                    self.noTheAmountYouDrinkStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                }
                if (data.SC_ALCOHOLSTOP == "Y") {
                    self.yesHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                } else if (data.SC_ALCOHOLSTOP == "N"){
                    self.noHaveYouConsideredStoppingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                }
                if (data.SC_ALCOHOLBO == "Y") {
                    self.yesBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                } else if (data.SC_ALCOHOLBO == "N"){
                    self.noBlackoutsStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                }
                if (data.SC_ALCOHOLBG == "Y") {
                    self.yesBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                } else if (data.SC_ALCOHOLBG == "N"){
                    self.noBingeDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                }
                if (data.SC_ALCOHOLDR == "Y") {
                    self.yesDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                } else if (data.SC_ALCOHOLDR == "N"){
                    self.noDriveAfterDrinkingStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
                }
            } else if (data.SC_ALCOHOL == "N"){
                self.noDoYouDrinkAlcoholStep14ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 15{
            self.viewHeightConstraintCigarettesStep15.constant = 0
            self.viewCigarettesStep15.isHidden = true
            self.viewHeightConstraintKsDayStep15.constant = 0
            self.viewKsDayStep15.isHidden = true
            self.viewHeightConstraintPksWeekStep15.constant = 0
            self.viewPksWeekStep15.isHidden = true
            self.viewHeightConstraintChewDayStep15.constant = 0
            self.viewChewDayStep15.isHidden = true
            self.txtChewDayStep15.isHidden = true
            self.viewHeightConstraintPipeDayStep15.constant = 0
            self.viewPipeDayStep15.isHidden = true
            self.txtPipeDayStep15.isHidden = true
            self.viewHeightConstraintCigarsDayStep15.constant = 0
            self.viewCigarsDayStep15.isHidden = true
            self.txtCigarsDayStep15.isHidden = true
            self.viewHeightConstraintOfYearsInTobaccoStep15.constant = 0
            self.viewOfYearsInTobaccoStep15.isHidden = true
            self.txtOfYearsInTobaccoStep15.isHidden = true
            self.txtNumberOfYearsQuitStep15.isHidden = true
            self.cigarettesStep15 = false
            self.chewDayStep15 = false
            self.pipeDayStep15 = false
            self.cigarsDayStep15 = false
            self.ofYearsInTobaccoStep15 = false
            self.numberOfYearsQuitStep15 = false
            if (data.SC_TOBACCO == "Y") {
                self.yesDoYouUseTobaccoStep15ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.heightView += 40
                self.viewHeightConstraintCigarettesStep15.constant = 40
                self.viewCigarettesStep15.isHidden = false
                if data.SC_TOBACCOCIG == "Y"{
                    self.heightView += 160
                    self.chkCigarettesStep15ImgView.image = UIImage.init(named: "checkbox_active")
                    self.viewKsDayStep15.isHidden = false
                    self.viewHeightConstraintKsDayStep15.constant = 80
                    self.viewPksWeekStep15.isHidden = false
                    self.viewHeightConstraintPksWeekStep15.constant = 80
                    self.txtpksDayStep15.text = data.SC_TOBACCOPKSDAY
                    self.txtPksWeekStep15.text = data.SC_TOBACCOPKSWEEK
                    self.cigarettesStep15 = true
                }
                self.viewChewDayStep15.isHidden = false
                self.viewHeightConstraintChewDayStep15.constant = 35
                self.heightView += 35
                if data.SC_TOBACCOCHW == "Y"{
                    self.chkChewDayStep15ImgView.image = UIImage.init(named: "checkbox_active")
                    self.txtChewDayStep15.text = data.SC_TOBACCOCHW_DES
                    self.txtChewDayStep15.isHidden = false
                    self.chewDayStep15 = true
                }
                self.viewPipeDayStep15.isHidden = false
                self.viewHeightConstraintPipeDayStep15.constant = 35
                self.heightView += 35
                if data.SC_TOBACCOCPP == "Y"{
                    self.chkPipeDayStep15ImgView.image = UIImage.init(named: "checkbox_active")
                    self.txtPipeDayStep15.text = data.SC_TOBACCOCPP_DES
                    self.txtPipeDayStep15.isHidden = false
                    self.pipeDayStep15 = true
                }
                self.viewCigarsDayStep15.isHidden = false
                self.viewHeightConstraintCigarsDayStep15.constant = 35
                self.heightView += 35
                if data.SC_TOBACCOCCG == "Y"{
                    self.chkBtnCigarsDayStep15ImgView.image = UIImage.init(named: "checkbox_active")
                    self.txtCigarsDayStep15.text = data.SC_TOBACCOCCG_DES
                    self.txtCigarsDayStep15.isHidden = false
                    self.cigarsDayStep15 = true
                }
                self.viewOfYearsInTobaccoStep15.isHidden = false
                self.viewHeightConstraintOfYearsInTobaccoStep15.constant = 40
                self.heightView += 40
                if data.SC_TOBACCOYRS == "Y"{
                    self.chkOfYearsInTobaccoStep15ImgView.image = UIImage.init(named: "checkbox_active")
                    self.txtOfYearsInTobaccoStep15.text = data.SC_TOBACCOYRS_DES
                    self.txtOfYearsInTobaccoStep15.isHidden = false
                    self.ofYearsInTobaccoStep15 = true
                }
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SC_TOBACCO == "N"){
                self.noDoYouUseTobaccoStep15ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if data.SC_TOBACCOYRSQT == "Y"{
                self.chkNumberOfYearsQuitStep15ImgView.image = UIImage.init(named: "checkbox_active")
                self.txtNumberOfYearsQuitStep15.text = data.SC_TOBACCOYRSQT_DES
                self.txtNumberOfYearsQuitStep15.isHidden = false
                self.numberOfYearsQuitStep15 = true
            }
        }
        else if stepNumber == 16{
            if (data.SC_DRUGRCST == "Y") {
                self.yesRecreationalOrStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_DRUGRCST == "N"){
                self.noRecreationalOrStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
            }
            
            if (data.SC_DRUGRCSTNDL == "Y") {
                self.yesGivenYourselfStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_DRUGRCSTNDL == "N"){
                self.noGivenYourselfStreetDrugsStep16.image = UIImage.init(named: "radioBtn-checked")
            }
            self.iPreferToDiscussWithThePhysicianStep16 = false
            if (data.SC_DRUGPHY == "Y") {
                self.iPreferToDiscussWithThePhysicianStep16ImgView.image = UIImage.init(named: "checkbox_active")
                self.iPreferToDiscussWithThePhysicianStep16 = true
            }
        }
        else if stepNumber == 17{
            self.viewHeightConstraintTryPregnancyStep17.constant = 0
            self.viewTryPregnancyStep17.isHidden = true
            self.viewHeightConstraintListContraceptiveStep17.constant = 0
            self.viewListContraceptiveStep17.isHidden = true
            self.viewHeightConstraintAnyDiscomfortWithIntercourseStep17.constant = 0
            self.viewAnyDiscomfortWithIntercourseStep17.isHidden = true
            if (data.SC_SEX == "Y") {
                self.yesAreYouSexuallyActiveStep17.image = UIImage.init(named: "radioBtn-checked")
                self.heightView += 120
                self.viewHeightConstraintTryPregnancyStep17.constant = 60
                self.viewTryPregnancyStep17.isHidden = false
                self.viewHeightConstraintAnyDiscomfortWithIntercourseStep17.constant = 60
                self.viewAnyDiscomfortWithIntercourseStep17.isHidden = false
                if data.SC_SEXPREG == "Y"{
                    self.yesTryPregnancyStep17.image = UIImage.init(named: "radioBtn-checked")
                }else if (data.SC_SEXPREG == "N"){
                    self.heightView += 80
                    self.viewListContraceptiveStep17.isHidden = false
                    self.viewHeightConstraintListContraceptiveStep17.constant = 80
                    self.txtListContraceptiveStep17.text = data.SC_SEXCONTRA
                    self.noTryPregnancyStep17.image = UIImage.init(named: "radioBtn-checked")
                }
                if data.SC_SEXDISCOM == "Y"{
                    self.yesAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn-checked")
                }else if (data.SC_SEXDISCOM == "N"){
                    self.noAnyDiscomfortWithIntercourseStep17.image = UIImage.init(named: "radioBtn-checked")
                }
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SC_SEX == "N"){
                self.noAreYouSexuallyActiveStep17.image = UIImage.init(named: "radioBtn-checked")
            }
            if data.SC_SEXILLNESSPHY == "Y"{
                self.yesWouldYouLikeToSpeakStep17.image = UIImage.init(named: "radioBtn-checked")
            }else if (data.SC_SEXILLNESSPHY == "N"){
                self.noWouldYouLikeToSpeakStep17.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 18{
            if (data.SC_MENTALSTRESS == "Y") {
                self.YesIsStressAmajorProblemForYouStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALSTRESS == "N"){
                self.NoIsStressAmajorProblemForYouStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALDEPRESS == "Y") {
                self.YesDoYouFeelDepressedStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALDEPRESS == "N"){
                self.NoDoYouFeelDepressedStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALPANIC == "Y") {
                self.YesDoYouPanicStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALPANIC == "N"){
                self.NoDoYouPanicStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALEAT == "Y") {
                self.YesProblemsWithEatingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALEAT == "N"){
                self.NoProblemsWithEatingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALCRY == "Y") {
                self.YesCryFrequentlyStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALCRY == "N"){
                self.NoCryFrequentlyStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALSUICIDE == "Y") {
                self.YesAttemptedSuicideStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALSUICIDE == "N"){
                self.NoAttemptedSuicideStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALSLEEP == "Y") {
                self.YesTroubleSleepingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALSLEEP == "N"){
                self.NoTroubleSleepingStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_MENTALCOUNSEL == "Y") {
                self.YesBeenToCounselorStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_MENTALCOUNSEL == "N"){
                self.NoBeenToCounselorStep18ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 19{
            if (data.SC_PSAFETYALONE == "Y") {
                self.yesDoYouLiveAloneStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYALONE == "N"){
                self.noDoYouLiveAloneStep19Step19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_PSAFETYFALL == "Y") {
                self.yesDoYouHaveFrequentFallsStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYFALL == "N"){
                self.noDoYouHaveFrequentFallsStep19Step19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_PSAFETYVISION == "Y") {
                self.yesVisionOrHearingLossStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYVISION == "N"){
                self.noVisionOrHearingLoss19Step19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_PSAFETYABUSE == "Y") {
                self.yesWouldYouLikeToDiscussStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYABUSE == "N"){
                self.noWouldYouLikeToDiscussStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_PSAFETYSUNBURN == "Y") {
                self.yesSunburnStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYSUNBURN == "N"){
                self.noSunburnStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_PSAFETYSUNEXP == "OCCASIONALLY") {
                self.occasionallySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYSUNEXP == "FREQUENTLY"){
                self.frequentlySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }else if (data.SC_PSAFETYSUNEXP == "RARELY"){
                self.rarelySunExposureStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.SC_PSAFETYSEATBLT == "OCCASIONALLY") {
                self.occasionallySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_PSAFETYSEATBLT == "FREQUENTLY"){
                self.frequentlySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }else if (data.SC_PSAFETYSEATBLT == "ALWAYS"){
                self.rarelySeatbeltStep19ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
        }
        else if stepNumber == 20{
            self.txtAgeAtOnsetOfMenstruationStep20.text = data.WH_MENSTAG
            self.txtDateOfLastMenstruationStep20.text = data.WH_MENSTLASTDT
            self.txtPeriodDaysStep20.text = data.WH_MENSTDAYS
            if (data.WH_HEAVYPERIODS == "Y") {
                self.yesHeavyperiodsStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_HEAVYPERIODS == "N"){
                self.noHeavyperiodsStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtNumberOfPregnanciesStep20.text = data.WH_PREGCOUNT
            self.txtNumberOfLiveBirthsStep20.text = data.WH_LIVEBIRTH
            if (data.WH_PREGBRFEED == "Y") {
                self.yesPregnantOrBreastfeedingStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_PREGBRFEED == "N"){
                self.noPregnantOrBreastfeedingStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_INFECTION == "Y") {
                self.yesAnyUrinaryTractBladderKidneyStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_INFECTION == "N"){
                self.noAnyUrinaryTractBladderKidneyStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_CESAREAN == "Y") {
                self.yesDCHysterectomyCesareanStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_CESAREAN == "N"){
                self.noDCHysterectomyCesareanStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_PROC == "Y") {
                self.yesUrinationStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_PROC == "N"){
                self.noUrinationStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_URINEBLOOD == "Y") {
                self.yesBloodInUrineStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_URINEBLOOD == "N"){
                self.noBloodInUrineStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_FLASHSWEAT == "Y") {
                self.yesHotFlashesSweatingAtNightStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_FLASHSWEAT == "N"){
                self.noHotFlashesSweatingAtNightStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_MENSTSYMPTOM == "Y") {
                self.yesMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_MENSTSYMPTOM == "N"){
                self.noMenstrualTensionPainBloatingIrritabilityOtherStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_BREASTSELFEXM == "Y") {
                self.yesPerformMonthlyBreastStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_BREASTSELFEXM == "N"){
                self.noPerformMonthlyBreastStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.WH_BREASTSYMPTOM == "Y") {
                self.yesExperiencedAnyRecentBreastTendernessStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.WH_BREASTSYMPTOM == "N"){
                self.noExperiencedAnyRecentBreastTendernessStep20ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtDateOfLastPapSmearPelvicStep20.text = data.WH_PELPEPSMEAR
        }
        else if stepNumber == 21{
            if (data.MH_URINATE == "Y") {
                self.yesToUrinateStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_URINATE == "N"){
                self.noToUrinateStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_URINATEBURN == "Y") {
                self.yesUrineBurnStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_URINATEBURN == "N"){
                self.noUrineBurnStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_URINATEBLOOD == "Y") {
                self.yesBloodInUrineStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_URINATEBLOOD == "N"){
                self.noBloodInUrineStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_URINATEDISCHARGE == "Y") {
                self.yesBurningDischargePenisStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_URINATEDISCHARGE == "N"){
                self.noBurningDischargePenisStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_URINATEFORCE == "Y") {
                self.yesUrinationDecreasedStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_URINATEFORCE == "N"){
                self.noUrinationDecreasedStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_KDBLDPROSINF == "Y") {
                self.yesAnyKidneyBladderProstrateInfectionsStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_KDBLDPROSINF == "N"){
                self.noAnyKidneyBladderProstrateInfectionsStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_EMPTYBLADDER == "Y") {
                self.yesAnyProblemsEmptyingBladderCompletelyStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_EMPTYBLADDER == "N"){
                self.noAnyProblemsEmptyingBladderCompletelyStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_ERECTION == "Y") {
                self.yesDifficultyErectionEjaculationStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_ERECTION == "N"){
                self.nDifficultyErectionEjaculationStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            if (data.MH_TESTICLEPN == "Y") {
                self.yesTesticlePainSwellingStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.MH_TESTICLEPN == "N"){
                self.noTesticlePainSwellingStep21ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            self.txtDateLastProstateRectalExamStep21.text = data.MH_PROSRECEXAM
        }
        else if stepNumber == 22{
            self.txtShareMedicationDetailsStep22.text = ""
            self.viewShareMedication1Step22.isHidden = true
            self.viewHeightConstraintShareMedication1Step22.constant = 0
            
            self.txtSinceWhenStep22.text = ""
            self.viewSinceWhen1Step22.isHidden = true
            self.viewHeightConstraintSinceWhen1Step22.constant = 0
            
            if (data.DIABETES_MELLITUS == "Y") {
                self.yesDiabetesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtShareMedicationDetailsStep22.text = data.DIABETES_MED_DET
                self.viewShareMedication1Step22.isHidden = false
                self.viewHeightConstraintShareMedication1Step22.constant = 80
                self.heightView += 80
                
                self.txtSinceWhenStep22.text = data.DIABETES_SINCE_WHEN
                self.viewSinceWhen1Step22.isHidden = false
                self.viewHeightConstraintSinceWhen1Step22.constant = 60
                self.heightView += 60
                
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.DIABETES_MELLITUS == "N"){
                self.noDiabetesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.txtShareMedicationDetails2Step22.text = ""
            self.viewShareMedication2Step22.isHidden = true
            self.viewHeightConstraintShareMedication2Step22.constant = 0
            
            self.txtSinceWhen2Step22.text = ""
            self.viewSinceWhen2Step22.isHidden = true
            self.viewHeightConstraintSinceWhen2Step22.constant = 0
            
            if (data.HYPERTENSION == "Y") {
                self.yesHypertensionStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtShareMedicationDetails2Step22.text = data.HYPERTENSION_MED_DET
                self.viewShareMedication2Step22.isHidden = false
                self.viewHeightConstraintShareMedication2Step22.constant = 80
                self.heightView += 80
                
                self.txtSinceWhen2Step22.text = data.HYPERTENSION_SINCE_WHEN
                self.viewSinceWhen2Step22.isHidden = false
                self.viewHeightConstraintSinceWhen2Step22.constant = 60
                self.heightView += 60
                
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.HYPERTENSION == "N"){
                self.noHypertensionStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            self.viewLikeAdditionalStep22.isHidden = true
            self.viewHeightConstraintLikeAdditionalStep22.constant = 0
            if (data.SC_AD == "Y") {
                self.yesAdvancedDirectivesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_AD == "N"){
                self.noAdvancedDirectivesStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.viewLikeAdditionalStep22.isHidden = false
                self.viewHeightConstraintLikeAdditionalStep22.constant = 60
                if (data.SC_ADDETAILS == "Y") {
                    self.yesLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                } else if (data.SC_ADDETAILS == "N"){
                    self.noLikeAdditionalDetailsStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                }
                self.heightView += 60
                self.heightConstraintContentStepView.constant = self.heightView
            }
            
            self.viewDescribeStep22.isHidden = true
            self.viewHeightConstraintDescribeStep22.constant = 0
            self.txtDescribeStep22.text = ""
            if (data.SC_RELIGIONBELIEF == "Y") {
                self.yesReligiousCulturalBeliefsImpactHealthcareStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtDescribeStep22.text = data.SC_RELIGIONBELREM
                self.viewDescribeStep22.isHidden = false
                self.viewHeightConstraintDescribeStep22.constant = 60
                self.heightView += 60
                self.heightConstraintContentStepView.constant = self.heightView
            } else if (data.SC_RELIGIONBELIEF == "N"){
                self.noReligiousCulturalBeliefsImpactHealthcareStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
            }
            
            chkVerbalInstructionsStep22 = false
            chkWrittenInstructionsStep22 = false
            chkPicturesStep22 = false
            if self.healthRiskAssessmentModel.SC_INFO != ""{
                let arrayIfnoCode = self.healthRiskAssessmentModel.SC_INFO.components(separatedBy: [","])
                if arrayIfnoCode.contains("VERBAL") {
                    chkVerbalInstructionsStep22 = true
                    chkVerbalInstructionsStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arrayIfnoCode.contains("WRITTEN") {
                    chkWrittenInstructionsStep22 = true
                    chkWrittenInstructionsStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arrayIfnoCode.contains("PICTURES") {
                    chkPicturesStep22 = true
                    chkPicturesStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
            }
            
            chkLessThanHighSchoolStep22 = false
            chkHighSchoolOrGEDStep22 = false
            chk1_4YearsStep22 = false
            chk4YearsStep22 = false
            if self.healthRiskAssessmentModel.SC_EDUCATION != ""{
                let arrayEducationCode = self.healthRiskAssessmentModel.SC_EDUCATION.components(separatedBy: [","])
                if arrayEducationCode.contains("LEVEL1") {
                    chkLessThanHighSchoolStep22 = true
                    chkLessThanHighSchoolStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arrayEducationCode.contains("LEVEL2") {
                    chkHighSchoolOrGEDStep22 = true
                    chkHighSchoolOrGEDStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arrayEducationCode.contains("LEVEL3") {
                    chk1_4YearsStep22 = true
                    chk1_4YearsStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arrayEducationCode.contains("LEVEL4") {
                    chk4YearsStep22 = true
                    chk4YearsStep22ImgView.image = UIImage.init(named: "checkbox_active")
                }
            }
            self.txtPreferLanguageStep22.text = ""
            self.viewPreferLanguageStep22.isHidden = true
            self.viewHeightConstraintPreferLanguageStep22.constant = 0
            if (data.SC_ENGLISH == "Y") {
                self.yesUnderstandEnglishWellStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
            } else if (data.SC_ENGLISH == "N"){
                self.noUnderstandEnglishWellStep22ImgView.image = UIImage.init(named: "radioBtn-checked")
                self.txtPreferLanguageStep22.text = data.SC_LANGUAGE
                self.viewPreferLanguageStep22.isHidden = false
                self.viewHeightConstraintPreferLanguageStep22.constant = 60
                self.heightView += 60
                self.heightConstraintContentStepView.constant = self.heightView
            }
        }
        else if stepNumber == 23{
            if self.healthRiskAssessmentModel.SYMPTOMCD != ""{
                let arraySymptomCode = self.healthRiskAssessmentModel.SYMPTOMCD.components(separatedBy: [","])
                if arraySymptomCode.contains("SY01") {
                    chkFeverStep23 = true
                    chkFeverStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY18") {
                    chkConvulsionsSeizuresStep23 = true
                    chkConvulsionsSeizuresStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY02") {
                    chkChillsStep23 = true
                    chkChillsStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY19") {
                    chkSuicidalStep23 = true
                    chkSuicidalStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY03") {
                    chkEyePainStep23 = true
                    chkEyePainStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY20") {
                    chkSleepDisturbancesStep23 = true
                    chkSleepDisturbancesStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY04") {
                    chkRedEyesStep23 = true
                    chkRedEyesStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY21") {
                    chkDecreasedLibidoSexualDesireStep23 = true
                    chkDecreasedLibidoSexualDesireStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY05") {
                    chkEaracheStep23 = true
                    chkEaracheStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY22") {
                    chkEasyBleedingBruisingStep23 = true
                    chkEasyBleedingBruisingStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY06") {
                    chkChestPainStep23 = true
                    chkChestPainStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY23") {
                    chkFeelingPoorlyStep23 = true
                    chkFeelingPoorlyStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY07") {
                    chkPalpitationsStep23 = true
                    chkPalpitationsStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY24") {
                    chkFeelingTiredFatiguedStep23 = true
                    chkFeelingTiredFatiguedStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY08") {
                    chkShortnessBreathStep23 = true
                    chkShortnessBreathStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY25") {
                    chkEyesightProblemsStep23 = true
                    chkEyesightProblemsStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY09") {
                    chkWheezingStep23 = true
                    chkWheezingStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY26") {
                    chkDischargeEyesStep23 = true
                    chkDischargeEyesStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY10") {
                    chkAbdominalPainStep23 = true
                    chkAbdominalPainStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY27") {
                    chkNosebleedsStep23 = true
                    chkNosebleedsStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY11") {
                    chkVomitingStep23 = true
                    chkVomitingStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY28") {
                    chkDischargeNoseStep23 = true
                    chkDischargeNoseStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY12") {
                    chkPainUrinationStep23 = true
                    chkPainUrinationStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY29") {
                    chkFastSlowHeartbeatStep23 = true
                    chkFastSlowHeartbeatStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY13") {
                    chkUrinaryIncontinenceStep23 = true
                    chkUrinaryIncontinenceStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY30") {
                    chkColdHandsFeetStep23 = true
                    chkColdHandsFeetStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY14") {
                    chkMuscleJointPainStep23 = true
                    chkMuscleJointPainStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY31") {
                    chkCoughStep23 = true
                    chkCoughStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY15") {
                    chkSkinLesionsStep23 = true
                    chkSkinLesionsStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY32") {
                    chkShortnessBreathActivityStep23 = true
                    chkShortnessBreathActivityStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY16") {
                    chkSkinWoundStep23 = true
                    chkSkinWoundStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY33") {
                    chkConstipationStep23 = true
                    chkConstipationStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY17") {
                    chkConfusionStep23 = true
                    chkConfusionStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
                if arraySymptomCode.contains("SY34") {
                    chkDiarrheaStep23 = true
                    chkDiarrheaStep23ImgView.image = UIImage.init(named: "checkbox_active")
                }
            }
            self.txtOtherSymptomsStep23.text = data.OTHSYMPTOM
        }
    }
    
    func getDataStepByStep() {
        if stepNumber == 1{
            //Step 1
            healthRiskAssessmentModel.PATIENTNM = txtName.text!
            healthRiskAssessmentModel.GENDER = txtGender.text!
            healthRiskAssessmentModel.DOB = txtDOBDate.text!
            healthRiskAssessmentModel.AGE = txtAge.text!
            healthRiskAssessmentModel.MARITALSTS = lblMaritialStatus.text!
            healthRiskAssessmentModel.NOOFCHILDREN = txtNumberOfChildren.text!
            healthRiskAssessmentModel.NOOFCHILDRENLWY = txtNumberOfChildrenLive.text!
            healthRiskAssessmentModel.OCCUPATIONCUR = txtCurrentOccupation.text!
            healthRiskAssessmentModel.OCCUPATIONPRV = txtPreviousAccupation.text!
        }
        else if stepNumber == 2{
            //Step 2
        }
        else if stepNumber == 3{
            //Step 3
            healthRiskAssessmentModel.IMM_TETANUSDT = self.txtTetanusDate.text!
            healthRiskAssessmentModel.IMM_PNEUMONIADT = self.txtPneumoniaDate.text!
            healthRiskAssessmentModel.IMM_HEPATITISADT = self.txtHepatitisADate.text!
            healthRiskAssessmentModel.IMM_HEPATITISBDT = self.txtHepatitisBDate.text!
            healthRiskAssessmentModel.IMM_CHICKENPOXDT = self.txtChickenpoxStep3Date.text!
            healthRiskAssessmentModel.IMM_INFLUENZADT = self.txtInfluenzaDate.text!
            healthRiskAssessmentModel.IMM_MUMPSDT = self.txtMumpsStep3Date.text!
            healthRiskAssessmentModel.IMM_RUBELLADT = self.txtRubellaDate.text!
            healthRiskAssessmentModel.IMM_MENINGOCOCCALDT = self.txtMeningococcalDate.text!
        }
        else if stepNumber == 4{
            //Step 4
            healthRiskAssessmentModel.SCR_EYEEXAMDT = self.txtEyeExamDate.text!
            healthRiskAssessmentModel.SCR_COLONOSCOPYDT = txtColonoscopDate.text!
            healthRiskAssessmentModel.SCR_DEXA_SCANDT = txtDexaScanDate.text!
        }
        else if stepNumber == 5{
            //Step 5
            healthRiskAssessmentModel.SURGERY1_YEAR = self.txtYear1Step5.text!
            healthRiskAssessmentModel.SURGERY1_PROV = self.txtHospitalName1Step5.text!
            healthRiskAssessmentModel.SURGERY1_REASON = self.txtReasonSurgery1Step5.text!

            healthRiskAssessmentModel.SURGERY2_YEAR = self.txtYear2Step5.text!
            healthRiskAssessmentModel.SURGERY2_PROV = self.txtHospitalName2Step5.text!
            healthRiskAssessmentModel.SURGERY2_REASON = self.txtReasonSurgery2Step5.text!

            healthRiskAssessmentModel.SURGERY3_YEAR = self.txtYear3Step5.text!
            healthRiskAssessmentModel.SURGERY3_PROV = self.txtHospitalName3Step5.text!
            healthRiskAssessmentModel.SURGERY3_REASON = self.txtReasonSurgery3Step5.text!

            healthRiskAssessmentModel.SURGERY4_YEAR = self.txtYear4Step5.text!
            healthRiskAssessmentModel.SURGERY4_PROV = self.txtHospitalName4Step5.text!
            healthRiskAssessmentModel.SURGERY4_REASON = self.txtReasonSurgery4Step5.text!

            healthRiskAssessmentModel.SURGERY5_YEAR = self.txtYear5Step5.text!
            healthRiskAssessmentModel.SURGERY5_PROV = self.txtHospitalName5Step5.text!
            healthRiskAssessmentModel.SURGERY5_REASON = self.txtReasonSurgery5Step5.text!
        }
        else if stepNumber == 6{
            //Step 6
            healthRiskAssessmentModel.HOSP1_YEAR = self.txtYear1Step6.text!
            healthRiskAssessmentModel.HOSP1_PROV = self.txtHospitalName1Step6.text!
            healthRiskAssessmentModel.HOSP1_REASON = self.txtReasonHospitilization1Step6.text!

            healthRiskAssessmentModel.HOSP2_YEAR = self.txtYear2Step6.text!
            healthRiskAssessmentModel.HOSP2_PROV = self.txtHospitalName2Step6.text!
            healthRiskAssessmentModel.HOSP2_REASON = self.txtReasonHospitilization2Step6.text!

            healthRiskAssessmentModel.HOSP3_YEAR = self.txtYear3Step6.text!
            healthRiskAssessmentModel.HOSPY3_PROV = self.txtHospitalName3Step6.text!
            healthRiskAssessmentModel.HOSP3_REASON = self.txtReasonHospitilization3Step6.text!

            healthRiskAssessmentModel.HOSP4_YEAR = self.txtYear4Step6.text!
            healthRiskAssessmentModel.HOSP4_PROV = self.txtHospitalName4Step6.text!
            healthRiskAssessmentModel.HOSP4_REASON = self.txtReasonHospitilization4Step6.text!

            healthRiskAssessmentModel.HOSP5_YEAR = self.txtYear5Step6.text!
            healthRiskAssessmentModel.HOSP5_PROV = self.txtHospitalName5Step6.text!
            healthRiskAssessmentModel.HOSP5_REASON = self.txtReasonHospitilization5Step6.text!
        }
        else if stepNumber == 7{
            //Step 7
            healthRiskAssessmentModel.DOCVST1_YEAR = self.txtMonth1Step7.text!
            healthRiskAssessmentModel.DOCVST1_PROV = self.txtProviderName1Step7.text!
            healthRiskAssessmentModel.DOCVST1_REASON = self.txtReasonVisit1Step7.text!

            healthRiskAssessmentModel.DOCVST2_YEAR = self.txtMonth2Step7.text!
            healthRiskAssessmentModel.DOCVST2_PROV = self.txtProviderName2Step7.text!
            healthRiskAssessmentModel.DOCVST2_REASON = self.txtReasonVisit2Step7.text!

            healthRiskAssessmentModel.DOCVST3_YEAR = self.txtMonth3Step7.text!
            healthRiskAssessmentModel.DOCVST3_PROV = self.txtProviderName3Step7.text!
            healthRiskAssessmentModel.DOCVST3_REASON = self.txtReasonVisit3Step7.text!

            healthRiskAssessmentModel.DOCVST4_YEAR = self.txtMonth4Step7.text!
            healthRiskAssessmentModel.DOCVST4_PROV = self.txtProviderName4Step7.text!
            healthRiskAssessmentModel.DOCVST4_REASON = self.txtReasonVisit4Step7.text!

            healthRiskAssessmentModel.DOCVST5_YEAR = self.txtMonth5Step7.text!
            healthRiskAssessmentModel.DOCVST5_PROV = self.txtProviderName5Step7.text!
            healthRiskAssessmentModel.DOCVST5_REASON = self.txtReasonVisit5Step7.text!
        }
        else if stepNumber == 8{
            //Step 8
            getValueStep8()
        }
        else if stepNumber == 9{
            //Step 9
            healthRiskAssessmentModel.PASTMEDHIST = self.txtmedicalProblemsStep9.text!
            healthRiskAssessmentModel.PREVREFDOC = self.txtReferringDoctorStep9.text!
            healthRiskAssessmentModel.PHYSICALEXAMDT = self.txtDatePhysicalExamStep9.text!
        }
        else if stepNumber == 10{
            //Step 10
            healthRiskAssessmentModel.MEDICATION1_NAME = self.txtName1Step10.text!
            healthRiskAssessmentModel.MEDICATION1_DOSAGE = self.txtDosageFrequency1Step10.text!

            healthRiskAssessmentModel.MEDICATION2_NAME = self.txtName2Step10.text!
            healthRiskAssessmentModel.MEDICATION2_DOSAGE = self.txtDosageFrequency2Step10.text!

            healthRiskAssessmentModel.MEDICATION3_NAME = self.txtName3Step10.text!
            healthRiskAssessmentModel.MEDICATION3_DOSAGE = self.txtDosageFrequency3Step10.text!

            healthRiskAssessmentModel.MEDICATION4_NAME = self.txtName4Step10.text!
            healthRiskAssessmentModel.MEDICATION4_DOSAGE = self.txtDosageFrequency4Step10.text!
            healthRiskAssessmentModel.MEDICATION5_NAME = self.txtName5Step10.text!
            healthRiskAssessmentModel.MEDICATION5_DOSAGE = self.txtDosageFrequency5Step10.text!
        }
        else if stepNumber == 11{
            //Step 11
            healthRiskAssessmentModel.ALERGY1_NAME = self.txtName1Step11.text!
            healthRiskAssessmentModel.ALERGY1_REACTION = self.txtReactionYouHad1Step11.text!
            healthRiskAssessmentModel.ALERGY2_NAME = self.txtName2Step11.text!
            healthRiskAssessmentModel.ALERGY2_REACTION = self.txtReactionYouHad2Step11.text!
            healthRiskAssessmentModel.ALERGY3_NAME = self.txtName3Step11.text!
            healthRiskAssessmentModel.ALERGY3_REACTION = self.txtReactionYouHad3Step11.text!
        }
        else if stepNumber == 12{
            //Step 12
            getValueStep12()
        }
        else if stepNumber == 13{
            healthRiskAssessmentModel.SC_EXERCISEDUR = self.txtMinutesStep13.text!
            healthRiskAssessmentModel.SC_MEALPRDAY = self.txtMealsEatAverageDayStep13.text!
            if healthRiskAssessmentModel.SC_MEALPRDAY != ""{
                let newString = healthRiskAssessmentModel.SC_MEALPRDAY.replacingOccurrences(of: pleaseSelect, with: "")
                healthRiskAssessmentModel.SC_MEALPRDAY = newString
            }
            healthRiskAssessmentModel.SC_SALTINTAKE = self.txtRankSaltIntakeStep13.text!
            if healthRiskAssessmentModel.SC_SALTINTAKE != ""{
                let newString = healthRiskAssessmentModel.SC_SALTINTAKE.replacingOccurrences(of: pleaseSelect, with: "")
                healthRiskAssessmentModel.SC_SALTINTAKE = newString
            }
            healthRiskAssessmentModel.SC_FATINTAKE = self.txtRankFatIntake1Step13.text!
            if healthRiskAssessmentModel.SC_FATINTAKE != ""{
                let newString = healthRiskAssessmentModel.SC_FATINTAKE.replacingOccurrences(of: pleaseSelect, with: "")
                healthRiskAssessmentModel.SC_FATINTAKE = newString
            }
            healthRiskAssessmentModel.SC_CAFFINEINTAKE = self.txtpreferredDrinkStep13.text!
            healthRiskAssessmentModel.SC_CAFFINEPERDAY = self.txtRankFatIntake2Step13.text!
            if healthRiskAssessmentModel.SC_CAFFINEPERDAY != ""{
                let newString = healthRiskAssessmentModel.SC_CAFFINEPERDAY.replacingOccurrences(of: pleaseSelect, with: "")
                healthRiskAssessmentModel.SC_CAFFINEPERDAY = newString
            }
        }
        else if stepNumber == 14{
            healthRiskAssessmentModel.SC_ALCOHOLTYP = self.txtWhatKindStep14.text!
            healthRiskAssessmentModel.SC_ALCOHOLPWK = self.txtDrinksPerWeekStep14.text!
        }
        else if stepNumber == 15{
            healthRiskAssessmentModel.SC_TOBACCOPKSDAY = self.txtpksDayStep15.text!
            healthRiskAssessmentModel.SC_TOBACCOPKSWEEK = self.txtPksWeekStep15.text!
            healthRiskAssessmentModel.SC_TOBACCOCHW_DES = self.txtChewDayStep15.text!
            healthRiskAssessmentModel.SC_TOBACCOCPP_DES = self.txtPipeDayStep15.text!
            healthRiskAssessmentModel.SC_TOBACCOCCG_DES = self.txtCigarsDayStep15.text!
            healthRiskAssessmentModel.SC_TOBACCOYRS_DES = self.txtOfYearsInTobaccoStep15.text!
            healthRiskAssessmentModel.SC_TOBACCOYRSQT_DES = self.txtNumberOfYearsQuitStep15.text!
        }
        else if stepNumber == 16{

        }
        else if stepNumber == 17{
            healthRiskAssessmentModel.SC_SEXCONTRA = self.txtListContraceptiveStep17.text!
        }
        else if stepNumber == 20{
            healthRiskAssessmentModel.WH_MENSTAG = self.txtAgeAtOnsetOfMenstruationStep20.text!
            healthRiskAssessmentModel.WH_MENSTLASTDT = self.txtDateOfLastMenstruationStep20.text!
            healthRiskAssessmentModel.WH_MENSTDAYS = self.txtPeriodDaysStep20.text!
            healthRiskAssessmentModel.WH_PREGCOUNT = self.txtNumberOfPregnanciesStep20.text!
            healthRiskAssessmentModel.WH_LIVEBIRTH = self.txtNumberOfLiveBirthsStep20.text!
            healthRiskAssessmentModel.WH_PELPEPSMEAR = self.txtDateOfLastPapSmearPelvicStep20.text!
        }
        else if stepNumber == 21{
            healthRiskAssessmentModel.MH_PROSRECEXAM = self.txtDateLastProstateRectalExamStep21.text!
        }
        else if stepNumber == 22{
            healthRiskAssessmentModel.DIABETES_MED_DET = self.txtShareMedicationDetailsStep22.text!
            healthRiskAssessmentModel.DIABETES_SINCE_WHEN = self.txtSinceWhenStep22.text!
            healthRiskAssessmentModel.HYPERTENSION_MED_DET = self.txtShareMedicationDetails2Step22.text!
            healthRiskAssessmentModel.HYPERTENSION_SINCE_WHEN = self.txtSinceWhen2Step22.text!
            healthRiskAssessmentModel.SC_RELIGIONBELREM = self.txtDescribeStep22.text!
            healthRiskAssessmentModel.SC_INFO = ""
            if chkVerbalInstructionsStep22 {
                self.healthRiskAssessmentModel.SC_INFO += self.healthRiskAssessmentModel.SC_INFO != "" ? ",VERBAL" : "VERBAL"
            }
            if chkWrittenInstructionsStep22 {
                self.healthRiskAssessmentModel.SC_INFO += self.healthRiskAssessmentModel.SC_INFO != "" ? ",WRITTEN" : "WRITTEN"
            }
            if chkPicturesStep22 {
                self.healthRiskAssessmentModel.SC_INFO += self.healthRiskAssessmentModel.SC_INFO != "" ? ",PICTURES" : "PICTURES"
            }
            healthRiskAssessmentModel.SC_EDUCATION = ""
            if chkLessThanHighSchoolStep22 {
                self.healthRiskAssessmentModel.SC_EDUCATION += self.healthRiskAssessmentModel.SC_EDUCATION != "" ? ",LEVEL1" : "LEVEL1"
            }
            if chkHighSchoolOrGEDStep22 {
                self.healthRiskAssessmentModel.SC_EDUCATION += self.healthRiskAssessmentModel.SC_EDUCATION != "" ? ",LEVEL2" : "LEVEL2"
            }
            if chk1_4YearsStep22 {
                self.healthRiskAssessmentModel.SC_EDUCATION += self.healthRiskAssessmentModel.SC_EDUCATION != "" ? ",LEVEL3" : "LEVEL3"
            }
            if chk4YearsStep22 {
                self.healthRiskAssessmentModel.SC_EDUCATION += self.healthRiskAssessmentModel.SC_EDUCATION != "" ? ",LEVEL4" : "LEVEL4"
            }
            healthRiskAssessmentModel.SC_LANGUAGE = self.txtPreferLanguageStep22.text!
        }
        else if stepNumber == 23{
            getValueStep23()
        }
    }
    
    func getValueStep8(){
        self.healthRiskAssessmentModel.MEDICALHISTORYCD = ""
        if alcoholAbuseStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH01" : "MH01"
        }
        if diabetesStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH18" : "MH18"
        }
        if anemiaStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH02" : "MH02"
        }
        if migrainesStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH19" : "MH19"
        }
        if anestheticComplicationStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH03" : "MH03"
        }
        if osteoporosisStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH20" : "MH20"
        }
        if anxietyDisorderStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH04" : "MH04"
        }
        if prostateCancerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH21" : "MH21"
        }
        if arthritis1Step8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH05" : "MH05"
        }
        if rectalCancerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH22" : "MH22"
        }
        if asthmaStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH06" : "MH06"
        }
        if refluxGERDStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH23" : "MH23"
        }
        if autoimmuneProblemsStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH07" : "MH07"
        }
        if seizuresConvulsionsStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH24" : "MH24"
        }
        if birthDefectsStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH08" : "MH08"
        }
        if severeAllergyStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH25" : "MH25"
        }
        if bladderProblemsStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH09" : "MH09"
        }
        if sexuallyTransmittedDiseaseStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH26" : "MH26"
        }
        if bleedingDiseaseStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH10" : "MH10"
        }
        if skinCancerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH27" : "MH27"
        }
        if bloodClotsStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH11" : "MH11"
        }
        if strokeCVAoftheBrainStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH28" : "MH28"
        }
        if bloodTransfusionStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH12" : "MH12"
        }
        if suicideAttemptStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH29" : "MH29"
        }
        if bowelDiseaseStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH13" : "MH13"
        }
        if thyroidProblemsStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH30" : "MH30"
        }
        if breastCancerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH14" : "MH14"
        }
        if ulcerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH31" : "MH31"
        }
        if cervicalCancerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH15" : "MH15"
        }
        if visualImpairmentStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH32" : "MH32"
        }
        if colonCancerStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH16" : "MH16"
        }
        if otherStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH33" : "MH33"
        }
        if depressionStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD += self.healthRiskAssessmentModel.MEDICALHISTORYCD != "" ? ",MH17" : "MH17"
        }
        if noneOfTheAboveStep8 {
            self.healthRiskAssessmentModel.MEDICALHISTORYCD = "MH34"
        }
    }
    
    func getValueStep12(){
        self.healthRiskAssessmentModel.FMEDICALHISTORYCD = ""
        if iAmAdoptedStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH01" : "FH01"
        }
        if leukemiaStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH18" : "FH18"
        }
        if familyHistoryUnknownStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH02" : "FH02"
        }
        if lungRespiratoryDiseaseStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH19" : "FH19"
        }
        if alcoholAbuseStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH03" : "FH03"
        }
        if migrainesStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH20" : "FH20"
        }
        if anemiaStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH04" : "FH04"
        }
        if osteoporosisStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH21" : "FH21"
        }
        if anestheticComplicationStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH05" : "FH05"
        }
        if otherCancerStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH22" : "FH22"
        }
        if arthritisStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH06" : "FH06"
        }
        if rectalCancerStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH23" : "FH23"
        }
        if asthmaStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH07" : "FH07"
        }
        if seizuresConvulsionsStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH24" : "FH24"
        }
        if bladderProblemsStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH08" : "FH08"
        }
        if severeAllergyStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH25" : "FH25"
        }
        if bleedingDiseaseStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH09" : "FH09"
        }
        if strokeCVAoftheBrainStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH26" : "FH26"
        }
        if breastCancerStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH10" : "FH10"
        }
        if thyroidProblemsStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH27" : "FH27"
        }
        if colonCancerStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH11" : "FH11"
        }
        if motherStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH28" : "FH28"
        }
        if depressionStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH12" : "FH12"
        }
        if fatherStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH29" : "FH29"
        }
        if diabetesStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH13" : "FH13"
        }
        if heartDiseaseStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH14" : "FH14"
        }
        if highBloodPressureStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH15" : "FH15"
        }
        if highCholesterolStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH16" : "FH16"
        }
        if kidneyDiseaseStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD += self.healthRiskAssessmentModel.FMEDICALHISTORYCD != "" ? ",FH17" : "FH17"
        }
        if noneOfTheAboveStep12 {
            self.healthRiskAssessmentModel.FMEDICALHISTORYCD = "FH30"
        }
    }
    
    func getValueStep23(){
        self.healthRiskAssessmentModel.SYMPTOMCD = ""
        if chkFeverStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY01" : "SY01"
        }
        if chkConvulsionsSeizuresStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY18" : "SY18"
        }
        if chkChillsStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY02" : "SY02"
        }
        if chkSuicidalStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY19" : "SY19"
        }
        if chkEyePainStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY03" : "SY03"
        }
        if chkSleepDisturbancesStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY20" : "SY20"
        }
        if chkRedEyesStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY04" : "SY04"
        }
        if chkDecreasedLibidoSexualDesireStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY21" : "SY21"
        }
        if chkEaracheStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY05" : "SY05"
        }
        if chkEasyBleedingBruisingStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY22" : "SY22"
        }
        if chkChestPainStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY06" : "SY06"
        }
        if chkFeelingPoorlyStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY23" : "SY23"
        }
        if chkPalpitationsStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY07" : "SY07"
        }
        if chkFeelingTiredFatiguedStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY24" : "SY24"
        }
        if chkShortnessBreathStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY08" : "SY08"
        }
        if chkEyesightProblemsStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY25" : "SY25"
        }
        if chkWheezingStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY09" : "SY09"
        }
        if chkDischargeEyesStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY26" : "SY26"
        }
        if chkAbdominalPainStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY10" : "SY10"
        }
        if chkNosebleedsStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY27" : "SY27"
        }
        if chkVomitingStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY11" : "SY11"
        }
        if chkDischargeNoseStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY28" : "SY28"
        }
        if chkPainUrinationStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY12" : "SY12"
        }
        if chkFastSlowHeartbeatStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY29" : "SY29"
        }
        if chkUrinaryIncontinenceStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY13" : "SY13"
        }
        if chkColdHandsFeetStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY30" : "SY30"
        }
        if chkMuscleJointPainStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY14" : "SY14"
        }
        if chkCoughStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY31" : "SY31"
        }
        if chkSkinLesionsStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY15" : "SY15"
        }
        if chkShortnessBreathActivityStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY32" : "SY32"
        }
        if chkSkinWoundStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY16" : "SY16"
        }
        if chkConstipationStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY33" : "SY33"
        }
        if chkConfusionStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY17" : "SY17"
        }
        if chkDiarrheaStep23 {
            self.healthRiskAssessmentModel.SYMPTOMCD += self.healthRiskAssessmentModel.SYMPTOMCD != "" ? ",SY34" : "SY34"
        }
        self.healthRiskAssessmentModel.OTHSYMPTOM = self.txtOtherSymptomsStep23.text!
    }
    
    func validateInput() -> Bool{
        if stepNumber == 1 {
            if healthRiskAssessmentModel.PATIENTNM == "" {
                self.displayAlert(message: "\"Nama\" can not be null.")
                return false
            }else if healthRiskAssessmentModel.MARITALSTS == "" || healthRiskAssessmentModel.MARITALSTS == pleaseSelect{
                self.displayAlert(message: "Please select your \"Status Pernikahan\".")
                return false
            }
        }
        else if stepNumber > 1 && stepNumber < 24
        {
            if strSelected == "" {
                self.displayAlert(message: "Atleast 1 Value has to be Selected.")
                return false
            }//step 3
            else if !isValidateDate(healthRiskAssessmentModel.IMM_TETANUSDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_PNEUMONIADT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_HEPATITISADT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_HEPATITISBDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_CHICKENPOXDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_INFLUENZADT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_MUMPSDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_RUBELLADT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.IMM_MENINGOCOCCALDT,self.formatDate)
            {
                self.displayAlert(message: "Date value is not valid.")
                return false
            }
            //step 4
            else if !isValidateDate(healthRiskAssessmentModel.SCR_EYEEXAMDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.SCR_COLONOSCOPYDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.SCR_DEXA_SCANDT,self.formatDate)
            {
                self.displayAlert(message: "Date value is not valid.")
                return false
            }
            //step 9
            else if !isValidateDate(healthRiskAssessmentModel.PHYSICALEXAMDT,self.formatDate)
            {
                self.displayAlert(message: "Date value is not valid.")
                return false
            }
            //step 20
            else if !isValidateDate(healthRiskAssessmentModel.WH_MENSTLASTDT,self.formatDate)
                        || !isValidateDate(healthRiskAssessmentModel.WH_PELPEPSMEAR,self.formatDate)
            {
                self.displayAlert(message: "Date value is not valid.")
                return false
            }
            //step 21
            else if !isValidateDate(healthRiskAssessmentModel.MH_PROSRECEXAM,self.formatDate)
            {
                self.displayAlert(message: "Date value is not valid.")
                return false
            }
            else {
                let newString = strSelected.replacingOccurrences(of: pleaseSelect, with: "")
                if newString.trim() == "" {
                    self.displayAlert(message: "Atleast 1 Value has to be Selected.")
                    return false
                }
            }
        }
        return true
    }

    //MARK: Service Call
    
    func serviceCallAdd(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let pstMemId: String = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            let encryptedUserId: String = AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId)
            let userId = try! encryptedUserId.aesDecrypt()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            var params: Parameters = [:]
            params["PATIENTNM"] = healthRiskAssessmentModel.PATIENTNM
            params["GENDER"] = healthRiskAssessmentModel.GENDER
            params["DOB"] = healthRiskAssessmentModel.DOB
            params["AGE"] = healthRiskAssessmentModel.AGE
            params["MARITALSTS"] = healthRiskAssessmentModel.MARITALSTS
            params["NOOFCHILDREN"] = healthRiskAssessmentModel.NOOFCHILDREN
            params["NOOFCHILDRENLWY"] = healthRiskAssessmentModel.NOOFCHILDRENLWY
            params["OCCUPATIONCUR"] = healthRiskAssessmentModel.OCCUPATIONCUR
            params["OCCUPATIONPRV"] = healthRiskAssessmentModel.OCCUPATIONPRV
            params["CARDNO"] = healthRiskAssessmentModel.CARDNO
            params["EMPID"] = healthRiskAssessmentModel.EMPID
            params["MEMCTLNO"] = healthRiskAssessmentModel.MEMCTLNO
            params["PAYORCD"] = healthRiskAssessmentModel.PAYORCD
            params["CORPCD"] = healthRiskAssessmentModel.CORPCD
            params["ICNO"] = healthRiskAssessmentModel.ICNO
            params["DEPID"] = healthRiskAssessmentModel.DEPID
            params["MEMID"] = pstMemId
            params["INSBY"] = userId
            params["UPDBY"] = userId
            
            print("params===\(params)")
            print("url===\(AppConstant.postAddHealthRiskAssessmentUrl)")
            AFManager.request( AppConstant.postAddHealthRiskAssessmentUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallAdd()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let response = dict!["Data"] as? [String: AnyObject]{
                                        if let strValue = response["HRAID"] as? String
                                        {
                                            self.healthRiskAssessmentModel.HRAID = strValue
                                        }
                                    }
                                    self.stepNumber = self.stepNumber + 1
                                    self.stepNumberDisplay = self.stepNumberDisplay + 1
                                    self.controlStep()
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postAddHealthRiskAssessmentUrl)
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallUpdateStepByStep()
    {
        if AppConstant.hasConnectivity()
        {
            self.strSelected = ""
            let encryptedUserId: String = AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId)
            let userId = try! encryptedUserId.aesDecrypt()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            var params: Parameters = [:]
            params["HRAID"] = healthRiskAssessmentModel.HRAID
            params["UPDBY"] = userId
            params["STEP"] = String(stepNumber)
            
            if self.stepNumber == 1
            {
                params["PATIENTNM"] = healthRiskAssessmentModel.PATIENTNM
                params["GENDER"] = healthRiskAssessmentModel.GENDER
                params["DOB"] = healthRiskAssessmentModel.DOB
                params["AGE"] = healthRiskAssessmentModel.AGE
                params["MARITALSTS"] = healthRiskAssessmentModel.MARITALSTS
                params["NOOFCHILDREN"] = healthRiskAssessmentModel.NOOFCHILDREN
                params["NOOFCHILDRENLWY"] = healthRiskAssessmentModel.NOOFCHILDRENLWY
                params["OCCUPATIONCUR"] = healthRiskAssessmentModel.OCCUPATIONCUR
                params["OCCUPATIONPRV"] = healthRiskAssessmentModel.OCCUPATIONPRV
            }
            else if self.stepNumber == 2 {
                self.strSelected = healthRiskAssessmentModel.CHILDHDILLNESS_MEASLES + healthRiskAssessmentModel.CHILDHDILLNESS_MUMPS + healthRiskAssessmentModel.CHILDHDILLNESS_RUB + healthRiskAssessmentModel.CHILDHDILLNESS_CHKPOX + healthRiskAssessmentModel.CHILDHDILLNESS_RTFEVER + healthRiskAssessmentModel.CHILDHDILLNESS_POLIO + healthRiskAssessmentModel.CHILDHDILLNESS_NONE
                
                params["CHILDHDILLNESS_MEASLES"] = healthRiskAssessmentModel.CHILDHDILLNESS_MEASLES
                params["CHILDHDILLNESS_MUMPS"] = healthRiskAssessmentModel.CHILDHDILLNESS_MUMPS
                params["CHILDHDILLNESS_RUB"] = healthRiskAssessmentModel.CHILDHDILLNESS_RUB
                params["CHILDHDILLNESS_CHKPOX"] = healthRiskAssessmentModel.CHILDHDILLNESS_CHKPOX
                params["CHILDHDILLNESS_RTFEVER"] = healthRiskAssessmentModel.CHILDHDILLNESS_RTFEVER
                params["CHILDHDILLNESS_POLIO"] = healthRiskAssessmentModel.CHILDHDILLNESS_POLIO
                params["CHILDHDILLNESS_NONE"] = healthRiskAssessmentModel.CHILDHDILLNESS_NONE
            }
            else if self.stepNumber == 3 {
                self.strSelected = healthRiskAssessmentModel.IMM_TETANUS + healthRiskAssessmentModel.IMM_PNEUMONIA + healthRiskAssessmentModel.IMM_HEPATITISA + healthRiskAssessmentModel.IMM_HEPATITISB + healthRiskAssessmentModel.IMM_CHICKENPOX + healthRiskAssessmentModel.IMM_INFLUENZA + healthRiskAssessmentModel.IMM_MUMPS + healthRiskAssessmentModel.IMM_RUBELLA + healthRiskAssessmentModel.IMM_MENINGOCOCCAL + healthRiskAssessmentModel.IMM_NONE
                
                params["IMM_TETANUS"] = healthRiskAssessmentModel.IMM_TETANUS
                params["IMM_TETANUSDT"] = healthRiskAssessmentModel.IMM_TETANUSDT
                params["IMM_PNEUMONIA"] = healthRiskAssessmentModel.IMM_PNEUMONIA
                params["IMM_PNEUMONIADT"] = healthRiskAssessmentModel.IMM_PNEUMONIADT
                params["IMM_HEPATITISA"] = healthRiskAssessmentModel.IMM_HEPATITISA
                params["IMM_HEPATITISADT"] = healthRiskAssessmentModel.IMM_HEPATITISADT
                params["IMM_HEPATITISB"] = healthRiskAssessmentModel.IMM_HEPATITISB
                params["IMM_HEPATITISBDT"] = healthRiskAssessmentModel.IMM_HEPATITISBDT
                params["IMM_CHICKENPOX"] = healthRiskAssessmentModel.IMM_CHICKENPOX
                params["IMM_CHICKENPOXDT"] = healthRiskAssessmentModel.IMM_CHICKENPOXDT
                params["IMM_INFLUENZA"] = healthRiskAssessmentModel.IMM_INFLUENZA
                params["IMM_INFLUENZADT"] = healthRiskAssessmentModel.IMM_INFLUENZADT
                params["IMM_MUMPS"] = healthRiskAssessmentModel.IMM_MUMPS
                params["IMM_MUMPSDT"] = healthRiskAssessmentModel.IMM_MUMPSDT
                params["IMM_RUBELLA"] = healthRiskAssessmentModel.IMM_RUBELLA
                params["IMM_RUBELLADT"] = healthRiskAssessmentModel.IMM_RUBELLADT
                params["IMM_MENINGOCOCCAL"] = healthRiskAssessmentModel.IMM_MENINGOCOCCAL
                params["IMM_MENINGOCOCCALDT"] = healthRiskAssessmentModel.IMM_MENINGOCOCCALDT
                params["IMM_NONE"] = healthRiskAssessmentModel.IMM_NONE
            }
            else if self.stepNumber == 4 {
                self.strSelected = healthRiskAssessmentModel.SCR_EYEEXAM + healthRiskAssessmentModel.SCR_COLONOSCOPY + healthRiskAssessmentModel.SCR_DEXA_SCAN + healthRiskAssessmentModel.SCR_NONE
                
                params["SCR_EYEEXAM"] = healthRiskAssessmentModel.SCR_EYEEXAM
                params["SCR_EYEEXAMDT"] = healthRiskAssessmentModel.SCR_EYEEXAMDT
                params["SCR_COLONOSCOPY"] = healthRiskAssessmentModel.SCR_COLONOSCOPY
                params["SCR_COLONOSCOPYDT"] = healthRiskAssessmentModel.SCR_COLONOSCOPYDT
                params["SCR_DEXA_SCAN"] = healthRiskAssessmentModel.SCR_DEXA_SCAN
                params["SCR_DEXA_SCANDT"] = healthRiskAssessmentModel.SCR_DEXA_SCANDT
                params["SCR_NONE"] = healthRiskAssessmentModel.SCR_NONE
            }
            else if self.stepNumber == 5 {
                self.strSelected = healthRiskAssessmentModel.SURGERY1 + healthRiskAssessmentModel.SURGERY2 + healthRiskAssessmentModel.SURGERY3 + healthRiskAssessmentModel.SURGERY4 + healthRiskAssessmentModel.SURGERY5 + healthRiskAssessmentModel.SURGERY_DONEBF;
                
                params["SURGERY1"] = healthRiskAssessmentModel.SURGERY1
                params["SURGERY1_YEAR"] = healthRiskAssessmentModel.SURGERY1_YEAR
                params["SURGERY1_REASON"] = healthRiskAssessmentModel.SURGERY1_REASON
                params["SURGERY1_PROV"] = healthRiskAssessmentModel.SURGERY1_PROV
                params["SURGERY2"] = healthRiskAssessmentModel.SURGERY2
                params["SURGERY2_YEAR"] = healthRiskAssessmentModel.SURGERY2_YEAR
                params["SURGERY2_REASON"] = healthRiskAssessmentModel.SURGERY2_REASON
                params["SURGERY2_PROV"] = healthRiskAssessmentModel.SURGERY2_PROV
                params["SURGERY3"] = healthRiskAssessmentModel.SURGERY3
                params["SURGERY3_YEAR"] = healthRiskAssessmentModel.SURGERY3_YEAR
                params["SURGERY3_REASON"] = healthRiskAssessmentModel.SURGERY3_REASON
                params["SURGERY3_PROV"] = healthRiskAssessmentModel.SURGERY3_PROV
                params["SURGERY4"] = healthRiskAssessmentModel.SURGERY4
                params["SURGERY4_YEAR"] = healthRiskAssessmentModel.SURGERY4_YEAR
                params["SURGERY4_REASON"] = healthRiskAssessmentModel.SURGERY4_REASON
                params["SURGERY4_PROV"] = healthRiskAssessmentModel.SURGERY4_PROV
                params["SURGERY5"] = healthRiskAssessmentModel.SURGERY5
                params["SURGERY5_YEAR"] = healthRiskAssessmentModel.SURGERY5_YEAR
                params["SURGERY5_REASON"] = healthRiskAssessmentModel.SURGERY5_REASON
                params["SURGERY5_PROV"] = healthRiskAssessmentModel.SURGERY5_PROV
                params["SURGERY_DONEBF"] = healthRiskAssessmentModel.SURGERY_DONEBF
            }
            else if self.stepNumber == 6 {
                self.strSelected = healthRiskAssessmentModel.HOSP1 + healthRiskAssessmentModel.HOSP2 + healthRiskAssessmentModel.HOSP3 + healthRiskAssessmentModel.HOSP4 + healthRiskAssessmentModel.HOSP5 + healthRiskAssessmentModel.HOSPY_DONEBF;
                
                params["HOSP1"] = healthRiskAssessmentModel.HOSP1
                params["HOSP1_YEAR"] = healthRiskAssessmentModel.HOSP1_YEAR
                params["HOSP1_REASON"] = healthRiskAssessmentModel.HOSP1_REASON
                params["HOSP1_PROV"] = healthRiskAssessmentModel.HOSP1_PROV
                
                params["HOSP2"] = healthRiskAssessmentModel.HOSP2
                params["HOSP2_YEAR"] = healthRiskAssessmentModel.HOSP2_YEAR
                params["HOSP2_REASON"] = healthRiskAssessmentModel.HOSP2_REASON
                params["HOSP2_PROV"] = healthRiskAssessmentModel.HOSP2_PROV
                
                params["HOSP3"] = healthRiskAssessmentModel.HOSP3
                params["HOSP3_YEAR"] = healthRiskAssessmentModel.HOSP3_YEAR
                params["HOSP3_REASON"] = healthRiskAssessmentModel.HOSP3_REASON
                params["HOSPY3_PROV"] = healthRiskAssessmentModel.HOSPY3_PROV
                
                params["HOSP4"] = healthRiskAssessmentModel.HOSP4
                params["HOSP4_YEAR"] = healthRiskAssessmentModel.HOSP4_YEAR
                params["HOSP4_REASON"] = healthRiskAssessmentModel.HOSP4_REASON
                params["HOSP4_PROV"] = healthRiskAssessmentModel.HOSP4_PROV
                
                params["HOSP5"] = healthRiskAssessmentModel.HOSP5
                params["HOSP5_YEAR"] = healthRiskAssessmentModel.HOSP5_YEAR
                params["HOSP5_REASON"] = healthRiskAssessmentModel.HOSP5_REASON
                params["HOSP5_PROV"] = healthRiskAssessmentModel.HOSP5_PROV
                
                params["HOSPY_DONEBF"] = healthRiskAssessmentModel.HOSPY_DONEBF
            }
            else if self.stepNumber == 7 {
                self.strSelected = healthRiskAssessmentModel.DOCVST1 + healthRiskAssessmentModel.DOCVST2 + healthRiskAssessmentModel.DOCVST3 + healthRiskAssessmentModel.DOCVST4 + healthRiskAssessmentModel.DOCVST5 + healthRiskAssessmentModel.DOCVST_DONEBF;
                
                params["DOCVST1"] = healthRiskAssessmentModel.DOCVST1
                params["DOCVST1_YEAR"] = healthRiskAssessmentModel.DOCVST1_YEAR
                params["DOCVST1_REASON"] = healthRiskAssessmentModel.DOCVST1_REASON
                params["DOCVST1_PROV"] = healthRiskAssessmentModel.DOCVST1_PROV
                
                params["DOCVST2"] = healthRiskAssessmentModel.DOCVST2
                params["DOCVST2_YEAR"] = healthRiskAssessmentModel.DOCVST2_YEAR
                params["DOCVST2_REASON"] = healthRiskAssessmentModel.DOCVST2_REASON
                params["DOCVST2_PROV"] = healthRiskAssessmentModel.DOCVST2_PROV
                
                params["DOCVST3"] = healthRiskAssessmentModel.DOCVST3
                params["DOCVST3_YEAR"] = healthRiskAssessmentModel.DOCVST3_YEAR
                params["DOCVST3_REASON"] = healthRiskAssessmentModel.DOCVST3_REASON
                params["DOCVST3_PROV"] = healthRiskAssessmentModel.DOCVST3_PROV
                
                params["DOCVST4"] = healthRiskAssessmentModel.DOCVST4
                params["DOCVST4_YEAR"] = healthRiskAssessmentModel.DOCVST4_YEAR
                params["DOCVST4_REASON"] = healthRiskAssessmentModel.DOCVST4_REASON
                params["DOCVST4_PROV"] = healthRiskAssessmentModel.DOCVST4_PROV
                
                params["DOCVST5"] = healthRiskAssessmentModel.DOCVST5
                params["DOCVST5_YEAR"] = healthRiskAssessmentModel.DOCVST5_YEAR
                params["DOCVST5_REASON"] = healthRiskAssessmentModel.DOCVST5_REASON
                params["DOCVST5_PROV"] = healthRiskAssessmentModel.DOCVST5_PROV
                
                params["DOCVST_DONEBF"] = healthRiskAssessmentModel.DOCVST_DONEBF
            }
            else if self.stepNumber == 8 {
                self.strSelected = healthRiskAssessmentModel.MEDICALHISTORYCD;
                params["MEDICALHISTORYCD"] = healthRiskAssessmentModel.MEDICALHISTORYCD
            }
            else if self.stepNumber == 9 {
                self.strSelected = healthRiskAssessmentModel.PASTMEDHIST + healthRiskAssessmentModel.PREVREFDOC + healthRiskAssessmentModel.PHYSICALEXAMDT + healthRiskAssessmentModel.BLOODTRANSFUSION;
                params["PASTMEDHIST"] = healthRiskAssessmentModel.PASTMEDHIST
                params["PREVREFDOC"] = healthRiskAssessmentModel.PREVREFDOC
                params["PHYSICALEXAMDT"] = healthRiskAssessmentModel.PHYSICALEXAMDT
                params["BLOODTRANSFUSION"] = healthRiskAssessmentModel.BLOODTRANSFUSION
            }
            else if self.stepNumber == 10 {
                self.strSelected = healthRiskAssessmentModel.MEDICATION1_DRUG + healthRiskAssessmentModel.MEDICATION2_DRUG + healthRiskAssessmentModel.MEDICATION3_DRUG + healthRiskAssessmentModel.MEDICATION4_DRUG + healthRiskAssessmentModel.MEDICATION5_DRUG + healthRiskAssessmentModel.MEDICATION_NONE;
                
                params["MEDICATION1_DRUG"] = healthRiskAssessmentModel.MEDICATION1_DRUG
                params["MEDICATION1_NAME"] = healthRiskAssessmentModel.MEDICATION1_NAME
                params["MEDICATION1_DOSAGE"] = healthRiskAssessmentModel.MEDICATION1_DOSAGE
                params["MEDICATION2_DRUG"] = healthRiskAssessmentModel.MEDICATION2_DRUG
                params["MEDICATION2_NAME"] = healthRiskAssessmentModel.MEDICATION2_NAME
                params["MEDICATION2_DOSAGE"] = healthRiskAssessmentModel.MEDICATION2_DOSAGE
                params["MEDICATION3_DRUG"] = healthRiskAssessmentModel.MEDICATION3_DRUG
                params["MEDICATION3_NAME"] = healthRiskAssessmentModel.MEDICATION3_NAME
                params["MEDICATION3_DOSAGE"] = healthRiskAssessmentModel.MEDICATION3_DOSAGE
                params["MEDICATION4_DRUG"] = healthRiskAssessmentModel.MEDICATION4_DRUG
                params["MEDICATION4_NAME"] = healthRiskAssessmentModel.MEDICATION4_NAME
                params["MEDICATION4_DOSAGE"] = healthRiskAssessmentModel.MEDICATION4_DOSAGE
                params["MEDICATION5_DRUG"] = healthRiskAssessmentModel.MEDICATION5_DRUG
                params["MEDICATION5_NAME"] = healthRiskAssessmentModel.MEDICATION5_NAME
                params["MEDICATION5_DOSAGE"] = healthRiskAssessmentModel.MEDICATION5_DOSAGE
                params["MEDICATION_NONE"] = healthRiskAssessmentModel.MEDICATION_NONE
            }
            else if self.stepNumber == 11 {
                self.strSelected = healthRiskAssessmentModel.ALERGY1 + healthRiskAssessmentModel.ALERGY2 + healthRiskAssessmentModel.ALERGY3 + healthRiskAssessmentModel.ALERGY_NONE;
                
                params["ALERGY1"] = healthRiskAssessmentModel.ALERGY1
                params["ALERGY1_NAME"] = healthRiskAssessmentModel.ALERGY1_NAME
                params["ALERGY1_REACTION"] = healthRiskAssessmentModel.ALERGY1_REACTION

                params["ALERGY2"] = healthRiskAssessmentModel.ALERGY2
                params["ALERGY2_NAME"] = healthRiskAssessmentModel.ALERGY2_NAME
                params["ALERGY2_REACTION"] = healthRiskAssessmentModel.ALERGY2_REACTION
                
                params["ALERGY3"] = healthRiskAssessmentModel.ALERGY3
                params["ALERGY3_NAME"] = healthRiskAssessmentModel.ALERGY3_NAME
                params["ALERGY3_REACTION"] = healthRiskAssessmentModel.ALERGY3_REACTION
                
                params["ALERGY_NONE"] = healthRiskAssessmentModel.ALERGY_NONE
            }
            else if self.stepNumber == 12 {
                self.strSelected = healthRiskAssessmentModel.FMEDICALHISTORYCD;
                params["FMEDICALHISTORYCD"] = healthRiskAssessmentModel.FMEDICALHISTORYCD
            }
            else if self.stepNumber == 13 {
                self.strSelected = healthRiskAssessmentModel.SC_EXERCISE + healthRiskAssessmentModel.SC_DIET + healthRiskAssessmentModel.SC_MEALPRDAY + healthRiskAssessmentModel.SC_SALTINTAKE + healthRiskAssessmentModel.SC_FATINTAKE + healthRiskAssessmentModel.SC_CAFFINE;
                
                params["SC_EXERCISE"] = healthRiskAssessmentModel.SC_EXERCISE
                params["SC_EXERCISEDUR"] = healthRiskAssessmentModel.SC_EXERCISEDUR
                params["SC_DIET"] = healthRiskAssessmentModel.SC_DIET
                params["SC_DIETPHY"] = healthRiskAssessmentModel.SC_DIETPHY
                params["SC_MEALPRDAY"] = healthRiskAssessmentModel.SC_MEALPRDAY
                params["SC_SALTINTAKE"] = healthRiskAssessmentModel.SC_SALTINTAKE
                params["SC_FATINTAKE"] = healthRiskAssessmentModel.SC_FATINTAKE
                params["SC_CAFFINE"] = healthRiskAssessmentModel.SC_CAFFINE
                params["SC_CAFFINEINTAKE"] = healthRiskAssessmentModel.SC_CAFFINEINTAKE
                params["SC_CAFFINEPERDAY"] = healthRiskAssessmentModel.SC_CAFFINEPERDAY
            }
            else if self.stepNumber == 14 {
                self.strSelected = healthRiskAssessmentModel.SC_ALCOHOL;
                
                params["SC_ALCOHOL"] = healthRiskAssessmentModel.SC_ALCOHOL
                params["SC_ALCOHOLTYP"] = healthRiskAssessmentModel.SC_ALCOHOLTYP
                params["SC_ALCOHOLPWK"] = healthRiskAssessmentModel.SC_ALCOHOLPWK
                params["SC_ALCOHOLCN"] = healthRiskAssessmentModel.SC_ALCOHOLCN
                params["SC_ALCOHOLSTOP"] = healthRiskAssessmentModel.SC_ALCOHOLSTOP
                params["SC_ALCOHOLBO"] = healthRiskAssessmentModel.SC_ALCOHOLBO
                params["SC_ALCOHOLBG"] = healthRiskAssessmentModel.SC_ALCOHOLBG
                params["SC_ALCOHOLDR"] = healthRiskAssessmentModel.SC_ALCOHOLDR
            }
            else if self.stepNumber == 15 {
                self.strSelected = healthRiskAssessmentModel.SC_TOBACCO + healthRiskAssessmentModel.SC_TOBACCOYRSQT;
                
                params["SC_TOBACCO"] = healthRiskAssessmentModel.SC_TOBACCO
                params["SC_TOBACCOCIG"] = healthRiskAssessmentModel.SC_TOBACCOCIG
                params["SC_TOBACCOPKSDAY"] = healthRiskAssessmentModel.SC_TOBACCOPKSDAY
                params["SC_TOBACCOPKSWEEK"] = healthRiskAssessmentModel.SC_TOBACCOPKSWEEK
                params["SC_TOBACCOCHW"] = healthRiskAssessmentModel.SC_TOBACCOCHW
                params["SC_TOBACCOCHW_DES"] = healthRiskAssessmentModel.SC_TOBACCOCHW_DES
                params["SC_TOBACCOCPP"] = healthRiskAssessmentModel.SC_TOBACCOCPP
                params["SC_TOBACCOCPP_DES"] = healthRiskAssessmentModel.SC_TOBACCOCPP_DES
                params["SC_TOBACCOCCG"] = healthRiskAssessmentModel.SC_TOBACCOCCG
                params["SC_TOBACCOCCG_DES"] = healthRiskAssessmentModel.SC_TOBACCOCCG_DES
                params["SC_TOBACCOYRS"] = healthRiskAssessmentModel.SC_TOBACCOYRS
                params["SC_TOBACCOYRS_DES"] = healthRiskAssessmentModel.SC_TOBACCOYRS_DES
                params["SC_TOBACCOYRSQT"] = healthRiskAssessmentModel.SC_TOBACCOYRSQT
                params["SC_TOBACCOYRSQT_DES"] = healthRiskAssessmentModel.SC_TOBACCOYRSQT_DES
            }
            else if self.stepNumber == 16{
                self.strSelected = healthRiskAssessmentModel.SC_DRUGRCST + healthRiskAssessmentModel.SC_DRUGRCSTNDL + healthRiskAssessmentModel.SC_DRUGPHY;
                
                params["SC_DRUGRCST"] = healthRiskAssessmentModel.SC_DRUGRCST
                params["SC_DRUGRCSTNDL"] = healthRiskAssessmentModel.SC_DRUGRCSTNDL
                params["SC_DRUGPHY"] = healthRiskAssessmentModel.SC_DRUGPHY
            }
            else if self.stepNumber == 17{
                self.strSelected = healthRiskAssessmentModel.SC_SEX + healthRiskAssessmentModel.SC_SEXPREG + healthRiskAssessmentModel.SC_SEXCONTRA + healthRiskAssessmentModel.SC_SEXDISCOM + healthRiskAssessmentModel.SC_SEXILLNESSPHY;
                
                params["SC_SEX"] = healthRiskAssessmentModel.SC_SEX
                params["SC_SEXPREG"] = healthRiskAssessmentModel.SC_SEXPREG
                params["SC_SEXCONTRA"] = healthRiskAssessmentModel.SC_SEXCONTRA
                params["SC_SEXDISCOM"] = healthRiskAssessmentModel.SC_SEXDISCOM
                params["SC_SEXILLNESSPHY"] = healthRiskAssessmentModel.SC_SEXILLNESSPHY
            }
            else if self.stepNumber == 18{
                self.strSelected = healthRiskAssessmentModel.SC_MENTALSTRESS + healthRiskAssessmentModel.SC_MENTALDEPRESS + healthRiskAssessmentModel.SC_MENTALPANIC + healthRiskAssessmentModel.SC_MENTALEAT + healthRiskAssessmentModel.SC_MENTALCRY + healthRiskAssessmentModel.SC_MENTALSUICIDE + healthRiskAssessmentModel.SC_MENTALSLEEP + healthRiskAssessmentModel.SC_MENTALCOUNSEL;
                
                params["SC_MENTALSTRESS"] = healthRiskAssessmentModel.SC_MENTALSTRESS
                params["SC_MENTALDEPRESS"] = healthRiskAssessmentModel.SC_MENTALDEPRESS
                params["SC_MENTALPANIC"] = healthRiskAssessmentModel.SC_MENTALPANIC
                params["SC_MENTALEAT"] = healthRiskAssessmentModel.SC_MENTALEAT
                params["SC_MENTALCRY"] = healthRiskAssessmentModel.SC_MENTALCRY
                params["SC_MENTALSUICIDE"] = healthRiskAssessmentModel.SC_MENTALSUICIDE
                params["SC_MENTALSLEEP"] = healthRiskAssessmentModel.SC_MENTALSLEEP
                params["SC_MENTALCOUNSEL"] = healthRiskAssessmentModel.SC_MENTALCOUNSEL
            }
            else if self.stepNumber == 19{
                self.strSelected = healthRiskAssessmentModel.SC_PSAFETYALONE + healthRiskAssessmentModel.SC_PSAFETYFALL + healthRiskAssessmentModel.SC_PSAFETYVISION + healthRiskAssessmentModel.SC_PSAFETYABUSE + healthRiskAssessmentModel.SC_PSAFETYSUNBURN + healthRiskAssessmentModel.SC_PSAFETYSUNEXP + healthRiskAssessmentModel.SC_PSAFETYSEATBLT;
                
                params["SC_PSAFETYALONE"] = healthRiskAssessmentModel.SC_PSAFETYALONE
                params["SC_PSAFETYFALL"] = healthRiskAssessmentModel.SC_PSAFETYFALL
                params["SC_PSAFETYVISION"] = healthRiskAssessmentModel.SC_PSAFETYVISION
                params["SC_PSAFETYABUSE"] = healthRiskAssessmentModel.SC_PSAFETYABUSE
                params["SC_PSAFETYSUNBURN"] = healthRiskAssessmentModel.SC_PSAFETYSUNBURN
                params["SC_PSAFETYSUNEXP"] = healthRiskAssessmentModel.SC_PSAFETYSUNEXP
                params["SC_PSAFETYSEATBLT"] = healthRiskAssessmentModel.SC_PSAFETYSEATBLT
            }
            else if self.stepNumber == 20{
                self.strSelected = healthRiskAssessmentModel.WH_MENSTAG + healthRiskAssessmentModel.WH_MENSTLASTDT + healthRiskAssessmentModel.WH_MENSTDAYS + healthRiskAssessmentModel.WH_HEAVYPERIODS + healthRiskAssessmentModel.WH_PREGCOUNT + healthRiskAssessmentModel.WH_LIVEBIRTH + healthRiskAssessmentModel.WH_PREGBRFEED + healthRiskAssessmentModel.WH_INFECTION + healthRiskAssessmentModel.WH_CESAREAN + healthRiskAssessmentModel.WH_PROC + healthRiskAssessmentModel.WH_URINEBLOOD + healthRiskAssessmentModel.WH_FLASHSWEAT + healthRiskAssessmentModel.WH_MENSTSYMPTOM + healthRiskAssessmentModel.WH_BREASTSELFEXM + healthRiskAssessmentModel.WH_BREASTSYMPTOM + healthRiskAssessmentModel.WH_PELPEPSMEAR;
                
                params["WH_MENSTAG"] = healthRiskAssessmentModel.WH_MENSTAG
                params["WH_MENSTLASTDT"] = healthRiskAssessmentModel.WH_MENSTLASTDT
                params["WH_MENSTDAYS"] = healthRiskAssessmentModel.WH_MENSTDAYS
                params["WH_HEAVYPERIODS"] = healthRiskAssessmentModel.WH_HEAVYPERIODS
                params["WH_PREGCOUNT"] = healthRiskAssessmentModel.WH_PREGCOUNT
                params["WH_LIVEBIRTH"] = healthRiskAssessmentModel.WH_LIVEBIRTH
                params["WH_PREGBRFEED"] = healthRiskAssessmentModel.WH_PREGBRFEED
                params["WH_INFECTION"] = healthRiskAssessmentModel.WH_INFECTION
                params["WH_CESAREAN"] = healthRiskAssessmentModel.WH_CESAREAN
                params["WH_PROC"] = healthRiskAssessmentModel.WH_PROC
                params["WH_URINEBLOOD"] = healthRiskAssessmentModel.WH_URINEBLOOD
                params["WH_FLASHSWEAT"] = healthRiskAssessmentModel.WH_FLASHSWEAT
                params["WH_MENSTSYMPTOM"] = healthRiskAssessmentModel.WH_MENSTSYMPTOM
                params["WH_BREASTSELFEXM"] = healthRiskAssessmentModel.WH_BREASTSELFEXM
                params["WH_BREASTSYMPTOM"] = healthRiskAssessmentModel.WH_BREASTSYMPTOM
                params["WH_PELPEPSMEAR"] = healthRiskAssessmentModel.WH_PELPEPSMEAR
            }
            else if self.stepNumber == 21{
                self.strSelected = healthRiskAssessmentModel.MH_URINATE + healthRiskAssessmentModel.MH_URINATEBURN + healthRiskAssessmentModel.MH_URINATEBLOOD + healthRiskAssessmentModel.MH_URINATEDISCHARGE + healthRiskAssessmentModel.MH_URINATEFORCE + healthRiskAssessmentModel.MH_KDBLDPROSINF + healthRiskAssessmentModel.MH_EMPTYBLADDER + healthRiskAssessmentModel.MH_ERECTION + healthRiskAssessmentModel.MH_TESTICLEPN + healthRiskAssessmentModel.MH_PROSRECEXAM;
                
                params["MH_URINATE"] = healthRiskAssessmentModel.MH_URINATE
                params["MH_URINATEBURN"] = healthRiskAssessmentModel.MH_URINATEBURN
                params["MH_URINATEBLOOD"] = healthRiskAssessmentModel.MH_URINATEBLOOD
                params["MH_URINATEDISCHARGE"] = healthRiskAssessmentModel.MH_URINATEDISCHARGE
                params["MH_URINATEFORCE"] = healthRiskAssessmentModel.MH_URINATEFORCE
                params["MH_KDBLDPROSINF"] = healthRiskAssessmentModel.MH_KDBLDPROSINF
                params["MH_EMPTYBLADDER"] = healthRiskAssessmentModel.MH_EMPTYBLADDER
                params["MH_ERECTION"] = healthRiskAssessmentModel.MH_ERECTION
                params["MH_TESTICLEPN"] = healthRiskAssessmentModel.MH_TESTICLEPN
                params["MH_PROSRECEXAM"] = healthRiskAssessmentModel.MH_PROSRECEXAM
            }
            else if self.stepNumber == 22{
                self.strSelected = healthRiskAssessmentModel.DIABETES_MELLITUS + healthRiskAssessmentModel.HYPERTENSION + healthRiskAssessmentModel.SC_AD + healthRiskAssessmentModel.SC_RELIGIONBELIEF + healthRiskAssessmentModel.SC_INFO + healthRiskAssessmentModel.SC_EDUCATION + healthRiskAssessmentModel.SC_ENGLISH;
                
                params["DIABETES_MELLITUS"] = healthRiskAssessmentModel.DIABETES_MELLITUS
                params["DIABETES_MED_DET"] = healthRiskAssessmentModel.DIABETES_MED_DET
                params["DIABETES_SINCE_WHEN"] = healthRiskAssessmentModel.DIABETES_SINCE_WHEN
                params["HYPERTENSION"] = healthRiskAssessmentModel.HYPERTENSION
                params["HYPERTENSION_MED_DET"] = healthRiskAssessmentModel.HYPERTENSION_MED_DET
                params["HYPERTENSION_SINCE_WHEN"] = healthRiskAssessmentModel.HYPERTENSION_SINCE_WHEN
                params["SC_AD"] = healthRiskAssessmentModel.SC_AD
                params["SC_ADDETAILS"] = healthRiskAssessmentModel.SC_ADDETAILS
                params["SC_RELIGIONBELIEF"] = healthRiskAssessmentModel.SC_RELIGIONBELIEF
                params["SC_RELIGIONBELREM"] = healthRiskAssessmentModel.SC_RELIGIONBELREM
                params["SC_INFO"] = healthRiskAssessmentModel.SC_INFO
                params["SC_EDUCATION"] = healthRiskAssessmentModel.SC_EDUCATION
                params["SC_ENGLISH"] = healthRiskAssessmentModel.SC_ENGLISH
                params["SC_LANGUAGE"] = healthRiskAssessmentModel.SC_LANGUAGE
            }
            else if self.stepNumber == 23{
                self.strSelected = healthRiskAssessmentModel.SYMPTOMCD + healthRiskAssessmentModel.OTHSYMPTOM
                
                params["SYMPTOMCD"] = healthRiskAssessmentModel.SYMPTOMCD
                params["OTHSYMPTOM"] = healthRiskAssessmentModel.OTHSYMPTOM
            }
            print("params===\(params)")
            print("url===\(AppConstant.postUpdateStepByStepHealthRiskAssessmentUrl)")
            if validateInput() {
                AppConstant.showHUD()
                AFManager.request( AppConstant.postUpdateStepByStepHealthRiskAssessmentUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                    .responseString { response in
                        AppConstant.hideHUD()
                        debugPrint(response)
                        switch(response.result) {
                        case .success(_):
                            let headerStatusCode : Int = (response.response?.statusCode)!
                            print("Status Code: \(headerStatusCode)")
                            if(headerStatusCode == 401){//Session expired
                                self.isTokenVerified(completion: { (Bool) in
                                    if Bool{
                                        self.serviceCallUpdateStepByStep()
                                    }
                                })
                            }else{
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                if let status = dict!["Status"] as? String {
                                    if(status == "1"){
                                        self.stepNumber = self.stepNumber + 1
                                        self.stepNumberDisplay = self.stepNumberDisplay + 1
                                        if self.stepNumber == 20 && (self.healthRiskAssessmentModel.GENDER == "Male" || self.healthRiskAssessmentModel.GENDER == self.male){
                                            self.stepNumber = self.stepNumber + 1
                                        }else  if self.stepNumber == 21 && (self.healthRiskAssessmentModel.GENDER == "Female" ||  self.healthRiskAssessmentModel.GENDER == self.female){
                                            self.stepNumber = self.stepNumber + 1
                                        }
                                        self.controlStep()
                                    }else{
                                        if let msg = dict?["Message"] as? String{
                                            self.displayAlert(message: msg )
                                        }
                                    }
                                }
                            }
                            break
                        case .failure(_):
                            AppConstant.showNetworkAlertMessage(apiName: AppConstant.postUpdateStepByStepHealthRiskAssessmentUrl)
                            break
                        }
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func isValidateDate(_ strDate: String, _ formatDate: String) -> Bool{

        if strDate != "" && formatDate != ""{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = formatDate
            if dateFormatterGet.date(from: strDate) != nil {
                return true
            }else{
                return false
            }
        }
        return true
    }
    
    
    func requireMaxlength(){
        self.txtNumberOfChildren.delegate = self
        self.txtNumberOfChildrenLive.delegate = self
        
        self.txtYear1Step5.delegate = self
        self.txtYear2Step5.delegate = self
        self.txtYear3Step5.delegate = self
        self.txtYear4Step5.delegate = self
        self.txtYear5Step5.delegate = self
        
        self.txtYear1Step6.delegate = self
        self.txtYear2Step6.delegate = self
        self.txtYear3Step6.delegate = self
        self.txtYear4Step6.delegate = self
        self.txtYear5Step6.delegate = self
        
        self.txtMonth1Step7.delegate = self
        self.txtMonth2Step7.delegate = self
        self.txtMonth3Step7.delegate = self
        self.txtMonth4Step7.delegate = self
        self.txtMonth5Step7.delegate = self
        
        self.txtDrinksPerWeekStep14.delegate = self
        
        self.txtpksDayStep15.delegate = self
        self.txtPksWeekStep15.delegate = self
        self.txtChewDayStep15.delegate = self
        self.txtPipeDayStep15.delegate = self
        self.txtCigarsDayStep15.delegate = self
        self.txtOfYearsInTobaccoStep15.delegate = self
        self.txtNumberOfYearsQuitStep15.delegate = self
        
        self.txtAgeAtOnsetOfMenstruationStep20.delegate = self
        self.txtPeriodDaysStep20.delegate = self
        self.txtNumberOfPregnanciesStep20.delegate = self
        self.txtNumberOfLiveBirthsStep20.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 1
        if (textField.accessibilityIdentifier ?? "") as String == "MaxLength2"
        {
            maxLength = 2
        }
        if (textField.accessibilityIdentifier ?? "") as String == "MaxLength3"
        {
            maxLength = 3
        }
        if (textField.accessibilityIdentifier ?? "") as String == "MaxLength4"
        {
            maxLength = 4
        }
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }

}
