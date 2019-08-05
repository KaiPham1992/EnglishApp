//
//  ChangeGiftTitleCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ChangeGiftTitleCell: BaseTableCell {
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbTitle.text = "\(LocalizableKey.exchangeTitle.showLanguage)"
    }
}
