
//
//  WordLikeResponse.swift
//  EnglishApp
//
//  Created by Steve on 8/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class WordLikeResponse : Mappable {
    var total_likes : String?
    var likes : [WordLikeEntity] = []
    func mapping(map: Map) {
        self.total_likes <- map["total_likes"]
        self.likes <- map["likes"]
    }
    required init?(map: Map) {
        
    }
}
