//
//  CommentEntity.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentEntity: Mappable {
    var total_records : Int?
    var data : [ParentComment] = []
    
    init(){
        total_records = 0
        data = []
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.data <- map["data"]
    }
}
