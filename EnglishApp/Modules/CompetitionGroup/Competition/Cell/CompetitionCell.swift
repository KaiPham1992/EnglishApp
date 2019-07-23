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
    var type: ResultCompetition = .result{
        didSet{
            if type == .result {
                btnJoin.setTitle(LocalizableKey.see_explain.showLanguage, for: .normal)
            }
            if type == .competition{
                btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage.uppercased(), for: .normal)
            }
        }
    }
    
    var competitionEntity: CompetitionEntity? {
        didSet {
            guard let competitionEntity = competitionEntity else { return }
            if (competitionEntity.can_join ?? 0) == 0 {
                btnJoin.isHidden = false
                btnJoin.backgroundColor = .clear
                btnJoin.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1), for: .normal)
                btnJoin.setTitle(LocalizableKey.not_correct.showLanguage.uppercased(), for: .normal)
                btnJoin.isUserInteractionEnabled = false
            } else {
                btnJoin.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                btnJoin.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.08235294118, blue: 0.03137254902, alpha: 1), for: .normal)
                btnJoin.isUserInteractionEnabled = true
                if competitionEntity.is_fight_joined& == "0"{
                    btnJoin.isHidden = false
                }
            }
            
            lbName.text = competitionEntity.name
            lbCondition.text = "\(LocalizableKey.conditionCompetition.showLanguage)\(competitionEntity.rankName&)"
            if let startTime = competitionEntity.startTime{
                lbTimeStart.text = "\(LocalizableKey.timeStart.showLanguage)\(startTime.toString(dateFormat: AppDateFormat.commahhmmaddMMMyy))"
            }
            
            lbCountTeam.text = "\(LocalizableKey.countTeam.showLanguage)\(competitionEntity.countTeam&)\(LocalizableKey.team.showLanguage)"
            lbContent.text = competitionEntity.content
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
