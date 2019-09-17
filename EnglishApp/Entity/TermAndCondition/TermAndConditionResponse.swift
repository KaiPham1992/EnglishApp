//
//  TermAndConditionResponse.swift
//  EnglishApp
//
//  Created by Steve on 9/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class TermAndConditionResponse : Mappable {
    
    var _id : String?
    var content : String?
    var created_date : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.content <- map["content"]
        self.created_date <- map["created_date"]
    }
    
    
}
