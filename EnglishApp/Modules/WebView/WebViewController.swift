//
//  WebViewController.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/4/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit
//import WebKit

protocol WebViewControllerDelegate: class {
    func goBack()
}

class WebViewController: BaseViewController {
    
    @IBOutlet weak var wkMain: UIWebView!
    var policyUrl = ""
    var termUrl = "_admin/terms/listing"
    var isTermsOfUse = true
    var isPush = true
    var mainUrl = ""
    
    weak var delegate: WebViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
//        wkMain.navigationDelegate = self
        self.loadWeb()
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        tabBarController?.tabBar.isHidden = true
        addButtonToNavigation(image: AppImage.imgBack, style: .left, action: #selector(self.tapBackButton))
        setTitleNavigation(title: LocalizableKey.privacyAndPolicy.showLanguage)
    }
    
    @objc func tapBackButton(){
        if isPush {
            self.pop(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    private func loadWeb() {
        if mainUrl.contains("http") {
            if let url = URL(string: mainUrl) {
                let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
                wkMain.loadRequest(urlRequest)
            }
        } else {
            if isTermsOfUse {
                mainUrl = BASE_URL + termUrl
            } else {
                mainUrl = BASE_URL + policyUrl
            }
            if let url = URL(string: mainUrl) {
//                let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
//                wkMain.loadRequest(urlRequest)
            }
        }
    }
}
