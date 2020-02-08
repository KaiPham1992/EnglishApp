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
    
    func removeAllObject<T: Object>(type: T.Type){
        try! database.write {
            let allObject = database.objects(type)
            database.delete(allObject)
        }
    }
    
    func removeAllObject<T: Object, V: Codable>(type: T.Type, key: String, value: V) {
        try! database.write {
            var query = "\(key) contains '\(value)'"
            if value is Int {
                query = "\(key) = \(value)"
            }
            let objects = database.objects(type).filter(query)
            if objects.count > 0 {
                database.delete(objects)
            }
        }
    }
    
    func removeObject<T: Object>(type: T.Type, value: Int) {
        let valueTemp = value
        let objectTemp = self.database.object(ofType: type, forPrimaryKey: valueTemp)
        if objectTemp != nil {
            try! self.database.write {
                self.database.delete(objectTemp!)
            }
        }
    }
    
    func removeObject<T: Object, V: Codable>(type: T.Type, value: V) {
        let objectTemp = self.database.object(ofType: type, forPrimaryKey: value)
        if objectTemp != nil {
            try! self.database.write {
                self.database.delete(objectTemp!)
            }
        }
    }
    
    func updateLocalConfigDictionary(id: Int,id_user: Int) {
        try! database.write {
            let objects = self.filter(objectType: LocalConfigDictionary.self, key: "id_user", value: id_user)
            for object in objects {
                if object.id_dictionary == id {
                    object.isDefault = 1
                } else {
                    object.isDefault = 0
                }
            }
        }
    }
    
    func filter<T:Object, K: Codable>(objectType: T.Type, key: String, value: K) -> [T]{
        var query = "\(key) BEGINSWITH '\(value)'"
        if value is Int {
            query = "\(key) = \(value)"
        }
        let objects = database.objects(objectType).filter(query).sorted(byKeyPath: "\(key)").toArrayLimit20()
        guard let _objects = objects as? [T] else{
            return []
        }
        return _objects
    }
    
    func addObject<T:Object>(value: T) {
        try! database.write {
            database.add(value, update: Realm.UpdatePolicy.all)
        }
    }
    func addSequence<T: Object>(value: [T]){
        try! database.write {
            database.add(value)
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
    
    func toArrayLimit20<T: Object>() -> [T] {
        var arr : [T] = []
//        let lastIndex = self.count > 20 ? 20 : self.count
        for item in self {
            if let _item = item as? T {
                arr.append(_item)
                if arr.count == 20 {
                    break
                }
            }
        }
        return arr
    }
}
