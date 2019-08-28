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
        #if APPSTORE
        let googleServiceFile = "GoogleService-Prod-Info"
        #else
        let googleServiceFile = "GoogleService-Dev-Info"
        #endif
        
        let filePath = Bundle.main.path(forResource: googleServiceFile, ofType: "plist")!
        guard let options = FirebaseOptions(contentsOfFile: filePath) else {
            print("There are some problems with GoogleService-Info file")
            return
        }
        
        FirebaseApp.configure(options: options)
    }
    
    func configurePushNotification(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            
        }
        UIApplication.shared.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        UserDefaultHelper.shared.deviceToken = token
//        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications with with error: \(error)")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(JSON(userInfo))
//        AppRouter.shared.openTabbar(index: 3)
//        AppRouter.shared.handleNotification(userInfo: userInfo)
        
        print("didReceive")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
        completionHandler([.alert, .badge, .sound])
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(messaging)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("\n\n🚀 Firebase registration token\n\(fcmToken)\n\n")
        UserDefaultHelper.shared.fcmToken = fcmToken
    }
}


