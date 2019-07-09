//
//  CompetitionEndPoint.swift
//  EnglishApp
//
//  Created by Truc Tran on 7/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum CompetitionEndPoint{
    case getListFight
    case getListFightTestTeam(competitionId: Int)
}
extension CompetitionEndPoint: EndPointType{
    var path: String {
        switch self {
        case .getListFight:
            return "_api/fight/get_list_fight_test"
        case .getListFightTestTeam:
            return "_api/fight/get_list_fight_test_team"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListFight, .getListFightTestTeam:
            return .post
        
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListFight:
            return [:]
        case .getListFightTestTeam(let competitionId):
            return ["competition_id": competitionId]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
