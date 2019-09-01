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

class ItemDictionaryResponse : Mappable {
    var id : Int = 0
    var name : String = ""
    var link_dictionary : String = ""
    var isDownload = false
    var isDefault = false
    var isDownloading = false
    
    
    func changeStatus(isDownload: Bool) {
        self.isDownload = isDownload
    }
    
    func mapping(map: Map) {
        self.id <- (map["_id"] , StringToIntTransform())
        self.name <- map["name"]
        self.link_dictionary <- map["link_dictionary"]
    }
    
    required init?(map: Map) {
    }
}
