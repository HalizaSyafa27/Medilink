//
//  AppDelegate.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/2/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import GoogleMaps
import CoreData
//import Quickblox
//import QuickbloxWebRTC
import SVProgressHUD
import PushKit
import Firebase
import JitsiMeetSDK
import HealthKit
import Alamofire
import FirebaseCore

//To update the Credentials, please see the README file.
struct CredentialsConstant {
    //Manas
    static let applicationID:UInt = 78619
    static let authKey = "tEgB9y8barHkrUd"
    static let authSecret = "NJQWU-OF-M6XjhX"
    static let accountKey = "Bhf7F3bYQtUu1Ph2Soam"
    
}

struct TimeIntervalConstant {
    static let answerTimeInterval: TimeInterval = 60.0
    static let dialingTimeInterval: TimeInterval = 5.0
}

struct AppDelegateConstant {
    static let enableStatsReports: UInt = 1
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var isHudShowing : Bool = false
    var navController: UINavigationController!
    var mode = ""
    var jitsiMeetView: JitsiMeetView?
    var pipViewCoordinator: PiPViewCoordinator?
    
    private let userHealthProfile = UserHealthProfile()
    var inBedSeconds = 0
    var asleepSeconds = 0
    
//    var dataSource: UsersDataSource = {
//        let dataSource = UsersDataSource()
//        return dataSource
//    }()
    
    lazy private var navViewController: UINavigationController = {
        let navViewController = UINavigationController()
        return navViewController
        
    }()
    
    var isCalling = false {
        didSet {
            if UIApplication.shared.applicationState == .background,
                isCalling == false {
                //disconnect()
            }
        }
    }
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.isJailBroken()
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.toolbarConfiguration.tintColor = AppConstant.themeRedColor
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey(AppConstant.GoogleMapApiKey)
        
        self.registerForPushNotification(application: application)
        
        if AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) == StringConstant.YES {
            self.gotoHomeScreen()
        }else{
            self.gotoTnCScreen()
        }
        
        let remoteNotif = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary
        if remoteNotif != nil {
            let aps = remoteNotif?[AnyHashable("aps")] as? NSDictionary
            let msgBo = MessageBo()
            
            if let message = aps!["alert"] as? String{
                msgBo.text = message
                print(message)
            }else{
                msgBo.text = ""
            }
            if let date = aps!["Date"] as? String{
                msgBo.date = date
            }else{
                msgBo.date = ""
            }
            if let OutboxId = aps!["OutboxId"] as? String{
                msgBo.messageId = OutboxId
            }else{
                msgBo.messageId = ""
            }
            if let type = aps!["alertype"] as? String{
                msgBo.type = type
            }else{
                msgBo.type = ""
            }
            
            msgBo.userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
            
            let pushMsg = PushMessages(context: CoreDataManager.context)
            pushMsg.msg = msgBo.text
            pushMsg.date = msgBo.date
            pushMsg.id = msgBo.messageId
            pushMsg.userId = msgBo.userId
            pushMsg.insertedDate = NSDate() as Date
            pushMsg.type = msgBo.type
            pushMsg.readStatus = false
            
            if pushMsg.msg != ""{
                CoreDataManager.saveContext()
            }
            
            if (msgBo.type == "1" || msgBo.type == "2"){
                
            }
            
        }else{
            
        }
        
        //Check for update app
        checkIfAnyUpdatedVersionInAppStore()
        //Configure PushKit
        CallManager.shared.configurePushKit()
        
//        if AppConstant.isCallKitSupport(){
//            CallManager.shared.configurePushKit()
//        }
        
        // Fetch data once an hour.
        UIApplication.shared.setMinimumBackgroundFetchInterval(3600)
        
        guard let launchOptions = launchOptions else { return false }
        return JitsiMeet.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //return true
    }
    
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
                     @escaping (UIBackgroundFetchResult) -> Void) {
        print("background fetch")
        if AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) == StringConstant.YES {
            self.authorizeHealthKit()
            self.serviceCallToUpdateHealthDataToServerInBackground(fetchCompletionHandler: completionHandler)
        }
        
       //completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard {
            print("Application use of Third-Party keyboard.")
            return false
        }
       return true
    }
    
    
    func isJailBroken() {
//        if UIApplication.shared.canOpenURL(URL(string: "cydia://")!){
//            // This Device is jailbroken
//            print("This Device is jailbroken")
//            exit(-1)
//        }
//        let fm = FileManager.default
//        if(fm.fileExists(atPath: "/private/var/lib/apt")  ||
//            fm.fileExists(atPath: "/bin/sh") ||
//            fm.fileExists(atPath: "/usr/libexec/sftp-server") ||
//            fm.fileExists(atPath: "/usr/libexec/ssh-keysign") ||
//            fm.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
//            fm.fileExists(atPath: "/bin/bash") ||
//            fm.fileExists(atPath: "/usr/sbin/sshd") ||
//            fm.fileExists(atPath: "/etc/apt") ||
//            fm.fileExists(atPath: "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist") ||
//            fm.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist") ||
//            fm.fileExists(atPath: "/System/Library/LaunchDaemons/com.ikey.bbot.plist") ||
//            fm.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/Veency.plist") ||
//            fm.fileExists(atPath: "/Applications/blackra1n.app") ||
//            fm.fileExists(atPath: "/Applications/FakeCarrier.app") ||
//            fm.fileExists(atPath: "/Applications/Icy.app") ||
//            fm.fileExists(atPath: "/Applications/IntelliScreen.app") ||
//            fm.fileExists(atPath: "/Applications/MxTube.app") ||
//            fm.fileExists(atPath: "/Applications/RockApp.app") ||
//            fm.fileExists(atPath: "/Applications/SBSettings.app") ||
//            fm.fileExists(atPath: "/Applications/WinterBoard.app") ||
//            fm.fileExists(atPath: "/Applications/Cydia.app"))
//        {
//            // This Device is jailbroken
//            print("This Device is jailbroken")
//            exit(-1)
//        }
//        let jailBreakTestText = "Test for JailBreak"
//        do {
//            try jailBreakTestText.write(toFile:"/private/jailBreakTestText.txt", atomically:true, encoding:String.Encoding.utf8)
//            // This Device is jailbroken
//            print("This Device is jailbroken")
//            exit(-1)
//        } catch {
//
//        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // Logging out from chat.
//        if isCalling == false {
//            disconnect()
//        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        checkIfAnyUpdatedVersionInAppStore()
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("did become active called")
        self.isJailBroken()
        if AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) == StringConstant.YES {
            self.authorizeHealthKit()
        }
//        let viewController = UIApplication.shared.keyWindow?.rootViewController
//        if viewController is LogInController || AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) != StringConstant.YES {
//
//        }else{
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.apiCheckMultipleLogin()
//        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        CoreDataManager.saveContext()
        
        // Logging out from chat.
        //disconnect()
    }
    
    // MARK: - Linking delegate methods
//    func application(_ application: UIApplication,
//                     continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        return JitsiMeet.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler)
//    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        // Get URL components from the incoming user activity.
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let incomingURL = userActivity.webpageURL,
            let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
            return false
        }
        // Check for specific URL components that you need.
        guard let path = components.path,
              let params = components.queryItems else {
            return false
        }
        
        if let token = params.first(where: { $0.name == "token" })?.value{
            gotoLoginScreen(fromJwt: true, url: components)
            return true
        }
        
        return JitsiMeet.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    //@ade: end
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return JitsiMeet.sharedInstance().application(app, open: url, options: options)
    }
    
    //MARK: - Jitsi Meet
    func cleanUp() {
        print("Cleanup")
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        AppConstant.isAppOpenedFromCallReceived = false
        if(jitsiMeetView != nil) {
            self.window?.rootViewController?.dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
            
            //Pip Mode
//            jitsiMeetView?.removeFromSuperview()
//            jitsiMeetView = nil
//            pipViewCoordinator = nil
        }
    }
    
    func startMeeting(){
//        let room: String = "testm" //"MEDILINKDEMO" //"oditek"
//        if(room.count < 1) {
//            return
//        }
        print("Meeting Started")
        IQKeyboardManager.shared.isEnabled = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.serverURL = URL(string: "https://vc.medilink.co.id")
            builder.room = AppConstant.Jitsi_room
            builder.token = AppConstant.Jitsi_token
//            builder.welcomePageEnabled = false
            builder.userInfo = JitsiMeetUserInfo(displayName: AppConstant.retrievFromDefaults(key: StringConstant.name), andEmail: AppConstant.retrievFromDefaults(key: StringConstant.email), andAvatar: URL(string: ""))
            builder.setAudioOnly(false)
        }
        
        //setup view controller
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view = jitsiMeetView

        // join room and display jitsi-call
        jitsiMeetView.join(options)
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        
    }
    
    func startMeetingWithPip(){
        cleanUp()

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
            //builder.serverURL = URL(string: "https://ec2-100-24-253-127.compute-1.amazonaws.com")
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
    
    //MARK: Navigations
    func gotoTnCScreen(){
        navController = UINavigationController()
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : TermsAndConditionController = mainStoryboardIpad.instantiateViewController(withIdentifier: "TermsAndConditionController") as! TermsAndConditionController
        navController.viewControllers = [initialViewControlleripad]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.clipsToBounds = true
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    func gotoLandingScreen(){
        navController = UINavigationController()
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : TermsAndConditionController = mainStoryboardIpad.instantiateViewController(withIdentifier: "TermsAndConditionController") as! TermsAndConditionController
        navController.viewControllers = [initialViewControlleripad]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.clipsToBounds = true
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    func gotoHomeScreen(){
        navController = UINavigationController()
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : HomeViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navController.viewControllers = [initialViewControlleripad]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.clipsToBounds = true
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        navController.isNavigationBarHidden = true
    }

    func gotoLoginScreen(){
        navController = UINavigationController()
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : LogInController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LogInController") as! LogInController
        navController.viewControllers = [initialViewControlleripad]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.clipsToBounds = true
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    //@ade: start
    func gotoLoginScreen(fromJwt: Bool, url: NSURLComponents) {
        navController = UINavigationController()
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : LogInController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LogInController") as! LogInController
        initialViewControlleripad.isFromJwt = fromJwt
        initialViewControlleripad.url = url
        navController.viewControllers = [initialViewControlleripad]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.clipsToBounds = true
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    //@ade: end
    
    func pushToAdvisoryScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let navController = self.navController, let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HealthAdvisoryViewController") as? HealthAdvisoryViewController{
            navController.pushViewController(viewController, animated: true)
        }

    }
    
    //MARK: Register for Push Notification
    
    func registerForPushNotification(application: UIApplication){
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { granted, error in }
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        application.registerForRemoteNotifications()
        
        
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        let str = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        // Print it to console
        print("Set APNs device token: \(deviceTokenString)")
        //print("str : \(str)")
        AppConstant.saveInDefaults(key: StringConstant.deviceToken, value: str)
        // Persist it in your backend in case it's new
        let apnsId = AppConstant.retrievFromDefaults(key: StringConstant.deviceToken)
        print("Get APNs device token: \(apnsId)")
        getChatInfo(deviceToken: deviceToken)
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
        print("didReceiveRemoteNotification called")
        if(application.applicationState != .active) {
            let aps = data[AnyHashable("aps")] as? NSDictionary
            print(aps)
            
            let msgBo = MessageBo()
            
            if let message = aps!["alert"] as? String{
                msgBo.text = message
                print(message)
            }else{
                msgBo.text = ""
            }
            if let date = aps!["Date"] as? String{
                msgBo.date = date
            }else{
                msgBo.date = ""
            }
            if let OutboxId = aps!["OutboxId"] as? String{
                msgBo.messageId = OutboxId
            }else{
                msgBo.messageId = ""
            }
            
            if let type = aps!["alertype"] as? String{
                msgBo.type = type
            }else{
                msgBo.type = ""
            }
            
            msgBo.userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
            
            let pushMsg = PushMessages(context: CoreDataManager.context)
            pushMsg.msg = msgBo.text
            pushMsg.date = msgBo.date
            pushMsg.id = msgBo.messageId
            pushMsg.userId = msgBo.userId
            pushMsg.insertedDate = NSDate() as Date
            pushMsg.type = msgBo.type
            pushMsg.readStatus = false
            
            if pushMsg.msg != ""{
                CoreDataManager.saveContext()
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.updateNotificationCount), object: self, userInfo: nil)
            
            if (msgBo.type == "1" || msgBo.type == "2"){
                
            }
            
        }
        
//        if let notificationMode = data[AnyHashable("mode")] as? String{
//            mode = notificationMode
//        }else{
//            print("Notification Payload error")
//            return
//        }
        
       // print("Notification type : \(mode)")
        if(application.applicationState == .active) {
            print("App is active")
            //let mode = "chat"
//            if mode == "chat"{
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.chatReceivedNotification), object: self, userInfo: data)
//            }
            
            //app is currently active, can update badges count here
            
        } else if(application.applicationState == .background){
            print("App is in background")
            
            //app is in background, if content-available key of your notification is set to 1, poll to your backend to retrieve data and update your interface here
            
        } else if(application.applicationState == .inactive){
            print("App is in inactive")
            
            //app is transitioning from background to foreground (user taps notification), do what you need when user taps here
           
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        print("Notif===\(notification.request.content.userInfo)")
        if let aps = notification.request.content.userInfo[AnyHashable("aps")] as? NSDictionary{
            print(aps)
            
            let msgBo = MessageBo()
            
            if let message = aps["alert"] as? String{
                msgBo.text = message
                print(message)
            }else{
                msgBo.text = ""
            }
            if let date = aps["Date"] as? String{
                msgBo.date = date
            }else{
                msgBo.date = ""
            }
            if let OutboxId = aps["OutboxId"] as? String{
                msgBo.messageId = OutboxId
            }else{
                msgBo.messageId = ""
            }
            if let type = aps["alertype"] as? String{
                msgBo.type = type
            }else{
                msgBo.type = ""
            }
            
            msgBo.userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
            
            let pushMsg = PushMessages(context: CoreDataManager.context)
            pushMsg.msg = msgBo.text
            pushMsg.date = msgBo.date
            pushMsg.id = msgBo.messageId
            pushMsg.userId = msgBo.userId
            pushMsg.insertedDate = NSDate() as Date
            pushMsg.type = msgBo.type
            pushMsg.readStatus = false
            
            if pushMsg.msg != ""{
                CoreDataManager.saveContext()
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StringConstant.updateNotificationCount), object: self, userInfo: nil)
            
            if (msgBo.type == "1" || msgBo.type == "2"){
                
            }
        }
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void){
        print("App is in background state")
        let  userInfo  =  response.notification.request.content.userInfo
        ChatManager.shared.userTapNotification(userInfo:  userInfo)
        completionHandler()
    }
    
    //For Background refresh
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("fetchCompletionHandler called")
        //print("Notification === \(userInfo)")
        ChatManager.shared.userTapNotification(userInfo: userInfo)
        if AppConstant.retrievFromDefaults(key: StringConstant.isLoggedIn) == StringConstant.YES {
            //completionHandler(.newData)
            self.authorizeHealthKit()
            self.serviceCallToUpdateHealthDataToServerInBackground(fetchCompletionHandler: completionHandler)
        }
        //completionHandler(.newData)
    }
    
    func showlocalNotification() {
        //present a local notifcation to visually see when we are recieving a VoIP Notification
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.body = "description"
        //content.sound = UNNotificationSound.default
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "iphoneringtone.mp3"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
            repeats: false)

        let requestIdentifier = "localNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier,
            content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request,
            withCompletionHandler: { (error) in
                // Handle error
                print(error?.localizedDescription)
            })
    }
    
    //MARK:- App Update
    func checkIfAnyUpdatedVersionInAppStore(){
        checkForUpdate { (isUpdate) in
            print("Update needed:\(isUpdate)")
            if isUpdate{
                DispatchQueue.main.async {
                    self.showPopupForAppUpdate()
                    print("new update Available")
                }
            }
        }
    }
    
    func checkForUpdate(completion:@escaping(Bool)->()){
        
        guard let bundleInfo = Bundle.main.infoDictionary,
            let currentVersion = bundleInfo["CFBundleShortVersionString"] as? String,
            let identifier = bundleInfo["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)")
            //print("app url = \(url)")
            else{
                print("something went wrong")
                completion(false)
                return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, resopnse, error) in
            if error != nil{
                completion(false)
                print("something went wrong")
            }else{
                do{
                    guard let reponseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any],
                        let result = (reponseJson["results"] as? [Any])?.first as? [String: Any],
                        let appStoreVersion = result["version"] as? String
                        else{
                            completion(false)
                            return
                    }
                    print("Current Ver:\(currentVersion)")
                    print("Appstore version:\(appStoreVersion)")
                    let floatCurr = Float(currentVersion)!
                    let floatAppstore = Float(appStoreVersion)!
                    if floatCurr < floatAppstore{
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
                catch{
                    completion(false)
                    print("Something went wrong")
                }
            }
        }
        task.resume()
    }
    
    func showPopupForAppUpdate(){
        let alertController = UIAlertController(
            title: "Update available",
            message: "We have now just got smarter!.\nUpdating to the latest version of the app to get latest information.",
            preferredStyle: UIAlertController.Style.alert
        )
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertAction.Style.default) { (action) in
        }
        let confirmAction = UIAlertAction(
        title: "Update", style: UIAlertAction.Style.default) { (action) in
            let url = "https://itunes.apple.com/app/id6444691018"
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: url)!)
            }
        }
        alertController.view.tintColor = UIColor.black
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        alertController.preferredAction = confirmAction
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Heahth Kit Data
    func authorizeHealthKit() {
        HealthKitInterface.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                AppConstant.hideHUD()
                return
            }
            
            self.updateHealthInfo()
            print("HealthKit Successfully Authorized.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                //Upload Health Data To Server
                self.serviceCallToUpdateHealthDataToServer()
            }
        }
        
    }
    
    private func updateHealthInfo() {
        loadAndDisplayAgeSexAndBloodType()
        loadAndDisplayMostRecentWeight()
        loadAndDisplayMostRecentHeight()
        loadAndDisplayTodayStepCount()
        loadAndDisplayTodayFlightClimbCount()
        loadAndDisplayTodayWalkingAndRunningDistance()
        loadAndDisplayMostRecentBodyTemperature()
        loadAndDisplayMostRecentBodyFatPercentage()
        loadAndDisplayMostRecentHeartRate()
        loadAndDisplayMostRecentHeartRateVariability()
        loadAndDisplayMostRecentEnergyBurned()
        loadAndDisplayMostRecentBloodPressure()
        loadAndDisplayMostRecentSleepData()
    }
    
    private func loadAndDisplayAgeSexAndBloodType() {
        do {
            let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
        } catch let error {
        }
    }
    
    private func loadAndDisplayMostRecentWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile.weightInKilograms = self.roundToPlaces(value: weightInKilograms, places: 2)
        }
    }
    
    private func loadAndDisplayMostRecentHeight() {
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.userHealthProfile.heightInMeters = heightInMeters
        }
    }
    
    private func loadAndDisplayTodayStepCount() {
        ProfileDataStore.getTodaysSteps { (steps) in
            self.userHealthProfile.stepsToday = Int(steps)
            print("Today step count \(steps)")
            //self.serviceCallToUpdateHealthDataToServer()
        }
    }
    
    private func loadAndDisplayTodayFlightClimbCount() {
        ProfileDataStore.getTodaysFlightClimbed { (flights) in
            self.userHealthProfile.flightClimbToday = Int(flights)
            print("Today flight climbed count \(flights)")
        }
    }
    
    private func loadAndDisplayTodayWalkingAndRunningDistance() {
        ProfileDataStore.getTodaysWalkingAndRunningDistance { (distance) in
            let distanceInKm = distance/1000
            print("Today walking + running distnce \(distance) m")
            self.userHealthProfile.walkingRunningDistance = distanceInKm
            print("Today walking + running distnce \(distanceInKm) km")
        }
    }
    
    private func loadAndDisplayMostRecentBodyTemperature() {
        //1. Use HealthKit to create the Height Sample Type
        guard let tempSampleType = HKSampleType.quantityType(forIdentifier: .bodyTemperature) else {
            print("Body temperature Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: tempSampleType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let tempInCelcius = sample.quantity.doubleValue(for: HKUnit.degreeCelsius())
            self.userHealthProfile.tempInCelcius = tempInCelcius
        }
    }
    
    private func loadAndDisplayMostRecentBodyFatPercentage() {
        //1. Use HealthKit to create the Height Sample Type
        guard let fatPercentageType = HKSampleType.quantityType(forIdentifier: .bodyFatPercentage) else {
            print("Body fat Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: fatPercentageType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            let fat =  sample.quantity.doubleValue(for: HKUnit.percent())
            self.userHealthProfile.bodyFatPercentage = fat * 100.0
        }
    }
    
    private func loadAndDisplayMostRecentHeartRate() {
        guard let heartRateSampleType = HKSampleType.quantityType(forIdentifier: .heartRate) else {
            print("Heart Rate Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heartRateSampleType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            let heartRateUnit:HKUnit = HKUnit(from: "count/min")
            print("manas Heart Rate : \(sample.quantity.doubleValue(for: heartRateUnit))")
            self.userHealthProfile.heartRate = Int(sample.quantity.doubleValue(for: heartRateUnit))
        }
    }
    
    private func loadAndDisplayMostRecentHeartRateVariability() {
        if #available(iOS 11.0, *) {
            guard let heartRateVariabilitySampleType = HKSampleType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
                print("Heart Rate Variability Sample Type is no longer available in HealthKit")
                return
            }
            
            ProfileDataStore.getMostRecentSample(for: heartRateVariabilitySampleType) { (sample, error) in
                guard let sample = sample else {
                    return
                }
                let heartRateVariabilityUnit:HKUnit = HKUnit(from: "ms")
                print("manas Heart Rate Variability : \(sample.quantity.doubleValue(for: heartRateVariabilityUnit))")
                
                self.userHealthProfile.heartRateVariability = Int(sample.quantity.doubleValue(for: heartRateVariabilityUnit))
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    private func loadAndDisplayMostRecentEnergyBurned() {
        guard let energyBurnedType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Energy Burned data is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: energyBurnedType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            self.userHealthProfile.caloriesBurned = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
        }
    }
    
    private func loadAndDisplayMostRecentBloodPressure() {
        guard let bloodPressureSystolSampleType = HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic) else {
            print("Blood Pressure Systolic Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: bloodPressureSystolSampleType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            let bpSystolic:HKUnit = HKUnit(from: "mmHg")
            self.userHealthProfile.bpSystolic = Int(sample.quantity.doubleValue(for: bpSystolic))
        }
        
        guard let bloodPressureDiastolicSampleType = HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic) else {
            print("Blood Pressure Diastolic Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: bloodPressureDiastolicSampleType) { (sample, error) in
            guard let sample = sample else {
                return
            }
            
            let bpDiastolic:HKUnit = HKUnit(from: "mmHg")
            self.userHealthProfile.bpDiastolic = Int(sample.quantity.doubleValue(for: bpDiastolic))
        }
    }
    
    func loadAndDisplayMostRecentSleepData() {
        let healthKitStore = HKHealthStore()
        // first, we define the object type we want
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                                  end: Date(),
                                                                  options: .strictEndDate)
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                  ascending: false)
            
            let limit = 2
            let query = HKSampleQuery(sampleType: sleepType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                if error != nil {
                    // something happened
                    return
                }
                
                if let result = tmpResult {
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                            print("Most Recent sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                            
                            if value == "InBed"{
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                self.inBedSeconds = Int(seconds)
                                let minutes = (Int(seconds) / 60) % 60
                                let hours = Int(seconds) / 3600
                                print("In bed: \(hours)h \(minutes)m")
                                self.userHealthProfile.totalSleepTime = "\(hours)h \(minutes)m"
                            }else{
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                self.asleepSeconds = Int(seconds)
                                let minutes = (Int(seconds) / 60) % 60
                                let hours = Int(seconds) / 3600
                                print("Asleep: \(hours)h \(minutes)m")
                                self.userHealthProfile.deepSleepTime = "\(hours)h \(minutes)m"
                            }
                            
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthKitStore.execute(query)
        }
    }
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    //MARK: Service Call Method
    func serviceCallToUpdateHealthDataToServer() {
            if(AppConstant.hasConnectivity()) {//true connected
                print("ManasDashboard")
               // AppConstant.showHUD()
                
                let userName = AppConstant.retrievFromDefaults(key: StringConstant.name)
//                let userEmail = AppConstant.retrievFromDefaults(key: StringConstant.email)
//                let password = AppConstant.retrievFromDefaults(key: StringConstant.password)
                let planCode = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
                
                var gender = "N"
                if self.userHealthProfile.biologicalSex == HKBiologicalSex.notSet{
                    gender = "N"
                }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.male{
                    gender = "M"
                }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.female{
                    gender = "F"
                }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.other{
                    gender = "O"
                }
                let date = NSDate() // Get Todays Date
                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let stringDate: String = dateFormatter.string(from: date as Date)
                let userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)

                let params: Parameters = [
                    "pstUsrID": AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId),
                    //"pstPassword": password,
                    "pstCardNo": userType == "2" ? "0" : AppConstant.retrievFromDefaults(key: StringConstant.cardNo),
                    "pstName": userName,
                    "pstPlancode": planCode,
                    "pstBmi": String(format: "%.02f", userHealthProfile.bodyMassIndex!),
                    "pstFat": "\(self.userHealthProfile.bodyFatPercentage)%",
                    "pstCalBurnied": "\(Int(userHealthProfile.caloriesBurned)) cal",
                    "pstAge": self.userHealthProfile.age,
                    "pstWalkingDistanceToday": String(format: "%.02f km", userHealthProfile.walkingRunningDistance),
                    "pstStepsToday": "\(self.userHealthProfile.stepsToday)",
                    "pstGender": gender,
                    "pstBloodPressure": "\(userHealthProfile.bpSystolic)" + "/" + "\(userHealthProfile.bpDiastolic)",
                    "pstHeartRate": "\(userHealthProfile.heartRate) bpm",
                    "pstHeight": "\(userHealthProfile.heightInMeters * 100) cm",
                    "pstHeartRateVariability": "\(self.userHealthProfile.heartRateVariability) ms",
                    "pstTotalSleep": userHealthProfile.totalSleepTime,
                    "pstWeight": "\(userHealthProfile.weightInKilograms) kg",
                    "pstTemperature": String(format: "%.01f", userHealthProfile.tempInCelcius),
                    "pstFlightsClimbToday": String(format: "\(userHealthProfile.flightClimbToday)"),
                    "pstDeepSleep": userHealthProfile.deepSleepTime,
                    "pdtDataCaptureDt": stringDate
                ]
                let url = AppConstant.updateDashboardHealthDataUrl
                
                print("params===\(params)")
                print("url===\(url)")
                
                let headers: HTTPHeaders = [
                    "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                    "Accept": "application/json"
                ]
                
                print("Headers--- \(headers)")
                
                Alamofire.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        //AppConstant.hideHUD()
                        debugPrint(response)
                        switch(response.result) {
                        case .success(_):
                            
                            let headerStatusCode : Int = (response.response?.statusCode)!
                            print("Status Code: \(headerStatusCode)")
                            
                            if(headerStatusCode == 401){//Session expired
                                AppConstant.isTokenVerified(completion: { (Bool) in
                                    if Bool{
                                        self.serviceCallToUpdateHealthDataToServer()
                                    }
                                })
                            }else{
                                //let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                //  debugPrint(dict)
                                
                            }
                            
                            break
                            
                        case .failure(_):
                            let error = response.result.error!
                            print(error.localizedDescription)
                            break
                            
                        }
                }
                
            }else{
                print("Please check your internet connection.")
            }
        }
    
    func serviceCallToUpdateHealthDataToServerInBackground(fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
                if(AppConstant.hasConnectivity()) {//true connected
                    print("ManasDashboard")
                   // AppConstant.showHUD()
                    
                    let userName = AppConstant.retrievFromDefaults(key: StringConstant.name)
    //                let userEmail = AppConstant.retrievFromDefaults(key: StringConstant.email)
    //                let password = AppConstant.retrievFromDefaults(key: StringConstant.password)
                    let planCode = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
                    
                    var gender = "N"
                    if self.userHealthProfile.biologicalSex == HKBiologicalSex.notSet{
                        gender = "N"
                    }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.male{
                        gender = "M"
                    }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.female{
                        gender = "F"
                    }else if self.userHealthProfile.biologicalSex == HKBiologicalSex.other{
                        gender = "O"
                    }
                    let date = NSDate() // Get Todays Date
                    let dateFormatter = DateFormatter()
    //                dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let stringDate: String = dateFormatter.string(from: date as Date)
                    let userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)

                    let params: Parameters = [
                        "pstUsrID": AppConstant.retrievFromDefaults(key: StringConstant.encryptedUserId),
                        //"pstPassword": password,
                        "pstCardNo": userType == "2" ? "0" : AppConstant.retrievFromDefaults(key: StringConstant.cardNo),
                        "pstName": userName,
                        "pstPlancode": planCode,
                        "pstBmi": String(format: "%.02f", userHealthProfile.bodyMassIndex!),
                        "pstFat": "\(self.userHealthProfile.bodyFatPercentage)%",
                        "pstCalBurnied": "\(Int(userHealthProfile.caloriesBurned)) cal",
                        "pstAge": self.userHealthProfile.age,
                        "pstWalkingDistanceToday": String(format: "%.02f km", userHealthProfile.walkingRunningDistance),
                        "pstStepsToday": "\(self.userHealthProfile.stepsToday)",
                        "pstGender": gender,
                        "pstBloodPressure": "\(userHealthProfile.bpSystolic)" + "/" + "\(userHealthProfile.bpDiastolic)",
                        "pstHeartRate": "\(userHealthProfile.heartRate) bpm",
                        "pstHeight": "\(userHealthProfile.heightInMeters * 100) cm",
                        "pstHeartRateVariability": "\(self.userHealthProfile.heartRateVariability) ms",
                        "pstTotalSleep": userHealthProfile.totalSleepTime,
                        "pstWeight": "\(userHealthProfile.weightInKilograms) kg",
                        "pstTemperature": String(format: "%.01f", userHealthProfile.tempInCelcius),
                        "pstFlightsClimbToday": String(format: "\(userHealthProfile.flightClimbToday)"),
                        "pstDeepSleep": userHealthProfile.deepSleepTime,
                        "pdtDataCaptureDt": stringDate
                    ]
                    let url = AppConstant.updateDashboardHealthDataUrl
                    
                    print("params===\(params)")
                    print("url===\(url)")
                    
                    let headers: HTTPHeaders = [
                        "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                        "Accept": "application/json"
                    ]
                    
                    print("Headers--- \(headers)")
                    
                    Alamofire.request( url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                        .responseJSON { response in
                            //AppConstant.hideHUD()
                            debugPrint(response)
                            switch(response.result) {
                            case .success(_):
                                completionHandler(UIBackgroundFetchResult.noData)
                                let headerStatusCode : Int = (response.response?.statusCode)!
                                print("Status Code: \(headerStatusCode)")
                                
                                if(headerStatusCode == 401){//Session expired
                                    AppConstant.isTokenVerified(completion: { (Bool) in
                                        if Bool{
                                            self.serviceCallToUpdateHealthDataToServer()
                                        }
                                    })
                                }else{
                                    //let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                    //  debugPrint(dict)
                                    
                                }
                                
                                break
                                
                            case .failure(_):
                                completionHandler(UIBackgroundFetchResult.noData)
                                let error = response.result.error!
                                print(error.localizedDescription)
                                break
                                
                            }
                    }
                    
                }else{
                    print("Please check your internet connection.")
                }
            }
    
    
    func getChatInfo(deviceToken: Data){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            print("url===\(AppConstant.getChatInfoUrl)")
            AFManager.request( AppConstant.getChatInfoUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseString { response in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    let dict = AppConstant.convertToDictionary(text: response.result.value!)
                    if let status = dict?["Status"] as? String {
                        if(status == "1"){//Success
                            let fullPath = dict?["FullPath"] as! String
                            if (fullPath != ""){
                                let fullPathArray = fullPath.split(separator: "/")
                                if fullPathArray.count > 1 {
                                    print("This is App ID: " + String(fullPathArray[fullPathArray.count - 2]))
                                    print("This is Channel ID: " + String(fullPathArray[fullPathArray.count - 1]))
                                    AppConstant.saveInDefaults(key: StringConstant.chatAppId, value: String(fullPathArray[fullPathArray.count - 2]))
                                    AppConstant.saveInDefaults(key: StringConstant.chatChannelId, value: String(fullPathArray[fullPathArray.count - 1]))
                                    
                                    //qiscus chat register
                                    ChatManager.shared.register(deviceToken:  deviceToken)
                                }
                                AppConstant.saveInDefaults(key: StringConstant.chatUrl, value: fullPath)
                            }else{
                                AppConstant.saveInDefaults(key: StringConstant.chatUrl, value: "")
                                AppConstant.saveInDefaults(key: StringConstant.chatAppId, value: "")
                                AppConstant.saveInDefaults(key: StringConstant.chatChannelId, value: "")
                            }
                        }
                    }
                    break
                case .failure(_):
                    break
                }
                AppConstant.hideHUD()
            }
        }else{
            print("Please check your internet connection.")
        }
    }
}

extension AppDelegate: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        print("Meeting Over")
        self.cleanUp()
        CallManager.shared.endCall()
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
