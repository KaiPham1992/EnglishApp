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
    let productIds = ["product_obee_12", "product_obee_13", "product_obee_14", "product_obee_15", "product_obee_16", "product_obee_17", "Test_Premium", "Test_Premium1"]
    var productsRequest: SKProductsRequest?
    
    static let shared = PaymentHelper()
    var completionPurchased: CompletionAny?
    var purchaseFailed: CompletionClosure?
    
    var completionRestored: CompletionAny?
    
    func fetchAvailableProducts() { //1
        let productIdentifiers = Set(productIds)
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func restoreProduct(productId: String, completionRestored: CompletionAny?) {
        self.completionRestored = completionRestored
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func purcharseProduct(_ productId: String, completionPurchased: CompletionAny?, purchaseFailed: CompletionClosure?) { //2
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
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        var transactionParams = [TransactionParam]()
        
        for transaction in queue.transactions {
//            let t: SKPaymentTransaction = transaction
//            let prodID = t.payment.productIdentifier as String
//
//            print("***********************: \(prodID)")
////            queue.finishTransaction(transaction)
            
            let transactionDate = transaction.transactionDate?.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
            let transactionId = transaction.transactionIdentifier&
            let productPurchaseId = transaction.payment.productIdentifier
            
            let newTransaction = TransactionParam(transactionId: transactionId, productPurchaseId: productPurchaseId, transactionDate: transactionDate&)
            
            transactionParams.append(newTransaction)
        }
        
        completionRestored?(transactionParams)
       
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Purchasing")
            case .purchased:
                print("purchased")
//                savePaymentInfo()
                
                self.completionPurchased?(transaction.transactionIdentifier&)
                
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
//                self.completionRestored?(<#Any?#>)
                SKPaymentQueue.default().finishTransaction(transaction)
                
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
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    
    
}
