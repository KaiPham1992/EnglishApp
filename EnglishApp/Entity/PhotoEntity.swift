//
//  PhotoEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class PhotoEntity: BaseEntity {
    var imgSrc: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.imgSrc <- map["img_src"]
    }
}
