//
//  SQLHelper.swift
//  EnglishApp
//
//  Created by Steve on 7/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import RealmSwift
import SQLite3

class SQLHelper {
    static let shared = SQLHelper()
    //sqlite into document file
    func convertSQLiteToRealmWordEntity(path: String,complete: @escaping () -> ()) {
        DispatchQueue.main.async {
            //save file in docment
//            let fileURL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(appendingPathComponent)
            var database : OpaquePointer?
            //save file in project
//            guard let path = Bundle.main.path(forResource: "sqliteWord", ofType:"db") else{
//                return
//            }
            //use with file URL
//            if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
//                print("Error open \(fileURL.path)")
//            }
            if sqlite3_open(path, &database) != SQLITE_OK {
                print("Error open \(path)")
            }
            var statement : OpaquePointer?
            if sqlite3_prepare_v2(database, "SELECT * from word", -1, &statement, nil) != SQLITE_OK {
                print("select error in path \(path)")
            }
            var objects : [WordEntity] = []
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let word  : String = String(cString: sqlite3_column_text(statement, 1))
                objects.append(WordEntity(id: id, word: word))
            }
            RealmDBManager.share.addSequence(value: objects)
            if sqlite3_finalize(statement) != SQLITE_OK {
                print("finalize statement failed")
            }
            statement = nil
            if sqlite3_close(database) != SQLITE_OK{
                print("close database failed")
            }
            database = nil
            complete()
        }
       
    }
    func convertSQLiteToRealmWordExplainEntity(path: String, complete: @escaping () -> ()){
        DispatchQueue.main.async {
            //save file in docment
//            let fileURL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(appendingPathComponent)
            var database : OpaquePointer?
            //save file in project
//            guard let path = Bundle.main.path(forResource: "sqliteWordExplain", ofType:"db") else{
//                return
//            }
            //use with file URL
            //            if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
            //                print("Error open \(fileURL.path)")
            //            }
            if sqlite3_open(path, &database) != SQLITE_OK {
                print("Error open \(path)")
            }
            var statement : OpaquePointer?
            if sqlite3_prepare_v2(database, "SELECT * from word_explain", -1, &statement, nil) != SQLITE_OK {
                print("select error in path \(path)")
            }
            var objects : [WordExplainEntity] = []
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let word  : String = String(cString: sqlite3_column_text(statement, 1))
                let explain : String = String(cString: sqlite3_column_text(statement, 2))
                objects.append(WordExplainEntity(id: id, word: word, explain: explain))
            }
            RealmDBManager.share.addSequence(value: objects)
            if sqlite3_finalize(statement) != SQLITE_OK {
                print("finalize statement failed")
            }
            statement = nil
            if sqlite3_close(database) != SQLITE_OK{
                print("close database failed")
            }
            database = nil
            complete()
        }
    }
}
