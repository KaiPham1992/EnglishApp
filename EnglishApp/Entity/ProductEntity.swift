//
//  ProductEntity.swift
//  EnglishApp
//
//  Created by KaiPham on 6/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class ProductCollectionEntity: BaseEntity {
    var groupUpgrade = [ProductEntity]()
    var groupHoney = [ProductEntity]()
    var groupGift = [ProductEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.groupUpgrade <- map["group_upgrade"]
        self.groupHoney <- map["group_honey"]
        self.groupGift <- map["group_gift"]
    }
}



class ProductEntity: BaseEntity {
   
    var id: String?
    var name: String?
    var content: String?
    var type: String?
    var logo: String?
    var cropLogo: String?
    var durationAmount: String?
    var durationUnit: String?
    var amountHoney: String?
    var createDate: Date?
    var nationId: String?
    var amountDiamond: String?
    var amountMoney: Double?
    var color: String?
    var isBought: Bool?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.createDate <- (map["created_time_mi"], AppTimestampTransform())
        self.name <- map["name"]
        self.type <- map["type"]
        self.content <- map["description"]
        self.logo <- map["logo"]
        self.cropLogo <- map["crop_logo"]
        self.durationAmount <- map["duration_amount"]
        self.durationUnit <- map["duration_unit"]
        self.amountDiamond <- map["amount_diamond"]
//        self.amountHoney <- (map["amount_honey"], StringToDoubleTransform())
        self.amountHoney <- map["amount_honey"]
        self.nationId <- map["nation_id"]
        self.amountMoney <- (map["amount_money"], StringToDoubleTransform())
        self.color <- map["color"]
        self.isBought <- map["is_bought"]
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.logo, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        }
        
        return nil
    }
    
    var money: String?{
        if let money = self.amountMoney{
            let newMoney = convertToCurrency(number: money)
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            if let _money = formatter.string(from: Int(moneyString)! as NSNumber) {
//                return _money
//            }
            return newMoney.description.replacingOccurrences(of: ".", with: ",")
//            return moneyString.description
        }
        return ""
        
    }
    
    func convertToCurrency(number: Double) -> String{
        let myDouble = number
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        let priceString = currencyFormatter.string(from: NSNumber(value: myDouble))!
        return priceString
    }
    
}

class UpgradeInfoEntity: BaseEntity {
    var id : String?
    var code : String?
    var user_id : String?
    var created_date : String?
    var created_time_mi : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.code <- map["code"]
        self.user_id <- map["user_id"]
        self.created_date <- map["created_date"]
        self.created_time_mi <- map["created_time_mi"]
    }
}
