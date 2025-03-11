//
//  CallUsViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 23/09/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
import Quickblox
import QuickbloxWebRTC
import PushKit

class CallUsViewController: UIViewController {

    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    private weak var session: QBRTCSession?
    lazy private var voipRegistry: PKPushRegistry = {
        let voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
        return voipRegistry
    }()
    private var callUUID: UUID?
    lazy private var backgroundTask: UIBackgroundTaskIdentifier = {
        let backgroundTask = UIBackgroundTaskIdentifier.invalid
        return backgroundTask
    }()
    lazy private var dataSource: UsersDataSource = {
        let dataSource = UsersDataSource()
        return dataSource
    }()
    lazy private var navViewController: UINavigationController = {
        let navViewController = UINavigationController()
        return navViewController
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = 92
            topBarHeightConstraint.constant = 92
        }
        let userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
        
        self.signUp(fullName: userId, login: userId)
    }
    
    func loadUsers() {
        let firstPage = QBGeneralResponsePage(currentPage: 1, perPage: 100)
        QBRequest.users(withExtendedRequest: ["order": "desc date updated_at"],
                        page: firstPage,
                        successBlock: { [weak self] (response, page, users) in
                            self?.dataSource.update(users: users)
                            
            }, errorBlock: { response in
        })
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeViewAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnAudioCallAction(_ sender: UIButton) {
        call(with: QBRTCConferenceType.audio)
    }
    
    @IBAction func btnVideoCallAction(_ sender: UIButton) {
        call(with: QBRTCConferenceType.video)
    }
    
    //MARK: - Call Methods
    
    private func call(with conferenceType: QBRTCConferenceType) {
        
        if session != nil {
            return
        }
        
        if AppConstant.hasConnectivity() {
            CallPermissions.check(with: conferenceType) { granted in
                if granted {
                    let opponentsIDs = self.dataSource.ids(forUsers: self.dataSource.selectedUsers)
                    //Create new session
                    let session = QBRTCClient.instance().createNewSession(withOpponents: opponentsIDs, with: conferenceType)
                    if session.id.isEmpty == false {
                        self.session = session
                        let uuid = UUID()
                        self.callUUID = uuid
                        
                        CallKitManager.instance.startCall(withUserIDs: opponentsIDs, session: session, uuid: uuid)
                        
                        let storyBoard = UIStoryboard.init(name: "Call", bundle: nil)
                        if let callViewController = storyBoard.instantiateViewController(withIdentifier: UsersSegueConstant.call) as? CallViewController {
                            callViewController.session = self.session
                            callViewController.usersDataSource = self.dataSource
                            callViewController.callUUID = uuid
                            let nav = UINavigationController(rootViewController: callViewController)
                            nav.modalTransitionStyle = .crossDissolve
                            self.present(nav , animated: false)
//                            self.audioCallButton.isEnabled = false
//                            self.videoCallButton.isEnabled = false
                            self.navViewController = nav
                        }
                        let profile = Profile()
                        guard profile.isFull == true else {
                            return
                        }
                        let opponentName = profile.fullName.isEmpty == false ? profile.fullName : "Unknown user"
                        let payload = ["message": "\(opponentName) is calling you.",
                            "ios_voip": "1", UsersConstant.voipEvent: "1"]
                        let data = try? JSONSerialization.data(withJSONObject: payload,
                                                               options: .prettyPrinted)
                        var message = ""
                        if let data = data {
                            message = String(data: data, encoding: .utf8) ?? ""
                        }
                        let event = QBMEvent()
                        event.notificationType = QBMNotificationType.push
                        let arrayUserIDs = opponentsIDs.map({"\($0)"})
                        event.usersIDs = arrayUserIDs.joined(separator: ",")
                        event.type = QBMEventType.oneShot
                        event.message = message
                        QBRequest.createEvent(event, successBlock: { response, events in
                            debugPrint("[UsersViewController] Send voip push - Success")
                        }, errorBlock: { response in
                            debugPrint("[UsersViewController] Send voip push - Error")
                        })
                    } else {
                        AppConstant.showAlert(strTitle: UsersAlertConstant.shouldLogin, delegate: nil)
                    }
                }
            }
        }
    }
    /**
     *  Signup and login
     */
    private func signUp(fullName: String, login: String) {
        let newUser = QBUUser()
        newUser.login = login
        newUser.fullName = fullName
        newUser.password = LoginConstant.defaultPassword
        QBRequest.signUp(newUser, successBlock: { [weak self] response, user in
            
            self?.login(fullName: fullName, login: login)
            
            }, errorBlock: { [weak self] response in
                
                if response.status == QBResponseStatusCode.validationFailed {
                    // The user with existent login was created earlier
                    self?.login(fullName: fullName, login: login)
                    return
                }
                self?.handleError(response.error?.error, domain: ErrorDomain.signUp)
        })
    }
    
    /**
     *  login
     */
    private func login(fullName: String, login: String, password: String = LoginConstant.defaultPassword) {
        QBRequest.logIn(withUserLogin: login,
                        password: password,
                        successBlock: { [weak self] response, user in
                            
                            user.password = password
                            user.updatedAt = Date()
                            Profile.synchronize(user)
                            
                            if user.fullName != fullName {
                                self?.updateFullName(fullName: fullName, login: login)
                            } else {
                                self?.connectToChat(user: user)
                            }
                            
            }, errorBlock: { [weak self] response in
                self?.handleError(response.error?.error, domain: ErrorDomain.logIn)
                if response.status == QBResponseStatusCode.unAuthorized {
                    // Clean profile
                    Profile.clearProfile()
                }
        })
    }
    
    private func connectToChat(user: QBUUser) {
        QBChat.instance.connect(withUserID: user.id,
                                password: LoginConstant.defaultPassword,
                                completion: { [weak self] error in
                                    if let error = error {
                                        if error._code == QBResponseStatusCode.unAuthorized.rawValue {
                                            // Clean profile
                                            Profile.clearProfile()
                                        } else {
                                            self?.handleError(error, domain: ErrorDomain.logIn)
                                        }
                                    } else {
                                        //did Login action
                                        //Make Video Call
                                    }
        })
    }
    
    // MARK: - Handle errors
    private func handleError(_ error: Error?, domain: ErrorDomain) {
        guard let error = error else {
            return
        }
        
    }
    
    private func updateFullName(fullName: String, login: String) {
        let updateUserParameter = QBUpdateUserParameters()
        updateUserParameter.fullName = fullName
        QBRequest.updateCurrentUser(updateUserParameter, successBlock: {  [weak self] response, user in
            
            user.updatedAt = Date()
            
            Profile.update(user)
            self?.connectToChat(user: user)
            
            }, errorBlock: { [weak self] response in
                self?.handleError(response.error?.error, domain: ErrorDomain.signUp)
        })
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
