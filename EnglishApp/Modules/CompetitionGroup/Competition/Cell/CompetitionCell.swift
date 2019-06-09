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
            if type == .result{
                btnJoin.setTitle(LocalizableKey.see_explain.showLanguage, for: .normal)
            }
            if type == .competition{
                btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage, for: .normal)
            }
        }
    }
    
    var competitionEntity: CompetitionEntity? {
        didSet {
            guard let competitionEntity = competitionEntity else { return }
            lbName.text = competitionEntity.name
            lbCondition.text = "\(LocalizableKey.conditionCompetition.showLanguage)\(competitionEntity.condition&)"
            lbTimeStart.text = competitionEntity.timeStart
            lbCountTeam.text = competitionEntity.countTeam
            lbContent.text = competitionEntity.content
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
