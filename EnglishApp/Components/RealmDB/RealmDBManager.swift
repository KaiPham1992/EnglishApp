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
    
    func removeObject<T: Object>(type: T.Type,value: Int) {
        DispatchQueue.main.async {
            let valueTemp = value
            let objectTemp = self.database.object(ofType: type, forPrimaryKey: valueTemp)
            if objectTemp != nil {
                try! self.database.write {
                    self.database.delete(objectTemp!)
                }
            }
        }
    }
    
    func filter<T:Object,K: Codable>(objectType: T.Type,key: String,value: K) -> [T]{
        var query = "\(key) contains '\(value)'"
        if value is Int {
            query = "\(key) = \(value)"
        }
        let objects = database.objects(objectType).filter(query).toArray()
        guard let _objects = objects as? [T] else{
            return []
        }
        return _objects
    }
    
    func addObject<T:Object>(value: T) {
        try! database.write {
            database.add(value)
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
}
