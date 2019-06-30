//
//  QuestionChoiceResultParam.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionChoiceResultParam :  BaseParam {
    var question_id : Int?
    var option_id : Int?
    var value: String?
    override func mapping(map: Map) {
           super.mapping(map: map)
           self.question_id <- map["question_id"]
           self.option_id <- map["option_id"]
            self.value <- map["value"]
    }
    
    init(question_id : Int, option_id : Int = 0,value: String = "") {
        super.init()
        self.question_id = question_id
        self.option_id = option_id
        self.value = value
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
