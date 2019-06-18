//
//  File.swift
//  EnglishApp
//
//  Created by vinova on 6/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum TheoryEndpoint {
    case getListLesson(lesson_category_id: Int,offset: Int)
    case getLessonDetail(lesson_id: Int)
    case searchLesson(keyword: String)
}

extension TheoryEndpoint :EndPointType {
    var path: String {
        switch self {
        case .getListLesson:
            return "_api/lesson/get_list_lesson"
        case .getLessonDetail:
            return "_api/lesson/get_view_lesson"
        case .searchLesson:
            return "_api/lesson/search_lesson"
        default:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListLesson, .getLessonDetail,.searchLesson:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListLesson(let lesson_category_id,let offset):
            return ["lesson_category_id":lesson_category_id, "offset":offset, "limit": limit]
        case .getLessonDetail(let lesson_id):
            return ["lesson_id": lesson_id]
        case .searchLesson(let keyword):
            return ["keyword": keyword]
        default:
            return ["" : ""]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
