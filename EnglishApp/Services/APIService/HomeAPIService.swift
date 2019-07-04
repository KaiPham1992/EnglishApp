//
//  HomeAPIService.swift
//  EnglishApp
//
//  Created by Henry on 7/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol HomeAPIServiceProtocol {
    func getTopThree(success: @escaping SuccessHandler<CollectionUserEntity>.object,failure: @escaping RequestFailure)
}

class HomeAPIService: HomeAPIServiceProtocol {
    
    func getTopThree( success: @escaping SuccessHandler<CollectionUserEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = HomeEndPoint.getTopThree
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
