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
    case getListResultFight
    case createTeamFight(id: Int,name: String)
    case getDetailTeam(id: String)
}
extension CompetitionEndPoint: EndPointType{
    var path: String {
        switch self {
        case .getDetailTeam(let id):
            return "_api/fight/get_view_fight_test_team/\(id)"
        case .getListFight:
            return "_api/fight/get_list_fight_test"
        case .getListFightTestTeam:
            return "_api/fight/get_list_fight_test_team"
        case .getListResultFight:
            return "_api/result/get_list_fight_test_result"
        case .createTeamFight:
            return "_api/fight/create_fight_test_team"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getDetailTeam:
            return .get
        case .getListFight, .getListFightTestTeam,.getListResultFight,.createTeamFight:
            return .post
        
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getDetailTeam:
            return ["":""]
        case .createTeamFight(let id, let name):
            return ["competition_id": id,
                "name": name]
        case .getListResultFight:
            return ["":""]
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
