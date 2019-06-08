//
//  ThanksReportContent.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class LevelUpContent: BaseViewXib {
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnPackage: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbPackage: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        
        lbTitle.text = LocalizableKey.levelUp.showLanguage
        lbPackage.text = LocalizableKey.messagePackage.showLanguage.uppercased()
        btnYes.setTitle(LocalizableKey.confirm.showLanguage.uppercased(), for: .normal)
    }
}
