//
//  ChildrenComment.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class ChildrenComment: Mappable{
    var _id : String?
    var content : String?
    var status : String?
    var user_id : String?
    var parent_id : String?
    var lesson_id : String?
    var created_by : String?
    var created_date : String?
    var updated_date : String?
    var created_time_mi : String?
    var is_waiting_approved : String?
    var social_img_src : String?
    var attach_img_src : String?
    var img_src: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       self._id <- map["_id"]
       self.content <- map["content"]
       self.status <- map["status"]
       self.user_id <- map["user_id"]
       self.parent_id <- map["parent_id"]
       self.lesson_id <- map["lesson_id"]
       self.created_by <- map["created_by"]
       self.created_date <- map["created_date"]
       self.updated_date <- map["updated_date"]
       self.created_time_mi <- map["created_time_mi"]
       self.is_waiting_approved <- map["is_waiting_approved"]
        self.social_img_src <- map["social_img_src"]
        self.attach_img_src <- map["attach_img_src"]
        self.img_src <- map["img_src"]
    }
}
