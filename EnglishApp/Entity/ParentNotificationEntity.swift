//
//  ParentNotificationEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//


import ObjectMapper

class ParentNotificationEntity: BaseEntity {
    var totalUnread: Int?
    var notifications = [NotificationEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.totalUnread <- map["total_unread"]
        self.notifications <- map["data_notification"]
    }
}

