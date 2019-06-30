//
//  DateCalendarEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class DateCalendarEntity : Mappable{
    var date: [String]?
    
    func mapping(map: Map) {
        self.date <- map["date"]
    }
    
    required init?(map: Map) {
        
    }
    
}
