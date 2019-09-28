//
//  TeamEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//


import Foundation
import ObjectMapper
class CollectionTeamEntity: BaseEntity{
    var numberTeam: Int?
    var maxMember: Int?
    var isFightJoined: Int?
    var teams = [TeamEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.teams <- map["teams"]
        self.isFightJoined <- map["is_fight_joined"]
        self.numberTeam <- (map["number_team"], StringToIntTransform())
        self.maxMember <- (map["max_member"], StringToIntTransform())
        
    }
}
class TeamEntity: BaseEntity {
    var id: String?
    var name: String?
    var leader: String?
    var imgSrc: String?
    var socialImgSrc: String?
    var attachImgSrc: String?
    var countMember: String?
    var isTeamJoined: Int?
    var maxMember: String?
    var competition_id: String?
    var start_date : Date?
    var end_date : Date?
    var start_time_mi : String?
   
    convenience init(name: String) {
        self.init()
        self.name = name
        self.countMember = "16"
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.start_date <- (map["start_date"],TranformStringtoDate())
        self.end_date <- (map["end_date"],TranformStringtoDate())
        self.start_time_mi <- map["start_time_mi"]
        self.competition_id <- map["competition_id"]
        self.id <- map["_id"]
        self.maxMember <- map["max_member"]
        self.name <- map["name"]
        self.leader <- map["leader_id"]
        self.countMember <- map["current"]
        self.imgSrc <- map["img_src"]
        self.socialImgSrc <- map["social_img_src"]
        self.attachImgSrc <- map["attach_img_src"]
        self.isTeamJoined <- map["is_team_joined"]
    }

    func toPercentMember() -> String{
        return self.countMember& + "/" + self.maxMember& + " \(LocalizableKey.member.showLanguage)"
    }
    
    var urlImage:  URL? {
        if let urlString = self.imgSrc, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        } else if let urlString = socialImgSrc, let url = URL(string: urlString) {
            return url
        }
        
        return nil
    }
    
    class func toArray() -> [TeamEntity] {
        var listHistory = [TeamEntity]()
        for i in 0...10 {
            let newHis = TeamEntity(name: "Team mat ong \(i+1)")
            listHistory.append(newHis)
        }
        
        return listHistory
    }
    
}
