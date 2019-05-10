//
//  UserDefaultHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserDefaultHelperKey: String {
    case deviceToken = "DeviceToken"
    case fcmToken = "FcmToken"

    case userToken = "UserToken"
    case userName  = "UserName"
    case email = "Email"
    case bio = "Bio"
    case website = "Website"
    case profilePhoto = "Profile Photo"
    case refreshToken = "RefreshUserToken"

    case userLoggedIn = "UserLogin"
    case userSkipIntro = "UserSkipIntroduction"
    case isFirstLauch = "IsFirstLauch"
    case loginUserInfo = "loginUserInfo"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard

    var loginUserInfo: UserEntity? {
        get {
            if let savedUser = UserDefaults.standard.object(forKey: UserDefaultHelperKey.loginUserInfo.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(UserEntity.self, from: savedUser) {
                    return user
                }
            }
            return nil
        }
        set(loginUserInfo) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(loginUserInfo) {
                UserDefaults.standard.set(encoded, forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
            }
        }
    }
    
    var fcmToken: String? {
        get {
            let value = get(key: .fcmToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .fcmToken)
        }
    }
    
    var deviceToken: String? {
        get {
            let value = get(key: .fcmToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .fcmToken)
        }
    }
    
    var userToken: String? {
        get {
            let value = get(key: .userToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .userToken)
        }
    }
}

extension UserDefaultHelper {
    private func save(value: Any?, key: UserDefaultHelperKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }

    private func get(key: UserDefaultHelperKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
}
