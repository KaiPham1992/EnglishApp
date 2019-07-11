//
//  CompetitionProfileEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CompetitionProfileEntity: Mappable {
    var total_records : Int?
    var results : [CompetitionResultsProfileEntity]?
    func mapping(map: Map) {
        
        
    }
    required init?(map: Map) {
       self.total_records <- map["total_records"]
       self.results <- map["results"]
    }
}
