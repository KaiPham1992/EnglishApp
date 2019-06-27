//
//  ProductEndPoint.swift
//  EnglishApp
//
//  Created by KaiPham on 6/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
//ProductEndPoint
//_api/product/get_list_product


import Foundation
import Alamofire

enum ProductEndPoint {
    case getListProduct
    case sendRedeem(code: String)
    case exchangeGift
}

extension ProductEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getListProduct:
            return "_api/product/get_list_product"
        case .sendRedeem:
            return "_api/product/send_redeem_code"
        case .exchangeGift:
            return "_api/product/exchange_gift"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListProduct, .sendRedeem, .exchangeGift:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListProduct, .exchangeGift:
            return [:]
        case .sendRedeem(let code):
            return ["code": code]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
