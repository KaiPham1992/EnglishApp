//
//  CategoryParam.swift
//  EnglishApp
//
//  Created by vinova on 7/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryParam : BaseParam {
    var categ_id : Int?
    var level : Int?
    var number_of_question : Int?
    
    init(categ_id : Int = 0, level : Int = 1, number_of_question : Int = 0) {
        super.init()
        self.categ_id = categ_id
        self.level = level
        self.number_of_question = number_of_question
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.categ_id  <- map["categ_id"]
        self.level  <- map["level"]
        self.number_of_question  <- map["number_of_question"]
    }
}
