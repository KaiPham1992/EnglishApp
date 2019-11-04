//
//  ShareNativeHelper.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/8/19.
//  Copyright © 2019 demo. All rights reserved.
//


import UIKit
import FBSDKShareKit

class ShareNativeHelper: NSObject {
    static let shared = ShareNativeHelper()
    
    let linkShare = "http://onelink.to/2t5hcp"
    
    func showShare(items: [String]) {
        guard let controller = UIApplication.topViewController() else { return }
        var share = ""
        if !items.isEmpty {
            share = "\(items[0])\n\(linkShare)"
        } else {
            share = "\(linkShare)"
        }
        let activityController = UIActivityViewController(activityItems: [share], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = controller.view
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completion")
            } else {
                print(error.debugDescription&)
            }
        }
        controller.present(controller: activityController)
    }
    
    func showShareLinkInstall(quote: String = "") {
//        showShare(items: [])
        showShareFacebook(quote: quote)
    }
    
    func showShareFacebook(quote: String = "") {
        guard let controller = UIApplication.topViewController() else { return }
        let content : ShareLinkContent = ShareLinkContent()
        if let url = URL(string: linkShare) {
            content.contentURL = url
        }
        content.quote = quote
        let shareDialog = ShareDialog(fromViewController: controller, content: content, delegate: self)
        shareDialog.mode = .native
        shareDialog.show()
    }
}

extension ShareNativeHelper : SharingDelegate {
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
//         PopUpHelper.shared.showError(message: "Share thành công.", completionYes: nil)
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        PopUpHelper.shared.showError(message: "Bạn cần cài Facebook để thực hiện tính năng này.", completionYes: nil)
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        
    }
}
