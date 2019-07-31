//
//  ViewFightTestResponse.swift
//  EnglishApp
//
//  Created by Steve on 7/31/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ViewFightTestResponse : Mappable {
    var _id : String?
    var name : String?
    var rank_id : String?
    var number_team : String?
    var max_member : String?
    var start_date : String?
    var start_time_mi : String?
    var description : String?
    var image : String?
    var status : String?
    var exercise_id : String?
    var created_by : String?
    var created_date : String?
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
        self.rank_id <- map["rank_id"]
        self.number_team <- map["number_team"]
        self.max_member <- map["max_member"]
        self.start_date <- map["start_date"]
        self.start_time_mi <- map["start_time_mi"]
        self.description <- map["description"]
        self.image <- map["image"]
        self.status <- map["status"]
        self.exercise_id <- map["exercise_id"]
        self.created_by <- map["created_by"]
        self.created_date <- map["created_date"]
    }
    required init?(map: Map) {
        
    }
}
