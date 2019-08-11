//
//  WordLikeEntity.swift
//  EnglishApp
//
//  Created by Steve on 8/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class WordLikeEntity : Mappable {
    var _id : String?
    var word_id : String?
    var word : String?
    var is_favorite : String?
    var created_date : String?
    var isDelete = false
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.word_id <- map["word_id"]
        self.word <- map["word"]
        self.is_favorite <- map["is_favorite"]
        self.created_date <- map["created_date"]
    }
    required init?(map: Map) {
        
    }
}
