//
//  WordExplainEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class WordExplainEntity : Object,Mappable {
    @objc dynamic var id : Int = 0
    @objc dynamic var word : String = ""
    @objc dynamic var explain : String = ""
    @objc dynamic var link_audio : String = ""
    var is_favorite : Bool = false
    @objc dynamic var id_user : Int = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0") ?? 0
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(id: Int,word: String,explain : String) {
        self.init()
        self.id = id
        self.word = word
        self.explain = explain
        self.id_user = id_user
    }
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.word <- map["word"]
        self.explain <- map["explain"]
        self.id <- (map["_id"], StringToIntTransform())
        self.is_favorite <- map["is_favorite"]
        self.link_audio <- map["link_audio"]
    }
}
