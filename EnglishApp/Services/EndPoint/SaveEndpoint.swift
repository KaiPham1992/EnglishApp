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
}

extension SaveEndpoint : EndPointType {
    var path: String {
        switch self {
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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
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
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
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
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
