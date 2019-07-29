//
//  ExerciseChoiceEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ExerciseChoiceEntity : Mappable{
    var total_exercises : Int?
    var exercises : [ExerciseEntity] = []
    func mapping(map: Map) {
        
    }
    required init?(map: Map) {
        self.total_exercises <- map["total_exercises"]
        self.exercises <- map["exercises"]
    }
}
