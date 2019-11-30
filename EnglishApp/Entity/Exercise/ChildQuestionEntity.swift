//
//  ChildQuestionEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ChildQuestionEntity : Mappable {
    
    var _id : String?
    var sequence : String?
    var type : String?
    var isShowSuggestQuestion = false
    var content : String?
    var options : [OptionEntity] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.content <- map["content"]
        self._id <- map["_id"]
        self.sequence <- map["sequence"]
        self.type <- map["type"]
        self.options <- map["options"]
    }
    
}
