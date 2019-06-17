//
//  NoteRespone.swift
//  EnglishApp
//
//  Created by vinova on 6/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class NoteRespone : Mappable {
    
    var _id : String?
    var name : String?
    
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
    }
    
    required init?(map: Map) {
        
    }
}
