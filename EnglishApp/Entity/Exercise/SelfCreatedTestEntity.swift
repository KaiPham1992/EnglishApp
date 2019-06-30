//
//  SelfCreatedTestEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class SelfCreatedTestEntity : Mappable {
    var _id : String?
    var exercise_name : String?
    var type_test : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.exercise_name <- map["exercise_name"]
        self.type_test <- map["type_test"]
    }
}