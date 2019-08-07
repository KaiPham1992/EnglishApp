//
//  ItemDictionaryResponse.swift
//  EnglishApp
//
//  Created by Steve on 8/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ItemDictionaryResponse : Object, Mappable {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var link_dictionary : String = ""
    @objc dynamic var isDownload = false
    
    override static func primaryKey() -> String{
        return "id"
    }
    
    func changeStatus(isDownload: Bool) {
        self.isDownload = isDownload
    }
    
    convenience init(id: Int,name: String,link_dictionary: String,isDownload: Bool){
        self.init()
        self.id = id
        self.name = name
        self.link_dictionary = link_dictionary
        self.isDownload = isDownload
    }
    
    func mapping(map: Map) {
        self.id <- (map["_id"] , StringToIntTransform())
        self.name <- map["name"]
        self.link_dictionary <- map["link_dictionary"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}
