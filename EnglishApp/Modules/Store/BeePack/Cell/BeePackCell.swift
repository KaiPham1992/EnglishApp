//
//  BeePackCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class BeePackCell: BaseTableCell {
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var background: UIView!
    
    var item: ProductEntity? {
        didSet {
            guard let bee = item else { return }
//            imgIcon.sd_setImage(with: bee.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
            var name = ""
            if LanguageHelper.currentAppleLanguage() == "en" {
                name = bee.nameEn&
            } else {
                name = bee.name&
            }
            lbMoney.text = "\(bee.money&) VND\n \(name)"
//            imgIcon.image = bee.image
//            lbMoney.text = bee.money?.description&
//            imgBackground.image = bee.background
            let color = UIColor(hexString: bee.color ?? "")
            background.backgroundColor = color
            imgIcon.sd_setImage(with: bee.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
        }
    }
}
