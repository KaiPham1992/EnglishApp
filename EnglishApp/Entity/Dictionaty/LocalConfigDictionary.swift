//
//  LocalConfigDictionary.swift
//  EnglishApp
//
//  Created by Steve on 8/7/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift

class LocalConfigDictionary : Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name : String = ""
    
    override static func primaryKey() -> String{
        return "id"
    }
    
    convenience init(id: Int,name: String){
        self.init()
        self.id = id
        self.name = name
    }
}
