//
//  NotificationEndPoint.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Alamofire

enum NotificationEndPoint {
    case getNotification(offset: Int, limit: Int?)
    case readNotification(notificationId: String)
}

extension NotificationEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getNotification:
            return "_api/notification/get_notification_list"
        case .readNotification:
            return "_api/notification/read_notifications"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getNotification(let offset, let limit):
            if let _ = limit {
                return ["offset": "\(offset)", "limit": ""]
            } else {
                return ["offset": "\(offset)", "limit": "\(limitLoad)"]
            }
        case .readNotification(let id):
            return ["notification_ids":"\(id)"]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
