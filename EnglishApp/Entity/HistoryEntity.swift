//
//  HistoryEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class HistoryEntity: BaseEntity {
    var id: String?
    var title: String?
    var date: Date?
    
   convenience init(title: String) {
        self.init()
        self.title = title
        self.date = Date()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.title <- map["title"]
        self.date <- map["Date"]
    }
    
    class func toArray() -> [HistoryEntity] {
        var listHistory = [HistoryEntity]()
        for i in 0...10 {
            let newHis = HistoryEntity(title: "Bạn nhận được \(i)000 từ phạm ngọc dương")
            listHistory.append(newHis)
        }
        
        return listHistory
    }
}
