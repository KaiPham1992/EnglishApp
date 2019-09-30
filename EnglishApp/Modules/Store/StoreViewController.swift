//
//  StoreViewController.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class StoreViewController: PageViewController, TheoryViewProtocol {
    
    var presenter: TheoryPresenterProtocol?
    var fromDoEntrance : Bool = false
    var point : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavigation(title: LocalizableKey.titleStore.showLanguage)
        self.view.backgroundColor = .white
        addBackToNavigation()
        self.tabBarController?.tabBar.isHidden = true
        self.edgesForExtendedLayout = UIRectEdge.bottom
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [StudyPackRouter.createModule(fromDoEntrance: self.fromDoEntrance, point: point),BeePackRouter.createModule()]
    }
}
