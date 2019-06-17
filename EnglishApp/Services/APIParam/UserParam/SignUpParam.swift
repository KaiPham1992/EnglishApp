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
    var rePassword        : String?
    var captcha         : String?
    var fullName         : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.email          <- map["email"]
        self.password       <- map["password"]
        self.rePassword       <- map["repassword"]
        self.captcha        <- map["captcha"]
        self.fullName        <- map["fullname"]
    }
    
    init(email      : String?,
         password   : String?,
         captcha    : String?,
         displayName: String?) {
        super.init()
        self.email          = email
        self.password       = password
        self.captcha        = captcha
        self.rePassword = password
        self.fullName = displayName
        
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

