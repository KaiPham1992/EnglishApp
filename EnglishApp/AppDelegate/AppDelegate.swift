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
import Fabric
import Crashlytics
import netfox
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NFX.sharedInstance().start()
//        Fabric.with([Crashlytics.self])
        Crashlytics.sharedInstance().debugMode = true
        Fabric.sharedSDK().debug = true 
        LanguageHelper.setAppleLAnguageTo(lang: LanguageType.vietname)
        IQKeyboardManager.shared.enable = true
        
        configureGoogle()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //---
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        checkLogin()
        realmConfig()
        AppRouter.shared.updateRootView()
        
        //--
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, err) in
            print("granted: (\(granted)")
        }
        return true
    }
    
    func checkLogin() {
        Provider.shared.userAPIService.checkLogin(success: { _ in
            
        }) { _error in
            if let _ = _error?.code {
                UserDefaultHelper.shared.clearUser()
                AppRouter.shared.openLogin()
                return
            } else {
                return
            }
        }
    }
    
    func realmConfig() {
        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { (migration, oldSchemaVersion) in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: LocalConfigDictionary.className(), { (oldObject, newObject) in
                    newObject!["isDefault"] = 0
                })
            }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:], sourceApplication: String) -> Bool {
        let fb = ApplicationDelegate.shared.application(app, open: url, options: options)
        let gg = GIDSignIn.sharedInstance().handle(url as URL?,
                                                   sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                   annotation: options[UIApplication.OpenURLOptionsKey.annotation])
       
        
        return fb || gg
        
    }
}

