//
//  WebViewController.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/4/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
    func goBack()
}

class WebViewController: BaseViewController {
    
    @IBOutlet weak var lblContent: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        loadData()
    }
    
    private func loadData() {
        ProgressView.shared.show()
        Provider.shared.homeAPIService.getTermAndCondition(success: { (response) in
            ProgressView.shared.hide()
            if let _response = response {
                self.lblContent.attributedText = NSAttributedString(string: _response.content?.htmlToString ?? "")
            }
        }) { (error) in
            ProgressView.shared.show()
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        tabBarController?.tabBar.isHidden = true
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.privacyAndPolicy.showLanguage)
    }
}
