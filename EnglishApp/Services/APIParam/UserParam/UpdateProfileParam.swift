//
//  UpdateProfileParam.swift
//  Oganban
//
//  Created by Kent on 1/21/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class UpdateProfileParam: BaseParam {
    
    var nationalId        : Int?
    var fullName        : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.nationalId          <- map["nation_id"]
        self.fullName      <- map["fullname"]
    }
    
     init(nationalId: Int?, fullName: String?) {
        super.init()
        self.nationalId       = nationalId
        self.fullName       = fullName
        
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

