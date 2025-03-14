//
//  UsersViewController.swift
//  sample-videochat-webrtc-swift
//
//  Created by Injoit on 12/10/18.
//  Copyright © 2018 QuickBlox. All rights reserved.
//

import UIKit
import Quickblox
import QuickbloxWebRTC
import PushKit
import SVProgressHUD

struct UsersConstant {
    static let pageSize: UInt = 50
    static let aps = "aps"
    static let alert = "alert"
    static let voipEvent = "VOIPCall"
}

struct UsersAlertConstant {
    static let checkInternet = NSLocalizedString("Please check your Internet connection", comment: "")
    static let okAction = NSLocalizedString("Ok", comment: "")
    static let shouldLogin = NSLocalizedString("You should login to use VideoChat API. Session hasn’t been created. Please try to relogin.", comment: "")
    static let logout = NSLocalizedString("Logout...", comment: "")
}

struct UsersSegueConstant {
    static let settings = "PresentSettingsViewController"
    static let call = "CallViewController"
    static let sceneAuth = "SceneSegueAuth"
}

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - IBOutlets
    @IBOutlet private weak var audioCallButton: UIButton!
    @IBOutlet private weak var videoCallButton: UIButton!
    @IBOutlet weak var tblViewUsers: UITableView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    let refreshControl = UIRefreshControl()
    var selectedUsers = [QBUUser]()
    private var users = [QBUUser]()
    
    //MARK: - Properties
    lazy private var dataSource: UsersDataSource = {
        let dataSource = UsersDataSource()
        return dataSource
    }()
    lazy private var navViewController: UINavigationController = {
        let navViewController = UINavigationController()
        return navViewController
        
    }()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isToolbarHidden = true
        initDesigns()
        QBRTCClient.instance().add(self)
        
        
        // Reachability
        //        if Reachability.instance.networkConnectionStatus() != NetworkConnectionStatus.notConnection {
        //            loadUsers()
        //        }
        
        if(AppConstant.hasConnectivity()) {
            loadUsers()
        }
        
        // adding refresh control task
        refreshControl.addTarget(self, action: #selector(loadUsers), for: .valueChanged)
        tblViewUsers.refreshControl = refreshControl
        tblViewUsers.tableFooterView = UIView()
        
        configureNavigationBar()
        configureTableViewController()
        setupToolbarButtonsEnabled(false)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = Set<PKPushType>([.voIP])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        //MARK: - Reachability
        audioCallButton.isEnabled = true
        videoCallButton.isEnabled = true
        
        if AppConstant.hasConnectivity(){
            self.loadUsers()
        }else{
            self.cancelCallAlert()
        }
        //        let updateConnectionStatus: ((_ status: NetworkConnectionStatus) -> Void)? = { [weak self] status in
        //            let notConnection = status == .notConnection
        //            if notConnection == true {
        //                self?.cancelCallAlert()
        //            } else {
        //                self?.loadUsers()
        //            }
        //        }
        //        Reachability.instance.networkStatusBlock = { status in
        //            updateConnectionStatus?(status)
        //        }
        
        if refreshControl.isRefreshing == true {
            let contentOffset = CGPoint(x: 0.0, y: -refreshControl.frame.size.height)
            tblViewUsers.setContentOffset(contentOffset, animated: false)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        navigationController?.isToolbarHidden = true
    }
    
    func initDesigns() {
        //Manage for iPhone X
        if (AppConstant.screenSize.height >= 812) {
            navBarHeightConstraint.constant = 92
            topBarHeightConstraint.constant = 92
        }
    }
    
    // MARK: - UI Configuration
    private func configureTableViewController() {
        dataSource = UsersDataSource()
        CallKitManager.instance.usersDatasource = dataSource
        //tblViewUsers.dataSource = dataSource
        tblViewUsers.rowHeight = 44
        refreshControl.beginRefreshing()
    }
    
    private func configureNavigationBar() {
        let settingsButtonItem = UIBarButtonItem(image: UIImage(named: "ic-settings"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(self.didPressSettingsButton(_:)))
        navigationItem.leftBarButtonItem = settingsButtonItem
        //add info button
        showInfoButton()
        
        //Custom label
        var loggedString = "Logged in as "
        var roomName = ""
        var titleString = ""
        let profile = Profile()
        
        if profile.isFull == true  {
            let fullname = profile.fullName
            titleString = loggedString + fullname
            let tags = profile.tags
            if  tags?.isEmpty == false,
                let name = tags?.first {
                roomName = name
                loggedString = loggedString + fullname
                titleString = roomName + "\n" + loggedString
            }
        }
        
        let attrString = NSMutableAttributedString(string: titleString)
        let roomNameRange: NSRange = (titleString as NSString).range(of: roomName)
        attrString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16.0), range: roomNameRange)
        
        let userNameRange: NSRange = (titleString as NSString).range(of: loggedString)
        attrString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12.0), range: userNameRange)
        attrString.addAttribute(.foregroundColor, value: UIColor.gray, range: userNameRange)
        
        let titleView = UILabel(frame: CGRect.zero)
        titleView.numberOfLines = 2
        titleView.attributedText = attrString
        titleView.textAlignment = .center
        titleView.sizeToFit()
        navigationItem.titleView = titleView
        //Show tool bar
        //navigationController?.isToolbarHidden = false
        //Set exclusive touch for tool bar
        if let subviews = navigationController?.toolbar.subviews {
            for subview in subviews {
                subview.isExclusiveTouch = true
            }
        }
    }
    
    /**
     *  Load all (Recursive) users for current room (tag)
     */
    @objc func loadUsers() {
        let firstPage = QBGeneralResponsePage(currentPage: 1, perPage: 100)
        QBRequest.users(withExtendedRequest: ["order": "desc date updated_at"],
                        page: firstPage,
                        successBlock: { [weak self] (response, page, users) in
                            self?.dataSource.update(users: users)
                            self?.tblViewUsers.reloadData()
                            self?.refreshControl.endRefreshing()
                            
            }, errorBlock: { response in
                self.refreshControl.endRefreshing()
                debugPrint("[UsersViewController] loadUsers error: \(self.errorMessage(response: response) ?? "")")
        })
    }
    
    // MARK: - Actions
    @IBAction func refresh(_ sender: UIRefreshControl?) {
        loadUsers()
    }
    
    @IBAction func didPressAudioCall(_ sender: UIButton) {
        if dataSource.selectedUsers.count == 0{
            return
        }
        call(with: QBRTCConferenceType.audio)
    }
    
    @IBAction func didPressVideoCall(_ sender: UIButton) {
        if dataSource.selectedUsers.count == 0{
            return
        }
        call(with: QBRTCConferenceType.video)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Internal Methods
    private func hasConnectivity() -> Bool {
        
        if !AppConstant.hasConnectivity(){
            showAlertView(message: UsersAlertConstant.checkInternet)
            if CallKitManager.instance.isCallStarted() == false {
                CallKitManager.instance.endCall(with: callUUID) {
                    debugPrint("[UsersViewController] endCall")
                }
            }
            return false
        }
        //        let status = Reachability.instance.networkConnectionStatus()
        //        guard status != NetworkConnectionStatus.notConnection else {
        //            showAlertView(message: UsersAlertConstant.checkInternet)
        //            if CallKitManager.instance.isCallStarted() == false {
        //                CallKitManager.instance.endCall(with: callUUID) {
        //                    debugPrint("[UsersViewController] endCall")
        //                }
        //            }
        //            return false
        //        }
        return true
    }
    
    private func showAlertView(message: String?) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: UsersAlertConstant.okAction, style: .default,
                                                handler: nil))
        present(alertController, animated: true)
    }
    
    @objc func didPressSettingsButton(_ sender: UIBarButtonItem?) {
        let settingsStoryboard =  UIStoryboard(name: "Settings", bundle: nil)
        if let settingsController = settingsStoryboard.instantiateViewController(withIdentifier: "SessionSettingsViewController") as? SessionSettingsViewController {
            settingsController.delegate = self
            navigationController?.pushViewController(settingsController, animated: true)
        }
    }
    
    //MARK: - Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case UsersSegueConstant.settings:
            let settingsViewController = (segue.destination as? UINavigationController)?.topViewController
                as? SessionSettingsViewController
            settingsViewController?.delegate = self
        case UsersSegueConstant.call:
            debugPrint("[UsersViewController] UsersSegueConstant.call")
        default:
            break
        }
    }
    
    private func call(with conferenceType: QBRTCConferenceType) {
        
        if session != nil {
            return
        }
        
        if hasConnectivity() {
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
                        
                        if let callViewController = self.storyboard?.instantiateViewController(withIdentifier: UsersSegueConstant.call) as? CallViewController {
                            callViewController.session = self.session
                            callViewController.usersDataSource = self.dataSource
                            callViewController.callUUID = uuid
                            let nav = UINavigationController(rootViewController: callViewController)
                            nav.modalTransitionStyle = .crossDissolve
                            self.present(nav , animated: false)
                            self.audioCallButton.isEnabled = false
                            self.videoCallButton.isEnabled = false
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
                        SVProgressHUD.showError(withStatus: UsersAlertConstant.shouldLogin)
                    }
                }
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.selectUser(at: indexPath)
        setupToolbarButtons()
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    private func setupToolbarButtonsEnabled(_ enabled: Bool) {
        guard let toolbarItems = toolbarItems, toolbarItems.isEmpty == false else {
            return
        }
        for item in toolbarItems {
            item.isEnabled = enabled
        }
    }
    
    private func setupToolbarButtons() {
        setupToolbarButtonsEnabled(dataSource.selectedUsers.count > 0)
        if dataSource.selectedUsers.count > 4 {
            videoCallButton.isEnabled = false
        }
    }
    
    private func cancelCallAlert() {
        let alert = UIAlertController(title: UsersAlertConstant.checkInternet, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            
            CallKitManager.instance.endCall(with: self.callUUID) {
                debugPrint("[UsersViewController] endCall")
                
            }
            self.prepareCloseCall()
        }
        alert.addAction(cancelAction)
        present(alert, animated: false) {
        }
    }
    
    //Handle Error
    private func errorMessage(response: QBResponse) -> String? {
        var errorMessage : String
        if response.status.rawValue == 502 {
            errorMessage = "Bad Gateway, please try again"
        } else if response.status.rawValue == 0 {
            errorMessage = "Connection network error, please try again"
        } else {
            guard let qberror = response.error,
                let error = qberror.error else {
                    return nil
            }
            
            errorMessage = error.localizedDescription.replacingOccurrences(of: "(",
                                                                           with: "",
                                                                           options:.caseInsensitive,
                                                                           range: nil)
            errorMessage = errorMessage.replacingOccurrences(of: ")",
                                                             with: "",
                                                             options: .caseInsensitive,
                                                             range: nil)
        }
        return errorMessage
    }
    
    //MARK: Tableview Delegates
    
    func update(users: [QBUUser]) {
        for chatUser in users {
            update(user:chatUser)
        }
    }
    
    func update(user: QBUUser) {
        if let localUser = users.filter({ $0.id == user.id }).first {
            //Update local User
            localUser.fullName = user.fullName
            localUser.updatedAt = user.updatedAt
            return
        }
        users.append(user)
    }
    
    func selectUser(at indexPath: IndexPath) {
        
        let user = usersSortedByLastSeen()[indexPath.row]
        if selectedUsers.contains(user) {
            selectedUsers.removeAll(where: { element in element == user })
        } else {
            selectedUsers.append(user)
        }
    }
    
    func user(withID ID: UInt) -> QBUUser? {
        return users.filter{ $0.id == ID }.first
    }
    
    
    func ids(forUsers users: [QBUUser]) -> [NSNumber] {
        
        var result = [NSNumber]()
        
        for user in users {
            result.append(NSNumber(value: user.id))
        }
        return result
    }
    
    func removeAllUsers() {
        users.removeAll()
    }
    
    func usersSortedByFullName() -> [QBUUser] {
        let sortedUsers = unsortedUsersWithoutMe().sorted(by: {
            guard let firstUserName = $0.fullName, let secondUserName = $1.fullName else {
                return false
            }
            return firstUserName < secondUserName
        })
        return sortedUsers
    }
    
    func usersSortedByLastSeen() -> [QBUUser] {
        let sortedUsers = unsortedUsersWithoutMe().sorted(by: {
            guard let firstUpdatedAt = $0.updatedAt, let secondUpdatedAt = $1.updatedAt else {
                return false
            }
            return secondUpdatedAt < firstUpdatedAt
        })
        return sortedUsers
    }
    
    func unsortedUsersWithoutMe() -> [QBUUser] {
        var unsorterUsers = self.users
        let profile = Profile()
        if profile.isFull == false {
            return unsorterUsers
        }
        guard let index = unsorterUsers.index(where: { $0.id == profile.ID }) else {
            return unsorterUsers
        }
        unsorterUsers.remove(at: index)
        return unsorterUsers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.usersSortedByLastSeen().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersDataSourceConstant.userCellIdentifier)
            as? UserTableViewCell else {
                return UITableViewCell()
        }
        
        let user = dataSource.usersSortedByLastSeen()[indexPath.row]
        let selected = dataSource.selectedUsers.contains(user)
        
        let size = CGSize(width: 32.0, height: 32.0)
        var name = user.fullName ?? ""
        if name.isEmpty {
            name = user.login ?? "Unknown user"
        }
        let userImage = PlaceholderGenerator.placeholder(size: size, title: name)
        cell.fullName = name
        cell.check = selected
        cell.userImage = userImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let str = String(format: "Select users for call (%tu)", dataSource.selectedUsers.count)
        return NSLocalizedString(str, comment: "")
    }
}

// MARK: - QBRTCClientDelegate
extension UsersViewController: QBRTCClientDelegate {
    
    func session(_ session: QBRTCSession, hungUpByUser userID: NSNumber, userInfo: [String : String]? = nil) {
        if CallKitManager.instance.isCallStarted() == false && self.session?.id == session.id && self.session?.initiatorID == userID {
            CallKitManager.instance.endCall(with: callUUID) {
                debugPrint("[UsersViewController] endCall")
            }
            prepareCloseCall()
        }
    }
    
    func didReceiveNewSession(_ session: QBRTCSession, userInfo: [String : String]? = nil) {
        if self.session != nil {
            session.rejectCall(["reject": "busy"])
            return
        }
        
        self.session = session
        let uuid = UUID()
        callUUID = uuid
        var opponentIDs = [session.initiatorID]
        let profile = Profile()
        guard profile.isFull == true else {
            return
        }
        for userID in session.opponentsIDs {
            if userID.uintValue != profile.ID {
                opponentIDs.append(userID)
            }
        }
        
        var callerName = ""
        var opponentNames = [String]()
        var newUsers = [NSNumber]()
        for userID in opponentIDs {
            
            // Getting recipient from users.
            if let user = dataSource.user(withID: userID.uintValue),
                let fullName = user.fullName {
                opponentNames.append(fullName)
            } else {
                newUsers.append(userID)
            }
        }
        
        if newUsers.isEmpty == false {
            let loadGroup = DispatchGroup()
            for userID in newUsers {
                loadGroup.enter()
                dataSource.loadUser(userID.uintValue) { (user) in
                    if let user = user {
                        opponentNames.append(user.fullName ?? user.login ?? "")
                    } else {
                        opponentNames.append("\(userID)")
                    }
                    loadGroup.leave()
                }
            }
            loadGroup.notify(queue: DispatchQueue.main) {
                callerName = opponentNames.joined(separator: ", ")
                self.reportIncomingCall(withUserIDs: opponentIDs, outCallerName: callerName, session: session, uuid: uuid)
            }
        } else {
            callerName = opponentNames.joined(separator: ", ")
            self.reportIncomingCall(withUserIDs: opponentIDs, outCallerName: callerName, session: session, uuid: uuid)
        }
    }
    
    private func reportIncomingCall(withUserIDs userIDs: [NSNumber], outCallerName: String, session: QBRTCSession, uuid: UUID) {
        if hasConnectivity() {
            CallKitManager.instance.reportIncomingCall(withUserIDs: userIDs,
                                                       outCallerName: outCallerName,
                                                       session: session,
                                                       uuid: uuid,
                                                       onAcceptAction: { [weak self] in
                                                        guard let self = self else {
                                                            return
                                                        }
                                                        
                                                        if let callViewController = self.storyboard?.instantiateViewController(withIdentifier: UsersSegueConstant.call) as? CallViewController {
                                                            callViewController.session = session
                                                            callViewController.usersDataSource = self.dataSource
                                                            callViewController.callUUID = self.callUUID
                                                            self.navViewController = UINavigationController(rootViewController: callViewController)
                                                            
                                                            self.navViewController.modalTransitionStyle = .crossDissolve
                                                            self.present(self.navViewController , animated: false)
                                                            
                                                        }
                }, completion: { (end) in
                    debugPrint("[UsersViewController] endCall")
            })
        } else {
            
        }
    }
    
    func sessionDidClose(_ session: QBRTCSession) {
        if let sessionID = self.session?.id,
            sessionID == session.id {
            if self.navViewController.presentingViewController?.presentedViewController == self.navViewController {
                self.navViewController.view.isUserInteractionEnabled = false
                self.navViewController.dismiss(animated: false)
            }
            CallKitManager.instance.endCall(with: self.callUUID) {
                debugPrint("[UsersViewController] endCall")
                
            }
            prepareCloseCall()
        }
    }
    
    private func prepareCloseCall() {
        self.callUUID = nil
        self.session = nil
        if QBChat.instance.isConnected == false {
            self.connectToChat()
        }
        self.setupToolbarButtons()
    }
    
    private func connectToChat() {
        let profile = Profile()
        guard profile.isFull == true else {
            return
        }
        
        QBChat.instance.connect(withUserID: profile.ID,
                                password: LoginConstant.defaultPassword,
                                completion: { [weak self] error in
                                    guard let self = self else { return }
                                    if let error = error {
                                        if error._code == QBResponseStatusCode.unAuthorized.rawValue {
                                            self.logoutAction()
                                        } else {
                                            debugPrint("[UsersViewController] login error response:\n \(error.localizedDescription)")
                                        }
                                    } else {
                                        //did Login action
                                        SVProgressHUD.dismiss()
                                    }
        })
    }
}

extension UsersViewController: PKPushRegistryDelegate {
    // MARK: - PKPushRegistryDelegate
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        guard let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        let subscription = QBMSubscription()
        subscription.notificationChannel = .APNSVOIP
        subscription.deviceUDID = deviceIdentifier
        subscription.deviceToken = pushCredentials.token
        
        QBRequest.createSubscription(subscription, successBlock: { response, objects in
            debugPrint("[UsersViewController] Create Subscription request - Success")
        }, errorBlock: { response in
            debugPrint("[UsersViewController] Create Subscription request - Error")
        })
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        guard let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        QBRequest.unregisterSubscription(forUniqueDeviceIdentifier: deviceIdentifier, successBlock: { response in
            debugPrint("[UsersViewController] Unregister Subscription request - Success")
        }, errorBlock: { error in
            debugPrint("[UsersViewController] Unregister Subscription request - Error")
        })
    }
    
    func pushRegistry(_ registry: PKPushRegistry,
                      didReceiveIncomingPushWith payload: PKPushPayload,
                      for type: PKPushType) {
        if payload.dictionaryPayload[UsersConstant.voipEvent] != nil {
            let application = UIApplication.shared
            if application.applicationState == .background && backgroundTask == .invalid {
                backgroundTask = application.beginBackgroundTask(expirationHandler: {
                    application.endBackgroundTask(self.backgroundTask)
                    self.backgroundTask = UIBackgroundTaskIdentifier.invalid
                })
            }
            if QBChat.instance.isConnected == false {
                connectToChat()
            }
        }
    }
}

// MARK: - SettingsViewControllerDelegate
extension UsersViewController: SettingsViewControllerDelegate {
    func settingsViewController(_ vc: SessionSettingsViewController, didPressLogout sender: Any) {
        logoutAction()
    }
    
    private func logoutAction() {
        if QBChat.instance.isConnected == false {
            SVProgressHUD.showError(withStatus: "Error")
            return
        }
        SVProgressHUD.show(withStatus: UsersAlertConstant.logout)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        guard let identifierForVendor = UIDevice.current.identifierForVendor else {
            return
        }
        let uuidString = identifierForVendor.uuidString
        #if targetEnvironment(simulator)
        disconnectUser()
        #else
        QBRequest.subscriptions(successBlock: { (response, subscriptions) in
            
            if let subscriptions = subscriptions {
                for subscription in subscriptions {
                    if let subscriptionsUIUD = subscriptions.first?.deviceUDID,
                        subscriptionsUIUD == uuidString,
                        subscription.notificationChannel == .APNSVOIP {
                        self.unregisterSubscription(forUniqueDeviceIdentifier: uuidString)
                        return
                    }
                }
            }
            self.disconnectUser()
            
        }) { response in
            if response.status.rawValue == 404 {
                self.disconnectUser()
            }
        }
        #endif
    }
    
    private func disconnectUser() {
        QBChat.instance.disconnect(completionBlock: { error in
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                return
            }
            self.logOut()
        })
    }
    
    private func unregisterSubscription(forUniqueDeviceIdentifier uuidString: String) {
        QBRequest.unregisterSubscription(forUniqueDeviceIdentifier: uuidString, successBlock: { response in
            self.disconnectUser()
        }, errorBlock: { error in
            if let error = error.error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                return
            }
            SVProgressHUD.dismiss()
        })
    }
    
    private func logOut() {
        QBRequest.logOut(successBlock: { [weak self] response in
            //ClearProfile
            Profile.clearProfile()
            SVProgressHUD.dismiss()
            //Dismiss Settings view controller
            self?.dismiss(animated: false)
            
            DispatchQueue.main.async(execute: {
                self?.navigationController?.popToRootViewController(animated: false)
            })
        }) { response in
            debugPrint("QBRequest.logOut error\(response)")
        }
    }
}
