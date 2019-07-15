//
//  LessonCatelogyDetailRealm.swift
//  EnglishApp
//
//  Created by Steve on 7/14/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift

class LessonCatelogyDetailRealm : Object{
    
    @objc dynamic var _id : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var unread_comments: Int = 0
    @objc dynamic var is_favorite : Int = 1
    
    override static func primaryKey() -> String? {
        return "_id"
    }
    
    convenience init(lessonCatelogyDetail: LessonCatelogyDetail) {
        self.init()
        self._id = lessonCatelogyDetail._id&
        self.name = lessonCatelogyDetail.name&
        self.content = lessonCatelogyDetail.content&
        self.unread_comments = lessonCatelogyDetail.unread_comments ?? 0
    }
}

