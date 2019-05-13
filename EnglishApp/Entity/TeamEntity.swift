//
//  TeamEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//


import Foundation
import ObjectMapper

class TeamEntity: BaseEntity {
    var id: String?
    var name: String?
    var countMember: String?
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.countMember = "16"
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
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
