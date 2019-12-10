//
//  CompetitionCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol TimerCompetitionDelegate : class {
    func callbackTimer(index: Int, time: Int)
}


class CompetitionCell: BaseTableCell {
    @IBOutlet weak var btnCompetition: UIButton!
    @IBOutlet weak var lblTitleButtonCompetition: UILabel!
    @IBOutlet weak var viewButtonCompetition: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCondition: UILabel!
    @IBOutlet weak var lbTimeStart: UILabel!
    @IBOutlet weak var lbCountTeam: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    
    weak var delegate: TimerCompetitionDelegate?
    
    @IBAction func competition(_ sender: Any) {
        actionFight?(index)
    }
    
    var index: Int!
    var callbackTimer: ((_ index: Int, _ time: Int) -> ())?

    func setupCellResult(competitionEntity: CompetitionResultsProfileEntity){
        lbName.attributedText = NSAttributedString(string: competitionEntity.name ?? "")
        lbCondition.attributedText = NSAttributedString(string: "\(LocalizableKey.conditionCompetition.showLanguage)\(competitionEntity.rank_name&)")
        lbCountTeam.attributedText = NSAttributedString(string: "\(competitionEntity.number_team&) \(LocalizableKey.team.showLanguage)")
        lbContent.attributedText = NSAttributedString(string: competitionEntity.description?.htmlToString ?? "", attributes: [NSAttributedString.Key.font : AppFont.fontRegular14])
        btnShare.isHidden = true
        if let startDate = competitionEntity.start_date {
            lbTimeStart.attributedText = NSAttributedString(string: "\(LocalizableKey.time.showLanguage): \(startDate.toString(dateFormat: AppDateFormat.HHmmddMMyyyy))")
        }
        lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.see_result.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
    }
    
    func setupCellDone(competitionEntity: CompetitionEntity){
        self.parseBaseData(competitionEntity: competitionEntity)
        lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.see_result.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
    }
    
    var actionFight : ((_ index: Int)->())?
    
    func setupCellStart(competitionEntity: CompetitionEntity) {
        self.parseBaseData(competitionEntity: competitionEntity)
        let isJoined = competitionEntity.is_fight_joined ?? 0
        if isJoined == 0 {
            viewButtonCompetition.isHidden = true
            btnCompetition.isHidden = true
        } else {
            viewButtonCompetition.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)])
        }
    }
    
    func setupCellCannotJoin(competitionEntity: CompetitionEntity) {
        self.parseBaseData(competitionEntity: competitionEntity)
        lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.joinTeam.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1)])
    }
    
    func setupCellDoing(competitionEntity: CompetitionEntity) {
        self.parseBaseData(competitionEntity: competitionEntity)
        lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.see_result.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
        viewButtonCompetition.alpha = 0.8
        viewButtonCompetition.isUserInteractionEnabled = false
    }
    
    func setupCellCanjoin(competitionEntity: CompetitionEntity){
        self.parseBaseData(competitionEntity: competitionEntity)
        viewButtonCompetition.alpha = 1
        viewButtonCompetition.isUserInteractionEnabled = true
        if competitionEntity.isHidden {
            viewButtonCompetition.isHidden = true
            lblTitleButtonCompetition.text = ""
        } else {
            viewButtonCompetition.isHidden = false
            if (competitionEntity.is_fight_joined ?? 0) == 0 {
                lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.joinTeam.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)])
                viewButtonCompetition.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            } else {
                lblTitleButtonCompetition.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
                if let startTime = competitionEntity.startTime?.timeIntervalSince1970 {
                    let currentTime = Date().timeIntervalSince1970
                    if startTime < currentTime {
                        viewButtonCompetition.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
                        lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)])
                        delegate?.callbackTimer(index: -1, time: -1)
                    } else {
                        let distanceTime = Int(startTime - currentTime)
                        lblTitleButtonCompetition.attributedText = NSAttributedString(string: distanceTime.convertMilisecondsToTime(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
                        delegate?.callbackTimer(index: self.index, time: distanceTime)
                        viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
                    }
                }
            }
        }
    }
    
    func parseBaseData(competitionEntity: CompetitionEntity) {
        lbName.attributedText = NSAttributedString(string: competitionEntity.name ?? "")
        lbCondition.attributedText = NSAttributedString(string: "\(LocalizableKey.conditionCompetition.showLanguage)\(competitionEntity.rankName&)")
        btnShare.isHidden = false
        if let startTime = competitionEntity.startTime {
            lbTimeStart.attributedText = NSAttributedString(string: "\(LocalizableKey.timeStart.showLanguage) \(startTime.toString(dateFormat: AppDateFormat.hhmm))")
        }
        lbCountTeam.attributedText = NSAttributedString(string: "\(competitionEntity.countTeam&) \(LocalizableKey.team.showLanguage)")
        self.lbContent.attributedText = competitionEntity.contentHtml
    }
    
    func processTime(time: Int) {
        if time > 0 {
            lblTitleButtonCompetition.attributedText = NSAttributedString(string: time.convertMilisecondsToTime(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        } else {
            self.callbackTimer?(self.index, 0)
            viewButtonCompetition.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)])
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewButtonCompetition.isHidden = false
        btnCompetition.isHidden = false
    }
    
}
