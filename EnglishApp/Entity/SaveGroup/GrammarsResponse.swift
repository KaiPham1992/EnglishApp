//
//  GrammarsResponse.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class GrammarsResponse : Mappable {
    var total_likes : String?
    var likes : [GrammarEntity] = []
    func mapping(map: Map) {
        self.total_likes <- map["total_likes"]
        self.likes <- map["likes"]
    }
    required init?(map: Map) {
        
    }
}
