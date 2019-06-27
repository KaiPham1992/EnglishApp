//
//  ExerciseAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol ExerciseAPIServiceProtocol {
    func getListExercise(type_test: Int, category_id: Int,level: Int,offset:Int,success: @escaping SuccessHandler<ListExerciseEntity>.object, failure: @escaping RequestFailure)
    func getViewExercise(id: Int,success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
}

class ExerciseAPIService: ExerciseAPIServiceProtocol {
    
    func getListExercise(type_test: Int, category_id: Int, level: Int,offset:Int, success: @escaping SuccessHandler<ListExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getListExercise(type_test: type_test, category_id: category_id, level: level,offset:offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getViewExercise(id: Int, success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpont = ExerciseEnpoint.getViewExercise(id: id)
        network.requestData(endPoint: endpont, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
