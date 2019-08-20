//
//  WalletLogEndPoint.swift
//  EnglishApp
//
//  Created by Henry on 7/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum WalletLogEndPoint{
    case getWalletLog(offset: Int, wallet_type: Int)
}
extension WalletLogEndPoint: EndPointType{
    var path: String {
        switch self {
        case .getWalletLog:
            return "_api/wallet_log/get_list_wallet_log"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getWalletLog:
            return .post
            
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getWalletLog(let offset, let wallet_type):
            return ["offset": offset, "limit": limit, "wallet_type": wallet_type]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
