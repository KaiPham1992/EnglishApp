//
//  RelatedLessonResponse.swift
//  EnglishApp
//
//  Created by Steve on 7/29/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class RelatedLessonResponse : Mappable {
    var total_records : String?
    var data : [SearchEntity] = []
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.data <- map["data"]
    }
    required init?(map: Map) {
        
    }
}
