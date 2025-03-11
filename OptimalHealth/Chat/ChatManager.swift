//
//  ChatManager.swift
//  OptimalHealth
//
//  Created by Dinh Van Tin on 05/02/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import QiscusMultichannelWidget

final  class  ChatManager {

    static let shared: ChatManager = ChatManager()
    var displayName:String = ""
    let chatAppId = AppConstant.retrievFromDefaults(key: StringConstant.chatAppId)
    let chatChannelId = AppConstant.retrievFromDefaults(key: StringConstant.chatChannelId)
    lazy  var  qiscusWidget: QiscusMultichannelWidget = {
        return QiscusMultichannelWidget(appID: chatAppId)
    }()
    
    func setUser(id: String, displayName: String, avatarUrl: String = "") {
        self.displayName = displayName;
        qiscusWidget.setUser(id: id, displayName: displayName, avatarUrl: avatarUrl)
    }
    
    func signOut() {
        qiscusWidget.clearUser()
    }
    
    func isLoggedIn() -> Bool {
        return qiscusWidget.isLoggedIn()
    }
    
    func startChat(from viewController: UIViewController) {
        qiscusWidget.initiateChat()
            .setRoomTitle(title: "Customer Service")
            .setRoomSubTitle(subTitle: "")
            .setNavigationColor(color: #colorLiteral(red: 0, green: 81/255, blue: 129/255, alpha: 1))
            .setChannelId(channelId: Int(chatChannelId) ?? 0)
            .setHideUIEvent(showSystemEvent: false)
            .setEnableNotification(enableNotification: true)
            .startChat { (chatViewController) in
                viewController.navigationController?.setNavigationBarHidden(false, animated: true)
                viewController.navigationController?.setViewControllers([viewController, chatViewController], animated: true)
        }
    }    
    
    func register(deviceToken: Data?) {

        if let deviceToken = deviceToken {
            var tokenString: String = ""
            for i in 0..<deviceToken.count {
                tokenString += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
            }
             //isDevelopment = true : for development or running from XCode
            //isDevelopment = false : release mode TestFlight or appStore
            self.qiscusWidget.register(deviceToken: tokenString, isDevelopment: true, onSuccess: { (response) in
                print("Multichannel widget success to register device token")
            }) { (error) in
                print("Multichannel widget failed to register device token")
            }
        }
    }

    func userTapNotification(userInfo : [AnyHashable : Any]) {
        self.qiscusWidget.handleNotification(userInfo: userInfo, removePreviousNotif: false)
    }

}
extension String {
   func localized() -> String {
       return NSLocalizedString( self,tableName: "Localizable", bundle: .main, value: self, comment: self)
       
   }
}
