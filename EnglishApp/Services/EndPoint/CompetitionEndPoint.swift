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
    case getListFight(offset: Int)
    case getListFightTestTeam(competitionId: Int)
    case getListResultFight(offset: Int)
    case createTeamFight(id: Int,name: String)
    case getDetailTeam(id: String)
    case leaveTeam(id: String)
    case joinTeam(id: String)
}
extension CompetitionEndPoint: EndPointType{
    var path: String {
        switch self {
        case .joinTeam(let id):
            return "_api/fight/join_fight_test_team/\(id)"
        case .leaveTeam(let id):
            return "_api/fight/leave_fight_test_team/\(id)"
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
        case .getDetailTeam,.leaveTeam,.joinTeam:
            return .get
        case .getListFight, .getListFightTestTeam,.getListResultFight,.createTeamFight:
            return .post
        
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .joinTeam:
            return ["":""]
        case .leaveTeam:
            return ["":""]
        case .getDetailTeam:
            return ["":""]
        case .createTeamFight(let id, let name):
            return ["competition_id": id,
                "name": name]
        case .getListResultFight(let offset):
            return ["offset": offset,"limit":limit]
        case .getListFight(let offset):
            return ["offset": offset,"limit":limit]
        case .getListFightTestTeam(let competitionId):
            return ["competition_id": competitionId]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
