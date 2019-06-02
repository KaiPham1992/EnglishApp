//
//  BeePackEntity.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//
import Foundation
import ObjectMapper

class BeePackEntity: BaseEntity {
    var id: String?
    var money: CGFloat?
    var image: UIImage?
    
    convenience init(money: CGFloat, image: UIImage) {
        self.init()
        self.money = money
        self.image = image
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
    }
    
    class func toArray() -> [BeePackEntity] {
        var listHistory = [BeePackEntity]()
        listHistory.append(BeePackEntity(money: 0.99, image: AppImage.img099))
        listHistory.append(BeePackEntity(money: 1.99, image: AppImage.img199))
        listHistory.append(BeePackEntity(money: 9.99, image: AppImage.img999))
        listHistory.append(BeePackEntity(money: 49.99, image: AppImage.img4999))
        listHistory.append(BeePackEntity(money: 99.99, image: AppImage.img9999))
        
        return listHistory
    }
}
