//
//  AppContainerViewController.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

class AppContainerViewController: SideMenuViewController {
    let vcHome = HomeRouter.createModule()
    let vcMenu = MenuRouter.createModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openViewController(presentingController: vcHome)
    }
}
