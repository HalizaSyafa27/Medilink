//
//  PushKitCallManager.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 05/06/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import Foundation
import UIKit
import CallKit
import PushKit

class CallManager: NSObject {

    static let shared: CallManager = CallManager()

    private var provider: CXProvider?
    var myudid: UUID?
    var cxCallController: CXCallController = CXCallController()
    let config = CXProviderConfiguration(localizedName: "Optimal Health")
    
    var notificationType: Int = 0

    private override init() {
        super.init()
        self.configureProvider()
    }

    private func configureProvider() {
        config.supportsVideo = true
//        config.supportedHandleTypes = [.emailAddress]
        config.supportedHandleTypes = [.phoneNumber]
        if let callKitIcon = UIImage(named: "optimal_health_logo")
        {
            config.iconTemplateImageData = callKitIcon.pngData()
        }
        
        provider = CXProvider(configuration: config)
        provider?.setDelegate(self, queue: DispatchQueue.main)
    }

    private let voipRegistry = PKPushRegistry(queue: nil)
    public func configurePushKit() {
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
    }

    public func incommingCall(from: String) {
        incommingCall(from: from, delay: 0)
    }

    public func incommingCall(from: String, delay: TimeInterval) {
        let update = CXCallUpdate()
//        update.remoteHandle = CXHandle(type: .emailAddress, value: from)
        update.remoteHandle = CXHandle(type: .phoneNumber, value: from)
        update.hasVideo = true

        let bgTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            self.provider?.reportNewIncomingCall(with: UUID(), update: update, completion: { (_) in })
            UIApplication.shared.endBackgroundTask(bgTaskID)
        }
    }

    public func outgoingCall(from: String, connectAfter: TimeInterval) {
        let controller = CXCallController()
//        let fromHandle = CXHandle(type: .emailAddress, value: from)
        let fromHandle = CXHandle(type: .phoneNumber, value: from)
        let startCallAction = CXStartCallAction(call: UUID(), handle: fromHandle)
        startCallAction.isVideo = true
        let startCallTransaction = CXTransaction(action: startCallAction)
        controller.request(startCallTransaction) { (error) in }

        self.provider?.reportOutgoingCall(with: startCallAction.callUUID, startedConnectingAt: nil)

        let bgTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + connectAfter) {
            self.provider?.reportOutgoingCall(with: startCallAction.callUUID, connectedAt: nil)
            UIApplication.shared.endBackgroundTask(bgTaskID)
        }
    }
}

extension CallManager: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        print("provider did reset")
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("call answered...")
        self.showlocalNotification(title: "\(AppConstant.Jitsi_caller) started video.", description: "Tap here to share your video.")

        DispatchQueue.main.async {
            if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
               myDelegate.startMeeting()
            }
        }
        
        action.fulfill()
        print("Udidddd === \(String(describing: self.myudid))")
        //endCall()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("call ended")
        //AppConstant.isAppOpenedFromCallReceived = false
        endCall()
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        //End call automatically
        print("call started")
        action.fulfill()
    }
}

extension CallManager: PKPushRegistryDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let parts = pushCredentials.token.map { String(format: "%02.2hhx", $0) }
        let token = parts.joined()

        AppConstant.saveInDefaults(key: StringConstant.voip_Token, value: token)
        print("VOIP device token: \(token)")

        let voipId = AppConstant.retrievFromDefaults(key: StringConstant.voip_Token)
        print("Get VOIP device token: \(voipId)")
    }
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        print("VOIP Push Notification")
        print(payload.dictionaryPayload)
        
        //voip_device_token_developer = 09dd1c937666627a2c0de55011412e9eca7e6c034cc01ddd32d8e78f5432d97c
        //  curl -v -d '{"aps":{"caller":"Doctor12345","room":"","token":""}}' --http2 --cert ApnsVoipPush.pem https://api.development.push.apple.com/3/device/09dd1c937666627a2c0de55011412e9eca7e6c034cc01ddd32d8e78f5432d97c
        
        //voip_device_token_production = ee7a0cec2d6ff3e1d49f4ef679c5cb74f405ed937a818124301265051971d09c
        //  curl -v -d '{"aps":{"caller":"Doctor12345","room":"1111","token":"ee7a0cec2d6ff3e1d49f4ef679c5cb74f405ed937a818124301265051971d09c"}}' --http2 --cert ApnsVoipPush.pem https://api.push.apple.com/3/device/ee7a0cec2d6ff3e1d49f4ef679c5cb74f405ed937a818124301265051971d09c
        
        //{"aps":{"caller":"caller name","room":"room name","token":"token to connect JITSI"}}
        
        if let aps = payload.dictionaryPayload[AnyHashable("aps")] as? NSDictionary {
            if let caller = aps["caller"] as? String {
                print(caller)
                AppConstant.Jitsi_caller = caller
            }
            if let room = aps["room"] as? String {
                //Show as local Notification msg
                AppConstant.Jitsi_room = room
            }
            if let token = aps["token"] as? String {
                AppConstant.Jitsi_token = token
            }
        }
        
        
        AppConstant.isAppOpenedFromCallReceived = true
        
        config.supportsVideo = true
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: AppConstant.Jitsi_caller)
        update.hasVideo = true
        self.myudid = UUID()
        self.provider?.reportNewIncomingCall(with: myudid!, update: update, completion: { error in
            if (error == nil) {
//                if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
//                   myDelegate.startMeeting()
//                }
                //End call automatically
                print("Udid === \(String(describing: self.myudid))")
                
            } else {
                print("Error === \(error)")
            }
        })

    }

    func showlocalNotification(title: String, description: String) {
        //present a local notifcation to visually see when we are recieving a VoIP Notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = description
        content.sound = UNNotificationSound.default
        //content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "iphoneringtone.mp3"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
            repeats: false)

        let requestIdentifier = "localNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier,
            content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request,
            withCompletionHandler: { (error) in
                // Handle error
            })
    }

    func endCall() {
        if let unwrappedCurrentCall = self.myudid {
            let endCallAction = CXEndCallAction.init(call: unwrappedCurrentCall)
            let transaction = CXTransaction.init()
            transaction.addAction(endCallAction)
            self.cxCallController.request(transaction) { error in
                if let error = error {
                    print("EndCallAction transaction request failed: \(error.localizedDescription).")
                    self.provider?.reportCall(with: unwrappedCurrentCall, endedAt: Date(), reason: .remoteEnded)
                    return
                }

                print("EndCallAction transaction request successful")

            }
        }
    }
}
