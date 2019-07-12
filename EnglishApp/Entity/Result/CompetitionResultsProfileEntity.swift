//
//  File.swift
//  EnglishApp
//
//  Created by Steve on 7/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CompetitionResultsProfileEntity: Mappable {
    var _id : String?
    var name : String?
    var description : String?
    var rank_name : String?
    var start_date : String?
    var number_team : String?
    var image : String?
    var exercise_id : String?
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.rank_name <- map["rank_name"]
        self.start_date <- map["start_date"]
        self.number_team <- map["number_team"]
        self.image <- map["image"]
        self.exercise_id <- map["exercise_id"]
    }
}
