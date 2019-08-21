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
    case getTestResult(type: Int,date: String,offset: Int)
    case submitExercise(param: SubmitExerciseParam)
    case getListExerciseCatelogy(offset: Int)
    case createExercise(param: CreateExerciseParam)
    case getViewExercise(id: String)
    case exitExercise(id: Int)
    case getListCatelogy
    case getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int,studyPackId: Int?,offset: Int)
    case getDailyMisson
    case getListAssignExercise(offset: Int)
    case getListQuestionCategory(offset: Int)
    case suggestQuestion(id: String,isDiamond: Bool)
    case explainExercise(id: Int)
    case reportQuestion(question_details_id:Int,content: String)
    case searchVocabulary(word: String)
}

extension ExerciseEnpoint: EndPointType {
    var path: String {
        switch self {
        case .searchVocabulary:
            return "_api/dictionary/lookup_word_online"
        case .reportQuestion:
            return "_api/question/report_question"
        case .explainExercise:
            return "_api/question/explain_question"
        case .suggestQuestion:
            return "_api/question/suggest_question"
        case .getListQuestionCategory:
            return "_api/question/get_list_question_category"
        case .getListAssignExercise:
            return "_api/exercise/get_list_exercise"
        case .getDailyMisson:
            return "_api/exercise/do_daily_mission_test"
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
        case .searchVocabulary:
            return .post
        case .reportQuestion:
            return .post
        case .explainExercise:
            return .post
        case .suggestQuestion:
            return .post
        case .getListQuestionCategory:
            return .post
        case .getListAssignExercise:
            return .post
        case .getDailyMisson:
            return .get
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
        case .searchVocabulary(let word):
            return ["dictionary_id": 1,
                    "word": word]
        case .reportQuestion(let question_details_id,let content):
            return ["question_details_id":question_details_id,"content":content]
        case .explainExercise(let id):
            return ["question_id": id]
        case .suggestQuestion(let id,let isDiamond):
            if isDiamond {
                return ["question_details_id": id, "amount_diamond": 10]
            }
            return ["question_details_id": id,
                     "amount_honey": 5]
        case .getListQuestionCategory(let offset):
            return ["offset": offset, "limit": limit]
        case .getListAssignExercise(let offset):
            return [    "type_test": 6,
                        "offset": offset,
                        "limit": limit]
        case .getDailyMisson:
            return ["":""]
        case .getViewChoiceExercise(let typeTest, let catelogyId, let level, let studyPackId,let offset):
            if let _studyPackId = studyPackId {
                return ["offset": offset, "limit": limit,
                            "study_pack_id":_studyPackId,
                            "type_test": typeTest,
                            "category_id": catelogyId,
                            "level": level]
            }
            return ["offset": offset, "limit": limit,
                        "type_test": typeTest,
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
        case .getListExerciseCatelogy(let offset):
            return ["offset":offset,"limit": limit]
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
        case .getTestResult(let type, let date, let offset):
            return ["type_test": type, "date": date,"offset": offset,"limit": limit]
        case .submitExercise(let param):
            return param.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
