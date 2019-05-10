//
//  UpdateProfileSocial.swift
//  Oganban
//
//  Created by Kai Pham on 12/27/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateProfileSocial: BaseParam {
    var fullName: String?
    var birthDay: String?
    var gender: String?
    var address1: String?
    var address2: String?
    var codeIntroduction: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.birthDay <- map["birthday"]
        
        self.gender <- map["gender"]
        self.address1 <- map["address_1"]
        self.address2 <- map["address_2"]
        self.fullName <- map["fullname"]
        self.codeIntroduction <- map["code_introduction"]
    }
    
    init(fullName: String, birthDay: String, gender: String?, codeIntroduction: String?) {
        super.init()
        self.fullName = fullName
        self.birthDay = birthDay
        self.gender = gender
//        self.address1 = address1
//        self.address2 = address2
        self.codeIntroduction = codeIntroduction
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
