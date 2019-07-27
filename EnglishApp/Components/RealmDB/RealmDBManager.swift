//
//  RealmDBManager.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDBManager {
    private var database : Realm!
    static let share = RealmDBManager()
    init() {
        database = try! Realm()
    }
    func getDataFromRealm<T: Object>(type: T.Type) -> [T]{
        let objects = database.objects(type)
        return objects.toArray()
    }
    func removeAllRealm() {
        try! database.write {
            database.deleteAll()
        }
    }
    func addObject<T:Object>(value: T) {
        try! database.write {
            database.add(value, update: Realm.UpdatePolicy.all)
        }
    }
    func addSequence<T: Object>(value: [T]){
        try! database.write {
            database.add(value, update: Realm.UpdatePolicy.all)
        }
    }
}
extension Results {
    func toArray<T: Object>() -> [T] {
        var arr : [T] = []
        for item in self {
            if let _item = item as? T {
                arr.append(_item)
            }
        }
        return arr
    }
}
