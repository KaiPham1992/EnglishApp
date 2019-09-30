//
//  MainTabbar.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol TabbarProtocol: class {
    func tabbarSelected(index: Int)
}

extension Notification.Name {
    static let refreshTabbar = Notification.Name("RefreshTabbar")
}
let tabIconInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
let tabBarIncrease: CGFloat = 13

class MainTabbar: UITabBarController {
    weak var tabbarDelagate: TabbarProtocol?
    var listViewController = [UIViewController]()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setUpTabbar()
        setUpObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveCompetition), name: NSNotification.Name.init("RecieveCompetition"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(noCompetition), name: NSNotification.Name.init("NoCompetition"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReciveNotification), name: NSNotification.Name.init("didReciveNotification"), object: nil)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColor.color158_158_158, NSAttributedString.Key.font: AppFont.fontRegular12], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColor.color255_211_17, NSAttributedString.Key.font: AppFont.fontRegular12], for: .selected)
        self.hidesBottomBarWhenPushed = true 
    }
    
    @objc func didReciveNotification(notification: Notification){
        if let action_key = notification.userInfo?["click_action"] as? String {
            switch action_key {
            case "ANSWERED_QUESTION":
                self.selectedIndex = 0
                if let oid = notification.userInfo?["gcm.notification.oid"] as? String, let id = Int(oid) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                            let vc = QADetailRouter.createModule(id: id)
                            vc.hidesBottomBarWhenPushed = true
                            viewController.push(controller: vc)
                        }
                    }
                }
            case "NOTIF_EVENT", "REDEEM_CODE":
                self.selectedIndex = 0
                if let nid = notification.userInfo?["gcm.notification.nid"] as? String, let id = Int(nid){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                            let vc = NotificationDetailRouter.createModule(idNotification: id)
                            vc.isRead = false
                            vc.hidesBottomBarWhenPushed = true
                            viewController.push(controller: vc)
                        }
                    }
                }
            case "ASSIGNED_EXERCISE":
                self.selectedIndex = 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                        let vc = AssignExerciseRouter.createModule()
                        vc.hidesBottomBarWhenPushed = true
                        viewController.push(controller: vc)
                    }
                }
            case "EXPIRED_PRODUCT":
                self.selectedIndex = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController as? HomeViewController {
                        let vc = StoreViewController()
                        vc.hidesBottomBarWhenPushed = true
                        viewController.push(controller: vc)
                    }
                }
            case "COMMENT_QUESTION":
                self.selectedIndex = 0
                if let oid = notification.userInfo?["oid"] as? String, let id = Int(oid) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                            let vc = ExplainExerciseGroupRouter.createModule(id: id)
                            vc.selectedIndex = 1
                            vc.hidesBottomBarWhenPushed = true
                            viewController.push(controller: vc)
                        }
                    }
                }
            case "WALLET_DIAMOND":
                self.selectedIndex = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                        let vc = HistoryBeeRouter.createModule(wallet_type: 1)
                        vc.hidesBottomBarWhenPushed = true
                        viewController.push(controller: vc)
                    }
                }
            case "WALLET_HONEY", "BUY_HONEY":
                self.selectedIndex = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                        let vc = HistoryBeeRouter.createModule(wallet_type: 3)
                        vc.hidesBottomBarWhenPushed = true
                        viewController.push(controller: vc)
                    }
                }
            case "COMMENT_LESSON":
                self.selectedIndex = 0
                if let oid = notification.userInfo?["oid"] as? String, let id = Int(oid) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let navigation = self.viewControllers?[self.selectedIndex] as? UINavigationController, let viewController = navigation.topViewController {
                            let vc = CommentRouter.createModule(id: String(id))
                            vc.hidesBottomBarWhenPushed = true
                            viewController.push(controller: vc)
                        }
                    }
                }
            default:
                break
            }
        }
        
        if let nid = notification.userInfo?["gcm.notification.nid"] as? String, let id = Int(nid){
            Provider.shared.notificationAPIService.readNotification(notificationId: id, success: { _ in
                
            }) { _ in
                
            }
        }
    }
    
    func resetHome(){
        let home = UINavigationController(rootViewController: HomeRouter.createModule())
        self.viewControllers![0] = home
    }
    
    func gotoHome() {
        self.selectedIndex = 0
        if let viewController = self.viewControllers?[self.selectedIndex] as? UINavigationController {
            viewController.popToRootViewController(animated: false)
        }
    }
    
    @objc func noCompetition() {
        self.viewControllers?[3].tabBarItem = setBarItem(title: LocalizableKey.tabbarCompetition.showLanguage, selectedImage: AppImage.imgTabbarCompetitionSelected, normalImage: AppImage.imgTabbarCompetition)
        self.viewControllers?[3].tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    }
    
    @objc func didRecieveCompetition() {
        self.setupRedDot()
    }
    
    func setUpObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(resetTitle), name: NSNotification.Name(rawValue: "Refresh"), object: nil)
    }
    
    @objc func resetTitle() {
        tabBar.items?[0].title = LocalizableKey.tabbarHome.showLanguage
        tabBar.items?[1].title = LocalizableKey.tabbarProgram.showLanguage
        tabBar.items?[2].title = LocalizableKey.tabbarHomeWork.showLanguage
        tabBar.items?[3].title = LocalizableKey.tabbarCompetition.showLanguage
    }
    
    @objc func setUpTabbar() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        let vcHome = HomeRouter.createModule()
        let vcProgramer = TheoryRouter.createModule()
        let vcHomeWork = ExerciseRouter.createModule()
        let vcCompetition = CompetitionRouter.createModule()
        
        
        vcHome.tabBarItem = setBarItem(selectedImage: AppImage.imgTabbarHomeSelected, normalImage: AppImage.imgTabbarHome)
        vcHome.title = LocalizableKey.tabbarHome.showLanguage
        
        vcProgramer.tabBarItem = setBarItem(selectedImage: AppImage.imgTabbarProgramerSelected, normalImage: AppImage.imgTabbarProgramer)
        vcProgramer.title = LocalizableKey.tabbarProgram.showLanguage
        
        vcHomeWork.tabBarItem = setBarItem(selectedImage: AppImage.imgTabbarHomeWorkSelected, normalImage: AppImage.imgTabbarHomeWork)
        vcHomeWork.title = LocalizableKey.tabbarHomeWork.showLanguage
        let tabCompetition = setBarItem(selectedImage: AppImage.imgTabbarCompetitionSelected, normalImage: AppImage.imgTabbarCompetition)
        vcCompetition.tabBarItem = tabCompetition
        vcCompetition.title = LocalizableKey.tabbarCompetition.showLanguage
        
        listViewController = [vcHome, vcProgramer, vcHomeWork, vcCompetition]
        
        for controller in listViewController {
            controller.tabBarItem.imageInsets = tabIconInsets
        }
        
        if UIDevice.current.isIphone5_8Inch() == true {
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        } else {
//            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        }
        self.tabBar.tintColor = UIColor.white
        addViewControllerToTabbar(listViewController: listViewController)
    }
    
    func addViewControllerToTabbar(listViewController: [UIViewController]) {
        var listNavigationController = [UIViewController]()
        
        for (_, vc) in listViewController.enumerated() {
            let nc = UINavigationController(rootViewController: vc)
            listNavigationController.append(nc)
        }
        
        self.viewControllers = listNavigationController
    }
    
    func setBarItem(title: String? = nil, selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        return item
    }
    
    func setupRedDot() {
        self.viewControllers?[3].tabBarItem = self.setBarItem(title: LocalizableKey.tabbarCompetition.showLanguage, selectedImage: #imageLiteral(resourceName: "ic_fire_dot_choice").withRenderingMode(.alwaysOriginal), normalImage: #imageLiteral(resourceName: "ic_fire_dot_not_choice").withRenderingMode(.alwaysOriginal))
        self.viewControllers?[3].tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    }
}

extension MainTabbar: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        //        for (index, vc) in listViewController.enumerated() {
        //            vc.tabBarItem.title = index == tabBarController.selectedIndex ? titleTabbars[index] : ""
        //        }
        tabbarDelagate?.tabbarSelected(index: tabBarController.selectedIndex)
    }
}

extension UITabBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if UIDevice.current.isIphoneXOrLater() {
            sizeThatFits.height = 100
        } else {
            sizeThatFits.height = 60
        }
        return sizeThatFits
    }
}
