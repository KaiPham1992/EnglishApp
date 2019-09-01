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

class HistoryDailyMissonViewController: ListManagerVC {

	var presenter: HistoryDailyMissonPresenterProtocol?

    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func callAPI() {
        super.callAPI()
        self.presenter?.getHistoryExercise(type: 2,date: date, offset: self.offset)
    }
    
    override func registerTableView() {
        super.registerTableView()
        tableView.registerXibFile(CellGrammar.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = item as! TestResult
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        cell.setupTitle(title: data.exercise_name&)
        return cell
    }
}

extension HistoryDailyMissonViewController: HistoryDailyMissonViewProtocol {
    func reloadView() {
        initLoadData(data: self.presenter?.listResultDailyMisson ?? [])
    }
}

extension HistoryDailyMissonViewController : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.task_every_date.showLanguage)
    }
}

