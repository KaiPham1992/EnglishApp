//
//  SearchExersiseEntity.swift
//  EnglishApp
//
//  Created by Henry Tran on 1/3/20.
//  Copyright © 2020 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchExersiseEntity: Mappable {
    
    var lists: [TestResultProfileEntity]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        lists <- map["results"]
    }
    
    
}
