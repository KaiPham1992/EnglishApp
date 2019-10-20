//
//  RestoreParam.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class RestoreParam: BaseParam {
    var userId: String?
    var transactions = [TransactionParam]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.userId <- map["user_id"]
        self.transactions <- map["transactions"]
    }
    
    init(userId: String, transactions: [TransactionParam]) {
        super.init()
        self.userId = userId
        self.transactions = transactions
        
//        self.transactions.append(TransactionParam(transactionId: "BCBBD9B6C-FD0B-4926-9F7C-72146342E64F", productPurchaseId: "product_obee_16", transactionDate: "30/09/2019"))
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

class TransactionParam: BaseParam {
    var transaction_id: String?
    var product_purchase_id: String?
    var transaction_date: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.transaction_date <- map["transaction_date"]
        self.transaction_id <- map["transaction_id"]
        self.product_purchase_id <- map["product_purchase_id"]
    }
    
    init(transactionId: String, productPurchaseId: String, transactionDate: String) {
        super.init()
        self.transaction_id = transactionId
        self.product_purchase_id = productPurchaseId
        self.transaction_date = transactionDate
        
        if productPurchaseId == "product_obee_17" {
            self.product_purchase_id = "product_obee_16"
        }
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
