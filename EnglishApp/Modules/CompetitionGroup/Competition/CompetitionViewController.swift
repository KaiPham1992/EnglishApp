//
//  CompetitionViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

enum ResultCompetition {
    case result
    case competition
}

class CompetitionViewController: ListManagerVC {
    
	var presenter: CompetitionPresenterProtocol?
    var type : ResultCompetition = .competition
    
    override func setupViewListManager() {
        customTitle = LocalizableKey.titleCompetition.showLanguage
        showButtonBack = false
    }
    
    override func callAPI() {
        if type == .competition{
            presenter?.getListFight(offset: self.offset)
        } else {
            self.presenter?.getListResultFight(offset: self.offset)
        }
    }
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(CompetitionCell.self)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(CompetitionCell.self, for: indexPath)
        cell.type = self.type
        if let data = item as? CompetitionEntity {
            cell.competitionEntity = data
        }
        cell.btnJoin.tag = indexPath.item

        cell.actionFight = {[weak self](status, id) in
            self?.actionFight(status: status, tag: id)
        }
        //---
        cell.btnShare.tag = indexPath.item
        cell.btnShare.addTarget(self, action: #selector(btnShareTapped), for: .touchUpInside)
        return cell
    }
    func actionFight(status: String,tag: Int) {
        //correct
        if type == .competition {
            guard let competitionId = (listData[tag] as! CompetitionEntity).id else {
                return
            }
            if status == "CAN_JOIN"{
                self.push(controller: SelectTeamRouter.createModule(competitionId: competitionId))
            }
            if status == "DONE"{
                self.push(controller: ResultGroupRouter.createModule(idCompetition: String(competitionId)))
            }
        } else {
            let vc = ResultGroupRouter.createModule(idCompetition: String((listData[tag] as! CompetitionEntity).id ?? 0))
            self.push(controller: vc)
        }
    }
    
    @objc func btnShareTapped() {
        ShareNativeHelper.shared.showShareLinkInstall()
    }
}

extension CompetitionViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if type == .competition {
            return IndicatorInfo(title: LocalizableKey.action.showLanguage)
        }
        return IndicatorInfo(title: LocalizableKey.titleCompetition.showLanguage)
    }
}
extension CompetitionViewController: CompetitionViewProtocol{
    func didGetList(competitionList: CollectionCompetitionEntity) {
        guard let competition = competitionList.competitionEntity else {return}
        initLoadData(data: competition)
    }
    
    func didGetList(error: Error) {
        print(error.localizedDescription)
    }
    
    func didGetResultFight(resultFight: CompetitionProfileEntity) {
        guard let competition = resultFight.results else {return}
        initLoadData(data:competition.map{CompetitionEntity(competitionResultsProfileEntity: $0)}.compactMap{$0})
    }
}
