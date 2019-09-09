//
//  CellRankTeam.swift
//  EnglishApp
//
//  Created by Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import SDWebImage

class CellRankTeam: UICollectionViewCell {

    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var imgAvtTeam: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(dataCell: RankTeamEntity){
        let position = dataCell.position ?? 0
        if position == 1 {
            lblRank.textColor = .red
        } else {
            lblRank.textColor = .black
        }
        lblRank.attributedText = NSAttributedString(string: LocalizableKey.rank.showLanguage + "\(position)")
        lblPoint.attributedText = NSAttributedString(string: "\(dataCell.total_score ?? "0") " + LocalizableKey.point.showLanguage)
        imgAvtTeam.sd_setImage(with: URL(string: BASE_URL + dataCell.img_src&), placeholderImage: #imageLiteral(resourceName: "ic_avatar_default") ,completed: nil)
    }
}
