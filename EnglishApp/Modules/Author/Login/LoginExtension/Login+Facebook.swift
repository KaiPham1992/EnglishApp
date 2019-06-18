//
//  Login+Facebook.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import CryptoSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration

extension LoginViewController {
    private enum FacebookKey: String {
        case userId = "id"
        case email = "email"
        case name = "name"
        case lastName = "last_name"
        case firstName = "first_name"
        case picture = "picture"
        case gender = "gender"
        case birthday = "birthday"
    }
    
    func FBlogin() {
        let fbLoginManager = LoginManager()
        fbLoginManager.logOut()
        
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let req = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480),birthday"], tokenString: accessToken.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET"))
            req.start(completionHandler: { (connection, result, error) in
                if let _result = result as? [String: Any] {
                    let fbModel = FacebookEntity(json: _result)
                    // textFiled.text = fbmodel.userid
                    
                    
                    self.loginType = .facebook
                    let newLoginSocialParam = LoginSocialParam(user: fbModel)
                    self.presenter?.loginSocial(param: newLoginSocialParam)
                }
            })
        }
    }
}
