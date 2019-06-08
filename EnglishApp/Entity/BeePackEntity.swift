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
    var money: String?
    var image: UIImage?
    
    convenience init(money: String, image: UIImage) {
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
        listHistory.append(BeePackEntity(money: "10.000 VND\n1 hũ mật ong", image: AppImage.img099))
        listHistory.append(BeePackEntity(money: "100.000 VND\n10 hũ mật ong", image: AppImage.img199))
        listHistory.append(BeePackEntity(money: "1.000.000 VND\n100 hũ mật ong", image: AppImage.img999))
        listHistory.append(BeePackEntity(money: "2.000.000 VND\n200 hũ mật ong", image: AppImage.img4999))
        listHistory.append(BeePackEntity(money: "5.000.000 VND\n500 hũ mật ong", image: AppImage.img9999))
        
        return listHistory
    }
}
