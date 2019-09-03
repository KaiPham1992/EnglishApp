//
//  DetailTeamViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailTeamViewController: BaseTableViewController {

    @IBOutlet weak var lblTitleButtonStart: UILabel!
    @IBOutlet weak var viewButtonStart: UIView!
    
    @IBAction func start(_ sender: Any) {
        if timer == nil {
            let vc = FightRouter.createModule(completion_id: Int(self.presenter?.teamDetail?.team_info?.competition_id ?? "0") ?? 0, team_id: Int(self.presenter?.teamDetail?.team_info?.id ?? "0") ?? 0)
            vc.fightFinished = {[weak self] in
                self?.fightFinished?()
            }
            self.push(controller: vc)
        }
    }
    
    @IBOutlet weak var lblMember: UILabel!
    var presenter: DetailTeamPresenterProtocol?
    @IBOutlet weak var tbTeam: UITableView!
    @IBOutlet weak var btnExplain: UIButton!
    @IBOutlet weak var btnLeave: UIButton!
    var id: String = "0"
    var actionLeaveTeam : (()->())?
    var actionBackView: (() -> ())?
    var distanceTimeMi : Int = 0
    var timer : Timer?
    var isTeamJoined = 1
    var isFightJoined = 0
    
    var fightFinished : (() -> ())?
    
	override func viewDidLoad() {
        addLoadmore = false
        self.isAddPullToFresh = false
        super.viewDidLoad()
        initTableView(tableView: tbTeam)
    }
    
    override func callAPI() {
        super.callAPI()
        self.presenter?.getDetailTeam(id: self.id)
    }
    
    override func registerXibFile() {
        super.registerXibFile()
        self.tbTeam.registerXibFile(DetailTeamCell.self)
    }

    override func setTitleUI() {
        super.setTitleUI()
        addBackToNavigation()
        lblTitleButtonStart.attributedText = NSAttributedString(string: LocalizableKey.startAfter.showLanguage.uppercased())
        btnExplain.setAttributedTitle(NSAttributedString(string: LocalizableKey.explainConpetition.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)]), for: .normal)
        btnLeave.setAttributedTitle(NSAttributedString(string: LocalizableKey.leaveTeam.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)]), for: .normal)
        if isFightJoined == 0 {
            btnLeave.isHidden = true
            viewButtonStart.isHidden = true
        } else {
            if isTeamJoined == 0 {
                btnLeave.isHidden = true
            } else {
                btnLeave.isHidden = false
                viewButtonStart.isHidden = false
            }
        }
    }

    @IBAction func btnExplainTapped() {
        self.push(controller: ExplainCompetitionRouter.createModule(idCompetition: self.presenter?.teamDetail?.team_info?.competition_id ?? "0"))
    }
    
    @IBAction func btnLeaveTapped() {
        if timer != nil {
            PopUpHelper.shared.showLeaveGroup(completionNo: {
                
            }) {
                self.presenter?.leaveTeam(id: self.id)
            }
        } else {
            PopUpHelper.shared.showError(message: LocalizableKey.out_group_message.showLanguage) {
                
            }
        }
    }
    override func btnBackTapped() {
        actionBackView?()
        super.btnBackTapped()
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = item as! UserEntity
        let cell = tableView.dequeue(DetailTeamCell.self, for: indexPath)
        cell.lbIndex.text = "\(indexPath.item + 1)"
        cell.member = dataCell
        return cell
    }
}

extension DetailTeamViewController : DetailTeamViewProtocol {
    func reloadView() {
        DispatchQueue.global().async {
            guard let teamInfor = self.presenter?.teamDetail?.team_info else { return }
            self.id = teamInfor.id ?? "0"
            let startMi = TimeInterval(teamInfor.start_date?.timeIntervalSince1970 ?? 0)
            let currentTimeMi = Date().timeIntervalSince1970
            self.distanceTimeMi = Int(startMi - currentTimeMi)
            DispatchQueue.main.async {
                self.setTitleNavigation(title: teamInfor.name&)
                self.lblMember.text = teamInfor.toPercentMember()
                if self.distanceTimeMi > 0 {
                   self.lblTitleButtonStart.attributedText = NSAttributedString(string: LocalizableKey.startAfter.showLanguage.uppercased() + " " + self.distanceTimeMi.convertMilisecondsToTime())
                    if self.timer == nil {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
                            if self.distanceTimeMi > 0 {
                                self.processTime(time: self.distanceTimeMi)
                                self.distanceTimeMi -= 1
                            } else {
                                self.disableTimer()
                            }
                        })
                    }
                } else {
                    self.lblTitleButtonStart.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased())
                }
                self.initLoadData(data: self.presenter?.teamDetail?.members ?? [])
            }
        }
    }
    
    func disableTimer(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        btnLeave.isHidden = true
        self.lblTitleButtonStart.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased())
    }
    
    func processTime(time: Int) {
        self.lblTitleButtonStart.attributedText = NSAttributedString(string: LocalizableKey.startAfter.showLanguage.uppercased() + " " + time.convertMilisecondsToTime())
    }
    
    func leaveTeamSuccessed() {
        actionLeaveTeam?()
        self.pop(animated: true)
    }
}
