//
//  HomeTitleCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HomeTitleCell: BaseTableCell {
    @IBOutlet weak var lbTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lbTitle.text = LocalizableKey.actionRecently.showLanguage
    }
}
