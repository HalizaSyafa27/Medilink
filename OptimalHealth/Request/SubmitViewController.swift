//
//  SubmitViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 9/12/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import JitsiMeetSDK
import IQKeyboardManagerSwift

class SubmitViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnUploadNew: UIButton!
    @IBOutlet var btnGoHome: UIButton!
    @IBOutlet var btnLongGoHome: UIButton!
    @IBOutlet var viewReqId: UIView!
    @IBOutlet var lblReqId: UILabel!
    @IBOutlet var tblviewDoctors: UITableView!
    @IBOutlet weak var viewContainerBottomConstraint: NSLayoutConstraint!

    var className = ""
    var arrDoctors = [Doctors]()
    fileprivate var jitsiMeetView: JitsiMeetView?
    fileprivate var pipViewCoordinator: PiPViewCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppConstant.isClaimSubmitted = true
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let rect = CGRect(origin: CGPoint.zero, size: size)
        pipViewCoordinator?.resetBounds(bounds: rect)
        print("piprect===\(rect)")
    }
    
    func initDesign(){
        btnLongGoHome.isHidden = true
        btnLongGoHome.isUserInteractionEnabled = false
        btnUploadNew.isHidden = false
        btnGoHome.isHidden = false
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.hideBackButtonNotification), object: nil)
        
        self.lblMessage.text = AppConstant.requestPopupMsg + "\n\n" + AppConstant.strUploadTime

        if className == StringConstant.teleconsultRequest {
            viewReqId.isHidden = true
            tblviewDoctors.isHidden = true
            lblMessage.isHidden = false
            
            self.lblMessage.text = AppConstant.strUploadTime == "" ? AppConstant.requestPopupMsg + "\n\nTeleconsult Request ID: \(AppConstant.strClaimId)" :  AppConstant.requestPopupMsg + "\n\n" + AppConstant.strUploadTime + "\n\nTeleconsult Request ID: \(AppConstant.strClaimId)"
            
        } else {
            viewReqId.isHidden = true
            tblviewDoctors.isHidden = true
            lblMessage.isHidden = false
            
            self.lblMessage.text = AppConstant.requestPopupMsg + "\n\n" + AppConstant.strUploadTime
        }
    }

    //MARK: - Button Action
    @IBAction func btnGoHomeAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gotoHomeScreen()
    }

    @IBAction func btnUploadNewAction(_ sender: Any) {
        if AppConstant.currClassName == StringConstant.uploadMedicalChit {
            self.navigationController!.popViewController(animated: true)
        } else {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is DependentViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func btnSelectDoctorAction(_ sender: Any) {
        
        if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
           myDelegate.startMeeting()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppConstant.isClaimSubmitted = false
        
    }

    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDoctors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell", for: indexPath as IndexPath) as! DoctorTableViewCell
        cell.selectionStyle = .none

        let doctorsBo = arrDoctors[indexPath.row]
        
        cell.lblName.text = doctorsBo.name
        cell.lblEmail.text = doctorsBo.email
        cell.lblMobile.text = doctorsBo.phone
        cell.lblStatus.text = doctorsBo.isActive == true ? "Available" : "Unavailable"
        cell.lblstatusColor.backgroundColor = doctorsBo.isActive == true ? UIColor.init(hexString: "#599C28"): UIColor.init(hexString: "#CC0000")


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

    //MARK: - Jitsi Meet
    func startMeeting(){
        self.view.endEditing(true)
        let room: String = "MEDILINKDEMO"
        if(room.count < 1) {
            return
        }
        
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
//            builder.welcomePageEnabled = true
            builder.room = room
        }
        
        //setup view controller
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view = jitsiMeetView

        // join room and display jitsi-call
        jitsiMeetView.join(options)
        present(vc, animated: true, completion: nil)
        
        
    }
    
    func cleanUp() {
        print("Cleanup")
        if(jitsiMeetView != nil) {
            dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
            
            //Pip Mode
//            jitsiMeetView?.removeFromSuperview()
//            jitsiMeetView = nil
//            pipViewCoordinator = nil
        }
    }
    
    func startMeetingWithPip(){
        cleanUp()

        self.view.endEditing(true)
        let room: String = "MEDILINKDEMO"
        if(room.count < 1) {
            return
        }
        
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
//            builder.welcomePageEnabled = false
            builder.room = room
        }
        jitsiMeetView.join(options)

        // Enable jitsimeet view to be a view that can be displayed
        // on top of all the things, and let the coordinator to manage
        // the view state and interactions
        
        let window :UIWindow = UIApplication.shared.keyWindow!
        //window.rootViewController?.view
        pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
        pipViewCoordinator?.configureAsStickyView(withParentView: window)

        // animate in
        jitsiMeetView.alpha = 0
//        pipViewCoordinator?.show()
    }
    
    //MARK: - Service Call
    func serviceCallToGetDoctorsList() {
        if(AppConstant.hasConnectivity()) { //true connected
            AppConstant.showHUD()

            print("url===\(AppConstant.doctorListUrl)")
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 180 // seconds
            configuration.timeoutIntervalForResource = 180 //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request( AppConstant.doctorListUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)

                    switch(response.result) {
                    case .success(_):

                        let headerStatusCode: Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")

                        if(headerStatusCode == 401) { //Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool {
                                    self.serviceCallToGetDoctorsList()
                                }
                            })
                        } else {
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //  debugPrint(dict)

                            if let arrDoc = dict?["doctors"] as? [[String: Any]] {
                                for dictDoc in arrDoc{
                                    let doctorBo = Doctors()
                                    if let id = dictDoc["id"] as? Int {
                                        doctorBo.id = id
                                    }
                                    if let name = dictDoc["name"] as? String {
                                        doctorBo.name = name
                                    }
                                    if let email = dictDoc["email"] as? String {
                                        doctorBo.email = email
                                    }
                                    if let phone_no = dictDoc["phone_no"] as? String {
                                        doctorBo.phone = phone_no
                                    }
                                    if let active = dictDoc["active"] as? Int {
                                        doctorBo.isActive = active == 1 ? true : false
                                    }
                                    
                                    self.arrDoctors.append(doctorBo)
                                    self.tblviewDoctors.reloadData()
                                }
                            } else {
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.doctorListUrl)
                            }
                        }

                        break

                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.doctorListUrl)
                        break

                    }
            }
        } else {
            self.displayAlert(message: "Please check your internet connection.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SubmitViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        cleanUp()
        
        //Pip
//        DispatchQueue.main.async {
//            self.pipViewCoordinator?.hide() { _ in
//                self.cleanUp()
//            }
//        }
    }
    
    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
