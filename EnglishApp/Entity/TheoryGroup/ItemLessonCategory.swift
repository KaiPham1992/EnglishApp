//
//  ItemLesson.swift
//  EnglishApp
//
//  Created by Steve on 7/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ItemLessonCategory : Mappable {
    
    var _id : String?
    var name : String?
    var description : String?
    var lesson_type_id : String?
    var color : String?
    var status : String?
    var updated_date : String?
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.lesson_type_id <- map["lesson_type_id"]
        self.color <- map["color"]
        self.status <- map["status"]
        self.updated_date <- map["updated_date"]
    }
    
    required init?(map: Map) {
        
    }
}
