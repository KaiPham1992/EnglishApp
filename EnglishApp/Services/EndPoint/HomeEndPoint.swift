//
//  HomeEndPoint.swift
//  EnglishApp
//
//  Created by Henry on 7/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum HomeEndPoint{
    case getTopThree
}
extension HomeEndPoint: EndPointType{
    var path: String {
        switch self {
        case .getTopThree:
            return "/_api/home/get_home_summary"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTopThree:
            return .post
            
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getTopThree:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}

