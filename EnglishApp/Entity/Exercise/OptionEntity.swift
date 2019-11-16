//
//  OptionEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class OptionEntity : Mappable {
    var _id: String?
    var value: String?
    var content: String?
    var isChoice: Bool = false
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.value <- map["value"]
        self.content <- map["content"]
    }
}
