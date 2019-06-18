//
//  AppContainerViewController.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class AppContainerViewController: SideMenuViewController {
    let vcHome = HomeRouter.createModule()
    let vcMenu = MenuRouter.createModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openViewController(presentingController: vcHome)
    }
    
    init() {
        super.init(drawerDirection: .left, drawerWidth: 308, menuViewController: vcMenu)
//        vcMenu.delegateController = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
//extension AppContainerViewController: MenuViewControllerDelegate {
//    func controllerSelected(controller: UIViewController) {
//        vcHome.showHideMenu()
//    }
//}
