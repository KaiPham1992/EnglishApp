//
//  ShareNativeHelper.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/8/19.
//  Copyright © 2019 demo. All rights reserved.
//


import UIKit

class ShareNativeHelper: NSObject {
    static let shared = ShareNativeHelper()
    
    let linkShare = "http://onelink.to/k77kce"
    
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
    
    func showShareLinkInstall() {
        showShare(items: [])
    }
}

