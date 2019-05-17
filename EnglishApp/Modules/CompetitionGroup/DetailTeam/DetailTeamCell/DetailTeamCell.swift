//
//  DetailTeamCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class DetailTeamCell: UITableViewCell {
    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var imgLevel: UIImageView!
    
    var member: UserEntity? {
        didSet {
            guard let member = member else { return }
            lbName.text = member.fullName
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
