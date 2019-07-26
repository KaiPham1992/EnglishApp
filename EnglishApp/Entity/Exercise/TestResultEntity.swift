//
//  TestResultEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class TestsResultRespone : Mappable {
    var total_records : String?
    var results : [TestResult]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.results <- map["results"]
    }
    
}
