//
//  PageViewController.swift
//  EnglishApp
//
//  Created by vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class PageViewController : ButtonBarPagerTabStripViewController{
    override func viewDidLoad() {
        self.setupPage()
        super.viewDidLoad()
        setNavigationColor()
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    func setupPage(){
        self.settings.style.buttonBarBackgroundColor = .white
        self.settings.style.buttonBarItemBackgroundColor = .white
        self.settings.style.selectedBarBackgroundColor = AppColor.yellow
        self.settings.style.buttonBarItemFont = AppFont.fontRegular14
        self.settings.style.buttonBarHeight = 48
        self.settings.style.selectedBarHeight = 2
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = .white
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 0
        self.settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = {(_ oldCell: ButtonBarViewCell?, _ newCell: ButtonBarViewCell?, _ progressPercentage: CGFloat, _ changeCurrentIndex: Bool, _ animated: Bool) -> Void in
            guard changeCurrentIndex == true else {return}
            oldCell?.label.textColor  = AppColor.gray999999
            newCell?.label.textColor = AppColor.yellow
        }
    }
    
//    func gotoIndex(index: Int) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.02) {
//            if index < self.viewControllers.count {
//                self.moveToViewController(at: index)
//            }
//        }
//    }
    
    func addBackToNavigation(icon: UIImage = UIImage(named: "Material_Icons_white_chevron_left")! ) {
        addButtonImageToNavigation(image: icon, style: .left, action: #selector(btnBackTapped))
    }
    
    @objc func btnBackTapped() {
        self.pop()
    }
    
    func addButtonImageToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        showNavigation()
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let newAction = action {
            btn.addTarget(self, action: newAction, for: .touchUpInside)
        }
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        btn.imageView?.contentMode = .scaleAspectFit
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 20)
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 0)
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func setNavigationColor(color: UIColor = AppColor.yellow) {
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func setTitleNavigation(title: String, textColor: UIColor = UIColor.white, action: Selector? = nil ) {
        
        showNavigation()
        let vTitle = TitleNavigationBar()
        vTitle.lbTitle.text = title
        vTitle.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        self.navigationItem.titleView = vTitle
        
    }
    
    func addButtonTextToNavigation(title: String, style: StyleNavigation, action: Selector?, textColor: UIColor = AppColor.rightNavigation, font : UIFont = UIFont.systemFont(ofSize: 17)) {
        
        showNavigation()
        let btn = UIButton()
        
        var newTitle = title
        if style == .right {
            newTitle = title
        }
        
        btn.setAttributed(title: newTitle, color: textColor, font: font)
        
        btn.setTitleColor(textColor, for: .normal)
        if let newAction = action {
            btn.addTarget(self, action: newAction, for: .touchUpInside)
        }
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
}
