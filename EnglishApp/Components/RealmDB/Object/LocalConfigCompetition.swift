//
//  LocalConfigCompetition.swift
//  EnglishApp_Dev
//
//  Created by Steve on 8/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift

class LocalConfigCompetition : Object {
    @objc dynamic var id_user : Int = 0
    @objc dynamic var id_team : Int = 0
    
    override static func primaryKey() -> String?{
        return "id_user"
    }
    
    convenience init(id_user: Int, id_team: Int) {
        self.init()
        self.id_user = id_user
        self.id_team = id_team
    }
}
