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
    func sendRedeem(code: String, success: @escaping SuccessHandler<QAEntity>.object,failure: @escaping RequestFailure)
    func exchangeGift(id: String, type: String, success: @escaping SuccessHandler<QAEntity>.object,failure: @escaping RequestFailure)
    func upgradeProduc(productID: String, success: @escaping SuccessHandler<UpgradeInfoEntity>.object,failure: @escaping RequestFailure)
    func purchaseHoney(productID: String, success: @escaping SuccessHandler<UpgradeInfoEntity>.object,failure: @escaping RequestFailure)
}

class ProductAPIService: ProductAPIServiceProtocol {
    func exchangeGift(id: String, type: String, success: @escaping SuccessHandler<QAEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ProductEndPoint.exchangeGift(id: id, type: type)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func upgradeProduc(productID: String, success: @escaping SuccessHandler<UpgradeInfoEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ProductEndPoint.upgradeProduct(productID: productID)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListProduct(success: @escaping SuccessHandler<ProductCollectionEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ProductEndPoint.getListProduct
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func sendRedeem(code: String, success: @escaping SuccessHandler<QAEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ProductEndPoint.sendRedeem(code: code)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func purchaseHoney(productID: String, success: @escaping SuccessHandler<UpgradeInfoEntity>.object,failure: @escaping RequestFailure) {
        let endPoint = ProductEndPoint.purchaseHoney(productID: productID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
