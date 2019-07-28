//
//  ExplainQuestionResponse.swift
//  EnglishApp
//
//  Created by Steve on 7/29/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ExplainQuestionResponse : Mappable {
    var _id : String?
    var question_id : String?
    var explain : String?
    var created_time_mi : String?
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.question_id <- map["question_id"]
        self.explain <- map["explain"]
        self.created_time_mi <- map["created_time_mi"]
    }
    
    required init?(map: Map) {
        
    }
}
