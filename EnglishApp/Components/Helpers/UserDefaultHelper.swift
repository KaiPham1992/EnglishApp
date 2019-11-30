//
//  UserDefaultHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import ObjectMapper

class LiveData {
    public static var listDownloading : [Int] = []
}


enum UserDefaultHelperKey: String {
    case deviceToken = "DeviceToken"
    case fcmToken = "FcmToken"
    case userToken = "UserToken"
    case appLanguage = "AppLanguage"
    
    
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
    var collectionProduct = ProductCollectionEntity()
    
    var loginUserInfo: UserEntity? {
        get {
            if let savedUser = UserDefaults.standard.object(forKey: UserDefaultHelperKey.loginUserInfo.rawValue) as? String {
                let user = Mapper<UserEntity>().map(JSONString: savedUser)
                return user
            }
            return nil
        }
        set(loginUserInfo) {
            guard let json = loginUserInfo?.toJSONString() else { return }
            
            UserDefaults.standard.set(json, forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
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
            let value = get(key: .deviceToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .deviceToken)
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
    
    var appLanguage: String? {
        get {
            let value = get(key: .appLanguage) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .appLanguage)
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
    
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.userToken.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
        UserDefaults.standard.synchronize()
        
    }
    
    func saveUser(user: UserEntity) {
        loginUserInfo = user
    }
    
}
