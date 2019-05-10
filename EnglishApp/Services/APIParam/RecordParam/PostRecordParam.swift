//
//  PostRecordParam.swift
//  Oganban
//
//  Created by Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class PostRecordParam: BaseParam {
    var categoryId  : String?
    var name        : String?
    var imgSrc        = [String]()
    var quantity  : String?
    var expireDate      : String? //"2019-02-16"
    var aboutRecord      : String?
    
    var address1      : String?
    var long1      : String?
    var lat1      : String?
    
    var address2      : String?
    var long2      : String?
    var lat2      : String?
    
    var long      : String?
    var lat      : String?
    var price: String?
    var coin: String?
    var isGpsCurrent: Int?
    var isActivePhone: Int?
    var isActiveZalo: Int?
    var isActiveFacebook: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.categoryId     <- map["category_id"]
        self.name           <- map["name"]
        self.imgSrc            <- map["img_src"]
        self.quantity         <- map["quantity"]
        self.expireDate        <- map["expired_date"]
        self.aboutRecord         <- map["about_record"]
        
//        self.lat         <- map["latitude"]
//        self.long          <- map["longitude"]
        
        self.lat2         <- map["latitude_2"]
        self.long2          <- map["longitude_2"]
        
        self.lat1         <- map["latitude_1"]
        self.long1          <- map["longitude_1"]
        
        self.address2         <- map["address_2"]
        self.address1          <- map["address_1"]
        self.price         <- map["price"]
        self.coin          <- map["coin"]
        self.isGpsCurrent <- map["is_gps_current"]
        self.isActivePhone <- map["is_active_phone"]
        self.isActiveZalo <- map["is_active_zalo"]
        self.isActiveFacebook <- map["is_active_facebook"]
    }
    
    convenience init(categoryId  : String, name: String, imgSrc: [String], quantity: String, expireDate: String, aboutRecord: String) {
        self.init()
        self.categoryId = categoryId
        self.name = name
        self.imgSrc = imgSrc
        self.quantity = quantity
        self.expireDate = expireDate
        self.aboutRecord = aboutRecord
    }
    
    func updateInfoStepTwo(address1: String, lat1: String, long1: String, address2: String, lat2: String, long2: String, isLatlong: Bool, price: String, coin: String, isGpsCurrent: Int, isActivePhone: Int, isActiveZalo: Int, isActiveFacebook: Int) {
        self.address1 = address1
        self.lat1 = lat1
        self.lat2 = lat2
        self.long1 = long1
        self.long2 = long2
        
        self.address2 = address2
        
        self.price = price
        self.coin = coin
//        if isLatlong {
//            self.lat = UserDefaultHelper.shared.lat
//            self.long = UserDefaultHelper.shared.long
//        }
        self.isGpsCurrent = isGpsCurrent
        self.isActivePhone = isActivePhone
        self.isActiveZalo = isActiveZalo
        self.isActiveFacebook = isActiveFacebook
    }
}
