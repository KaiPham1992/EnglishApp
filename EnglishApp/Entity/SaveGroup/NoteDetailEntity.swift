//
//  NoteDetailEntity.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class NoteDetailEntity: Mappable {
    var _id : String?
    var name : String?
    var description : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       self._id <- map["_id"]
       self.name <- map["name"]
       self.description <- map["description"]
    }
}
