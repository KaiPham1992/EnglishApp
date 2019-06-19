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
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var lbDiamond: UILabel!
    @IBOutlet weak var lbHoney: UILabel!
    @IBOutlet weak var lbFullName: UILabel!
    
    var user: UserEntity? {
        didSet {
            guard let user = user else { return }
            lbPoint.text = user.amountPoint*.description
            lbDiamond.text = user.amountDiamond*.description
            lbHoney.text = user.amountHoney*.description
            lbFullName.text = user.fullName
            imgAvatar.sd_setImage(with: user.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
        }
    }
    
    
    @IBAction func btnGoToProfile() {
        AppRouter.shared.pushTo(viewController: ProfileRouter.createModule())
        NotificationCenter.default.post(name: NSNotification.Name.init("HideMenu"), object: nil)
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        self.backgroundColor = AppColor.yellow
        
        imgAvatar.setBorder(borderWidth: 1, borderColor: .white, cornerRadius: 21)
    }
    
    
}
