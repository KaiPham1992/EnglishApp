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
    var customTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.isScrollEnabled = false
        displayData()
        print("Product ID: \(product.id&)")
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
            if let url = URL(string: BASE_URL + "_api/webview/product_detail/\(id)") {
                webView.loadRequest(URLRequest(url: url))
            }
            setTitleNavigation(title: customTitle)
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

