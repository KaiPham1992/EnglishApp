//
//  HeaderUserView.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HeaderUserView: BaseViewXib {
    @IBOutlet weak var imgAvatar: UIImageView!
//    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var lbDiamond: UILabel!
    @IBOutlet weak var lbHoney: UILabel!
    @IBOutlet weak var lbFullName: UILabel!
//    @IBOutlet weak var imgRank: UIImageView!
    
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnGotoProfile: UIButton!
    var callbackGotoProfile : (()->())?
    var user: UserEntity? {
        didSet {
            guard let user = user else { return }
//            lbPoint.text = user.rankName
            if user.email& == emailDefault {
                viewProfile.isHidden = true
                btnGotoProfile.setTitle(LocalizableKey.user_not_login.showLanguage, for: .normal)
                btnGotoProfile.setTitleColor(AppColor.color117_117_117, for: .normal)
            } else {
                viewProfile.isHidden = false
                btnGotoProfile.setTitle("", for: .normal)
            }
            lbDiamond.text = user.amountDiamond*.description
            lbHoney.text = user.amountHoney*.description
            lbFullName.text = user.fullName
            imgAvatar.sd_setImage(with: user.urlRank, placeholderImage: AppImage.avatarDefault)
//            imgRank.sd_setImage(with: user.urlRank, placeholderImage: AppImage.imgPlaceHolder)
        }
    }
    
    @IBAction func goToProfile() {
        callbackGotoProfile?()
    }
    
    override func setUpViews() {
        super.setUpViews()
        viewProfile.isHidden = true
        btnGotoProfile.setTitle(LocalizableKey.user_not_login.showLanguage, for: .normal)
        self.backgroundColor = AppColor.yellow
        
//        imgAvatar.setBorder(borderWidth: 1, borderColor: .white, cornerRadius: 21)
//        imgRank.setBorder(borderWidth: 1, borderColor: .white, cornerRadius: 8)
    }
    
    
}
