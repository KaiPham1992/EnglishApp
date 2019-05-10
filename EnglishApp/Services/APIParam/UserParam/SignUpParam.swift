//
//  SignUpParam.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/25/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class SignUpParam: BaseParam {
    var email           : String?
    var password        : String?
    var birthday        : String?
    var captcha         : String?
    var fullName        : String?
    var codeIntroduce   : String?
    var gender          : String?
    var address1        : String?
    var address2        : String?
    
    var long1      : String?
    var lat1      : String?
    
    var long2      : String?
    var lat2      : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.email          <- map["email"]
        self.password       <- map["password"]
        self.birthday       <- map["birthday"]
        self.captcha        <- map["captcha"]
        self.fullName       <- map["fullname"]
        self.codeIntroduce  <- map["code_introduction"]
        self.gender         <- map["gender"]
        self.address1       <- map["address_1"]
        self.address2       <- map["address_2"]
        
        self.lat2         <- map["latitude_2"]
        self.long2          <- map["longitude_2"]
        
        self.lat1         <- map["latitude_1"]
        self.long1          <- map["longitude_1"]
        
    }
    
    init(email      : String?,
         password   : String?,
         birthday   : String?,
         captcha    : String?,
         fullName   : String?,
         gender     : String? = nil,
         address1   : String? = nil,
         address2   : String? = nil,
         codeIntroduce: String? = nil,
         lat1       : String? = nil,
         long1      : String? = nil,
         lat2       : String? = nil,
         long2      : String? = nil) {
        super.init()
        self.email          = email
        self.password       = password
        self.birthday       = birthday
        self.captcha        = captcha
        self.fullName       = fullName
        self.codeIntroduce  = codeIntroduce
        self.gender         = gender
        self.address1       = address1
        self.address2       = address2
        self.lat1           = lat1
        self.lat2           = lat2
        self.long1          = long1
        self.long2          = long2
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

