//
//  SuggesstionView.swift
//  EnglishApp
//
//  Created by vinova on 5/29/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class SuggesstionView : BaseViewXib{
    
    @IBOutlet weak var btnMoney: UIButton!
    @IBOutlet weak var btnDiamond: UIButton!
    @IBOutlet weak var lblDiamond: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    
    
    override func setUpViews() {
        super.setUpViews()
        lblDiamond.attributedText = NSAttributedString(string: "10 " + LocalizableKey.diamond.showLanguage.uppercased())
        lblMoney.attributedText = NSAttributedString(string: "5 " + LocalizableKey.boxHoneyTitle.showLanguage.uppercased())
    }
}
