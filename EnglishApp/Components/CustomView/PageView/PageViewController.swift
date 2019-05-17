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
        self.settings.style.buttonBarItemFont = AppFont.fontRegular12
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
        let lb = UILabel()
        lb.text             = title
        lb.textAlignment    = .center
        lb.numberOfLines    = 2
        lb.textColor        = textColor
        lb.sizeToFit()
        
        let vTest = UIView()
        vTest.isUserInteractionEnabled = true
        vTest.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        vTest.addSubview(lb)
        lb.centerSuperview()
        lb.font = AppFont.fontRegular18
        lb.textColor = UIColor.white
        let tap = UITapGestureRecognizer(target: self, action: action)
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(tap)
        self.navigationItem.titleView = vTest
    }
}
