//
//  SubmitExerciseParam.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class SubmitExerciseParam : BaseParam{
    var exercise_id : Int?
    var total_time : Int = 0
    var questions : [QuestionSubmitParam] = []
    init(exercise_id : Int, total_time : Int = 0,questions : [QuestionSubmitParam] = []) {
        super.init()
        self.exercise_id = exercise_id
        self.total_time = total_time
        self.questions = questions
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.exercise_id <- map["exercise_id"]
        self.total_time <- map["total_time"]
        self.questions <- map["questions"]
    }
}
