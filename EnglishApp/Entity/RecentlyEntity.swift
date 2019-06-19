//
//  RecentlyEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class RecentlyEntity: BaseEntity {
    var activities = [Acitvity]()
    var totalActivities: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.activities <- map["activities"]
        self.totalActivities <- map["total_activities"]
    }
    
}

class Acitvity: BaseEntity {
    var createDate: Date?
    var imgSrc: String?
    var content: String?
    var title: String?
    var id: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.createDate <- (map["created_time_mi"], AppTimestampTransform())
        self.content <- map["content"]
        self.title <- map["title"]
        self.imgSrc <- map["img_src"]
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.imgSrc, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        
        return nil
    }
    
}
