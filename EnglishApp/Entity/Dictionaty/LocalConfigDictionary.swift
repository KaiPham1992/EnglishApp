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
    @objc dynamic var isDefault : Int = 0
    @objc dynamic var id_user : Int = 0
    @objc dynamic var local_config_id : String = ""
    
    override static func primaryKey() -> String{
        return "local_config_id"
    }
    
    convenience init(id: Int,name: String, id_user: Int){
        self.init()
        self.id = id
        self.name = name
        self.id_user = id_user
        self.local_config_id = "\(id)\(id_user)"
    }
    
    func setValueDefault(value: Int){
        self.isDefault = value
    }
}
