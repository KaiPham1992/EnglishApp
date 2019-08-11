//
//  SubmitCompetitionQuestionResponse.swift
//  EnglishApp
//
//  Created by Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class SubmitCompetitionQuestionResponse : Mappable {
    
    var competition_id : Int = 0
    var team_id : Int = 0
    var time : Int = 0
    var questions : SubmitQuestionEntity?
    
    init(competition_id: Int,team_id: Int) {
        self.competition_id = competition_id
        self.team_id = team_id
    }
    
    func mapping(map: Map) {
        self.competition_id <- map["competition_id"]
        self.team_id <- map["team_id"]
        self.time <- map["time"]
        self.questions <- map["questions"]
    }
    required init?(map: Map) {
        
    }
}
