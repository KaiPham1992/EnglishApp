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
}

extension ExerciseEnpoint: EndPointType {
    var path: String {
        switch self {
        case .getListExercise:
            return "_api/exercise/get_list_exercise"
        case .getViewExercise(let id):
            return "_api/exercise/get_view_exercise/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListExercise:
            return .post
        case .getViewExercise:
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
            
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
