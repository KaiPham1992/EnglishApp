//
//  AppDelegate+Push.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import Firebase
import UserNotifications
import FirebaseMessaging
import SwiftyJSON

extension AppDelegate: UNUserNotificationCenterDelegate {
    func configureFirebase() {
        #if PROD
        let googleServiceFile = "GoogleService-Prod-Info"
        #else
        let googleServiceFile = "GoogleService-Prod-Info"
        #endif
        
        let filePath = Bundle.main.path(forResource: googleServiceFile, ofType: "plist")!
        guard let options = FirebaseOptions(contentsOfFile: filePath) else {
            print("There are some problems with GoogleService-Info file")
            return
        }
        
        FirebaseApp.configure(options: options)
    }
    
    func configurePushNotification(application: UIApplication) {
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        UserDefaultHelper.shared.deviceToken = token
//        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications with with error: \(error)")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber -= 1
        if let userInfor = response.notification.request.content.userInfo as? [String: Any] {
            self.handleNotification(userInfo: userInfor)
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.noData)
        print(userInfo)
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UIApplication.shared.applicationIconBadgeNumber += 1
        completionHandler([.alert, .badge, .sound])
    }
    
    private func handleNotification(userInfo: [String : Any]) {
        NotificationCenter.default.post(name: NSNotification.Name.init("didReciveNotification"), object: nil, userInfo: userInfo)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        UserDefaultHelper.shared.fcmToken = fcmToken
    }
}


