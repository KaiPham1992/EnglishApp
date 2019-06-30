//
//  HistoryExerciseDateViewController.swift
//  EnglishApp
//
//  Created vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class HistoryExerciseDateViewController: PageViewController, HistoryExerciseDateViewProtocol {

	var presenter: HistoryExerciseDatePresenterProtocol?
    var date: String = ""

	override func viewDidLoad() {
        super.viewDidLoad()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.history_exercise.showLanguage)
        self.tabBarController?.tabBar.isHidden = true
        self.edgesForExtendedLayout = .bottom
    }

    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ListLessonRouter.createModule(date: date),ExerciseRouter.createModule(isShowTabbar: false),CompetitionRouter.createModule(type: .result)]
    }
}
