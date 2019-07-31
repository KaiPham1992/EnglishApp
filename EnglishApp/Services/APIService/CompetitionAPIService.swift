//
//  CompetitionAPIService.swift
//  EnglishApp
//
//  Created by Truc Tran on 7/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol CompetitionAPIServiceProtocol {
    func getListFight(offset: Int,success: @escaping SuccessHandler<CollectionCompetitionEntity>.object,failure: @escaping RequestFailure)
    func getListFightTestTeam(competitionId: Int, success: @escaping SuccessHandler<CollectionTeamEntity>.object,failure: @escaping RequestFailure)
    func getListResultFight(offset: Int,success: @escaping SuccessHandler<CompetitionProfileEntity>.object,failure: @escaping RequestFailure)
    func createTeamFight(idCompetition: Int,name: String,success: @escaping SuccessHandler<TeamEntity>.object,failure: @escaping RequestFailure)
    func getDetailTeam(id: String,success: @escaping SuccessHandler<DetailTeamEntity>.object,failure: @escaping RequestFailure)
    func leaveTeam(id: String,success: @escaping SuccessHandler<BaseResponse>.object,failure: @escaping RequestFailure)
    func joinTeam(id:String,success: @escaping SuccessHandler<DetailTeamEntity>.object,failure: @escaping RequestFailure)
}

class CompetitionAPIService: CompetitionAPIServiceProtocol {
    func joinTeam(id:String,success: @escaping SuccessHandler<DetailTeamEntity>.object,failure: @escaping RequestFailure){
        let endpoint = CompetitionEndPoint.joinTeam(id: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func leaveTeam(id: String,success: @escaping SuccessHandler<BaseResponse>.object,failure: @escaping RequestFailure){
        let endpoint = CompetitionEndPoint.leaveTeam(id: id)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    func getDetailTeam(id: String,success: @escaping SuccessHandler<DetailTeamEntity>.object,failure: @escaping RequestFailure){
        let endpoint = CompetitionEndPoint.getDetailTeam(id: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createTeamFight(idCompetition: Int, name: String, success: @escaping SuccessHandler<TeamEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.createTeamFight(id: idCompetition, name: name)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListResultFight(offset: Int,success: @escaping SuccessHandler<CompetitionProfileEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.getListResultFight(offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListFight(offset: Int, success: @escaping SuccessHandler<CollectionCompetitionEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.getListFight(offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListFightTestTeam(competitionId: Int, success: @escaping SuccessHandler<CollectionTeamEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.getListFightTestTeam(competitionId: competitionId)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
