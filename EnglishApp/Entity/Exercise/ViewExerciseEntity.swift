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
    var total_times : String?
    var total_questions : String?
    var questions : [QuestionEntity]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
        self.total_times <- map["total_times"]
        self.total_questions <- map["total_questions"]
        self.questions <- map["questions"]
    }
}
