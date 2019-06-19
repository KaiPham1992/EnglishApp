//
//  NationalEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class NationalEntity: BaseEntity {
    var id: String?
    var name: String?
    var code: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["_id"]
        self.name <- map["name"]
        self.code <- map["code"]
    }
}
