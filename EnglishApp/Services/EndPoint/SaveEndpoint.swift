//
//  SaveEndpoint.swift
//  EnglishApp
//
//  Created by vinova on 6/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum SaveEndpoint {
    case getListNote(offset: Int)
}

extension SaveEndpoint : EndPointType {
    var path: String {
        switch self {
            case .getListNote:
                return "_api/note/notes_list"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListNote:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListNote(let offset):
            return ["offset" : offset,"limit":limit]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
