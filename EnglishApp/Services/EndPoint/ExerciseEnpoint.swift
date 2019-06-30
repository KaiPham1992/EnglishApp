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
            
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
