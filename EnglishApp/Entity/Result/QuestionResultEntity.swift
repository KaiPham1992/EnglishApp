//
//  QuestionResultEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionResultEntity : Mappable {
    var _id : String?
    var question_id : String?
    var content : String?
    var score : String?
    var time : String?
    var answers : [AnswerResultProfileEntity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       self._id <- map["_id"]
       self.question_id <- map["question_id"]
       self.content <- map["content"]
       self.score <- map["score"]
       self.time <- map["time"]
       self.answers <- map["answers"]
    }
}
