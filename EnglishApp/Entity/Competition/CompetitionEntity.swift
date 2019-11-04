//
//  Competition.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CollectionCompetitionEntity: BaseEntity{
    var total_can_join: Int?
    var total_fight_test: Int?
    var default_dict_id : String?
    var competitionEntity: [CompetitionEntity]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.total_can_join <- map["total_can_join"]
        self.total_fight_test <- map["total_fight_test"]
        self.competitionEntity <- map["records"]
        self.default_dict_id <- map["default_dict_id"]
    }
}

class CompetitionEntity : BaseEntity {
    var id: Int?
    var team_id: String?
    var name: String?
    var rankName: String?
    var countTeam: String?
    var startDate: Date?
    var endDate: Date?
    var startTime: Date?
    var content: String?
    var image: String?
    var exercise_id: String?
    var is_fight_joined: Int?
    var status : String?
    var start_time_mi : String?
    var end_time_mi : String?
    var isHidden = false
    var distance = 0
    
    convenience init(competitionResultsProfileEntity: CompetitionResultsProfileEntity) {
       self.init()
       self.id = Int(competitionResultsProfileEntity._id&) ?? 0
       self.name = competitionResultsProfileEntity.name
       self.rankName = competitionResultsProfileEntity.rank_name
       self.countTeam = competitionResultsProfileEntity.number_team
       self.startDate = competitionResultsProfileEntity.start_date
       self.content = competitionResultsProfileEntity.description
       self.image = competitionResultsProfileEntity.image
       self.exercise_id = competitionResultsProfileEntity.exercise_id
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.team_id <- map["team_id"]
        self.status <- map["status"]
        self.id <- (map["_id"], StringToIntTransform())
        self.name <- map["name"]
        self.rankName <- map["rank_name"]
        self.countTeam <- map["number_team"]
        self.startDate <- (map["start_date"], TranformStringtoDate())
        self.start_time_mi <- map["start_time_mi"]
        
        self.startTime <- (map["start_date"], TranformStringtoDate())
        self.image <- map["image"]
        self.exercise_id <- map["exercise_id"]
        self.is_fight_joined <- map["is_fight_joined"]
        self.content <- map["description"]
        self.end_time_mi <- map["end_time_mi"]
        self.endDate <- (map["end_date"], TranformStringtoDate())
    }
}
