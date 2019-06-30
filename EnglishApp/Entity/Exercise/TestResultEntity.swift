//
//  TestResultEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class TestResultEntity : Mappable {
    var self_created_test: [SelfCreatedTestEntity]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.self_created_test <- map["self_created_test"]
    }
    
}
