//
//  StudyPackDetailViewController.swift
//  EnglishApp
//
//  Created by Henry on 7/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class StudyPackDetailViewController: BaseViewController, StudyPackDetailViewProtocol {

    var presenter: StudyPackDetailPresenterProtocol?
    @IBOutlet weak var btnUpgrade: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    var product = ProductEntity()
    var id : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        print("Product ID: \(product.id&)")
    }

    private func loadData(completion: @escaping((_ name: String, _ product: ProductEntity) -> ())){
        ProgressView.shared.show()
        Provider.shared.productAPIService.getListProduct(success: { collectionProduct in
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
    
    @IBAction func btnUpgradeTapped(){
        guard let id = product.id else {
            return
        }
        ProgressView.shared.show()
        PaymentHelper.shared.purcharseProduct("product_test_03", completionPurchased: {
            ProgressView.shared.hide()
            self.presenter?.upgradeProduct(productID: id)
        }, purchaseFailed: {
            ProgressView.shared.hide()
        })
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
    }
    
    func displayData(){
        if id != "0" {
            self.loadData { (title, product) in
                self.setTitleNavigation(title: product.name ?? "")
                self.webView.loadHTMLString(product.content ?? "", baseURL: nil)
                ProgressView.shared.hide()
            }
            
        } else {
            if let htmlString = product.content{
                webView.loadHTMLString(htmlString, baseURL: nil)
            }
            setTitleNavigation(title: product.name ?? "")
        }
        btnUpgrade.setTitle(LocalizableKey.upgrade.showLanguage, for: .normal)
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

