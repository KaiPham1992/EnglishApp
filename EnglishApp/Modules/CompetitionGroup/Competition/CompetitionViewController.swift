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

class CompetitionViewController: ListManagerVC {
    
	var presenter: CompetitionPresenterProtocol?
    var timer: Timer?
    
    override func setupViewListManager() {
        customTitle = LocalizableKey.titleCompetition.showLanguage
        showButtonBack = false
        super.setupViewListManager()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveCompetition), name: NSNotification.Name.init("RecieveCompetition"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name.init("LogoutSuccessed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(login), name: NSNotification.Name.init("UserDidLogin"), object: nil)
    }
    
    @objc func login() {
        self.disableTimer()
        self.offset = 0
        callAPI()
    }
    
    private func disableTimer(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    override func actionPullToRefresh() {
        self.disableTimer()
        super.actionPullToRefresh()
    }
    
    @objc func logout() {
        self.disableTimer()
        self.offset = 0
        callAPI()
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
        presenter?.getListFight(offset: self.offset)
    }
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(CompetitionCell.self)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
  
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listData[indexPath.row] as! CompetitionEntity
        let cell = self.tableView.dequeue(CompetitionCell.self, for: indexPath)
        cell.index = indexPath.row
        cell.delegate = self
        switch data.status& {
            case "START":
                cell.setupCellStart(competitionEntity: data)
            case "CANNOT_JOIN":
                cell.setupCellCannotJoin(competitionEntity: data)
            case "DOING":
                cell.setupCellDoing(competitionEntity: data)
            case "CAN_JOIN":
                cell.setupCellCanjoin(competitionEntity: data)
           default:
            break
        }

        cell.actionFight = {[weak self](index) in
            self?.actionFight(index: index)
        }
        //---
        cell.btnShare.addTarget(self, action: #selector(btnShareTapped), for: .touchUpInside)
        return cell
    }
    
    private func setTimer(index: Int, time: Int){
        let data = listData[index] as! CompetitionEntity
        data.distance = time
        if time > 0 {
            if timer == nil {
                let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
                    self.minusTime(index: index)
                })
                RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
                timer.tolerance = 0.1
                self.timer = timer
            }
        } else {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    private func minusTime(index: Int) {
        let data = listData[index] as! CompetitionEntity
        data.distance = data.distance - 1
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CompetitionCell{
            cell.processTime(time: data.distance)
        }
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        let data = item as! CompetitionEntity
        if data.isHidden {
            let vc =  SelectTeamRouter.createModule(competitionId: data.id ?? 0, isCannotJoin: true, endDate: data.endDate ?? Date())
            vc.hidesBottomBarWhenPushed = true
            self.push(controller: vc)
        } else {
            if (data.is_fight_joined == 0 && data.status == "CAN_JOIN") || (data.is_fight_joined == 1){
                self.actionFight(index: indexPath.row)
            } else {
                let vc =  SelectTeamRouter.createModule(competitionId: data.id ?? 0, isCannotJoin: true, endDate: data.endDate ?? Date())
                vc.hidesBottomBarWhenPushed = true
                self.push(controller: vc)
            }
        }
    }
    
    func actionFight(index: Int) {
        //correct
        guard let competitionId = (listData[index] as! CompetitionEntity).id else {
            return
        }
        let status = (listData[index] as! CompetitionEntity).status&
        if status == "CAN_JOIN"{
            if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
                let vc = LoginRouter.createModule()
                vc.callBackLoginSuccessed = { [unowned self] in
                    if let tabbar = self.tabBarController as? MainTabbar {
                        tabbar.gotoHome()
                    }
                }
                self.present(controller: vc, animated: true)
            } else {
                if let _ = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CompetitionCell {
                    let data = listData[index] as! CompetitionEntity
                    if data.isHidden {
                        let vc = SelectTeamRouter.createModule(competitionId: competitionId, isCannotJoin: true, endDate: data.endDate ?? Date())
                        vc.hidesBottomBarWhenPushed = true
                        self.push(controller: vc)
                    } else {
                        if (data.startTime?.timeIntervalSince1970 ?? 0) <= Date().timeIntervalSince1970 {
                            let vc = FightRouter.createModule(completion_id: competitionId , team_id: Int(data.team_id ?? "0") ?? 0, startDate: data.startDate ?? Date(), endDate: data.endDate ?? Date())
                            vc.hidesBottomBarWhenPushed = true
                            vc.fightFinished = {[weak self] in
                                self?.fightComplete(index: index)
                            }
                            self.push(controller: vc,animated: true)
                        } else {
                            let vc = SelectTeamRouter.createModule(competitionId: competitionId, endDate: data.endDate ?? Date())
                            vc.hidesBottomBarWhenPushed = true
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
        }
        if status == "START" {
            if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
                let vc = LoginRouter.createModule()
                vc.callBackLoginSuccessed = { [unowned self] in
                    if let tabbar = self.tabBarController as? MainTabbar {
                        tabbar.gotoHome()
                    }
                }
                self.present(controller: vc, animated: true)
            } else {
                let data = listData[index] as! CompetitionEntity
                let vc = FightRouter.createModule(completion_id: competitionId , team_id: Int(data.team_id ?? "0") ?? 0, startDate: data.startDate ?? Date(), endDate: data.endDate ?? Date())
                vc.hidesBottomBarWhenPushed = true
                vc.fightFinished = {[weak self] in
                    self?.fightComplete(index: index)
                }
                self.push(controller: vc,animated: true)
            }
        
        }
        
        if status == "CANNOT_JOIN" {
            let vc = SelectTeamRouter.createModule(competitionId: competitionId, isCannotJoin: true, endDate: Date())
            vc.hidesBottomBarWhenPushed = true
            self.push(controller: vc)
        }
    }
    
    private func fightComplete(index: Int) {
        self.offset = 0
        self.isLoadmore = true
        self.callAPI()
    }
        
    
    func joinTeam(index: Int, teamId: Int) {
        self.offset = 0
        callAPI()
    }
    
    func leaveTeam(index: Int) {
        self.offset = 0
        callAPI()   
    }
    
    @objc func btnShareTapped(sender: UIButton) {
        let infor = listData[sender.tag] as! CompetitionEntity
        ShareNativeHelper.shared.showShareLinkInstall(quote: "\(LocalizableKey.competition.showLanguage): \(infor.name&) \n\(LocalizableKey.timeStart.showLanguage): \(infor.startTime?.toString(dateFormat: AppDateFormat.HHmm) ?? "")")
    }
}

extension CompetitionViewController : TimerCompetitionDelegate{
    func callbackTimer(index: Int, time: Int) {
        self.setTimer(index: index, time: time)
    }
}

extension CompetitionViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.doing.showLanguage)
    }
}
extension CompetitionViewController: CompetitionViewProtocol{
    func didGetList(competitionList: CollectionCompetitionEntity) {
        initLoadData(data: competitionList.competitionEntity ?? [])
    }
}
