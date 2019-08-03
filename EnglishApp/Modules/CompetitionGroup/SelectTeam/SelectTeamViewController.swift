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

class SelectTeamViewController: BaseViewController {

	var presenter: SelectTeamPresenterProtocol?
    
    @IBOutlet weak var tbTeam: UITableView!
    
    var maxMember = 0
    var competitionId: Int?

    var listTeam = [TeamEntity]() {
        didSet {
            tbTeam.reloadData()
            
            if listTeam.count == 0 {
                showNoData()
            } else {
                hideNoData()
            }
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        
//        listTeam = TeamEntity.toArray()
        presenter?.getListFightTestTeam(competitionId: competitionId*)
        hideTabbar()
    }
    
    override func btnBackTapped() {
        showTabbar()
        self.pop()
    }

    override func setTitleUI() {
        super.setTitleUI()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.selectTeamJoin.showLanguage)
    }
    
    @IBAction func btnCreateGroup() {
        PopUpHelper.shared.showCreateGroup(completionNo: {
            
        }) { [unowned self] (message) in
            if let _message = message {
                self.presenter?.createTeam(id: self.competitionId ?? 0, name: _message)
            }
        }
    }
}


extension SelectTeamViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbTeam.delegate = self
        tbTeam.dataSource = self
        tbTeam.registerXibFile(SelectTeamCell.self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SelectTeamCell.self, for: indexPath)
        cell.displayData(maxMember: self.maxMember, team: listTeam[indexPath.item])
        cell.btnJoin.tag = indexPath.item
        cell.btnJoined.tag = indexPath.item
        cell.btnJoin.addTarget(self, action: #selector(btnJoinTapped), for: .touchUpInside)
        cell.btnJoined.addTarget(self, action: #selector(btnJoined), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTeam.count
    }
    
    @objc func btnJoined(sender: UIButton) {
        if let id = listTeam[sender.tag].id {
            let vc = DetailTeamRouter.createModule(id: id)
            vc.actionLeaveTeam = { [weak self] in
                self?.presenter?.getListFightTestTeam(competitionId: self?.competitionId ?? 0)
            }
            self.push(controller: vc)
        }
    }
    @objc func btnJoinTapped(sender: UIButton) {
//        if let id = listTeam[sender.tag].id {
//            let vc = DetailTeamRouter.createModule(id: id)
//            self.push(controller: vc)
//        }
        if let id = listTeam[sender.tag].id {
            self.presenter?.joinTeam(id: id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension SelectTeamViewController: SelectTeamViewProtocol{
    
    func joinTeamFailed(error: APIError) {
        PopUpHelper.shared.showError(message: error.message&, completionYes: nil)
    }
    
    func joinTeamSuccessed(respone: DetailTeamEntity) {
        let vc = DetailTeamRouter.createModule(teamDetail: respone)
        vc.actionBackView = { [weak self] in
            self?.presenter?.getListFightTestTeam(competitionId: Int(respone.team_info?.id ?? "0") ?? 0)
        }
        self.push(controller: vc)
    }
    
    func didGetListFightTestTeam(error: APIError) {
        PopUpHelper.shared.showError(message: error.message&, completionYes: nil)
    }
    func didGetListFightTestTeam(collectionTeam: CollectionTeamEntity) {
        guard  let _maxMember = collectionTeam.maxMember else {
            showNoData()
            return
        }
        self.listTeam = collectionTeam.teams
        self.maxMember = _maxMember
        tbTeam.reloadData()
    }
    func didCreateTeamSuccessed(collectionTeam: TeamEntity){
        collectionTeam.isTeamJoined = 1
        collectionTeam.countMember = "1"
        listTeam.append(collectionTeam) 
    }
}
