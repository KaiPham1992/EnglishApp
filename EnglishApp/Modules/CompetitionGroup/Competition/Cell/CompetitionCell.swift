//
//  CompetitionCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol TimerCompetitionDelegate : class {
    func callbackTimer(index: IndexPath, time: Int)
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
        actionFight?(self.status, self.indexPath?.row ?? 0 )
    }
    var indexPath: IndexPath?
    var callbackTimer: ((_ index: IndexPath, _ time: Int) -> ())?
    var type: ResultCompetition = .result{
        didSet{
            if type == .result {
                lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.see_result.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
                viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            }
        }
    }
    
    @IBAction func clickFight(_ sender: Any) {
        
    }
    
    var actionFight : ((_ status: String,_ tag: Int)->())?
    
    var competitionEntity: CompetitionEntity? {
        didSet {
            guard let competitionEntity = competitionEntity else { return }
            viewButtonCompetition.isHidden = false
            btnCompetition.isHidden = false
            switch competitionEntity.status& {
            case "START":
                let isJoined = competitionEntity.is_fight_joined ?? 0
                if isJoined == 0 {
                    viewButtonCompetition.isHidden = true
                    btnCompetition.isHidden = true
                } else {
                    viewButtonCompetition.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
                    lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)])
                }
            case "CANNOT_JOIN":
                lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.not_qualify.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1)])
                viewButtonCompetition.backgroundColor = .white
            case "DOING":
                lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.see_result.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
                viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
                viewButtonCompetition.alpha = 0.8
                viewButtonCompetition.isUserInteractionEnabled = false
            case "CAN_JOIN":
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
                            } else {
                                let distanceTime = Int(startTime - currentTime)
                                lblTitleButtonCompetition.attributedText = NSAttributedString(string: distanceTime.convertMilisecondsToTime(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
                                delegate?.callbackTimer(index: self.indexPath ?? IndexPath(row: 0, section: 0), time: distanceTime)
                                viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
                            }
                        }
                    }
                }
            case "DONE":
                lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.see_result.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
                viewButtonCompetition.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
                viewButtonCompetition.alpha = 1
                viewButtonCompetition.isUserInteractionEnabled = true
            default:
                break
            }
            self.status = competitionEntity.status&
            lbName.attributedText = NSAttributedString(string: competitionEntity.name ?? "")
            lbCondition.attributedText = NSAttributedString(string: "\(LocalizableKey.conditionCompetition.showLanguage)\(competitionEntity.rankName&)")
            if type == .competition {
                btnShare.isHidden = false
                if let startTime = competitionEntity.startTime{
                    lbTimeStart.attributedText = NSAttributedString(string: "\(LocalizableKey.timeStart.showLanguage) \(startTime.toString(dateFormat: AppDateFormat.hhmm))h")
                }
            } else {
                btnShare.isHidden = true
                if let startDate = competitionEntity.startDate{
                    lbTimeStart.attributedText = NSAttributedString(string: "\(LocalizableKey.time.showLanguage) \(startDate.toString(dateFormat: AppDateFormat.HHmmddMMyyyy))")
                }
            }
            
            lbCountTeam.attributedText = NSAttributedString(string: "\(competitionEntity.countTeam&)\(LocalizableKey.team.showLanguage)")
            lbContent.attributedText = NSAttributedString(string: competitionEntity.content?.htmlToString ?? "", attributes: [NSAttributedString.Key.font : AppFont.fontRegular14])
            
        }
    }
    
    func processTime(time: Int) {
        if time > 0 {
            lblTitleButtonCompetition.attributedText = NSAttributedString(string: time.convertMilisecondsToTime(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        } else {
            self.callbackTimer?(self.indexPath ?? IndexPath(row: 0, section: 0), 0)
            viewButtonCompetition.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            lblTitleButtonCompetition.attributedText = NSAttributedString(string: LocalizableKey.start.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1)])
        }
        
    }
    
    var status : String = "CANNOT_JOIN"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
