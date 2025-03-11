//
//  ViewHistoryDetailViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 01/03/2024.
//  Copyright © 2024 Oditek. All rights reserved.
//

import UIKit

class ViewHistoryDetailViewController: UIViewController {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewHeader: UIImageView!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblFat: UILabel!
    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblBloodGlucose: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblCalBurnied: UILabel!
    @IBOutlet weak var lblHeartRate: UILabel!
    @IBOutlet weak var lblHeartRateVariability: UILabel!
    @IBOutlet weak var lblBloodPressure: UILabel!
    @IBOutlet weak var lblTotalSleepTime: UILabel!
    @IBOutlet weak var lblDeep: UILabel!
    @IBOutlet weak var lblLight: UILabel!
    @IBOutlet weak var lblFlightsClimbed: UILabel!
    @IBOutlet weak var lblStepsToday: UILabel!
    @IBOutlet weak var lblWalkingRunning: UILabel!
    
    var className:String = ""
    var pageTitle:String = ""
    var strHeaderImageName:String = ""
    var dashboardHistoryModel = DashboardHistoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.imgViewHeader.image = UIImage.init(named: strHeaderImageName)
        lblDate.text = dashboardHistoryModel.DataCaptureDt
        lblAge.text = dashboardHistoryModel.Age
        lblWeight.text = dashboardHistoryModel.Weight
        lblHeight.text = dashboardHistoryModel.Height
        lblFat.text = dashboardHistoryModel.Fat
        lblBMI.text = dashboardHistoryModel.Bmi
        lblBloodGlucose.text = dashboardHistoryModel.BloodGlucose 
        lblTemperature.text = dashboardHistoryModel.Temperature
        lblCalBurnied.text = dashboardHistoryModel.CalBurnied
        lblHeartRate.text = dashboardHistoryModel.HeartRate
        lblHeartRateVariability.text = dashboardHistoryModel.HeartRateVariability
        lblBloodPressure.text = dashboardHistoryModel.BloodPressure
        lblTotalSleepTime.text = dashboardHistoryModel.TotalSleep
        lblDeep.text = dashboardHistoryModel.DeepSleep
        lblLight.text = dashboardHistoryModel.LightSleep
        lblFlightsClimbed.text = dashboardHistoryModel.FlightsClimbToday
        lblStepsToday.text = dashboardHistoryModel.StepsToday
        lblWalkingRunning.text = dashboardHistoryModel.WalkingDistanceToday
    }
    
    
    // MARK: - Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
