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
    @IBOutlet weak var imgTeam: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnJoin.setTitle(LocalizableKey.joinTeam.showLanguage.uppercased(), for: .normal)
    }
    func displayData(maxMember: Int, team: TeamEntity){
        lbName.text = team.name
        lbCountMember.text = "\(team.countMember*)/\(maxMember*)"
        imgTeam.sd_setImage(with: team.urlImage, placeholderImage: AppImage.avatarDefault)
        if team.isTeamJoined ?? false{
            btnJoin.isHidden = true
        }else{
            btnJoin.isHidden = false
        }
    }
}
