//
//  AnswerChoiceParam.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerChoiceParam : BaseParam {
    
    var answer: [QuestionChoiceResultParam]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.answer <- map["answer"]
    }
    init(answer: [QuestionChoiceResultParam]) {
        super.init()
        self.answer = answer
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
