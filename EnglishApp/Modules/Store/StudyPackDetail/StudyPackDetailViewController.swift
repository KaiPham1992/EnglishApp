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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.isScrollEnabled = false
        displayData()
        print("Product ID: \(product.id&)")
    }

    @IBAction func btnUpgradeTapped(){
        guard let id = Int(product.id&) else {
            return
        }
        presenter?.upgradeProduct(productID: id)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: product.name ?? "")
    }
    
    func displayData(){
        if let htmlString = product.content{
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
        btnUpgrade.setTitle(LocalizableKey.upgrade.showLanguage, for: .normal)
    }
    
    func didUpgrade(info: UpgradeInfoEntity) {
        PopUpHelper.shared.showError(message: "Nâng cấp gói thành công") {
            //
        }
    }
    
    func didUpgrade(error: Error) {
        print(error.localizedDescription)
    }
}

