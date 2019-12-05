//
//  HistoryCompetitionViewController.swift
//  EnglishApp
//
//  Created Steve on 12/1/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class HistoryCompetitionViewController: ListManagerVC {

	var presenter: HistoryCompetitionPresenterProtocol?
    var date: String = ""

	override func setUpViews() {
        showButtonBack = false
        super.setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name.init("LogoutSuccessed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(login), name: NSNotification.Name.init("UserDidLogin"), object: nil)
    }
    
    @objc func login() {
       self.offset = 0
       callAPI()
    }
       
    @objc func logout() {
       self.offset = 0
       callAPI()
    }
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(CompetitionCell.self)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    override func callAPI() {
        super.callAPI()
        self.presenter?.getListResultFight(offset: self.offset, date: self.date)
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listData[indexPath.row] as! CompetitionResultsProfileEntity
        let cell = self.tableView.dequeue(CompetitionCell.self, for: indexPath)
        cell.index = indexPath.row
        cell.setupCellResult(competitionEntity: data)
        cell.actionFight = {[weak self](index) in
            self?.actionFight(index: index)
        }
        return cell
    }
    
    func actionFight(index: Int) {
        let data = listData[index] as! CompetitionResultsProfileEntity
        let vc = ResultGroupRouter.createModule(idCompetition: data._id ?? "0", idExercise: data.exercise_id ?? "0", isHistory: true, endDate: Date())
        self.push(controller: vc)
    }
}

extension HistoryCompetitionViewController : HistoryCompetitionViewProtocol {
    func reloadView(data: [CompetitionResultsProfileEntity]) {
        self.initLoadData(data: data)
    }
}

extension HistoryCompetitionViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if date == "" {
            return IndicatorInfo(title: LocalizableKey.passed.showLanguage)
        }
        return IndicatorInfo(title: LocalizableKey.competition.showLanguage)
    }
}