//
//  WordExplainEntity.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift

class WordExplainEntity : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var word : String = ""
    @objc dynamic var explain : String = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(id: Int,word: String,explain : String) {
        self.init()
        self.id = id
        self.word = word
        self.explain = explain
    }
}
