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
    
    var widthMenuConstraint: NSLayoutConstraint?
    var widthMenu: CGFloat = 0
    
    var minXContent: CGFloat = 50
    
    var tapGesture      : UITapGestureRecognizer!
    var currentController: UIViewController!
    
    let vBlack: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func setUpViews() {
        setColorStatusBar()
        //-- Main
        view.addSubview(vContainerMain)
        vContainerMain.fillSuperviewNotSafe()
        
        vContainerMain.addSubview(vContentMain)
        vContentMain.fillSuperviewNotSafe() 
        
        //-- Menu
        view.addSubview(vContentMenu)
        vContentMenu.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        
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
        
        guard let itemIcon = itemSelected.imgIcon else { return }
        switch itemIcon {
        case AppImage.imgInfo:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ProfileRouter.createModule())
            
        case AppImage.imgQA:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: QARouter.createModule())
            
        case AppImage.imgChangePass:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ChangePasswordRouter.createModule())
            
        case AppImage.imgLanguage:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ChangeLanguageRouter.createModule())
        case AppImage.imgSaved:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: SaveDictionaryRouter.createModule())
        case AppImage.imgTop:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: BXHRouter.createModule())
        case AppImage.imgHistoryCheck:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: HistoryExerciseRouter.createModule())
            
        case AppImage.imgPrivacy:
            self.hideMenu()
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
