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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LanguageHelper.setAppleLAnguageTo(lang: LanguageType.vietname)
        
        
        //---
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
//        window?.rootViewController = AppContainerViewController()
        let extractedExpr = UINavigationController(rootViewController: LoginRouter.createModule())
        window?.rootViewController = extractedExpr
        
        configureGoogle()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:], sourceApplication: String) -> Bool {
        let fb = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let gg = GIDSignIn.sharedInstance().handle(url as URL?,
                                                   sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                   annotation: options[UIApplication.OpenURLOptionsKey.annotation])
       
        
        return fb || gg
        
        
    }
}

