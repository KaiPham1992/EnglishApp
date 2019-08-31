//
//  ResultGroupViewController.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class ResultGroupViewController: PageViewController, ResultGroupViewProtocol {

	var presenter: ResultGroupPresenterProtocol?
    var idCompetition: String = "0"
    var idExercise : String = "0"
    var isHistory : Bool = false
    
	override func viewDidLoad() {
//        self.gotoIndex(index: 1)
        super.viewDidLoad()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.result_competion.showLanguage)
        self.edgesForExtendedLayout = .bottom
        self.tabBarController?.tabBar.isHidden = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
//            UIView.performWithoutAnimation {
//                self.moveToViewController(at: 1)
//            }
//        }
    }
    
    override func btnBackTapped() {
        if isHistory {
            super.btnBackTapped()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        if isHistory {
            return [ResultRouter.createModule(type: .competition, id: self.idCompetition, isHistory:  true),ResultCompetitionRouter.createModule(idCompetition: self.idCompetition)]
        } else {
             return [ResultRouter.createModule(type: .competition, id: self.idCompetition),ResultCompetitionRouter.createModule(idCompetition: self.idCompetition)]
        }
        
    }
}
