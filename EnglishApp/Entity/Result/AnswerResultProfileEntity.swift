//
//  AnswerResultProfileEntity.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerResultProfileEntity: Mappable {
    var _id : String?
    var question_details_id : String?
    var answer_id : String?
    var status : String?
    var value : String?
    var content : String?
    var content_extend : String?
    var type : String?
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        self.content_extend <- map["content_extend"]
        self._id <- map["_id"]
        self.question_details_id <- map["question_details_id"]
        self.answer_id <- map["answer_id"]
        self.status <- map["status"]
        self.value <- map["value"]
        self.content <- map["content"]
        self.type <- map["type"]
    }
}
