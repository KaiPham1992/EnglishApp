//
//  CatelogyEntity.swift
//  EnglishApp
//
//  Created by vinova on 7/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CatelogyEntity : Mappable {
    
    var total_records : Int?
    var categories : [SearchEntity] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       self.total_records <- map["total_records"]
       self.categories <- map["categories"]
    }
}
