//
//  Provider.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation

class Provider {
    static let shared = Provider()
    
    private let request: NetworkRequestProtocol = NetworkRequest()
    
    private var networkManager: APINetworkProtocol {
        return APINetwork(request: request)
    }
    
    var userAPIService: UserAPIServiceProtocol {
        return UserAPIService(network: networkManager)
    }
    
    var commonAPIService: CommonAPIServiceProtocol {
        return CommonAPIService(network: networkManager)
    }
    
    var notificationAPIService: NotificationAPIServiceProtocol {
        return NotificationAPIService(network: networkManager)
    }
    
    var saveAPIService: SaveAPIService {
        return SaveAPIService(network: networkManager)
    }
    
    var theoryAPIService: TheoryAPIService{
        return TheoryAPIService(network: networkManager)
    }
    
    var qAAPIService: QAAPIServiceProtocol{
        return QAAPIService(network: networkManager)
    }
    
    var findAPIService: FindAPIServiceProtocol {
        return FindAPIService(network: networkManager)
    }
    
    var exerciseAPIService: ExerciseAPIServiceProtocol {
        return ExerciseAPIService(network: networkManager)
    }
    
    var productAPIService: ProductAPIServiceProtocol {
        return ProductAPIService(network: networkManager)
    }
    
    var resultAPIService: ResultAPIServiceProtocol {
        return ResultAPIService(network: networkManager)
    }
    
    var competitionAPIService: CompetitionAPIServiceProtocol{
        return CompetitionAPIService(network: networkManager)
    }
    
    var homeAPIService: HomeAPIServiceProtocol{
        return HomeAPIService(network: networkManager)
    }
    
    var walletLogAPIService: WalletLogAPIServiceProtocol{
        return WalletLogAPIService(network: networkManager)
    }
}
