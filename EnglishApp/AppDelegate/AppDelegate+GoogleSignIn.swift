//
//  AppDelegate+GoogleSignIn.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import GoogleSignIn
//import GoogleMobileAds
import Firebase

extension AppDelegate {
    func configureGoogle() {
//        GADMobileAds.configure(withApplicationID: AppConstant.appAdmobId)
        
        // get key from fire base : AIzaSyCaOVKfotVN6tQ4sUbv8ssND
        #if APPSTORE
        GMSServices.provideAPIKey("AIzaSyBcHRsiNktggnuR-I5eeuZTfRemWD5Dr4c")
        GMSPlacesClient.provideAPIKey("AIzaSyBcHRsiNktggnuR-I5eeuZTfRemWD5Dr4c")
        GIDSignIn.sharedInstance().clientID = "204187467150-uf817q823gfjullmamdligjgvh257ki9.apps.googleusercontent.com"
        #else
        GMSServices.provideAPIKey("AIzaSyBcHRsiNktggnuR-I5eeuZTfRemWD5Dr4c")
        GMSPlacesClient.provideAPIKey("AIzaSyBcHRsiNktggnuR-I5eeuZTfRemWD5Dr4c")
        GIDSignIn.sharedInstance().clientID = "204187467150-uf817q823gfjullmamdligjgvh257ki9.apps.googleusercontent.com"
        #endif
        
        configureFirebase()
    }
    
    func setUpStatusBar() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
//        statusBar.backgroundColor = AppColor.red
    }
    

}
