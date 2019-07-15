//
//  DBManager.swift
//  EnglishApp
//
//  Created by Steve on 7/14/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    private var database : Realm?
    static let shared : DBManager = DBManager()
    
    private init(){
        database = try? Realm()
    }
    
    func addObject(object: Object) {
        try? database?.write {
            database?.add(object)
            print("realm add object")
        }
    }
    
    func getAllObject<T: Object>(type: T.Type) -> [T]? {
        return database?.objects(type).toArray(ofType: type)
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T]{
        return self.map { (item) -> T? in
            if let _item = item as? T {
                return _item
            }
            return nil
            }.compactMap{$0}
        
    }
}
