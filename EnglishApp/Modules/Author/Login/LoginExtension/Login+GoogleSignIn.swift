//
//  Login+GoogleSignIn.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
//import CryptoSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration

// MARK: GOOGLE
extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error login gmail: \(error.localizedDescription)")
        } else {
            let newLoginSocialParam = LoginSocialParam(user: user)
            self.loginType = .gmail
            self.presenter?.loginSocial(param: newLoginSocialParam)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}
