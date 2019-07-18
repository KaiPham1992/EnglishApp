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
    func getLevelExercise(type_test: Int,offset: Int,success: @escaping SuccessHandler<LevelExerciseEntity>.object, failure: @escaping RequestFailure)
    func getEntranceExercise(success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
    func getResultCalendar(from: String,to: String,success: @escaping SuccessHandler<DateCalendarEntity>.object, failure: @escaping RequestFailure)
    func getTestResult(date: String,offset: Int,success: @escaping SuccessHandler<TestResultEntity>.object, failure: @escaping RequestFailure)
    func submitExercise(param: SubmitExerciseParam,success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure)
    func getListExerciseCatelogy(success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure)
    func createExercise(param: CreateExerciseParam,success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
    func getViewExercise(id: String,success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
    func exitExercise(id: Int,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func exitExercise(success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure)
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int,success: @escaping SuccessHandler<ExerciseChoiceEntity>.object, failure: @escaping RequestFailure)
    
}

class ExerciseAPIService: ExerciseAPIServiceProtocol {
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int,success: @escaping SuccessHandler<ExerciseChoiceEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.getViewChoiceExercise(typeTest: typeTest, catelogyId: catelogyId, level: level)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func exitExercise(success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.getListCatelogy
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func exitExercise(id: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.exitExercise(id: id)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func createExercise(param: CreateExerciseParam, success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.createExercise(param: param)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListExerciseCatelogy(success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getListExerciseCatelogy
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getTestResult(date: String, offset: Int, success: @escaping SuccessHandler<TestResultEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getTestResult(date: date, offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    func submitExercise(param: SubmitExerciseParam, success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.submitExercise(param: param)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    func getResultCalendar(from: String, to: String, success: @escaping SuccessHandler<DateCalendarEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getResultCaledar(from: from, to: to)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getEntranceExercise(success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getViewEntrance
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getLevelExercise(type_test: Int, offset: Int, success: @escaping SuccessHandler<LevelExerciseEntity>.object, failure: @escaping RequestFailure) {
        let enpoint = ExerciseEnpoint.getLevelExercise(type_test: type_test, offset: offset)
        network.requestData(endPoint: enpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    func getListExercise(type_test: Int, category_id: Int, level: Int,offset:Int, success: @escaping SuccessHandler<ListExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getListExercise(type_test: type_test, category_id: category_id, level: level,offset:offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getViewExercise(id: String, success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpont = ExerciseEnpoint.getViewExercise(id: id)
        network.requestData(endPoint: endpont, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
