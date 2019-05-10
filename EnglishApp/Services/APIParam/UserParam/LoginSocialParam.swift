//
//  LoginSocialParam.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper
import GoogleSignIn

enum SocialType: String {
    case faceBook = "facebook"
    case gmail = "google"
}

class LoginSocialParam: BaseParam {
    var email: String?
    var fullName: String?
    var socialImage: String?
    var socialType: String?
    var socialId: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.email <- map["email"]
        self.fullName <- map["fullname"]
        self.socialImage <- map["social_img_src"]
        self.socialType <- map["social_type"]
        self.socialId <- map["social_id"]
    }
    
    init(socialId: String?, email: String?, fullName: String?, socialImage: String?, socialType: String?) {
        super.init()
        self.email = email
        self.fullName = fullName
        self.socialImage = socialImage
        self.socialType = socialType
        self.socialId = socialId
    }
    
    init(user: GIDGoogleUser) {
        super.init()
        self.socialId = user.userID
        self.fullName  = user.profile.name
        self.email = user.profile.email
        var image: String?
        if user.profile.hasImage {
            image = user.profile.imageURL(withDimension: 480).absoluteString
        }
        
        self.socialImage = image
        self.socialType = SocialType.gmail.rawValue
    }
    
    init(user: FacebookEntity) {
        super.init()
        self.socialId = user.id
        self.fullName  = user.name
        self.email = user.email
        self.socialImage = user.url
        self.socialType = SocialType.faceBook.rawValue
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
