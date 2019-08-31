//
//  DetailTeamCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import SDWebImage

class DetailTeamCell: BaseTableCell {
    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var imgLevel: UIImageView!
    
    var member: UserEntity? {
        didSet {
            guard let member = member else { return }
            lbName.attributedText = NSAttributedString(string: member.fullName ?? "")
            lbPoint.attributedText = NSAttributedString(string: member.rankName& + ": " + String(member.amountRank ?? 0))
            if (member.isLeader ?? 0) == 1{
                imgLevel.isHidden = false
                imgAvatar.sd_setImage(with: URL(string: BASE_URL_IMAGE + member.attachImg&), placeholderImage: UIImage(named: "ic_avatar_default")!, context: nil)
            } else {
                imgLevel.isHidden = true
                imgAvatar.sd_setImage(with: URL(string: BASE_URL_IMAGE + member.attachImg&), placeholderImage: UIImage(named: "ic_avatar_default")!, context: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
