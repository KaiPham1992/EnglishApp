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
            if competitionEntity.is_fight_joined& == "0"{
                btnJoin.isHidden = false
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
