//
//  LessonCatelogyDetailEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class LessonCatelogyDetail : Mappable{
    
    var _id : String?
    var name : String?
    var content : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
        self.content <- map["content"]
    }
}
