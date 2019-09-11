//
//  NotificationEndPoint.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Alamofire

enum NotificationEndPoint {
    case getNotification(offset: Int)
    case readNotification(notificationId: Int)
    case getNotificationDetail(id: Int)
}

extension NotificationEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getNotification:
            return "_api/notification/get_notification_list"
        case .readNotification:
            return "_api/notification/read_notifications"
        case .getNotificationDetail:
            return "_api/notification/notification_detail"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getNotification(let offset):
            return ["offset": "\(offset)", "limit": limit]
        case .readNotification(let id):
            return ["notification_ids": [id]]
        case .getNotificationDetail(let id):
            return ["notification_id": id]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
