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
    var deadline : Date?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.deadline <- (map["deadline"],TranformStringtoDate())
        self._id <- map["_id"]
        self.type_test <- map["type_test"]
        self.name <- map["name"]
        self.categ_id <- map["categ_id"]
    }
}

class TranformStringtoDate : TransformType {
    
    typealias Object = Date
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let _value = value as? String{
            return Date(gtFormat: _value, gfFormat: AppDateFormat.yyyyMMddHHmmss)
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        if let _value = value {
            return _value.toString(dateFormat: AppDateFormat.ddMMyyyyHHmmm)
        }
        return nil
    }
    
}
