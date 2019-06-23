//
//  QAAPIService.swift
//  EnglishApp
//
//  Created by KaiPham on 6/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
//QAAPIService


import Foundation


protocol QAAPIServiceProtocol {
    func getQA(offset: Int, success: @escaping SuccessHandler<QAEntity>.array,failure: @escaping RequestFailure)
    func detailQA(id: Int,success: @escaping SuccessHandler<QAEntity>.object,failure: @escaping RequestFailure)
    func sendQA(question: String,success: @escaping SuccessHandler<BaseEntity>.object,failure: @escaping RequestFailure)
}

class QAAPIService: QAAPIServiceProtocol {
    func getQA(offset: Int, success: @escaping SuccessHandler<QAEntity>.array, failure: @escaping RequestFailure) {
        let endpoint = QAEndPoint.getQA(offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func detailQA(id: Int, success: @escaping SuccessHandler<QAEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = QAEndPoint.detailQA(qAId: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func sendQA(question: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = QAEndPoint.sendQA(questionName: question)
        network.requestData(endPoint: endpoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
