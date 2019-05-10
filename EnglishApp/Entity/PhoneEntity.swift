//
//  PhoneEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//
import Foundation
import ObjectMapper

class PhoneEntity {
    var phoneNumber: String?
    var phoneCode: String?
    var phoneFullCodeAndNumber: String?
    
    init(phoneNumber: String?, phoneCode: String?) {
        self.phoneCode = "+\(phoneCode&)"
        self.phoneNumber = phoneNumber
        
        self.phoneFullCodeAndNumber = "\(self.phoneCode&)\(self.phoneNumber&)"
    }
}

struct BaseCodeEntity: Mappable {
    
    var data        : [CountryCodeEntity] = []
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.data       <- map["data"]
    }
}

struct CountryCodeEntity: Mappable {
    
    var name        : String?
    var dialCode    : String?
    var code        : String?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.name       <- map["name"]
        self.dialCode   <- map["dial_code"]
        self.code       <- map["code"]
    }
    
    init( name: String, dialCode: String, code: String ){
        self.name = name
        self.dialCode = dialCode
        self.code = code
    }
}
