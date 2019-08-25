//
//  ViewExerciseEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper


class ViewExerciseEntity: Mappable {
    
    var _id : String?
    var name : String?
    var total_times : Int?
    var total_questions : String?
    var default_dict_id: String?
    var type_test : String?
    var questions : [QuestionEntity]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.default_dict_id <- map["default_dict_id"]
        self.type_test <- map["type_test"]
        self._id <- map["_id"]
        self.name <- map["name"]
        self.total_times <- map["total_times"]
        self.total_questions <- map["total_questions"]
        self.questions <- map["questions"]
    }
}
