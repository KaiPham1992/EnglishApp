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

	override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.history_exercise.showLanguage)
    }

    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ListLessonRouter.createModule(type: .exercise_date),ExerciseRouter.createModule(isShowTabbar: false),CompetitionRouter.createModule()]
    }
}