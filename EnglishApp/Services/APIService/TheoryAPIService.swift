//
//  TheoryAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation


protocol TheoryAPIServiceProtocol {
    func getListLesson(lesson_category_id: Int,offset: Int, success: @escaping SuccessHandler<LessonsResponse>.object,failure: @escaping RequestFailure)
    func getLessonDetail(lesson_id: Int,success: @escaping SuccessHandler<LessonCatelogyDetail>.object,failure: @escaping RequestFailure)
    func getComment(idLesson: String,offset: Int,success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure)
    func likeLesson(idLesson: Int,idWord: Int?, isFavorite: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func addComment(idLesson: Int,content: String,idParent: Int?, success: @escaping SuccessHandler<ParentComment>.object, failure: @escaping RequestFailure)
    func getLessonRecipe(type: Int, offset: Int,success: @escaping SuccessHandler<LessonCategoryEntity>.object, failure: @escaping RequestFailure)
    func getCommentQuestion(question_details_id: Int,offset: Int,success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure)
    func addCommentQuestion(question_details_id: Int, content: String,parent_id: Int?,success: @escaping SuccessHandler<ParentComment>.object, failure: @escaping RequestFailure)
}

class TheoryAPIService: TheoryAPIServiceProtocol{
    func addCommentQuestion(question_details_id: Int, content: String,parent_id: Int?,success: @escaping SuccessHandler<ParentComment>.object, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.addCommentQuestion(question_details_id: question_details_id, content: content,parent_id: parent_id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCommentQuestion(question_details_id: Int,offset: Int,success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.getCommentQuestion(question_details_id: question_details_id, offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    func getLessonRecipe(type: Int, offset: Int,success: @escaping SuccessHandler<LessonCategoryEntity>.object, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.getLessonRecipe(type: type, offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func addComment(idLesson: Int, content: String,idParent: Int?, success: @escaping SuccessHandler<ParentComment>.object, failure: @escaping RequestFailure) {
        let endpoint = TheoryEndpoint.addComment(idLesson: idLesson, content: content,idParent: idParent)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func likeLesson(idLesson: Int,idWord: Int?, isFavorite: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = TheoryEndpoint.likeLesson(idLesson: idLesson,idWord: idWord, isFavorite: isFavorite)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func getListLesson(lesson_category_id: Int,offset: Int, success: @escaping SuccessHandler<LessonsResponse>.object, failure: @escaping (APIError?) -> Void) {
        let endpoint = TheoryEndpoint.getListLesson(lesson_category_id: lesson_category_id,offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getLessonDetail(lesson_id: Int, success: @escaping SuccessHandler<LessonCatelogyDetail>.object, failure: @escaping RequestFailure) {
        let endpoint = TheoryEndpoint.getLessonDetail(lesson_id: lesson_id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func searchLesson(keyword: String, success: @escaping SuccessHandler<SearchEntity>.array, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.searchLesson(keyword: keyword)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getComment(idLesson: String,offset: Int,success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.getComment(idLesson: idLesson,offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
