//
//  UserEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserEntity: Mappable, Codable  {
    
    var id: String?
    var email: String?
    var fullName: String?
    var national: String?
    var imgSrc: String?
    var imgCropSrc: String?
    var languageCode: String?
    var amountDiamond: Int?
    var amountHoney: Int?
    var rankId: Int?
    var rankName: String?
    var jwt: String?
    var socialImage: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id             <- map["_id"]
        self.email       <- map["email"]
        self.fullName          <- map["fullname"]
        self.national       <- map["nation"]
        self.imgSrc          <- map["img_src"]
        self.imgCropSrc      <- map["crop_img_src"]
        self.languageCode       <- map["language_code"]
        self.amountDiamond         <- map["amount_diamond"]
        self.amountHoney         <- map["amount_honey"]
        self.rankId     <- map["rank_id"]
        self.rankName      <- map["rank_name"]
        self.jwt <- map["jwt"]
        
        self.socialImage <- map["social_img_src"]
        
    }
    
//    init (displayName: String, phoneNumber: String,phoneCode: String, birthday: String, gender: String? = nil, houseAddress: String? = nil, companyAddress: String? = nil, lat1: String? = nil, long1: String? = nil,lat2: String? = nil, long2: String? = nil) {
//        self.fullName       = displayName
//        self.phone          = phoneNumber
//        self.phoneCode      = phoneCode
//        self.birthday       = birthday
//        self.gender         = gender
//        self.houseAddress   = houseAddress
//        self.companyAddress = companyAddress
//        self.latAddress1    = lat1
//        self.latAddress2    = lat2
//        self.longAddress1   = long1
//        self.longAddress2   = long2
//    }
    
    var urlAvatar:  URL? {
        if let urlString = self.imgCropSrc, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        } else if let urlString = socialImage, let url = URL(string: urlString) {
            return url
        }
        
        return nil
    }
}
