//
//  NotificationDetailViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import WebKit

class NotificationDetailViewController: BaseViewController, NotificationDetailViewProtocol {

	var presenter: NotificationDetailPresenterProtocol?
    
    @IBOutlet weak var webView: WKWebView!
    
    var idNotification: Int = 0
    var isRead = true

	override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        ProgressView.shared.show()
        webView.load(URLRequest(url: URL(string: BASE_URL + "_api/webview/notification_detail/\(idNotification)")!))
        if !isRead {
            self.presenter?.readNotification(id: idNotification)
        }
    }

    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleNotificationDetail.showLanguage)
    }
    
    override func setTitleUI() {
        super.setTitleUI()
    }
}

extension NotificationDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressView.shared.hide()
    }
}
