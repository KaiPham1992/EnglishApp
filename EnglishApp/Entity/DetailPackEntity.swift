//
//  DetailPackEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//


import Foundation
import ObjectMapper

class DetailPackEntity: BaseEntity {
    var title: String?
    var canUse: Bool?
    
    convenience init(title: String, canUse: Bool = true) {
        self.init()
        self.title = title
        self.canUse = canUse
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
    
    class func toArray() -> [DetailPackEntity] {
        var listHistory = [DetailPackEntity]()
        
        listHistory.append(DetailPackEntity(title: "Xem tất cả bài giảng", canUse: true))
        listHistory.append(DetailPackEntity(title: "Được làm tất cả bài tập", canUse: true))
        listHistory.append(DetailPackEntity(title: "Tạo bài tập cho riêng mình", canUse: true))
        listHistory.append(DetailPackEntity(title: "Tạo bài tập cho riêng mình", canUse: true))
        listHistory.append(DetailPackEntity(title: "Tạo bài tập cho riêng mình", canUse: true))
        listHistory.append(DetailPackEntity(title: "Các bài tập theo cấp độ", canUse: false))
        
        
        return listHistory
    }
}
