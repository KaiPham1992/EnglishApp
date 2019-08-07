//
//  SaveEndpoint.swift
//  EnglishApp
//
//  Created by vinova on 6/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

enum SaveEndpoint {
    case getListNote(offset: Int)
    case deleteNote(id: [Int])
    case addNote(description: String)
    case getViewNote(idNote: String)
    case editNote(idNote: String,description: String)
    case getListGrammar(offset: Int)
    case deleteListGrammar(liekList: [Int])
    case getListLikesVocab(offset: Int)
}

extension SaveEndpoint : EndPointType {
    var path: String {
        switch self {
        case .getListLikesVocab:
            return "_api/like/get_list_like_vocab"
        case .getListGrammar:
            return "_api/like/get_list_like"
        case .getListNote:
                return "_api/note/notes_list"
        case .deleteNote:
            return "_api/note/delete_note"
        case .addNote:
            return "_api/note/create_note"
        case .getViewNote(let idNote):
            return "_api/note/get_view_note/\(idNote)"
        case .editNote:
            return "_api/note/edit_note"
        case .deleteListGrammar:
            return "_api/like/delete_like"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListLikesVocab:
            return .post
        case .getListGrammar:
            return .post
        case .getListNote:
            return .post
        case .deleteNote:
            return .post
        case .addNote:
            return .post
        case .getViewNote:
            return .get
        case .editNote:
            return .post
        case .deleteListGrammar:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListLikesVocab(let offset):
            return ["offset":offset,"limit":limit]
        case .getListGrammar(let offset):
            return ["offset": offset,"limit": limit]
        case .getListNote(let offset):
            return ["offset" : offset,"limit":limit]
        case .deleteNote(let id):
            return ["note_ids": id]
        case .addNote(let desctiption):
            return ["description": desctiption]
        case .getViewNote:
            return ["" : ""]
        case .editNote(let idNote, let description):
            return ["note_id": idNote,
                    "description": description]
        case .deleteListGrammar(let likeList):
            return ["like_ids": likeList]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
