//
//  ItemLesson.swift
//  EnglishApp
//
//  Created by Steve on 7/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ItemLesson : Mappable {
    var _id : String?
    var name : String?
    var lesson_category_id : String?
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
        self.lesson_category_id <- map["lesson_category_id"]
    }
    required init?(map: Map) {
        
    }
}
