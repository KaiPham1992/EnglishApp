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
    var listTeam = [TeamEntity]() {
        didSet {
            tbTeam.reloadData()
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        
//        listTeam = TeamEntity.toArray()
        presenter?.getListFightTestTeam(competitionId: 1)
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
            print("Cancel")
        }) {
            print("Yes")
        }
    }
}


extension SelectTeamViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbTeam.delegate = self
        tbTeam.dataSource = self
        tbTeam.registerXibFile(SelectTeamCell.self)
        tbTeam.separatorStyle = .none
        
        tbTeam.estimatedRowHeight = 55
        tbTeam.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SelectTeamCell.self, for: indexPath)
        cell.displayData(maxMember: self.maxMember, team: listTeam[indexPath.item])
        cell.btnJoin.tag = indexPath.item
        cell.btnJoin.addTarget(self, action: #selector(btnJoinTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTeam.count
    }
    
    @objc func btnJoinTapped() {
        let vc = DetailTeamRouter.createModule()
        self.push(controller: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension SelectTeamViewController: SelectTeamViewProtocol{
    func didGetListFightTestTeam(error: Error) {
        print(error.localizedDescription)
    }
    func didGetListFightTestTeam(collectionTeam: CollectionTeamEntity) {
        guard let _listTeam = collectionTeam.teams, let _maxMember = collectionTeam.maxMember else {
            return
        }
        self.listTeam = _listTeam
        self.maxMember = _maxMember
    }
}
