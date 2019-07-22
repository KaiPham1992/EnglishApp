//
//  ExerciseEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation


import ObjectMapper

class ExerciseEntity : Mappable {
    var _id : String?
    var type_test : String?
    var name : String?
    var categ_id : String?
    var deadline : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.deadline <- map["deadline"]
        self._id <- map["_id"]
        self.type_test <- map["type_test"]
        self.name <- map["name"]
        self.categ_id <- map["categ_id"]
    }
}
