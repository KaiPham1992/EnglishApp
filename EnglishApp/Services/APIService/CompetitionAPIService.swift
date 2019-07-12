//
//  CompetitionAPIService.swift
//  EnglishApp
//
//  Created by Truc Tran on 7/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol CompetitionAPIServiceProtocol {
    func getListFight(success: @escaping SuccessHandler<CollectionCompetitionEntity>.object,failure: @escaping RequestFailure)
    func getListFightTestTeam(competitionId: Int, success: @escaping SuccessHandler<CollectionTeamEntity>.object,failure: @escaping RequestFailure)
    func getListResultFight(success: @escaping SuccessHandler<CompetitionProfileEntity>.object,failure: @escaping RequestFailure)
}

class CompetitionAPIService: CompetitionAPIServiceProtocol {
    func getListResultFight(success: @escaping SuccessHandler<CompetitionProfileEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.getListResultFight
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListFight( success: @escaping SuccessHandler<CollectionCompetitionEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.getListFight
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
