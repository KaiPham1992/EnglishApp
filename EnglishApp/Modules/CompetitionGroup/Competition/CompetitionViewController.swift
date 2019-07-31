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
        estimateHeightRow = 55
        heightRow = 0
    }
    
    override func callAPI() {
        self.offset = 0
        if type == .competition{
            presenter?.getListFight(offset: self.offset,replaceData: true)
        } else {
            self.presenter?.getListResultFight(offset: self.offset,replaceData: true)
        }
    }
    
    override func loadMoreData() {
        self.offset += limit
        if type == .competition{
            presenter?.getListFight(offset: self.offset,replaceData: false)
        } else {
            self.presenter?.getListResultFight(offset: self.offset,replaceData: false)
        }
        
    }
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(CompetitionCell.self)
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
    func didGetList(competitionList: CollectionCompetitionEntity,replaceData: Bool) {
        guard let competition = competitionList.competitionEntity else {return}
        initLoadData(data: competition,replaceData: replaceData)
    }
    
    func didGetList(error: Error) {
        print(error.localizedDescription)
    }
    
    func didGetResultFight(resultFight: CompetitionProfileEntity,replaceData: Bool) {
        guard let competition = resultFight.results else {return}
        initLoadData(data:competition.map{CompetitionEntity(competitionResultsProfileEntity: $0)}.compactMap{$0},replaceData: replaceData)
    }
}
