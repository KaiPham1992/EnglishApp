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
    func getHistoryExercise(type: Int,date: String,offset: Int,success: @escaping SuccessHandler<TestsResultRespone>.object, failure: @escaping RequestFailure)
    func submitExercise(param: SubmitExerciseParam,success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure)
    func getListExerciseCatelogy(offset: Int,success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure)
    func createExercise(param: CreateExerciseParam,success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
    func getViewExercise(id: String,success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
    func exitExercise(id: Int,success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure)
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int,studyPackId: Int?,offset: Int,success: @escaping SuccessHandler<ExerciseChoiceEntity>.object, failure: @escaping RequestFailure)
    func getDailyMisson(success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure)
    func getListAssignExercise(offset: Int,success: @escaping SuccessHandler<ExerciseChoiceEntity>.object, failure: @escaping RequestFailure)
    func getListQuestionCatelogy(success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure)
    func suggestQuestion(id: String,isDiamond: Bool,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func explainExercise(id: Int,success: @escaping SuccessHandler<ExplainQuestionResponse>.object, failure: @escaping RequestFailure)
    func reportQuestion(question_details_id: Int,content: String,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func searchVocabulary(word: String,success: @escaping SuccessHandler<WordExplainEntity>.object, failure: @escaping RequestFailure)
}

class ExerciseAPIService: ExerciseAPIServiceProtocol {
    func searchVocabulary(word: String,success: @escaping SuccessHandler<WordExplainEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.searchVocabulary(word: word)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    func reportQuestion(question_details_id: Int,content: String,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.reportQuestion(question_details_id: question_details_id, content: content)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    func explainExercise(id: Int,success: @escaping SuccessHandler<ExplainQuestionResponse>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.explainExercise(id: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func suggestQuestion(id: String,isDiamond: Bool,success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.suggestQuestion(id: id,isDiamond: isDiamond)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func getListQuestionCatelogy(success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.getListQuestionCategory
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListAssignExercise(offset: Int,success: @escaping SuccessHandler<ExerciseChoiceEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.getListAssignExercise(offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getDailyMisson(success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.getDailyMisson
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int,studyPackId: Int?,offset: Int,success: @escaping SuccessHandler<ExerciseChoiceEntity>.object, failure: @escaping RequestFailure){
        let endpoint = ExerciseEnpoint.getViewChoiceExercise(typeTest: typeTest, catelogyId: catelogyId, level: level,studyPackId: studyPackId,offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func exitExercise(id: Int, success: @escaping SuccessHandler<TestResultProfileEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.exitExercise(id: id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createExercise(param: CreateExerciseParam, success: @escaping SuccessHandler<ViewExerciseEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.createExercise(param: param)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListExerciseCatelogy(offset: Int,success: @escaping SuccessHandler<CatelogyEntity>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getListExerciseCatelogy(offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getHistoryExercise(type: Int,date: String, offset: Int, success: @escaping SuccessHandler<TestsResultRespone>.object, failure: @escaping RequestFailure) {
        let endpoint = ExerciseEnpoint.getTestResult(type: type,date: date, offset: offset)
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
