//
//  DictionarisResponse.swift
//  EnglishApp
//
//  Created by Steve on 8/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class DictionarisResponse : Mappable {
    var total_records : String?
    var dictionaries : [SearchEntity]?
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.dictionaries <- map["dictionaries"]
    }
    
    required init?(map: Map) {
        
    }
}
