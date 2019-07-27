//
//  GrammarEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class GrammarEntity : Mappable {
    var _id : String?
    var lesson_name : String?
    var lesson_category : String?
    var is_favorite : String?
    var created_date : String?
    var updated_date : String?
    var isDelete = false
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.lesson_name <- map["lesson_name"]
        self.lesson_category <- map["lesson_category"]
        self.is_favorite <- map["is_favorite"]
        self.created_date <- map["created_date"]
        self.updated_date <- map["updated_date"]
    }
    required init?(map: Map) {
        
    }
}
