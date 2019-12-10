//
//  PageViewCompetitionViewController.swift
//  EnglishApp
//
//  Created Steve on 12/1/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class PageViewCompetitionViewController: PageViewController, PageViewCompetitionViewProtocol {

	var presenter: PageViewCompetitionPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLanguage), name: NSNotification.Name.init("ChangeLanguage"), object: nil)
        setTitleNavigation(title: LocalizableKey.action.showLanguage)
    }

//    @objc func didChangeLanguage() {
//        self.viewDidLoad()
//    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [CompetitionRouter.createModule(), PassedCompetitionRouter.createModule()]
    }

}




