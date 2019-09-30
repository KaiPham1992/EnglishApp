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
    
    @IBOutlet weak var webView: WKWebView!
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
    
    override func setUpViews() {
        super.setUpViews()
        loadData()
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }
    
    private func loadData() {
        ProgressView.shared.show()
        Provider.shared.homeAPIService.getTermAndCondition(success: { (response) in
            ProgressView.shared.hide()
            if let _response = response {
                self.hideNoData()
                let htmlString = self.font + #"<span style="font-family: 'Comfortaa'; font-weight: Regular; font-size: 14; color: black">"# + (_response.content ?? "") + #"</span>"#
                self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
            } else {
                self.showNoData()
            }
        }) { (error) in
            ProgressView.shared.hide()
            self.showNoData()
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.privacyAndPolicy.showLanguage)
    }
}

extension WebViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        webView.evaluateJavaScript(jscript)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.frame.size.height = 1
        webView.frame.size = webView.scrollView.contentSize
    }
}
