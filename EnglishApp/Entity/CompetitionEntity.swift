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
    var competitionEntity: [CompetitionEntity]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.total_can_join <- map["total_can_join"]
        self.total_fight_test <- map["total_fight_test"]
        self.competitionEntity <- map["records"]
    }
}
class CompetitionEntity : BaseEntity {
    var id: String?
    var name: String?
    var rankName: String?
    var countTeam: String?
    var startDate: String?
    var startTime: String?
    var content: String?
    var image: String?
    var exercise_id: String?
    var is_fight_joined: String?
   
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.startTime = "Thời gian bắt đầu 16h"
        self.countTeam = "Số đội 20"
        self.content = "Team đang thi đấu nhào vô anh em ơi"
//        self.condition = "Vàng  "
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.name <- map["name"]
        self.rankName <- map["rank_name"]
        self.countTeam <- map["number_team"]
        self.startDate <- map["start_date"]
        self.startTime <- map["start_time_mi"]
        self.image <- map["image"]
        self.exercise_id <- map["exercise_id"]
        self.is_fight_joined <- map["is_fight_joined"]
        self.content <- map["description"]
        
    }
    
    class func toArray() -> [CompetitionEntity] {
        var listHistory = [CompetitionEntity]()
        for i in 0...10 {
            let newHis = CompetitionEntity(name: "Cuộc thi \(i+1)")
            listHistory.append(newHis)
        }
        
        return listHistory
    }
}
