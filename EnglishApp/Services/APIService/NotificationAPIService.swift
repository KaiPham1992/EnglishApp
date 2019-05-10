//
//  NotificationAPIService.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

protocol NotificationAPIServiceProtocol {
    func getNotification(offset: Int, limit: Int?, success: @escaping SuccessHandler<ParentNotificationEntity>.object, failure: @escaping RequestFailure)
    func readNotification(notificationId: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
    
}

extension NotificationAPIServiceProtocol {
    func getNotification(offset: Int, limit: Int? = nil, success: @escaping SuccessHandler<ParentNotificationEntity>.object, failure: @escaping RequestFailure) {
        return getNotification(offset: offset, limit: limit, success: success, failure: failure)
    }
}

class NotificationAPIService: NotificationAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getNotification(offset: Int, limit: Int? = nil, success: @escaping SuccessHandler<ParentNotificationEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = NotificationEndPoint.getNotification(offset: offset, limit: limit)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func readNotification(notificationId: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = NotificationEndPoint.readNotification(notificationId: notificationId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
        
    }
}
