//
//  SelectTeamCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class SelectTeamCell: BaseTableCell {

    @IBOutlet weak var heightBtnJoin: NSLayoutConstraint!
    @IBOutlet weak var btnJoined: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCountMember: UILabel!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var imgTeam: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnJoin.setTitle(LocalizableKey.join_team.showLanguage.uppercased(), for: .normal)
    }
    func displayData(maxMember: Int, team: TeamEntity, isCannotJoin: Bool){
        lbName.text = team.name
        lbCountMember.text = "\(team.countMember*)/\(maxMember*)"
        imgTeam.sd_setImage(with: URL(string: BASE_URL_IMAGE + team.attachImgSrc&) , placeholderImage: AppImage.avatarDefault)
        if isCannotJoin {
            btnJoined.isHidden = true
            heightBtnJoin.constant = 0
        } else {
            if (team.isTeamJoined ?? 0) == 0 {
                btnJoined.isHidden = true
                if Int(team.countMember&) == maxMember {
                    heightBtnJoin.constant = 0
                } else {
                    heightBtnJoin.constant = 24
                }
            } else {
                btnJoined.isHidden = false
                heightBtnJoin.constant = 0
            }
        }
    }
}
