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
}

class ResultAPIService: ResultAPIServiceProtocol {
    
    func getViewTestResultProfile(id: String, success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ResultEndpoint.getViewTestResultProfile(id: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }

    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
