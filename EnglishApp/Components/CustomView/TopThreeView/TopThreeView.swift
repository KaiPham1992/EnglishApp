//
//  TopThreeView.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    @IBOutlet weak var viewTop1: UIView!
    @IBOutlet weak var viewTop2: UIView!
    @IBOutlet weak var viewTop3: UIView!
    
    var listTopThree : [UserEntity]?{
        didSet{
            guard let listTopThree = listTopThree else { return }
            if listTopThree.count == 0 {return}
            
            lbNametop1.text = listTopThree[0].nameShowUI
            if let point1 = listTopThree[0].rankPoint {
                lbPointtop1.text = "\(point1) \(LocalizableKey.point.showLanguage)"
            }
            imgAvatar1.sd_setImage(with: listTopThree[0].urlAvatar, placeholderImage: AppImage.avatarDefault)
            if listTopThree.count == 1 {
                viewTop2.isHidden = true
                viewTop3.isHidden = true
                return
                
            }
            
            lbNametop2.text = listTopThree[1].nameShowUI
            if let point2 = listTopThree[1].rankPoint {
                lbPointtop2.text = "\(point2) \(LocalizableKey.point.showLanguage)"

            }
            imgAvatar2.sd_setImage(with: listTopThree[1].urlAvatar, placeholderImage: AppImage.avatarDefault)
            if listTopThree.count == 2 {
                viewTop3.isHidden = true
                return
            }
            
            lbNametop3.text = listTopThree[2].nameShowUI
            if let point3 = listTopThree[2].rankPoint {
                lbPointtop3.text = "\(point3) \(LocalizableKey.point.showLanguage)"
            }
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
