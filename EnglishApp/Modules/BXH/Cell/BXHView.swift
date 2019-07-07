//
//  BXHView.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class BXHView: BaseViewXib {

    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!

    var user = UserEntity(){
        didSet{
            lbLevel.text = user.level&
            lbName.text = user.nameShowUI
            lbRank.text = "\(user.rankName&): \(user.rankPoint&) \(LocalizableKey.point.showLanguage)"
            imgAvatar.sd_setImage(with: user.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
            
        }
    }
    
    @IBOutlet weak var vBackground: UIView!
    override func setUpViews() {
        super.setUpViews()
    }
}
