//
//  TheoryAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation


protocol TheoryAPIServiceProtocol {
    func getListLesson(lesson_category_id: Int,offset: Int, success: @escaping SuccessHandler<LessonCatelogy>.array,failure: @escaping RequestFailure)
    func getLessonDetail(lesson_id: Int,success: @escaping SuccessHandler<LessonCatelogyDetail>.object,failure: @escaping RequestFailure)
    func getComment(idLesson: String,success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure)
    func likeLesson(idLesson: Int,isFavorite: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func addComment(idLesson: Int,content: String,idParent: Int?, success: @escaping SuccessHandler<ParentComment>.object, failure: @escaping RequestFailure)
}

class TheoryAPIService: TheoryAPIServiceProtocol{
    
    func addComment(idLesson: Int, content: String,idParent: Int?, success: @escaping SuccessHandler<ParentComment>.object, failure: @escaping RequestFailure) {
        let endpoint = TheoryEndpoint.addComment(idLesson: idLesson, content: content,idParent: idParent)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func likeLesson(idLesson: Int, isFavorite: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = TheoryEndpoint.likeLesson(idLesson: idLesson, isFavorite: isFavorite)
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func getListLesson(lesson_category_id: Int,offset: Int, success: @escaping SuccessHandler<LessonCatelogy>.array, failure: @escaping (APIError?) -> Void) {
        let endpoint = TheoryEndpoint.getListLesson(lesson_category_id: lesson_category_id,offset: offset)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getLessonDetail(lesson_id: Int, success: @escaping SuccessHandler<LessonCatelogyDetail>.object, failure: @escaping RequestFailure) {
        let endpoint = TheoryEndpoint.getLessonDetail(lesson_id: lesson_id)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func searchLesson(keyword: String, success: @escaping SuccessHandler<SearchEntity>.array, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.searchLesson(keyword: keyword)
        network.requestData(endPoint: endpoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getComment(idLesson: String,success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure){
        let endpoint = TheoryEndpoint.getComment(idLesson: idLesson)
        network.requestData(endPoint: endpoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
}
