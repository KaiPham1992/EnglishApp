//
//  CellResultCompetition.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultCompetition: UITableViewCell {

    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblNameTeam: UILabel!
    @IBOutlet weak var imgAVTTeam: UIImageView!
    @IBOutlet weak var imgRank: UIImageView!
    @IBOutlet weak var lbRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setupData(dataCell: CompetitionResultTeamEntity){
        imgAVTTeam.sd_setImage(with: URL(string:BASE_URL_IMAGE + dataCell.img_src&), placeholderImage: #imageLiteral(resourceName: "avatarDefautl"), completed: nil)
        lblNameTeam.text = dataCell.name
        lblPoint.attributedText =  NSAttributedString(string: dataCell.total_score& + " " + LocalizableKey.point.showLanguage)
        let rank : Int = dataCell.position ?? 0
        if rank == 1 {
            lbRank.isHidden = true
            imgRank.image = #imageLiteral(resourceName: "001-gold-medal")
            return
        }
        if rank == 2{
            lbRank.isHidden = true
            imgRank.image = #imageLiteral(resourceName: "ic_silver-medal")
            return
        }
        if rank == 3{
            lbRank.isHidden = true
            imgRank.image = #imageLiteral(resourceName: "ic_bronze-medal")
            return
        }
        lbRank.isHidden = false
        imgRank.isHidden = true
        lbRank.text = LocalizableKey.rank.showLanguage + " \(rank)"
    }
}
