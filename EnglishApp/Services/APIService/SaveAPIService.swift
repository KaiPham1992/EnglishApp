//
//  SaveAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol SaveAPIServiceProtocol {
    func getListNote(offset: Int,success: @escaping SuccessHandler<NoteListRespone>.object, failure: @escaping RequestFailure)
    func deleteNote(id: [Int],success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func addNote(description: String,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func getViewNote(idNote: String,success: @escaping SuccessHandler<NoteDetailEntity>.object, failure: @escaping RequestFailure)
    func editNote(idNote: String,description: String,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func getListGrammar(offset: Int,success: @escaping SuccessHandler<GrammarsResponse>.object, failure: @escaping RequestFailure)
    func deleteListGrammar(likeList: [Int],success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
}

class SaveAPIService : SaveAPIServiceProtocol {
    
   
    let network : APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func deleteListGrammar(likeList: [Int],success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure){
        let endpoint = SaveEndpoint.deleteListGrammar(liekList: likeList)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func getListGrammar(offset: Int,success: @escaping SuccessHandler<GrammarsResponse>.object, failure: @escaping RequestFailure){
        let endpoint = SaveEndpoint.getListGrammar(offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListNote(offset: Int,success: @escaping SuccessHandler<NoteListRespone>.object, failure: @escaping RequestFailure) {
        let endpint = SaveEndpoint.getListNote(offset: offset)
        network.requestData(endPoint: endpint, success: MapperData.mapObject(success), failure: failure)
    }
    func deleteNote(id: [Int], success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = SaveEndpoint.deleteNote(id: id)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    func addNote(description: String,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure){
        let endpoint = SaveEndpoint.addNote(description: description)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func getViewNote(idNote: String, success: @escaping SuccessHandler<NoteDetailEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = SaveEndpoint.getViewNote(idNote: idNote)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    func editNote(idNote: String,description: String,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure){
        let endpoint = SaveEndpoint.editNote(idNote: idNote, description: description)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
}
