//
//  FaceBookEntitu.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class FacebookEntity: BaseEntity {
    var email: String?
    var id: String?
    var name: String?
    var url: String?
    var socialType: String?
    
    init(json: [String: Any]) {
        super.init()
        if let _email =  json["email"] as? String {
            self.email = _email
        }
        
        if let _id =  json["id"] as? String {
            self.id = _id
        }
        
        if let _name =  json["name"] as? String {
            self.name = _name
        }
        
        if let picture = json["picture"] as? Dictionary<String, Any>{
            if let data = picture["data"] as? Dictionary<String, Any> {
                if let url = data["url"] as? String {
                    self.url = url
                }
            }
        }
        
        socialType = "facebook"
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["social_id"]
        self.name <- map["fullname"]
        self.email <- map["email"]
        self.url <- map["social_img_src"]
        self.socialType <- map["social_type"]
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
