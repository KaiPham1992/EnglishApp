//
//  QuestionEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionEntity : Mappable {
    
    var _id : String?
    var content_extend : String?
    var question_time: String?
    var answers : [ChildQuestionEntity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.question_time <- map["question_time"]
        self.content_extend <- map["content_extend"]
        self.answers <- map["answers"]
    }

}
