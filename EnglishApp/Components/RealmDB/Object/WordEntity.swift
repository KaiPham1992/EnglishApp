//
//  WordEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class WordEntity : Object,Mappable {
    @objc dynamic var id : Int = 0
    @objc dynamic var word : String = ""
    @objc dynamic var id_user = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0") ?? 0
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(id: Int,word: String) {
        self.init()
        self.id = id
        self.word = word
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.word <- map["name"]
    }
}
