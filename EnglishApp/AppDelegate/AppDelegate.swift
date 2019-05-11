//
//  AppDelegate.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

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
}

