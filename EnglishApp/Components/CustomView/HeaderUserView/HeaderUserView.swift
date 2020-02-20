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
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnGotoProfile: UIButton!
    var callbackGotoProfile : (()->())?
    var user: UserEntity? {
        didSet {
            guard let user = user else { return }
            if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
                viewProfile.isHidden = true
                lblLogin.attributedText = NSAttributedString(string: LocalizableKey.user_not_login.showLanguage)
//                btnGotoProfile.setTitle(LocalizableKey.user_not_login.showLanguage, for: .normal)
            } else {
                lblLogin.attributedText = NSAttributedString(string: "")
                viewProfile.isHidden = false
//                btnGotoProfile.setTitle("", for: .normal)
            }
            lbDiamond.text = user.amountDiamond*.description
            lbHoney.text = user.amountHoney*.description
            lbFullName.text = user.fullName
            imgAvatar.sd_setImage(with: user.urlRank, placeholderImage: AppImage.avatarDefault)
        }
    }
    
    @IBAction func goToProfile() {
        callbackGotoProfile?()
    }
    
    override func setUpViews() {
        super.setUpViews()
        btnGotoProfile.setTitle("", for: .normal)
        lblLogin.textColor = AppColor.color117_117_117
        viewProfile.isHidden = true
//        btnGotoProfile.setTitle(LocalizableKey.user_not_login.showLanguage, for: .normal)
        self.backgroundColor = AppColor.yellow
    }
    
    
}
