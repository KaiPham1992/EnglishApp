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
    case getListLeaderBoard(quarter: String, year: String, rank: String, offset: Int)
}
extension HomeEndPoint: EndPointType{
    var path: String {
        switch self {
        case .getTopThree:
            return "_api/home/get_home_summary"
        case .getListLeaderBoard:
            return "_api/leader_board/get_list_leader_board"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTopThree, .getListLeaderBoard:
            return .post
            
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getTopThree:
            return [:]
        case .getListLeaderBoard(let quarter, let year, let rank, let offset):
            let param = ["quarter": quarter, "year": year, "rank": rank, "offset": offset, "limit": limit] as [String: Any]
            return param
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}

