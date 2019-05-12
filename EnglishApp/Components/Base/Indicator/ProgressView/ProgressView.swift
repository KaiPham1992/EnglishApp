//
//  ProgressView.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/2/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit


open class ProgressView {
    let vcontainer: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        return v
    }()
    
    let vIndicator: KActivityIndicatorView = {
        let view = KActivityIndicatorView(type: KActivityIndicatorType.ballClipRotateMultiple)
        
        return view
    }()
    
    
    public static let shared = ProgressView()
    
    private func show(_ view: UIView) {
        
        view.addSubview(vcontainer)
        vcontainer.centerSuperview()
        vcontainer.anchor(widthConstant: 80, heightConstant: 80)
        vcontainer.setBorder(borderWidth: 1, borderColor: .clear, cornerRadius: 10)
        //---
        vcontainer.addSubview(vIndicator)
        vIndicator.anchor(widthConstant: 60, heightConstant: 60)
        vIndicator.centerSuperview()
        vIndicator.startAnimating()
    }
    
    open func show() {
       
        DispatchQueue.main.async {
            guard let view = UIApplication.topViewController()?.view else { return }
            self.show(view)
        }
    }
    
    func showProgressOnWindow() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else  { return }
            self.show(window)
        }
    }
    
    open func hide() {
        DispatchQueue.main.async {
            self.vcontainer.removeFromSuperview()
            self.vIndicator.removeFromSuperview()
        }
        
    }
}


extension UIApplication {
    
    static var rootVC: UINavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
