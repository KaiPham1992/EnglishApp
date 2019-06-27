//
//  ProductAPIService.swift
//  EnglishApp
//
//  Created by KaiPham on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol ProductAPIServiceProtocol {
    func getListProduct(success: @escaping SuccessHandler<ProductCollectionEntity>.object,failure: @escaping RequestFailure)
//    func sendRedeem(code: String, success: @escaping SuccessHandler<QAEntity>.array,failure: @escaping RequestFailure)
//    func exchangeGift(success: @escaping SuccessHandler<QAEntity>.array,failure: @escaping RequestFailure)
    
}

class ProductAPIService: ProductAPIServiceProtocol {
    func getListProduct(success: @escaping SuccessHandler<ProductCollectionEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ProductEndPoint.getListProduct
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
