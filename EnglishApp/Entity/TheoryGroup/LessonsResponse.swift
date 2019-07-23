//
//  LessonsResponse.swift
//  EnglishApp
//
//  Created by Steve on 7/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class LessonsResponse : Mappable {
    var total_records : Int?
    var lessons : [ItemLesson] = []
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.lessons <- map["lessons"]
    }
    required init?(map: Map) {
        
    }
}
