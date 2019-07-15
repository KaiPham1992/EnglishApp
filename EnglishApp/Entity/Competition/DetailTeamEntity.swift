//
//  DetailTeamEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/15/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class DetailTeamEntity: Mappable {
    var team_info: TeamEntity?
    var members: [UserEntity]?
    func mapping(map: Map) {
        self.team_info <- map["team_info"]
        self.members <- map["members"]
    }
    
    required init?(map: Map) {
        
    }
}
