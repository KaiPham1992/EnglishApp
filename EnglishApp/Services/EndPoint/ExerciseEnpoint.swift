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
    case getLevelExercise(type_test: Int,offset: Int)
    case getViewEntrance
    case getResultCaledar(from: String,to: String)
    case getTestResult(date: String,offset: Int)
    case submitExercise(param: SubmitExerciseParam)
    case getListExerciseCatelogy
    case createExercise(param: CreateExerciseParam)
    case getViewExercise(id: String)
    case exitExercise(id: Int)
    case getListCatelogy
    case getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int)
}

extension ExerciseEnpoint: EndPointType {
    var path: String {
        switch self {
        case .getViewChoiceExercise:
            return "_api/exercise/get_list_exercise"
        case .getListCatelogy:
            return "_api/exercise/get_list_exercise_category"
        case .getListExercise:
            return "_api/exercise/get_list_exercise"
        case .getLevelExercise:
            return "_api/exercise/get_list_study_pack_exercise"
        case .getViewEntrance:
            return "_api/exercise/do_entrance_test"
        case .getResultCaledar:
            return "_api/result/get_list_test_result_calendar"
        case .getTestResult:
            return "_api/result/get_list_test_result"
        case .submitExercise:
            return "_api/result/submit_exercise"
        case .getListExerciseCatelogy:
            return "_api/exercise/get_list_exercise_category"
        case .createExercise:
            return "_api/exercise/create_exercise"
        case .getViewExercise(let id):
            return "_api/exercise/get_view_exercise/\(id)"
        case .exitExercise:
            return "_api/result/exit_exercise"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getViewChoiceExercise:
            return .post
        case .getListCatelogy:
            return .post
        case .exitExercise:
            return .post
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
        case .submitExercise:
            return .post
        case .getListExerciseCatelogy:
            return .post
        case .createExercise:
            return .post

        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getViewChoiceExercise(let typeTest, let catelogyId, let level):
            return [    "type_test": typeTest,
                        "category_id": catelogyId,
                        "level": level]
        case .getListCatelogy:
            return ["":""]
        case .exitExercise(let id):
            return ["exercise_id": id ]
        case .getViewExercise:
            return ["":""]
        case .createExercise(let param):
            return param.toJSON()
        case .getListExerciseCatelogy:
            return ["":""]
        case .getListExercise(let type_test,let category_id,let level,let offset):
            return [    "type_test": type_test,
                        "category_id": category_id,
                        "level": level,
                        "offset":offset,
                        "limit": limit
            ]
        case .getLevelExercise(let type_test,let offset):
            return ["type_test": type_test,"offset":offset,"limit":limit]
        case .getViewEntrance:
            return ["":""]
            
        case .getResultCaledar(let from, let to):
            return ["date_from":from,"date_to":to]
        case .getTestResult(let date, let offset):
            return ["date": date,"offset": offset,"limit": limit]
        case .submitExercise(let param):
            return param.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
