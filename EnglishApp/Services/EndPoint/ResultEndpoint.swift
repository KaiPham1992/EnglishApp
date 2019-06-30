//
//  ResultEndpoint.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum ResultEndpoint {
    case getViewTestResultProfile(id: String)
}

extension ResultEndpoint: EndPointType {
    var path: String {
        switch self {
        case .getViewTestResultProfile(let id):
            return "_api/result/get_view_test_result/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getViewTestResultProfile:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getViewTestResultProfile:
            return ["":""]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
