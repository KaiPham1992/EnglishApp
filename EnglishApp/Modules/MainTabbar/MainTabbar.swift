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
let tabIconInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
let tabBarIncrease: CGFloat = 13

class MainTabbar: UITabBarController {
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
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
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColor.color158_158_158, NSAttributedString.Key.font: AppFont.fontRegular12], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColor.color255_211_17, NSAttributedString.Key.font: AppFont.fontRegular12], for: .selected)
        self.hidesBottomBarWhenPushed = true 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var newTabBarHeight: CGFloat = 0
        if checkIncreaseTabbar() {
            newTabBarHeight = defaultTabBarHeight + tabBarIncrease
        } else {
            newTabBarHeight = defaultTabBarHeight
        }
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.barTintColor = UIColor.white
        tabBar.frame = newFrame
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
        vcCompetition.tabBarItem = setBarItem(selectedImage: AppImage.imgTabbarCompetitionSelected, normalImage: AppImage.imgTabbarCompetition)
        vcCompetition.title = LocalizableKey.tabbarCompetition.showLanguage
        
        listViewController = [vcHome, vcProgramer, vcHomeWork, vcCompetition]
        
//        for controller in listViewController {
//            controller.tabBarItem.imageInsets = tabIconInsets
//        }
        
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
}

extension MainTabbar: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        //        for (index, vc) in listViewController.enumerated() {
        //            vc.tabBarItem.title = index == tabBarController.selectedIndex ? titleTabbars[index] : ""
        //        }
        tabbarDelagate?.tabbarSelected(index: tabBarController.selectedIndex)
    }
    
    func checkIncreaseTabbar() -> Bool {
        return !UIDevice.current.isIphone5_8Inch()
    }
}
//
//extension UINavigationController {
//    override open var childForStatusBarStyle: UIViewController? {
//        return self.topViewController
//    }
//}

//extension TabbarViewController: CreatePostItineraryProtocol {
//    func addPhoto() {
//        vCreatePopup?.hide()
//
//        let vc = ContainerLibraryViewController.configureWith(mode: .multipleImage)
//
//        UIApplication.topViewController()?.present(controller: vc, animated: true)
//    }
//
//    func addIniterary() {
//        vCreatePopup?.hide()
//
//        let vc = CreateItineraryRouter.createModule() as! CreateItineraryViewController
//        UIApplication.topViewController()?.present(controller: vc, animated: true)
//    }
//
//    func dismissView() {
//        vCreatePopup?.hide()
//    }
//}

