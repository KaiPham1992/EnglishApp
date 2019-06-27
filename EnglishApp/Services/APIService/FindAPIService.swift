//
//  FindAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol FindAPIServiceProtocol {
    func searchExercise(text: String,success: @escaping SuccessHandler<SearchEntity>.array, failure: @escaping RequestFailure)
}

class FindAPIService: FindAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func searchExercise(text: String,success: @escaping SuccessHandler<SearchEntity>.array, failure: @escaping RequestFailure) {
        let endpoint = FindEnpoint.searchExercise(text: text)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
    
}
