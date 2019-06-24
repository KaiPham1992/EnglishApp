//
//  QAEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
import Foundation
import ObjectMapper

class QAEntity: BaseEntity {
    var id: String?
    var title: String?
    var date: Date?
    var content: String?
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.content = title
        self.date = Date()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.title <- map["question_name"]
        self.content <- map["content"]
        self.date <- (map["create_time_mi"], AppTimestampTransform())
    }
    
    class func toArray() -> [QAEntity] {
        var listHistory = [QAEntity]()
        for i in 0...10 {
            let newHis = QAEntity(title: "Thi hiện tại đơn là gi? Thi hiện tại đơn là gi? Thi hiện tại đơn là gi?")
            listHistory.append(newHis)
        }
        
        return listHistory
    }
}
