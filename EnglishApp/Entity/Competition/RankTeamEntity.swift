//
//  RankTeamEntity.swift
//  EnglishApp
//
//  Created by Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper
class RankTeamEntity : Mappable {
    var team_id : String?
    var total_score : String?
    var position : Int?
    var img_src : String?
    var attach_img_src: String?
    func mapping(map: Map) {
        self.team_id <- map["team_id"]
        self.total_score <- map["total_score"]
        self.position <- map["position"]
        self.img_src <- map["img_src"]
        self.attach_img_src <- map["attach_img_src"]
    }
    required init?(map: Map) {
        
    }
}
