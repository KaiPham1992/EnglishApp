//
//  CellResultCompetition.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultCompetition: UITableViewCell {

    @IBOutlet weak var imgRank: UIImageView!
    @IBOutlet weak var lbRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setupData(rank: Int){
        if rank == 0 {
            lbRank.isHidden = true
            imgRank.image = #imageLiteral(resourceName: "001-gold-medal")
            return
        }
        if rank == 1{
            lbRank.isHidden = true
            imgRank.image = #imageLiteral(resourceName: "ic_silver-medal")
            return
        }
        if rank == 2{
            lbRank.isHidden = true
            imgRank.image = #imageLiteral(resourceName: "ic_bronze-medal")
            return
        }
        lbRank.isHidden = false
        imgRank.isHidden = true
        lbRank.text = "Hang \(rank + 1)"
    }
}
