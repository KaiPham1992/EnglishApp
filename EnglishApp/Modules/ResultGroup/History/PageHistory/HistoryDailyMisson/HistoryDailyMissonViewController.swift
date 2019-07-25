//
//  HistoryDailyMissonViewController.swift
//  EnglishApp
//
//  Created Steve on 7/19/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

enum TypeHistoryExercise : Int{
    case history = 2
}

class HistoryDailyMissonViewController: BaseViewController {

	var presenter: HistoryDailyMissonPresenterProtocol?

    @IBOutlet weak var tbvLesson: UITableView!
    var date: String = ""
    var offset : Int = 0
    var type : TypeHistoryExercise = .history
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvLesson.registerXibFile(CellGrammar.self)
        tbvLesson.dataSource = self
        tbvLesson.delegate = self
        self.presenter?.getHistoryExercise(type: type.rawValue,date: date, offset: self.offset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension HistoryDailyMissonViewController: HistoryDailyMissonViewProtocol {
    func reloadView() {
        self.tbvLesson.reloadData()
    }
}

extension HistoryDailyMissonViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.listResultDailyMisson?.count ?? 0
        if row == 0 {
            showNoData()
        } else {
            hideNoData()
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        if let dataCell = self.presenter?.listResultDailyMisson?[indexPath.row] {
            cell.setupTitle(title: dataCell.name&)
        }
        return cell
    }
    
}
extension HistoryDailyMissonViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResultRouter.createModule(type: .dailyMissonExercise, id: self.presenter?.listResultDailyMisson?[indexPath.row]._id ?? "")
        self.push(controller: vc,animated: true)
    }
}

extension HistoryDailyMissonViewController : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.task_every_date.showLanguage)
    }
}

