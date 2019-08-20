//
//  WalletLogAPIService.swift
//  EnglishApp
//
//  Created by Henry on 7/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol WalletLogAPIServiceProtocol {
    func getWalletLog(offset: Int, wallet_type: Int, success: @escaping SuccessHandler<CollectionLogEntity>.object,failure: @escaping RequestFailure)
}

class WalletLogAPIService: WalletLogAPIServiceProtocol {
    
    func getWalletLog(offset: Int, wallet_type: Int, success: @escaping SuccessHandler<CollectionLogEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = WalletLogEndPoint.getWalletLog(offset: offset, wallet_type: wallet_type)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}

