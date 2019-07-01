//
//  QuestionSubmitParam.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionSubmitParam : BaseParam {
    var _id : Int?
    var time : Int?
    var answer : [QuestionChoiceResultParam]?
    init(_id : Int, time : Int = 0 , answer : [QuestionChoiceResultParam] = []) {
        super.init()
        self._id = _id
        self.time = time
        self.answer = answer
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
       self._id <- map["_id"]
       self.time <- map["time"]
       self.answer <- map["answer"]
    }
}
