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
    
    init(selfCreatedTestEntity: SelfCreatedTestEntity) {
        self._id = selfCreatedTestEntity._id
        self.name = selfCreatedTestEntity.exercise_name
        self.lesson_category_id = selfCreatedTestEntity.type_test
    }
    
    func mapping(map: Map) {
       self._id <- map["_id"]
       self.name <- map["name"]
       self.lesson_category_id <- map["lesson_category_id"]
    }
}
