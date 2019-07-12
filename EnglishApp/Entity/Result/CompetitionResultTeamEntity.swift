//
//  CompetitionResultTeamEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CompetitionResultTeamEntity: Mappable{
    var team_id : String?
    var name : String?
    var img_src : String?
    var social_img_src : String?
    var attach_img_src : String?
    var position : Int?
    func mapping(map: Map) {
        self.team_id <- map["team_id"]
        self.name <- map["name"]
        self.img_src <- map["img_src"]
        self.social_img_src <- map["social_img_src"]
        self.attach_img_src <- map["attach_img_src"]
        self.position <- map["position"]
    }
    
    required init?(map: Map) {
        
    }
}
