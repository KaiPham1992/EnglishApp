//
//  UserEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper
class CollectionUserEntity: BaseEntity{
    var count_notify: Int?
    var count_fight_test: Int?
    var user_info: UserEntity?
    var leader_boards: [UserEntity]?
    
    override func mapping(map: Map) {
        self.count_notify <- map["count_notify"]
        self.count_fight_test <- map["count_fight_test"]
        self.user_info <- map["user_info"]
        self.leader_boards <- map["leader_boards"]
    }
}

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
//    var amountPoint: Int?
    var rankId: String?
    var rankName: String?
    var jwt: String?
    var socialImage: String?
    var displayName: String?
    var socialType: String?
    var rankPoint: Int?
    var is_entrance_test: String?
    
    var typeUser = [String]()
    var amountRank: Int?
    var level: String?
    
    
    override func mapping(map: Map) {
        self.id             <- map["_id"]
        self.email       <- map["email"]
        self.fullName          <- map["fullname"]
        self.national       <- map["nation"]
        self.imgSrc          <- map["img_src"]
        self.imgCropSrc      <- map["crop_img_src"]
        
        if self.imgCropSrc == nil{
            self.imgCropSrc      <- map["img_src"]
        }
        
        self.languageCode       <- map["language_code"]
        self.amountDiamond         <- (map["amount_diamond"], StringToIntTransform())
        self.amountHoney         <- (map["amount_honey"], StringToIntTransform())
//        self.amountPoint         <- (map["rank_point"], StringToIntTransform())
        self.rankId     <- map["rank_id"]
        self.rankName      <- map["rank_name"]
        self.rankPoint <- (map["rank_point"], StringToIntTransform())
        if self.rankPoint == nil{
            self.rankPoint <- (map["point_rank"], StringToIntTransform())
        }
        if self.rankPoint == nil{
            self.rankPoint <- (map["amount_rank"], StringToIntTransform())
        }
        self.jwt <- map["jwt"]
        self.displayName <- map["username"]
        self.socialImage <- map["social_img_src"]
        self.socialType <- map["social_type"]
        self.is_entrance_test <- map["is_entrance_test"]
        
        self.typeUser <- map["type_user"]
        self.amountRank <- (map["amount_rank"],StringToIntTransform())
        self.level <- map["level"]
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
    
    var imageStudyPack: UIImage? {
        if self.typeUser.contains("STUDY_PACK") {
            return AppImage.imgStudyPack
        }
        return nil
    }
    
    var imagePremium: UIImage? {
        if self.typeUser.contains("PREMIUM") {
            return AppImage.imgPremium
        }
        return nil
    }
    
}
