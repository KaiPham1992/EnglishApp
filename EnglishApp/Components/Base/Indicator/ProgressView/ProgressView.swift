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
    
    let background : UIView = {
        let v = UIView()
//        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform = view.transform.scaledBy(x: 1.8, y: 1.8)
        return view
    }()
    
    private var imageLoadingCompetition : UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "img_ong_lam_bai"))
        image.backgroundColor = .white
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var time : Timer?
    private var number = 0
    
    public static let shared = ProgressView()
    
    private func show(_ view: UIView) {
        view.addSubview(background)
        background.fillSuperview()
        view.addSubview(vcontainer)
        vcontainer.centerSuperview()
        vcontainer.anchor(widthConstant: 80, heightConstant: 80)
        vcontainer.setBorder(borderWidth: 1, borderColor: .clear, cornerRadius: 10)
        //---
        vcontainer.addSubview(vIndicator)
        vIndicator.anchor(widthConstant: 60, heightConstant: 60)
        vIndicator.centerSuperview()
        vIndicator.startAnimating()
        self.time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.processTimer()
        })
    }
    
    private func showFullScreen(_ view: UIView) {
        view.addSubview(vcontainer)
        vcontainer.fillSuperview()
        vcontainer.backgroundColor =  UIColor.black.withAlphaComponent(0.2)
        vcontainer.setBorder(borderWidth: 1, borderColor: .clear, cornerRadius: 0)
        
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
    
    private func processTimer() {
        self.number += 1
        if self.number > 60 {
            if self.time != nil {
                self.time?.invalidate()
                self.time = nil
            }
        }
    }
    
    func showLoadingCompetition(){
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else  { return }
            self.showFillSuperView(view: window)
        }
    }
    
    open func showFullScreen() {
        DispatchQueue.main.async {
            let topViewController = UIApplication.topViewController() as? BaseViewController
            topViewController?.setColorStatusBar(color: .clear)
            topViewController?.setNeedsStatusBarAppearanceUpdate()
            guard let window = UIApplication.shared.keyWindow else  { return }
            self.showFullScreen(window)
        }
    }
    
    func showFillSuperView(view: UIView){
        view.addSubview(imageLoadingCompetition)
        imageLoadingCompetition.fillSuperview()
        self.time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.processTimer()
        })
    }
    
    func hideLoadingCompetition(){
        self.hide()
        DispatchQueue.main.async {
            self.imageLoadingCompetition.removeFromSuperview()
        }
        
    }
    
    func showProgressOnWindow() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else  { return }
            self.show(window)
        }
    }
    
    private func disableTimer() {
        if self.time != nil {
            self.time?.invalidate()
            self.time = nil
        }
    }
    
    open func hide() {
        self.disableTimer()
        DispatchQueue.main.async {
            let topViewController = UIApplication.topViewController() as? BaseViewController
            topViewController?.setColorStatusBar(color: AppColor.yellow)
            topViewController?.setNeedsStatusBarAppearanceUpdate()
            self.vcontainer.removeFromSuperview()
            self.vIndicator.removeFromSuperview()
            self.background.removeFromSuperview()
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
