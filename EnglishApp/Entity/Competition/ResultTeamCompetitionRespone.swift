//
//  ResultTeamCompetitionRespone.swift
//  EnglishApp
//
//  Created by Steve on 7/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ResultTeamCompetitionRespone : Mappable {
    var total_records: String?
    var team_results: [CompetitionResultTeamEntity]?
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.team_results <- map["team_results"]
    }
    required init?(map: Map) {

    }
}
