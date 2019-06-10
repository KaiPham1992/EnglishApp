//
//  MenuCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class MenuItem {
    var imgIcon: UIImage?
    var title: String?
    var isSelected: Bool?
    
    init(imgIcon: UIImage, title: String) {
        self.imgIcon = imgIcon
        self.title = title
        self.isSelected = false
    }
    
    class func toArray() -> [MenuItem] {
        return [
        MenuItem(imgIcon: AppImage.imgInfo, title: LocalizableKey.MenuInfo.showLanguage),
        MenuItem(imgIcon: AppImage.imgTop, title: LocalizableKey.MenuTop.showLanguage),
        MenuItem(imgIcon: AppImage.imgQA, title: LocalizableKey.MenuQA.showLanguage),
        MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage),
        MenuItem(imgIcon: AppImage.imgSaved, title: LocalizableKey.MenuSaved.showLanguage),
        MenuItem(imgIcon: AppImage.imgHistoryCheck, title: LocalizableKey.MenuHistory.showLanguage),
        MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPrivacy.showLanguage),
        MenuItem(imgIcon: AppImage.imgChangePass, title: LocalizableKey.MenuChangePassword.showLanguage),
        MenuItem(imgIcon: AppImage.imgLogout, title: LocalizableKey.MenuLogout.showLanguage)
        ]
    }
}

class MenuCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    var menuItem: MenuItem? {
        didSet {
            guard let menuItem = menuItem else { return }
            lbTitle.text = menuItem.title
            imgIcon.image = menuItem.imgIcon
            guard let isSelected = menuItem.isSelected else { return }
            
            
            if isSelected {
                lbTitle.textColor = AppColor.color255_211_17
                imgIcon.tintColor = AppColor.color255_211_17
            } else {
                lbTitle.textColor = AppColor.color117_117_117
                imgIcon.tintColor = AppColor.color117_117_117
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
