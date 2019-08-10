//
//  SubmitAnswerEntity.swift
//  EnglishApp
//
//  Created by Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper
class SubmitAnswerEntity : Mappable {
    var question_details_id : Int = 0
    var option_id : Int = 0
    
    func mapping(map: Map) {
       self.question_details_id <- map["question_details_id"]
       self.option_id <- map["option_id"]
    }
    required init?(map: Map) {
        
    }
}
