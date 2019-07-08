//
//  SaveAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol SaveAPIServiceProtocol {
    func getListNote(offset: Int,success: @escaping SuccessHandler<NoteRespone>.array, failure: @escaping RequestFailure)
    func deleteNote(id: [Int],success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
}

class SaveAPIService : SaveAPIServiceProtocol {
    
   
    let network : APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    func getListNote(offset: Int,success: @escaping SuccessHandler<NoteRespone>.array, failure: @escaping RequestFailure) {
        let endpint = SaveEndpoint.getListNote(offset: offset)
        network.requestData(endPoint: endpint, success: MapperData.mapArray(success), failure: failure)
    }
    func deleteNote(id: [Int], success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = SaveEndpoint.deleteNote(id: id)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
}
