//
//  PaymentViewModel.swift
//  EnglishApp
//
//  Created by KaiPham on 8/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import StoreKit

class PaymentHelper: NSObject {
    var validProducts: [SKProduct] = []
    let productIds = ["product_obee_11", "product_obee_12", "product_obee_13", "product_obee_14", "product_obee_15"]
    var productsRequest: SKProductsRequest?
    
    static let shared = PaymentHelper()
    var completionPurchased: CompletionClosure?
    var purchaseFailed: CompletionClosure?
    
    func fetchAvailableProducts() { //1
        let productIdentifiers = Set(productIds)
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func purcharseProduct(_ productId: String, completionPurchased: CompletionClosure?, purchaseFailed: CompletionClosure?) { //2
        guard canMakePurchases(), validProducts.count > 0 else {
            
            return
        }

        guard let skProduct = validProducts.filter({ $0.productIdentifier == productId }).first else {
            return
        }
        self.completionPurchased = completionPurchased
        self.purchaseFailed = purchaseFailed
        let payment = SKPayment(product: skProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    
}

extension PaymentHelper: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        validProducts = response.products
        for product in validProducts {
            print("product id \(product.productIdentifier) price : \(product.price)")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Purchasing")
            case .purchased:
                print("purchased")
//                savePaymentInfo()
                self.completionPurchased?()
                
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("restored")
            case .failed:
                self.purchaseFailed?()
                if let transactionError = transaction.error as NSError?,
                    let localizedDescription = transaction.error?.localizedDescription,
                    transactionError.code != SKError.paymentCancelled.rawValue {
                    print("Transaction Error: \(localizedDescription)")
                }
                print("failed")
            case .deferred:
                break
            }
            
        }
    }
    
    private func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    
    
}
