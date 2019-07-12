//
//  ResultAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol ResultAPIServiceProtocol {
    func getViewTestResultProfile(id: String,success: @escaping SuccessHandler<TestResultProfileEntity>.object,failure: @escaping RequestFailure)
    func getResultTeam(idCompetition: Int,success: @escaping SuccessHandler<CompetitionResultTeamEntity>.array,failure: @escaping RequestFailure)
    func getResultUser(idCompetition: Int,success: @escaping SuccessHandler<TestResultProfileEntity>.object,failure: @escaping RequestFailure)
}

class ResultAPIService: ResultAPIServiceProtocol {
    func getResultUser(idCompetition: Int,success: @escaping SuccessHandler<TestResultProfileEntity>.object,failure: @escaping RequestFailure){
        let endpoint = ResultEndpoint.getResultUser(id: idCompetition)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getResultTeam(idCompetition: Int,success: @escaping SuccessHandler<CompetitionResultTeamEntity>.array,failure: @escaping RequestFailure){
        let endpoint = ResultEndpoint.getResultTeam(id: idCompetition)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getViewTestResultProfile(id: String, success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ResultEndpoint.getViewTestResultProfile(id: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }

    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
