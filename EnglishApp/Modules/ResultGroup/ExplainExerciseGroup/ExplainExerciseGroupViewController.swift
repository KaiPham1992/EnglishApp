//
//  ExplainExerciseGroupViewController.swift
//  EnglishApp
//
//  Created Steve on 7/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class ExplainExerciseGroupViewController: PageViewController, ExplainExerciseGroupViewProtocol {

	var presenter: ExplainExerciseGroupPresenterProtocol?
    var id: Int = 0
    var selectedIndex : Int = 2

	override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.bottom
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.see_explain.showLanguage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.moveToViewController(at: self.selectedIndex - 1)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [CommentQuestionRouter.createModule(id_question: String(id)), ExplainExerciseRouter.createModule(id: id)]
    }

}
