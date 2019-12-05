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
    case getListFightTestTeam(competitionId: Int, offset: Int)
    case getListResultFight(offset: Int, date: String)
    case createTeamFight(id: Int,name: String)
    case getDetailTeam(id: String)
    case leaveTeam(id: String)
    case joinTeam(id: String)
    case getViewFightTest(idCompetition: String)
    case getViewFightCompetition(id: String)
    case submitCompetition(param: SubmitCompetitionQuestionResponse)
}
extension CompetitionEndPoint: EndPointType{
    var path: String {
        switch self {
        case .submitCompetition:
            return "_api/fight/submit_fight_test_question"
        case .getViewFightCompetition(let id):
            return "_api/exercise/do_real_time_test/\(id)"
        case .getViewFightTest(let id):
            return "_api/fight/get_view_fight_test/\(id)"
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
        case .getDetailTeam,.leaveTeam,.joinTeam,.getViewFightTest,.getViewFightCompetition:
            return .get
        case .getListFight, .getListFightTestTeam,.getListResultFight,.createTeamFight,.submitCompetition:
            return .post
        
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .submitCompetition(let param):
            return param.toJSON()
        case .getViewFightCompetition:
            return [:]
        case .getViewFightTest:
            return [:]
        case .joinTeam:
            return [:]
        case .leaveTeam:
            return [:]
        case .getDetailTeam:
            return [:]
        case .createTeamFight(let id, let name):
            return ["competition_id": id,
                "name": name]
        case .getListResultFight(let offset, let date):
            if date == "" {
                return ["offset": offset, "limit": limit]
            }
            return ["offset": offset,"limit": limit, "date": date]
        case .getListFight(let offset):
            return ["offset": offset,"limit":limit, "status": 1]
        case .getListFightTestTeam(let competitionId, let offset):
            return ["competition_id": competitionId, "offset": offset, "limit": limit]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
