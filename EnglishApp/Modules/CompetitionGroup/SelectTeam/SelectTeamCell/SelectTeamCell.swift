//
//  SelectTeamCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class SelectTeamCell: BaseTableCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCountMember: UILabel!
    @IBOutlet weak var btnJoin: UIButton!
    
    var team: TeamEntity? {
        didSet {
            guard let team = team else { return }
            lbName.text = team.name
            lbCountMember.text = "\(team.countMember*)/50"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage.uppercased(), for: .normal)
    }
}
