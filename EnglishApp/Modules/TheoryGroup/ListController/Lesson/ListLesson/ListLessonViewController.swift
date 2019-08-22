//
//  ListLessonViewController.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

//enum LessonRecipe {
//    case lesson
//    case recipe
//    case exercise_date
//}

var limit = 20

class ListLessonViewController: BaseViewController {

	var presenter: ListLessonPresenterProtocol?

    @IBOutlet weak var tbvLesson: UITableView!
    var lesson_category_id: String = "1"
    var offset : Int = 0
    var type : TheoryType = .lesson
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvLesson.registerXibFile(CellGrammar.self)
        tbvLesson.dataSource = self
        tbvLesson.delegate = self
        self.presenter?.getListLesson(lesson_category_id: self.lesson_category_id, offset: offset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        if type == .lesson {
            setTitleNavigation(title: LocalizableKey.lesson.showLanguage)
        } else {
            setTitleNavigation(title: LocalizableKey.recipe.showLanguage)
        }
        
    }
}

extension ListLessonViewController: ListLessonViewProtocol {
    func reloadView() {
        self.tbvLesson.reloadData()
    }
}

extension ListLessonViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.listLesson?.lessons.count ?? 0
        if row == 0 {
            showNoData()
        } else {
            hideNoData()
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        cell.setupTitle(title: self.presenter?.listLesson?.lessons[indexPath.row].name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = self.presenter?.listLesson?.lessons.count ?? 0
        if indexPath.row == row - 1 {
            self.offset += limit
             self.presenter?.getListLesson(lesson_category_id: self.lesson_category_id, offset: offset)
        }
    }
}
extension ListLessonViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailLessonRouter.createModule(lesson: self.presenter?.listLesson?.lessons[indexPath.row], type: .detailLesson)
        self.push(controller: vc,animated: true)
    }
}
