//
//  LeaderBoardEntity.swift
//  EnglishApp
//
//  Created by Henry on 7/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class LeaderBoardEntity: BaseEntity{
    var id: String?
    var fullName: String?
    var typeUser: [String]?
    var rankName: String?
    var rankPoint: Int?
    var level: String?
    var imgSrc: String?
    var socialImage: String?
    var attachImage: String?
    var total: Int?
    var boards: [UserEntity]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)

        self.id <- map["_id"]
        self.fullName <- map["fullname"]
        self.typeUser <- map["type_user"]
        self.rankName <- map["rank_name"]
        self.rankPoint <- map["point_rank"]
        self.level <- map["level"]
        self.imgSrc <- map["img_src"]
        self.socialImage <- map["social_img_src"]
        self.total <- map["total_records"]
        self.boards <- map["boards"]
        
        
    }
}
