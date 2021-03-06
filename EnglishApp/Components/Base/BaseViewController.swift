//
//  BaseViewController.swift
//  Ipos
//
//  Created by Kai Pham on 4/18/19.
//  Copyright © 2019 edward. All rights reserved.
//
import UIKit

enum StyleNavigation {
    case left
    case right
}

class BaseViewController: UIViewController {
    
    let mainBackgroundColor = UIColor.white
    let mainNavigationBarColor = UIColor.white
    
    lazy var btnRight : UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //store.subscribe(self)
        setUpNavigation()
        setUpViews()
    }
    
    func setUpViews() {}
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    func setUpNavigation() {
        self.view.backgroundColor = UIColor.white
        guard let navigationController = self.navigationController else { return }
        //---
        navigationController.navigationBar.barTintColor = mainNavigationBarColor
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func transparentNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
    func hideBackButton(){
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    func showBlackNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setTitleView(titleView: UIView) {
        titleView.frame = CGRect(x: 0, y: 0, width: 1000, height: 49)
        self.navigationItem.titleView = titleView
        self.navigationItem.hidesBackButton = true
    }
    
//    func setColorStatusBar(color: UIColor = AppColor.red) {
//        Utils.setColorStatusBar(color: color)
//    }
    
    func pushUpFromBottomView(controller: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(controller, animated: false)
    }
    func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
}

// MARK: Add button left, right, title
extension BaseViewController {
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        showNavigation()
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let newAction = action {
            btn.addTarget(self, action: newAction, for: .touchUpInside)
        }
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func addButtonToNavigation(title: String, style: StyleNavigation, action: Selector?, backgroundColor: UIColor = UIColor.white, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 17), cornerRadius: CGFloat = 0, size: CGSize = CGSize(width: 20, height: 10)) -> UIButton{
        
        showNavigation()
        if let newAction = action {
            btnRight.addTarget(self, action: newAction, for: .touchUpInside)
        }
        btnRight.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnRight.layer.cornerRadius = cornerRadius
        btnRight.backgroundColor = backgroundColor
        btnRight.contentHorizontalAlignment = .center
        //        btnRight.setAttributed(title: title, color: textColor, font: font)
        btnRight.setTitleColor(textColor, for: .normal)
        btnRight.setTitle(title, for: .normal)
        btnRight.titleLabel?.font = font
        
        let button = UIBarButtonItem(customView: btnRight)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
        return btnRight
    }
    
    func setTitleImageNavigation(image: UIImage) {
        showNavigation()
        let view = UIView()
        let imageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 9, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        self.navigationItem.titleView = view
    }
    
    func addTwoButtonToNavigation(image1: UIImage, action1: Selector?, image2: UIImage, action2: Selector?) {
        showNavigation()
        let btn1 = UIButton()
        btn1.setImage(image1, for: .normal)
        if let newAction = action1 {
            btn1.addTarget(self, action: newAction, for: .touchUpInside)
        }
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        btn1.contentHorizontalAlignment = .right
        let button1 = UIBarButtonItem(customView: btn1)
        
        //---
        let btn2 = UIButton()
        btn2.setImage(image2, for: .normal)
        if let newAction = action2 {
            btn2.addTarget(self, action: newAction, for: .touchUpInside)
        }
        btn2.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn2.contentHorizontalAlignment = .right
        
        let button2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.rightBarButtonItems = [button1, button2]
    }
    
    func addButtonTextToNavigation(title: String, style: StyleNavigation, action: Selector?, textColor: UIColor = AppColor.rightNavigation) {
        
        showNavigation()
        let btn = UIButton()
        
        var newTitle = title
        if style == .right {
            newTitle = title
        }
        
        btn.setAttributed(title: newTitle, color: textColor, font: UIFont.systemFont(ofSize: 17))
        
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
        lb.textColor = AppColor.black
        let tap = UITapGestureRecognizer(target: self, action: action)
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(tap)
        self.navigationItem.titleView = vTest
    }
    
    func setTitleWhiteNavigation(title: String, textColor: UIColor = UIColor.white, action: Selector? = nil ) {
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
        let tap = UITapGestureRecognizer(target: self, action: action)
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(tap)
        self.navigationItem.titleView = vTest
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
}

extension BaseViewController {
    func addKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide() {
        
    }
}
extension BaseViewController {
    func addBackToNavigation(icon: UIImage = AppImage.imgBack ) {
        addButtonImageToNavigation(image: icon, style: .left, action: #selector(btnBackTapped))
    }
    
    @objc func btnBackTapped() {
        self.pop()
    }
    
    func addCloseToNavigation(icon: UIImage = AppImage.imgClose ) {
        addButtonImageToNavigation(image: icon, style: .left, action: #selector(btnCloseTapped))
    }
    
    @objc func btnCloseTapped() {
        self.dismiss()
    }
}

extension BaseViewController {
    func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    func setBlackNavigation() {
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    func setWhiteCloseNavigation() {
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "cancel_white"), style: .left, action: #selector(btnCloseTapped))
    }
}
