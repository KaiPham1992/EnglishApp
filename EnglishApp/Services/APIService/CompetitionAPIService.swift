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
}

class CompetitionAPIService: CompetitionAPIServiceProtocol {
    
    func getListFight( success: @escaping SuccessHandler<CollectionCompetitionEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = CompetitionEndPoint.getListFight
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
