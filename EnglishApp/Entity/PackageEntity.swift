//
//  PackageEntity.swift
//  EnglishApp
//
//  Created by Henry on 9/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class PackageEntity: Mappable{
    var total_records: Int?
    var inventories: [Inventories]?
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        self.total_records <- (map["total_records"], StringToIntTransform())
        self.inventories <- map["inventories"]
    }
}
class Inventories: Mappable{
    
    var id: String?
    var productId: String?
    var name: String?
    var expiredTime: Date?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.productId <- map["productId"]
        self.name <- map["name"]
        self.expiredTime <- (map["expired_time"], yyyyMMddHHmmssTransform())
    }
    
}
