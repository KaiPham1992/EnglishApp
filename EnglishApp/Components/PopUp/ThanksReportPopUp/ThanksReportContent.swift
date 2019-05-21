//
//  ThanksReportContent.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ThanksReportContent: BaseViewXib {
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        
        lbTitle.text = LocalizableKey.reportTitlePopUp.showLanguage
        lbMessage.text = LocalizableKey.reportMessagePopUp.showLanguage
        btnYes.setTitle(LocalizableKey.reportButtonPopUp.showLanguage.uppercased(), for: .normal)
    }
}
