//
//  FindAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol FindAPIServiceProtocol {
    func searchExercise(text: String, offset: Int, success: @escaping SuccessHandler<SearchExersiseEntity>.object, failure: @escaping RequestFailure)
    func searchTheory(text: String, offset: Int, success: @escaping SuccessHandler<SearchEntity>.array, failure: @escaping RequestFailure)
    func getListDictionary(success: @escaping SuccessHandler<DictionarisResponse>.object, failure: @escaping RequestFailure)
    func lookupWordOnline(dictionary_id: Int,word: String,success: @escaping SuccessHandler<WordExplainEntity>.object, failure: @escaping RequestFailure)
    func getViewVocabulary(wordId: Int,success: @escaping SuccessHandler<WordExplainEntity>.object, failure: @escaping RequestFailure)
}

class FindAPIService: FindAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getViewVocabulary(wordId: Int,success: @escaping SuccessHandler<WordExplainEntity>.object, failure: @escaping RequestFailure){
        let endpoint = FindEnpoint.getViewVocabulary(wordId: wordId)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func lookupWordOnline(dictionary_id: Int,word: String,success: @escaping SuccessHandler<WordExplainEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = FindEnpoint.lookupWordOnline(dictionary_id: dictionary_id, word: word)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListDictionary(success: @escaping SuccessHandler<DictionarisResponse>.object, failure: @escaping RequestFailure){
        let endpoint = FindEnpoint.getListDictionary
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func searchExercise(text: String, offset: Int, success: @escaping SuccessHandler<SearchExersiseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = FindEnpoint.searchExercise(text: text, offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    func searchTheory(text: String, offset: Int, success: @escaping SuccessHandler<SearchEntity>.array, failure: @escaping RequestFailure){
        let endpoint = FindEnpoint.searchTheory(text: text, offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
}
