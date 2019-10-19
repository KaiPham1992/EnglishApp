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
    case getListProduct(fromDoEntrance: Bool, point: Int)
    case sendRedeem(code: String)
    case exchangeGift(id: String, type: String)
    case upgradeProduct(productID: String, transactionId: String)
    case purchaseHoney(productID: String, transactionId: String)
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
        case .upgradeProduct:
            return "_api/product/upgrade_product"
        case .purchaseHoney:
            return "_api/product/purchase_honey"
    
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListProduct, .sendRedeem, .exchangeGift, .upgradeProduct, . purchaseHoney:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListProduct(let fromDoEntrance, let point):
            if fromDoEntrance {
                return ["point_entrance_test": point < 0 ? 0 : point]
            }
            return [:]
        case .exchangeGift(let id, let type):
            return ["product_id": id, "amount_type": type]
        case .sendRedeem(let code):
            return ["code": code]
        case .upgradeProduct(let productID, let transactionId):
            return ["product_id": productID, "transaction_id": transactionId]
        case .purchaseHoney(let productID, let transactionId):
            return ["product_id": productID, "transaction_id": transactionId]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
