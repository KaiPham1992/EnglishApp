//
//  LevelExerciseEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class LevelExerciseEntity : Mappable{
    var total_records : Int?
    var study_categories : [SearchEntity] = []
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.study_categories <- map["study_categories"]
    }
}
