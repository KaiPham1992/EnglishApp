//
//  LessonCatelogy.swift
//  EnglishApp
//
//  Created by vinova on 6/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class LessonCatelogy : Mappable{

    var _id : String?
    var name : String?
    var lesson_category_id : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       self._id <- map["_id"]
       self.name <- map["name"]
       self.lesson_category_id <- map["lesson_category_id"]
    }
}
