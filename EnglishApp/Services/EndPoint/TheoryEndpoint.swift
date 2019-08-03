//
//  File.swift
//  EnglishApp
//
//  Created by vinova on 6/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum TheoryEndpoint {
    case getListLesson(lesson_category_id: Int,offset: Int)
    case getLessonDetail(lesson_id: Int)
    case searchLesson(keyword: String)
    case getComment(idLesson: String,offset: Int)
    case likeLesson(idLesson: Int,isFavorite: Int)
    case addComment(idLesson: Int,content: String,idParent: Int?)
    case getLessonRecipe(type: Int,offset: Int)
    case getCommentQuestion(question_details_id: Int,offset: Int)
    case addCommentQuestion(question_details_id: Int, content: String,parent_id: Int?)
}

extension TheoryEndpoint :EndPointType {
    var path: String {
        switch self {
        case .addCommentQuestion:
            return "_api/comment/create_comment_question"
        case .getCommentQuestion:
            return "_api/comment/get_list_comment_question"
        case .getLessonRecipe:
            return "_api/lesson/get_list_lesson_category"
        case .getListLesson:
            return "_api/lesson/get_list_lesson"
        case .getLessonDetail:
            return "_api/lesson/get_view_lesson"
        case .searchLesson:
            return "_api/lesson/search_lesson"
        case .getComment:
            return "_api/comment/get_list_comment"
        case .likeLesson:
            return "_api/like/toggle_like"
        case .addComment:
            return "_api/comment/create_comment"
        default:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListLesson, .getLessonDetail,.searchLesson, .getComment,.likeLesson,.addComment,.getLessonRecipe, .getCommentQuestion, .addCommentQuestion:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .addCommentQuestion(let question_details_id, let content,let parent_id):
            if parent_id == nil {
                return ["question_details_id":question_details_id,"content":content]
            }
            return ["question_details_id":question_details_id,"content":content, "parent_id":parent_id!]
        case .getCommentQuestion(let question_details_id,let offset):
            return ["question_details_id":question_details_id, "offset":offset,"limit":limit]
        case .getLessonRecipe(let type, let offset):
            return ["limit": limit,
                    "offset": offset,
                    "lesson_type_id": type]
        case .getListLesson(let lesson_category_id,let offset):
            return ["lesson_category_id":lesson_category_id, "offset":offset, "limit": limit]
        case .getLessonDetail(let lesson_id):
            return ["lesson_id": lesson_id]
        case .searchLesson(let keyword):
            return ["keyword": keyword]
        case .getComment(let idLesson,let offset):
            return ["lesson_id": Int(idLesson) ?? 0,"offset": offset,"limit":limit]
        case .likeLesson(let idLesson, let isFavorite):
            return ["lesson_id":idLesson,"is_favorite":isFavorite]
        case .addComment(let idLesson, let content,let idParent):
            if idParent == nil {
                return ["lesson_id": idLesson,
                        "content": content]
            }
            return ["lesson_id": idLesson,
                    "content": content,
                    "parent_id": idParent!]
            
        default:
            return ["" : ""]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
