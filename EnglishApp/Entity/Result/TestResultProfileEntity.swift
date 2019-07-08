//
//  TestResultEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class TestResultProfileEntity: Mappable {
    var _id : String?
    var total_score : String?
    var total_time : String?
    var amount_diamond : String?
    var amount_rank : String?
    var img_src : String?
    var social_img_src : String?
    var attach_img_src : String?
    var questions : [QuestionResultEntity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       self._id <- map["_id"]
       self.total_score <- map["total_score"]
       self.total_time <- map["total_time"]
       self.amount_diamond <- map["amount_diamond"]
       self.amount_rank <- map["amount_rank"]
       self.img_src <- map["img_src"]
       self.social_img_src <- map["social_img_src"]
       self.attach_img_src <- map["attach_img_src"]
       self.questions <- map["questions"]
    }
}
