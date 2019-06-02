//
//  ChangeLanguageCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ChangeLanguageCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    var language: LanguageEntity? {
        didSet {
            guard let language = language else { return }
            lbTitle.text = language.name&
            
            guard let isSelected = language.isSelected else { return }
            if isSelected {
                imgIcon.image = AppImage.imgRadioChecked
            } else {
                imgIcon.image = AppImage.imgRadioUnChecked
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
