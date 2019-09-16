//
//  ProfileHeader.swift
//  EnglishApp
//
//  Created by Henry on 9/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ProfileHeader: BaseTableCell {
    @IBOutlet weak var lbBee: UILabel!
    @IBOutlet weak var lbDiamon: UILabel!
    
    @IBOutlet weak var lbTitleBee: UILabel!
    @IBOutlet weak var lbTitleDiamon: UILabel!
    
    @IBOutlet weak var vDisplayName: AppTextField!
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vLocation: AppTextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgBorder: UIView!
    
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbPoint: UILabel!

    var user = UserEntity() {
        didSet {
            displayData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgBorder.setBorder(borderWidth: 4, borderColor: AppColor.yellow, cornerRadius: 35)
        setUpView()
    }
    
    func setUpView() {
        
        vDisplayName.setTitleAndPlaceHolder(title: LocalizableKey.DisplayName.showLanguage)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.LoginEmail.showLanguage)
        vLocation.setTitleAndPlaceHolder(title: LocalizableKey.Location.showLanguage)
        lbTitleBee.text = LocalizableKey.titleBee.showLanguage
        lbTitleDiamon.text = LocalizableKey.titleDiamon.showLanguage

        vDisplayName.tfInput.isEnabled = false
        vEmail.tfInput.isEnabled = false
        vLocation.tfInput.isEnabled = false
    }
    func displayData() {
        imgAvatar.sd_setImage(with: user.urlRank, placeholderImage: AppImage.avatarDefault)
        vDisplayName.lbPlaceHolder.text = user.nameShowUI
        vEmail.lbPlaceHolder.text = user.email
        vLocation.lbPlaceHolder.text = user.national
        lbFullName.text = user.fullName
        lbLevel.text = user.rankName
        lbBee.text = user.amountHoney*.description + "\(LocalizableKey.boxHoney.showLanguage)"
        lbDiamon.text = user.amountDiamond*.description + "\(LocalizableKey.point.showLanguage)"
        lbDiamon.text = user.amountDiamond*.description + "\(LocalizableKey.point.showLanguage)"
    }
    
    
}
