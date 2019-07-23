//
//  LessonEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class LessonCategoryEntity : Mappable {
    var total_records : Int?
    var categories : [ItemLessonCategory] = []
    
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.categories <- map["categories"]
    }
    
    required init?(map: Map) {
        
    }
}
