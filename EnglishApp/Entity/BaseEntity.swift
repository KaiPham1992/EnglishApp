//
//  BaseEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

class BaseEntity: NSObject, Mappable {
    
    override init() {}
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        
    }
    
}
