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
        super.setupViewListManager()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveCompetition), name: NSNotification.Name.init("RecieveCompetition"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLanguage), name: NSNotification.Name.init("ChangeLanguage"), object: nil)
    }
    
    @objc func didChangeLanguage() {
        self.offset = 0
        callAPI()
        customTitle = LocalizableKey.titleCompetition.showLanguage
        self.setUpNavigation()
    }
    
    @objc func didRecieveCompetition() {
        self.offset = 0
        callAPI()
    }
    
    @objc func leaveCompetition(){
        self.offset = 0
        callAPI()
    }
    
    override func callAPI() {
        super.callAPI()
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
        cell.indexPath = indexPath
        cell.actionFight = {[weak self](status, index) in
            self?.actionFight(status: status, index: index)
        }
        //---
        cell.btnShare.tag = indexPath.item
        cell.btnShare.addTarget(self, action: #selector(btnShareTapped), for: .touchUpInside)
        return cell
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        let data = item as! CompetitionEntity
        if data.isHidden {
            let vc =  SelectTeamRouter.createModule(competitionId: data.id ?? 0, isCannotJoin: true)
            self.push(controller: vc)
        } else {
            if data.is_fight_joined == 0 && data.status == "CAN_JOIN"{
                let vc =  SelectTeamRouter.createModule(competitionId: data.id ?? 0, isCannotJoin: false)
                
                vc.joinTeam = { [weak self] (teamId) in
                    self?.joinTeam(index: indexPath.row, teamId: teamId)
                }
                vc.leaveTeam = {[weak self] in
                    self?.leaveTeam(index: indexPath.row)
                }
                vc.fightFinished = { [weak self] in
                    self?.fightComplete(index: indexPath.row)
                }
                self.push(controller: vc)
            } else {
                let vc =  SelectTeamRouter.createModule(competitionId: data.id ?? 0, isCannotJoin: true)
                self.push(controller: vc)
            }
        }
    }
    
    func actionFight(status: String, index: Int) {
        //correct
        if type == .competition {
            guard let competitionId = (listData[index] as! CompetitionEntity).id else {
                return
            }
            if status == "CAN_JOIN"{
                if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CompetitionCell {
                    let data = listData[index] as! CompetitionEntity
                    if data.isHidden {
                        self.push(controller: SelectTeamRouter.createModule(competitionId: competitionId, isCannotJoin: true))
                    } else {
                        let isStarted = cell.isStarted
                        if isStarted {
                            let vc = FightRouter.createModule(completion_id: competitionId , team_id: Int(data.team_id ?? "0") ?? 0, startDate: data.startDate ?? Date())
                            vc.fightFinished = {[weak self] in
                                self?.fightComplete(index: index)
                            }
                            self.push(controller: vc,animated: true)
                        } else {
                            let vc = SelectTeamRouter.createModule(competitionId: competitionId)
                            vc.joinTeam = { [weak self] (teamId) in
                                self?.joinTeam(index: index, teamId: teamId)
                            }
                            vc.leaveTeam = {[weak self] in
                                self?.leaveTeam(index: index)
                            }
                            vc.fightFinished = { [weak self] in
                                self?.fightComplete(index: index)
                            }
                            self.push(controller: vc)
                        }
                    }
                }
            }
            
            if status == "DONE"{
                let data = listData[index] as! CompetitionEntity
                
                self.push(controller: ResultGroupRouter.createModule(idCompetition: String(data.id ?? 0), idExercise: String(data.id ?? 0), isHistory: true))
            }
            
            if status == "START" {
                let data = listData[index] as! CompetitionEntity
                let vc = FightRouter.createModule(completion_id: competitionId , team_id: Int(data.team_id ?? "0") ?? 0, startDate: data.startDate ?? Date())
                vc.fightFinished = {[weak self] in
                    self?.fightComplete(index: index)
                }
                self.push(controller: vc,animated: true)
            }
            
            
            if status == "CANNOT_JOIN" {
                self.push(controller: SelectTeamRouter.createModule(competitionId: competitionId, isCannotJoin: true))
            }
        } else {
            let data = listData[index] as! CompetitionEntity
            let vc = ResultGroupRouter.createModule(idCompetition: String(data.id ?? 0), idExercise: data.exercise_id ?? "0", isHistory: true)
            self.push(controller: vc)
        }
    }
    
    private func fightComplete(index: Int) {
        DispatchQueue.global().async {
            let data = self.listData[index] as! CompetitionEntity
            let endTimeMi = Int(data.end_time_mi ?? "0") ?? 0
            let currentTimeMi = Int(Date().timeIntervalSince1970)
            if currentTimeMi < endTimeMi {
                data.status = "DOING"
            } else {
                data.status = "DONE"
            }
            self.changeStatusShowData()
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
    }
        
    
    func joinTeam(index: Int, teamId: Int) {
        DispatchQueue.global().async {
            let data = self.listData[index] as! CompetitionEntity
            data.team_id = String(teamId)
            data.is_fight_joined = 1
            self.changeStatusHiddenData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func changeStatusHiddenData() {
        let data = listData as! [CompetitionEntity]
        for item in data {
            if item.is_fight_joined == 0 && item.status == "CAN_JOIN" {
                item.isHidden = true
            }
        }
    }
    
    private func changeStatusShowData() {
        let data = listData as! [CompetitionEntity]
        for item in data {
            if item.is_fight_joined == 0 && item.status == "CAN_JOIN" {
                item.isHidden = false
            }
        }
    }
    
    func leaveTeam(index: Int) {
        DispatchQueue.global().async {
            let data = self.listData[index] as! CompetitionEntity
            data.is_fight_joined = 0
            self.changeStatusShowData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func btnShareTapped(sender: UIButton) {
        let infor = listData[sender.tag] as! CompetitionEntity
        ShareNativeHelper.shared.showShareLinkInstall(quote: "\(LocalizableKey.competition.showLanguage): \(infor.name&) \n\(LocalizableKey.timeStart.showLanguage): \(infor.startTime?.toString(dateFormat: AppDateFormat.HHmm) ?? "")h")
    }
}

extension CompetitionViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if type == .competition {
            return IndicatorInfo(title: LocalizableKey.action.showLanguage)
        }
        return IndicatorInfo(title: LocalizableKey.competition.showLanguage)
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
