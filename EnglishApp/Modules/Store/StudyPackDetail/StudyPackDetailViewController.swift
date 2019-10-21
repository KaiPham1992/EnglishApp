//
//  StudyPackDetailViewController.swift
//  EnglishApp
//
//  Created by Henry on 7/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import WebKit

class StudyPackDetailViewController: BaseViewController, StudyPackDetailViewProtocol {
    
    var presenter: StudyPackDetailPresenterProtocol?
    @IBOutlet weak var btnUpgrade: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnRestore: UIButton!
    
    var product = ProductEntity()
    var id : String = "0"
    
    var font = """
    <style>
    @font-face
    {
        font-family: 'Comfortaa';
        font-weight: normal;
        src: url(Comfortaa-Regular.ttf);
    }
    @font-face
    {
        font-family: 'Comfortaa';
        font-weight: bold;
        src: url(Comfortaa-Bold.ttf);
    }
    </style>
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        print("Product ID: \(product.id&)")
        webView.navigationDelegate = self
    }
    
    private func loadData(completion: @escaping((_ name: String, _ product: ProductEntity) -> ())){
        ProgressView.shared.show()
        Provider.shared.productAPIService.getListProduct(fromDoEntrance: false, point: 0, success: { collectionProduct in
            guard let product = collectionProduct?.groupUpgrade else { return }
            if self.id == "-1" {
                for item in product {
                    if item.name == "Premium" {
                        completion(item.name ?? "", item)
                        break
                    }
                }
            } else {
                for item in product {
                    if item.id == self.id {
                        completion(item.name ?? "", item)
                        break
                    }
                }
            }
        }) { _ in
        }
    }
    
    @IBAction func btnUpgradeTapped() {
        guard let id = product.id , var inAppPurchase = product.in_app_product_id else {
            return
        }
        
        if inAppPurchase == "product_obee_16" {
            inAppPurchase = "product_obee_17"
        }
        ProgressView.shared.show()
        PaymentHelper.shared.purcharseProduct(inAppPurchase, completionPurchased: { transactionIdAny in
            ProgressView.shared.hide()
            guard let transactionId = transactionIdAny as? String else { return }
            
            self.presenter?.upgradeProduct(productID: id, transactionId: transactionId)
        }, purchaseFailed: {
            ProgressView.shared.hide()
        })
    }
    
    @IBAction func btnRestoreTapped() {
        guard var inAppPurchase = product.in_app_product_id else {
            return
        }
        if inAppPurchase == "product_obee_16" {
            inAppPurchase = "product_obee_17"
        }
        
        PaymentHelper.shared.restoreProduct(productId: inAppPurchase) { transaction in
            guard let transactions = transaction as? [TransactionParam] else { return }
            guard let userId = UserDefaultHelper.shared.loginUserInfo?.id else { return }
            
            print(transactions.toJSON())
            let restoreParma = RestoreParam(userId: userId, transactions: transactions)
            self.presenter?.restore(restoreParam: restoreParma)
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
    }
    
    func displayData(){
        if id != "0" {
            self.loadData { (title, product) in
                self.product = product
                self.setTitleNavigation(title: product.name ?? "")
                self.webView.loadHTMLString(product.content ?? "", baseURL: Bundle.main.bundleURL)
                let htmlString = self.font + #"<span style="font-family: 'Comfortaa'; font-weight: Regular; font-size: 18; color: black; text-align: justify">"# + (product.content ?? "") + #"</span>"#
                ProgressView.shared.hide()
            }
            
        } else {
            if let htmlString = product.content{
                let _htmlString = self.font + #"<span style="font-family: 'Comfortaa'; font-weight: Regular; font-size: 18; color: black; text-align: justify">"# + htmlString + #"</span>"#
                webView.loadHTMLString(_htmlString, baseURL: Bundle.main.bundleURL)
            }
            setTitleNavigation(title: product.name ?? "")
        }
        btnUpgrade.setTitle(LocalizableKey.upgrade.showLanguage, for: .normal)
        btnRestore.setTitle(LocalizableKey.restorePurchase.showLanguage.uppercased(), for: .normal)
    }
    
    func didUpgrade(info: UpgradeInfoEntity) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateProfile"), object: nil)
        PopUpHelper.shared.showError(message: "\(LocalizableKey.upgradeSuccess.showLanguage)") {
            //
        }
    }
    
    func didUpgrade(error: Error) {
        PopUpHelper.shared.showError(message: "\(LocalizableKey.getError.showLanguage)") {
            //
        }
    }
}

extension StudyPackDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        webView.evaluateJavaScript(jscript)
    }
}


