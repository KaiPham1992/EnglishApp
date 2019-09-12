//
//  SelectTeamViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SelectTeamViewController: BaseTableViewController {

    
    @IBOutlet weak var btnCreateTeam: UIButton!
	var presenter: SelectTeamPresenterProtocol?
    @IBOutlet weak var tbTeam: UITableView!
    
    var maxMember = 0
    var competitionId: Int?
    var isCannotJoin = false
    var idMyTeam = 0
    var isFightJoined = 0
    
    var joinTeam : ((_ teamId: Int) -> ())?
    var leaveTeam : (() -> ())?
    var fightFinished : (() -> ())?

	override func viewDidLoad() {
        super.viewDidLoad()
        hideTabbar()
        if isCannotJoin {
            btnCreateTeam.isHidden = true
        }
        initTableView(tableView: tbTeam)
    }
    
    override func btnBackTapped() {
        showTabbar()
        self.pop()
    }
    
    override func callAPI() {
        super.callAPI()
        presenter?.getListFightTestTeam(competitionId: competitionId*, offset: self.offset)
    }
    
    override func registerXibFile() {
        super.registerXibFile()
        tbTeam.registerXibFile(SelectTeamCell.self)
    }

    override func setTitleUI() {
        super.setTitleUI()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.selectTeamJoin.showLanguage)
    }
    
    @IBAction func btnCreateGroup() {
        let isUserStudyPack = UserDefaultHelper.shared.loginUserInfo?.isUserStudyPack ?? false
        let isUserPremium = UserDefaultHelper.shared.loginUserInfo?.isUserPremium ?? false
        if !isUserStudyPack && !isUserPremium {
            PopUpHelper.shared.showUpdateFeature(completeUpdate: {[unowned self] in
                let vc = StudyPackDetailRouter.createModule(id: "2")
                self.push(controller: vc)
            }) {
                
            }
        } else {
            PopUpHelper.shared.showCreateGroup(completionNo: {
            }) { [unowned self] (message) in
                let name = message?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
                if name.isEmpty {
                    PopUpHelper.shared.showError(message: " Vui lòng nhập tên nhóm", completionYes: {
                        
                    })
                } else {
                    self.presenter?.createTeam(id: self.competitionId ?? 0, name: message!)
                }
            }
        }
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = item as! TeamEntity
        let cell = tableView.dequeue(SelectTeamCell.self, for: indexPath)
        cell.displayData(maxMember: self.maxMember, team: data, isCannotJoin: self.isCannotJoin)
        cell.btnJoin.tag = indexPath.item
        cell.btnJoined.tag = indexPath.item
        cell.btnJoin.addTarget(self, action: #selector(btnJoinTapped), for: .touchUpInside)
        cell.btnJoined.addTarget(self, action: #selector(btnJoined), for: .touchUpInside)
        return cell
    }
    
    @objc func btnJoined(sender: UIButton) {
        let team = listData[sender.tag] as! TeamEntity
        let vc = DetailTeamRouter.createModule(id: team.id ?? "0", isTeamJoined: team.isTeamJoined ?? 0, isFightJoined: isFightJoined, isCannotJoin: self.isCannotJoin)
        vc.actionLeaveTeam = { [weak self] in
            self?.leaveTeamSuccessed()
        }
        vc.fightFinished = {[weak self] in
            self?.fightFinished?()
        }
        self.push(controller: vc)
    }
    
    private func leaveTeamSuccessed() {
        leaveTeam?()
        self.offset = 0
        self.isLoadmore = true
        self.presenter?.getListFightTestTeam(competitionId: self.competitionId ?? 0, offset: self.offset )
    }
    
    @objc func btnJoinTapped(sender: UIButton) {
        let team = listData[sender.tag] as! TeamEntity
        if let id = team.id {
            self.presenter?.joinTeam(id: id)
        }
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        let data = item as! TeamEntity
        if let id = data.id, let isTeamJoined = data.isTeamJoined {
            let vc = DetailTeamRouter.createModule(id: id, isTeamJoined: isTeamJoined, isFightJoined: isFightJoined, isCannotJoin: self.isCannotJoin)
            vc.actionLeaveTeam = { [weak self] in
               self?.leaveTeamSuccessed()
            }
            vc.fightFinished = {[weak self] in
                self?.fightFinished?()
            }
            self.push(controller: vc)
        }
    }
}

extension SelectTeamViewController: SelectTeamViewProtocol{
    
    func joinTeamFailed(error: APIError) {
        if error.message == "THIS USER JOINED TEAM" {
            PopUpHelper.shared.showError(message: "Bạn đã có nhóm không thể tạo và tham gia nhóm khác.", completionYes: nil)
        }
    }
    
    func joinTeamSuccessed(respone: DetailTeamEntity) {
        joinTeam?(Int(respone.team_info?.id ?? "0") ?? 0)
        self.isFightJoined = 1
        let vc = DetailTeamRouter.createModule(id: respone.team_info?.id ?? "0", isTeamJoined: 1, isFightJoined: isFightJoined, isCannotJoin: self.isCannotJoin)
        vc.actionBackView = { [weak self] in
            self?.offset = 0
            self?.isLoadmore = true
            self?.presenter?.getListFightTestTeam(competitionId: self?.competitionId ?? 0, offset: self?.offset ?? 0)
        }
        vc.actionLeaveTeam = { [weak self] in
            self?.leaveTeamSuccessed()
        }
        vc.fightFinished = {[weak self] in
            self?.fightFinished?()
        }
        self.push(controller: vc)
    }
    
    func didGetListFightTestTeam(error: APIError) {
        if error.message == "THIS USER CREATED AND JOINED TEAM" {
            PopUpHelper.shared.showError(message: "Bạn đã có nhóm không thể tạo và tham gia nhóm khác.", completionYes: nil)
        }
    }
    
    func didGetListFightTestTeam(collectionTeam: CollectionTeamEntity) {
        guard  let _maxMember = collectionTeam.maxMember else {
            showNoData()
            return
        }
        self.maxMember = _maxMember
        self.isFightJoined = collectionTeam.isFightJoined ?? 0
        initLoadData(data: collectionTeam.teams)
        if listData.count > 0 {
            let data = listData[0] as! TeamEntity
            if (data.isTeamJoined ?? 0) == 1 {
                self.idMyTeam = Int(data.id ?? "0") ?? 0
            }
        }
    }
    
    func didCreateTeamSuccessed(collectionTeam: TeamEntity){
        joinTeam?(Int(collectionTeam.id ?? "0") ?? 0)
        self.isFightJoined = 1
        collectionTeam.isTeamJoined = 1
        collectionTeam.countMember = "1"
        collectionTeam.attachImgSrc = UserDefaultHelper.shared.loginUserInfo?.attachImg ?? ""
        self.addData(data: collectionTeam, index: 0)
    }
}
