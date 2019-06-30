//
//  ExerciseEnpoint.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum ExerciseEnpoint {
    case getListExercise(type_test: Int, category_id: Int,level: Int,offset: Int)
    case getViewExercise(id: Int)
    case getLevelExercise(type_test: Int,offset: Int)
    case getViewEntrance
    case getResultCaledar(from: String,to: String)
    case getTestResult(date: String,offset: Int)
}

extension ExerciseEnpoint: EndPointType {
    var path: String {
        switch self {
        case .getListExercise:
            return "_api/exercise/get_list_exercise"
        case .getViewExercise(let id):
            return "_api/exercise/get_view_exercise/\(id)"
        case .getLevelExercise:
            return "_api/exercise/get_list_study_pack_exercise"
        case .getViewEntrance:
            return "_api/exercise/do_entrance_test"
        case .getResultCaledar:
            return "_api/result/get_list_test_result_calendar"
        case .getTestResult:
            return "_api/result/get_list_test_result"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListExercise:
            return .post
        case .getViewExercise:
            return .get
        case .getLevelExercise:
            return .post
        case .getViewEntrance:
            return .get
        case .getResultCaledar:
            return .post
        case .getTestResult:
            return .post

        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListExercise(let type_test,let category_id,let level,let offset):
            return [    "type_test": type_test,
                        "category_id": category_id,
                        "level": level,
                        "offset":offset,
                        "limit": limit
            ]
        case .getViewExercise:
            return ["":""]
        case .getLevelExercise(let type_test,let offset):
            return ["type_test": type_test,"offset":offset,"limit":limit]
        case .getViewEntrance:
            return ["":""]
            
        case .getResultCaledar(let from, let to):
            return ["date_from":from,"date_to":to]
        case .getTestResult(let date, let offset):
            return ["date": date,"offset": offset,"limit": limit]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
