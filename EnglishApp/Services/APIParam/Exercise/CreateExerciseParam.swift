//
//  CreateExerciseParam.swift
//  EnglishApp
//
//  Created by vinova on 7/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateExerciseParam : BaseParam {
    var name : String?
    var type_test : Int?
    var categories : [CategoryParam]?
    init(name : String = "", type_test : Int = 5, categories : [CategoryParam] = []) {
        super.init()
       self.name = name
       self.type_test = type_test
       self.categories = categories
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.name <- map["name"]
        self.type_test <- map["type_test"]
        self.categories <- map["categories"]
    }
}
