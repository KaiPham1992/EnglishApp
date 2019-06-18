//
//  ContainerViewController.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//
import UIKit

class ContainerViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // Main
    let vContainerMain: UIView = {
        let view = UIView()
        return view
    }()
    
    let vContentMain: UIView = {
        let view = UIView()
        return view
    }()
    
    // Menu
    let vContentMenu: UIView = {
        let view = UIView()
        return view
    }()
    
    //---
    var vcHome: HomeViewController!
    var ncHome: UINavigationController!
    
    var vcLeftMenu:  MenuViewController!
    
    
    //---
    var profileVC: ProfileViewController!
    var profileNC: UINavigationController!
    //-
    var bxhVC: BXHViewController!
    var bxhNC: UINavigationController!
    //
    var qaVC: QAViewController!
    var qaNC: UINavigationController!
    //--
    var languageVC: ChangeLanguageViewController!
    var languageNC: UINavigationController!
    
    //---
    var saveVC: SaveDictionaryViewController!
    var saveNC: UINavigationController!
    //---
    var historyVC: HistoryExerciseViewController!
    var historyNC: UINavigationController!
    //--
    var termOfUseVC: WebViewController!
    var termOfUseNC: UINavigationController!
    //--
    var changePasswordVC: ChangePasswordViewController!
    var changePasswordNC: UINavigationController!
    
    var widthMenuConstraint: NSLayoutConstraint?
    var widthMenu: CGFloat = 0
    
    var minXContent: CGFloat = 50
    
    var tapGesture      : UITapGestureRecognizer!
    var currentController: UIViewController!
    
    let vBlack: UIView = {
        let view = UIView()
        
        return view
    }()
    
    func setMacaroOrangeStatusBar() {
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
        statusBar.backgroundColor = AppColor.yellow
        UIApplication.shared.statusBarStyle = .lightContent
        statusBar.tintColor =  AppColor.yellow
    }
    
    override func setUpViews() {
        setMacaroOrangeStatusBar()
        //-- Main
        view.addSubview(vContainerMain)
        vContainerMain.fillSuperviewNotSafe()
        
        vContainerMain.addSubview(vContentMain)
        vContentMain.fillSuperviewNotSafe() 
        
        //-- Menu
        view.addSubview(vContentMenu)
        vContentMenu.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        profileVC = ProfileRouter.createModule()
        profileNC = UINavigationController(rootViewController: profileVC)
//        giftListVC.delegate = self
        
        //--
        bxhVC  = BXHRouter.createModule()
        bxhNC = UINavigationController(rootViewController: profileVC)
//        profileVC.delegate = self
        //--
        qaVC = QARouter.createModule()
        qaNC = UINavigationController(rootViewController: qaVC)
//        listContractVC.delegate = self
        //---
        languageVC = ChangeLanguageRouter.createModule()
        languageNC = UINavigationController(rootViewController: languageVC)
//        historyContainerVC.delegate = self
        //---
        saveVC = SaveDictionaryRouter.createModule()
        saveNC = UINavigationController(rootViewController: saveVC)
//        orderContainerVC.delegate = self
        //
        historyVC = HistoryExerciseRouter.createModule()
        historyNC = UINavigationController(rootViewController: historyVC)
//        favoriteContainerVC.delegate = self
        //---
        termOfUseVC = WebViewController.initFromNib()
        termOfUseNC = UINavigationController(rootViewController: termOfUseVC)
//        termOfUseVC.delegate = self
        //---
        changePasswordVC = ChangePasswordRouter.createModule()
        changePasswordNC = UINavigationController(rootViewController: changePasswordVC)
//        changePasswordVC.delegate = self
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(rootViewTapped))
        vcHome = HomeRouter.createModule() 
        ncHome = UINavigationController(rootViewController: vcHome)
       
        AppRouter.shared.rootNavigation = ncHome
        addFullToMain(controller: ncHome)
        addBlackView()
        vcLeftMenu = MenuRouter.createModule()
        
        vcLeftMenu.modalPresentationStyle = .overFullScreen
        addMenuViewController(vcMenu: vcLeftMenu)
        
        // DELEGATE
        vcHome.delegate = self
        vcLeftMenu.delegateController = self
    }
}

extension ContainerViewController: MenuViewControllerDelegate, HomeViewControllerDelegate {
    
    func controllerSelected(itemSelected: MenuItem) {
        self.hideMenu()
        guard let itemIcon = itemSelected.imgIcon else { return }
        switch itemIcon {
        case AppImage.imgInfo:
            AppRouter.shared.pushTo(viewController: ProfileRouter.createModule())
            
        case AppImage.imgQA:
            AppRouter.shared.pushTo(viewController: QARouter.createModule())
            
        case AppImage.imgChangePass:
            AppRouter.shared.pushTo(viewController: ChangePasswordRouter.createModule())
            
        case AppImage.imgLanguage:
            AppRouter.shared.pushTo(viewController: ChangeLanguageRouter.createModule())
        case AppImage.imgSaved:
            AppRouter.shared.pushTo(viewController: SaveDictionaryRouter.createModule())
        case AppImage.imgTop:
            AppRouter.shared.pushTo(viewController: BXHRouter.createModule())
        case AppImage.imgHistoryCheck:
            AppRouter.shared.pushTo(viewController: HistoryExerciseRouter.createModule())
            
        case AppImage.imgPrivacy:
            AppRouter.shared.pushTo(viewController: WebViewController.initFromNib())
        case AppImage.imgLogout:
            PopUpHelper.shared.showLogout(completionNo: {
                self.logout()
            }) {
                
            }
        default:
            break
        }
    }

    func showLefMenuTapped() {
        self.showMenu()
    }
}

extension ContainerViewController {
    func logout() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.logout(success: { (_) in
            ProgressView.shared.hide()
            UserDefaultHelper.shared.clearUser()
            AppRouter.shared.openLogin()
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
