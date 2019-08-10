//
//  SubmitQuestionEntity.swift
//  EnglishApp
//
//  Created by Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class SubmitQuestionEntity : Mappable {
    
    var question_id : Int = 0
    var sequence : Int = 0
    var answers : [SubmitAnswerEntity] = []
    func mapping(map: Map) {
        self.question_id <- map["question_id"]
        self.sequence <- map["sequence"]
        self.answers <- map["answers"]
    }
    required init?(map: Map) {
        
    }
    
}
