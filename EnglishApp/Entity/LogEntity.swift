//
//  LogEntity.swift
//  EnglishApp
//
//  Created by Henry on 7/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class CollectionLogEntity: Mappable{
    
    
    var total_records: Int?
    var total_wallets: Int?
    var logs: [LogEntity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.total_wallets <- map["total_wallets"]
        self.logs <- map["logs"]
    }
}
class LogEntity: Mappable{
    
    var description: String?
    var date: String?
    var amount: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.description <- map["description"]
        self.date <- map["date"]
        self.amount <- (map["amount"], StringToIntTransform())
    }
    
}
