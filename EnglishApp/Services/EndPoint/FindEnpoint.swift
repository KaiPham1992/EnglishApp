//
//  FindEnpoint.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum FindEnpoint {
    case searchExercise(text: String)
    case searchTheory(text: String)
}

extension FindEnpoint: EndPointType {
    var path: String {
        switch self {
        case .searchExercise:
            return "_api/exercise/search_exercise"
        case .searchTheory:
            return "_api/lesson/search_lesson"

        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchExercise:
            return .post
        case .searchTheory:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .searchExercise(let text):
            return ["keyword": text]
        case .searchTheory(let text):
            return ["keyword": text]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
