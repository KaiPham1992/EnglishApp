//
//  ListExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

import ObjectMapper

class ListExerciseEntity : Mappable{
    var total_exercises : Int?
    var exercises : [ExerciseEntity]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.total_exercises <- map["total_exercises"]
        self.exercises <- map["exercises"]
    }
}
