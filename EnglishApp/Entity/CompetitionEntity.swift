//
//  Competition.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CompetitionEntity : BaseEntity {
    var id: String?
    var name: String?
    var timeStart: String?
    var countTeam: String?
    var content: String?
    var condition: String?
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.timeStart = "16"
        self.countTeam = "20"
        self.content = "Team đang thi đấu nhào vô anh em ơi"
        self.condition = "Vàng 1"
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
    }
    
    class func toArray() -> [CompetitionEntity] {
        var listHistory = [CompetitionEntity]()
        for i in 0...10 {
            let newHis = CompetitionEntity(name: "Cuoc thi \(i+1)")
            listHistory.append(newHis)
        }
        
        return listHistory
    }
}
