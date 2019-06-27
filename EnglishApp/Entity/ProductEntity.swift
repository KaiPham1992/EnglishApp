//
//  ProductEntity.swift
//  EnglishApp
//
//  Created by KaiPham on 6/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class ProductCollectionEntity: BaseEntity {
    var groupUpgrade = [ProductEntity]()
    var groupHoney = [ProductEntity]()
    var groupGift = [ProductEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.groupUpgrade <- map["group_gift"]
        self.groupHoney <- map["group_honey"]
        self.groupGift <- map["group_gift"]
    }
}



class ProductEntity: BaseEntity {
   
    var id: String?
    var name: String?
    var type: String?
    var logo: String?
    var cropLogo: String?
    var durationAmount: String?
    var durationUnit: String?
    var amountHoney: String?
    var createDate: Date?
    var nationId: String?
    var amountDiamond: String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.createDate <- (map["created_time_mi"], AppTimestampTransform())
        self.name <- map["name"]
        self.type <- map["type"]
        self.logo <- map["logo"]
        self.cropLogo <- map["crop_logo"]
        self.durationAmount <- map["duration_amount"]
        self.durationUnit <- map["duration_unit"]
        self.amountDiamond <- map["amountDiamond"]
        self.amountHoney <- map["amount_honey"]
        self.nationId <- map["nation_id"]
        
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.cropLogo, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        
        return nil
    }
    
}
