//
//  SearchEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchEntity : Mappable{
    
    var _id : String?
    var name : String?
    
    //use for create exercise
    var typeCreateExercise : String = "Elementary"
    var numberQuestion : Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.name <- map["name"]
    }
}
