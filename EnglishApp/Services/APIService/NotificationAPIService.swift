//
//  NotificationAPIService.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

protocol NotificationAPIServiceProtocol {
    func getNotification(offset: Int, success: @escaping SuccessHandler<ParentNotificationEntity>.object, failure: @escaping RequestFailure)
    func readNotification(notificationId: Int, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
    
}

class NotificationAPIService: NotificationAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getNotification(offset: Int, success: @escaping SuccessHandler<ParentNotificationEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = NotificationEndPoint.getNotification(offset: offset)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func readNotification(notificationId: Int, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = NotificationEndPoint.readNotification(notificationId: notificationId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
        
    }
}
