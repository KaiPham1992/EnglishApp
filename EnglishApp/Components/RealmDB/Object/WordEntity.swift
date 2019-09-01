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
    @objc dynamic var id_dictionary : Int = 0
    @objc dynamic var primary_key : String = ""
    
    override static func primaryKey() -> String?{
        return "primary_key"
    }
    
    convenience init(id: Int, word: String, id_dictionary: Int) {
        self.init()
        self.id = id
        self.word = word
        self.id_dictionary = id_dictionary
        self.primary_key = "\(id_dictionary)_\(id)"
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.word <- map["name"]
    }
}
