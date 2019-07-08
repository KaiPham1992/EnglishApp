//
//  TopThreeView.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class TopThreeView: BaseViewXib {
    @IBOutlet weak var lbNametop1: UILabel!
    @IBOutlet weak var lbPointtop1: UILabel!
    
    @IBOutlet weak var lbNametop2: UILabel!
    @IBOutlet weak var lbPointtop2: UILabel!
    
    @IBOutlet weak var lbNametop3: UILabel!
    @IBOutlet weak var lbPointtop3: UILabel!
    
    @IBOutlet weak var imgAvatar1: UIImageView!
    @IBOutlet weak var widthAvartar1: NSLayoutConstraint!
    @IBOutlet weak var widthContent1: NSLayoutConstraint!
    
    @IBOutlet weak var imgAvatar2: UIImageView!
    @IBOutlet weak var widthAvartar2: NSLayoutConstraint!
    @IBOutlet weak var widthContent2: NSLayoutConstraint!

    @IBOutlet weak var imgAvatar3: UIImageView!
    @IBOutlet weak var widthAvartar3: NSLayoutConstraint!
    @IBOutlet weak var widthContent3: NSLayoutConstraint!
    
    var listTopThree : [UserEntity]?{
        didSet{
            guard let listTopThree = listTopThree else { return }
            if listTopThree.count < 2 {
                return
            }
            
            lbNametop1.text = listTopThree[0].nameShowUI
            lbNametop2.text = listTopThree[1].nameShowUI
            lbNametop3.text = listTopThree[2].nameShowUI
            
            if let point1 = listTopThree[0].rankPoint,
                let point2 = listTopThree[1].rankPoint,
                let point3 = listTopThree[2].rankPoint
                {
                lbPointtop1.text = "\(point1) \(LocalizableKey.point.showLanguage)"
                lbPointtop2.text = "\(point2) \(LocalizableKey.point.showLanguage)"
                lbPointtop3.text = "\(point3) \(LocalizableKey.point.showLanguage)"
            }
//            print(listTopThree?[0].urlAvatar)
            imgAvatar1.sd_setImage(with: listTopThree[0].urlAvatar, placeholderImage: AppImage.avatarDefault)
            imgAvatar2.sd_setImage(with: listTopThree[1].urlAvatar, placeholderImage: AppImage.avatarDefault)
            imgAvatar3.sd_setImage(with: listTopThree[2].urlAvatar, placeholderImage: AppImage.avatarDefault)
            
        }
    }
        
    override func setUpViews() {
        super.setUpViews()
        if UIDevice.current.isIphone4Inch() {
            lbNametop1.font = AppFont.fontRegular8
            lbNametop2.font = AppFont.fontRegular8
            lbNametop3.font = AppFont.fontRegular8
            
            lbPointtop1.font = AppFont.fontRegular8
            lbPointtop2.font = AppFont.fontRegular8
            lbPointtop3.font = AppFont.fontRegular8
            
            widthAvartar1.constant = 60
            widthContent1.constant = 100
            imgAvatar1.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 30)
            
            widthAvartar2.constant = 60
            widthContent2.constant = 100
            imgAvatar2.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 30)
            
            widthAvartar3.constant = 60
            widthContent3.constant = 100
            imgAvatar3.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 30)
        }
        
    }
   
}
