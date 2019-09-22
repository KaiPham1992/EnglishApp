//
//  ParentComment.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ParentComment : Mappable {
    var _id : String?
    var content : String?
    var user_id : String?
    var status : String?
    var created_date : Date?
    var created_time_mi : Date?
    var children : [ParentComment] = []
    var social_img_src : String?
    var attach_img_src : String?
    var img_src: String?
    var fullname: String?
    var is_waiting_approved: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.is_waiting_approved <- map["is_waiting_approved"]
       self.fullname <- map["fullname"]
       self._id <- map["_id"]
       self.content <- map["content"]
       self.user_id <- map["user_id"]
       self.status <- map["status"]
       self.created_date <- (map["created_date"],TranformStringtoDate())
       self.created_time_mi <- (map["created_time_mi"],TranformStringtoDate())
       self.children <- map["children"]
       self.social_img_src <- map["social_img_src"]
       self.attach_img_src <- map["attach_img_src"]
       self.img_src <- map["img_src"]
    }
}
