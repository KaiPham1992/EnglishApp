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
    case getResultTeam(id: Int)
    case getResultUser(id:Int)
}

extension ResultEndpoint: EndPointType {
    var path: String {
        switch self {
        case .getResultUser:
            return "_api/result/get_view_fight_test_user_result"
        case .getViewTestResultProfile(let id):
            return "_api/result/get_view_test_result/\(id)"
        case .getResultTeam:
            return "_api/result/get_list_fight_test_team_result"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getResultUser:
            return .post
        case .getViewTestResultProfile:
            return .get
        case .getResultTeam:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getResultUser(let id):
           return ["competition_id": id]
        case .getViewTestResultProfile:
            return ["":""]
        case .getResultTeam(let competition):
            return ["competition_id": competition]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
