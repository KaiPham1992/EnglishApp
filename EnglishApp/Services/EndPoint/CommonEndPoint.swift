//
//  CommonEndPoint.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Alamofire

enum CommonEndPoint {
    case uploadImages(image: UIImage)
    case getNationals
    case changeLanguageCode
}

extension CommonEndPoint: EndPointType {
    var path: String {
        
        switch self {
        case .uploadImages:
            return "_api/common/upload_tmp_img"
        case .getNationals:
            return "_api/nation/get_list_nation"
        case .changeLanguageCode:
            return "_api/user/change_language_code"
        default:
            break
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        return [:]
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
