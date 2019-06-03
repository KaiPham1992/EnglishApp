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

class ListLessonViewController: BaseViewController, ListLessonViewProtocol {

	var presenter: ListLessonPresenterProtocol?

    @IBOutlet weak var tbvLesson: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvLesson.registerXibFile(CellGrammar.self)
        tbvLesson.dataSource = self
        tbvLesson.delegate = self
    }
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.lesson.showLanguage)
    }
}
extension ListLessonViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.numberLesson() ?? 0
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        cell.setupTitle(title: self.presenter?.getLessonIndexPath(indexPath: indexPath) ?? "")
        return cell
    }
    
}
extension ListLessonViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailLessonRouter.createModule(titleNavi: self.presenter?.getLessonIndexPath(indexPath: indexPath) ?? "")
        self.push(controller: vc,animated: true)
    }
}

