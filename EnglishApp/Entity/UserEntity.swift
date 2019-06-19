//
//  UserEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

class UserEntity: BaseEntity  {
    
    var id: String?
    var email: String?
    var fullName: String?
    var national: String?
    var imgSrc: String?
    var imgCropSrc: String?
    var languageCode: String?
    var amountDiamond: Int?
    var amountHoney: Int?
    var amountPoint: Int?
    var rankId: String?
    var rankName: String?
    var jwt: String?
    var socialImage: String?
    var displayName: String?
    
    override func mapping(map: Map) {
        self.id             <- map["_id"]
        self.email       <- map["email"]
        self.fullName          <- map["fullname"]
        self.national       <- map["nation"]
        self.imgSrc          <- map["img_src"]
        self.imgCropSrc      <- map["crop_img_src"]
        self.languageCode       <- map["language_code"]
        self.amountDiamond         <- (map["amount_diamond"], StringToIntTransform())
        self.amountHoney         <- (map["amount_honey"], StringToIntTransform())
         self.amountPoint         <- (map["amount_point"], StringToIntTransform())
        self.rankId     <- map["rank_id"]
        self.rankName      <- map["rank_name"]
        self.jwt <- map["jwt"]
        self.displayName <- map["username"]
        self.socialImage <- map["social_img_src"]
        
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.imgCropSrc, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        } else if let urlString = socialImage, let url = URL(string: urlString) {
            return url
        }
        
        return nil
    }
    
    var nameShowUI: String {
        if self.fullName&.isEmpty {
            return self.displayName&
        }
        
        return self.fullName&
    }
}
