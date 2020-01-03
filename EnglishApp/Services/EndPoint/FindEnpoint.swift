//
//  FindEnpoint.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum FindEnpoint {
    case searchExercise(text: String, offset: Int)
    case searchTheory(text: String, offset: Int)
    case getListDictionary
    case lookupWordOnline(dictionary_id: Int,word: String)
    case getViewVocabulary(wordId: Int)
}

extension FindEnpoint: EndPointType {
    var path: String {
        switch self {
        case .lookupWordOnline:
            return "_api/dictionary/lookup_word_online"
        case .getListDictionary:
            return "_api/dictionary/get_list_dictionary"
        case .searchExercise:
            return "_api/exercise/search_exercise"
        case .searchTheory:
            return "_api/lesson/search_lesson"
        case .getViewVocabulary:
            return "_api/dictionary/get_view_vocab"

        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .lookupWordOnline:
            return .post
        case .getListDictionary:
            return .post
        case .searchExercise:
            return .post
        case .searchTheory:
            return .post
        case .getViewVocabulary:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .lookupWordOnline(let dictionary_id, let word):
            return ["dictionary_id": dictionary_id,
                    "word": word]
        case .getListDictionary:
            return ["":""]
        case .searchExercise(let text, let offset):
            return ["keyword": text, "offset": offset, "limit": limit]
        case .searchTheory(let text, let offset):
            return ["keyword": text, "offset": offset, "limit": limit]
        case .getViewVocabulary(let wordId):
            return ["word_id":wordId]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
