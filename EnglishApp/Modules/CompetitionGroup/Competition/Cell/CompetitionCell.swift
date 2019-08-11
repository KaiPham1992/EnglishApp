//
//  CompetitionCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CompetitionCell: BaseTableCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCondition: UILabel!
    @IBOutlet weak var lbTimeStart: UILabel!
    @IBOutlet weak var lbCountTeam: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    var timer: Timer?
    
    var type: ResultCompetition = .result{
        didSet{
            if type == .result {
                btnJoin.setTitle(LocalizableKey.see_result.showLanguage.uppercased(), for: .normal)
            }
            if type == .competition{
                btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage.uppercased(), for: .normal)
            }
        }
    }
    
    @IBAction func clickFight(_ sender: Any) {
        actionFight?(self.status,(sender as! UIButton).tag)
    }
    
    
    override func prepareForReuse() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    var actionFight : ((_ status: String,_ tag: Int)->())?
    var competitionEntity: CompetitionEntity? {
        didSet {
            guard let competitionEntity = competitionEntity else { return }
            switch competitionEntity.status& {
            case "CANNOT_JOIN":
                btnJoin.isHidden = false
                btnJoin.backgroundColor = .clear
                btnJoin.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1), for: .normal)
                btnJoin.setTitle(LocalizableKey.not_correct.showLanguage.uppercased(), for: .normal)
                btnJoin.isUserInteractionEnabled = false
            case "CAN_JOIN":
                if let startTime = competitionEntity.startTime?.timeIntervalSince1970 {
                    let currentTime = Date().timeIntervalSince1970
                    btnJoin.isHidden = false
                    if startTime < currentTime {
                        if (competitionEntity.is_fight_joined ?? 0) == 0 {
                            btnJoin.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
                            btnJoin.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1), for: .normal)
                            btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage.uppercased(), for: .normal)
                            btnJoin.isUserInteractionEnabled = true
                        } else {
                            btnJoin.isHidden = true
                        }
                    } else {
                        btnJoin.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
                        btnJoin.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                        btnJoin.isUserInteractionEnabled = true
                        var distanceTime = Int(startTime - currentTime)
                        if timer == nil {
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
                                if distanceTime > 0 {
                                    self.processTime(time: distanceTime)
                                    distanceTime -= 1
                                } else {
                                    self.disableTimer()
                                }
                            })
                        }
                    }
                }
            case "DONE":
                btnJoin.isHidden = false
                btnJoin.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
                btnJoin.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                btnJoin.setTitle(LocalizableKey.see_result.showLanguage.uppercased(), for: .normal)
                btnJoin.isUserInteractionEnabled = true
            default:
                break
            }
            self.status = competitionEntity.status&
            lbName.text = competitionEntity.name
            lbCondition.text = "\(LocalizableKey.conditionCompetition.showLanguage)\(competitionEntity.rankName&)"
            if let startTime = competitionEntity.startTime{
                lbTimeStart.text = "\(LocalizableKey.timeStart.showLanguage)\(startTime.toString(dateFormat: AppDateFormat.commahhmmaddMMMyy))"
            }
            
            lbCountTeam.text = "\(LocalizableKey.countTeam.showLanguage)\(competitionEntity.countTeam&)\(LocalizableKey.team.showLanguage)"
            lbContent.attributedText = competitionEntity.content?.htmlToAttributedString
            
        }
    }
    
    func disableTimer(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        btnJoin.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
        btnJoin.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1), for: .normal)
        btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage.uppercased(), for: .normal)
        btnJoin.isUserInteractionEnabled = true
    }
    
    func processTime(time: Int) {
        DispatchQueue.global().async {
            let hour : Int = time / 3600
            let min = (time - hour * 3600)/60
            let milisecond = time  % 60
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.btnJoin.setTitle("\(hour):\(min):\(milisecond < 10 ? "0\(milisecond)" : "\(milisecond)")", for: .normal)
                }
            }
        }
        
        
        
    }
    
    var status : String = "CANNOT_JOIN"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
