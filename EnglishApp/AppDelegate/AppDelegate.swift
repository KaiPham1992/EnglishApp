//
//  AppDelegate.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
//import Fabric
//import Crashlytics
//import netfox
import UserNotifications
import RealmSwift
import FBSDKShareKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        #if DEV
//            NFX.sharedInstance().start()
//        #endif
//        Fabric.with([Crashlytics.self])
//        Crashlytics.sharedInstance().debugMode = true
//        Fabric.sharedSDK().debug = true
        if UserDefaultHelper.shared.appLanguage == nil {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.english)
        }
        IQKeyboardManager.shared.enable = true
        
        configureGoogle()
        configurePushNotification(application: application)
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //---
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        checkLogin()
        realmConfig()
        AppRouter.shared.openHome()
//        AppRouter.shared.updateRootView()
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
       
        //--
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, err) in
//            if !didAllow {
//                print("User has declined notifications")
//            }
//        }
        return true
    }
    
//    func checkLogin() {
//        Provider.shared.userAPIService.checkLogin(success: { _ in
//
//        }) { _error in
//            if let _ = _error?.code {
//                UserDefaultHelper.shared.clearUser()
//                AppRouter.shared.openLogin()
//                return
//            } else {
//                return
//            }
//        }
//    }
    
    func realmConfig() {
//        let config = Realm.Configuration(schemaVersion: 2, migrationBlock: { (migration, oldSchemaVersion) in
//            if oldSchemaVersion < 1 {
//                migration.enumerateObjects(ofType: LocalConfigDictionary.className(), { (oldObject, newObject) in
//                    newObject!["isDefault"] = 0
//                })
//            }
//            if oldSchemaVersion < 2 {
//                migration.enumerateObjects(ofType: LocalConfigDictionary.className(), { (oldObject, newObject) in
//                    if let idUser = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0")  {
//                        oldObject?["id_user"] = idUser
//                    }
//                })
//
//                migration.enumerateObjects(ofType: LocalConfigDictionary.className(), { (oldObject, newObject) in
//                    if let idUser = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0")  {
//                        oldObject?["local_config_id"] = "\(String((oldObject?["id"] as? Int) ?? 0)))\(idUser)"
//                    }
//                })
//
//                migration.enumerateObjects(ofType: WordEntity.className(), { (oldObject, newObject) in
//                    if let idUser = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0")  {
//                        oldObject?["id_user"] = idUser
//                    }
//                })
//
//                migration.enumerateObjects(ofType: WordExplainEntity.className(), { (oldObject, newObject) in
//                    if let idUser = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0")  {
//                        oldObject?["id_user"] = idUser
//                    }
//                })
//            }
//        })
//        Realm.Configuration.defaultConfiguration = config
//    }
    
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:], sourceApplication: String) -> Bool {
        let fb = ApplicationDelegate.shared.application(app, open: url, options: options)
        return fb
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//            if settings.authorizationStatus == .authorized {
//                print("notification authorized")
//            } else {
//                print("notification not authorized")
//                self.configurePushNotification(application: application)
//            }
//        }
        
        print("=========================applicationDidBecomeActive=========================")
        
        Provider.shared.homeAPIService.getTopThree(success: { (object) in
            let count = object?.count_fight_test ?? 0
            UIApplication.shared.applicationIconBadgeNumber = object?.count_notify ?? 0
            if count > 0 {
                NotificationCenter.default.post(name: NSNotification.Name.init("RecieveCompetition"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name.init("NoCompetition"), object: nil)
            }
        }) { (error) in
            
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        LiveData.listDownloading.removeAll()
    }
}

