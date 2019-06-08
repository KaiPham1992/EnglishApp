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
    var background: UIImage?
    
    convenience init(money: String, image: UIImage, background: UIImage) {
        self.init()
        self.money = money
        self.image = image
        self.background = background
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
    }
    
    class func toArray() -> [BeePackEntity] {
        var listHistory = [BeePackEntity]()
        listHistory.append(BeePackEntity(money: "10.000 VND\n1 hũ mật ong", image: AppImage.imgIcon10k, background: AppImage.img10k))
        listHistory.append(BeePackEntity(money: "100.000 VND\n10 hũ mật ong", image: AppImage.imgIcon100k, background: AppImage.img100k))
        listHistory.append(BeePackEntity(money: "1.000.000 VND\n100 hũ mật ong", image: AppImage.imgIcon1Tr, background: AppImage.img1tr))
        listHistory.append(BeePackEntity(money: "2.000.000 VND\n200 hũ mật ong", image: AppImage.imgIcon2Tr, background: AppImage.img2tr))
        listHistory.append(BeePackEntity(money: "5.000.000 VND\n500 hũ mật ong", image: AppImage.imgIcon5Tr, background: AppImage.img5tr))
        
        return listHistory
    }
}
