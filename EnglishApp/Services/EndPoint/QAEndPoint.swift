//
//  QAEndPoint.swift
//  EnglishApp
//
//  Created by KaiPham on 6/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum QAEndPoint {
    case getQA(offset: Int)
    case detailQA(qAId: Int)
    case sendQA(questionName: String)
}

extension QAEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getQA:
            return "_api/question/get_list_question_answer"
        case .detailQA:
            return "_api/question/get_view_question_answer"
        case .sendQA:
            return "_api/question/send_question_answer"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getQA(let offset):
            return ["offset":offset, "limit": limit]
        case .detailQA(let id):
            return ["question_answer_id": id]
        case .sendQA(let keyword):
            return ["question_name": keyword]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
