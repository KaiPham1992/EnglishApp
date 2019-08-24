//
//  UpdateFeatureView.swift
//  EnglishApp
//
//  Created by vinova on 6/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class UpdateFeatureView: BaseViewXib{
    
    var actionUpdate : (()->())?
    var actionNo: (()->())?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vVideo: ViewFeature!
    @IBOutlet weak var vSlide: ViewFeature!
    @IBOutlet weak var vLorem: ViewFeature!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBAction func clickCancel(_ sender: Any) {
        self.actionNo?()
    }
    
    @IBAction func clickUpdate(_ sender: Any) {
        self.actionUpdate?()
    }
    
    override func setUpViews() {
        super.setUpViews()
        lblTitle.attributedText = NSAttributedString(string: LocalizableKey.requireUpGrade.showLanguage)
        vVideo.isHidden = true
        vSlide.isHidden = true
        vLorem.isHidden = true
        btnCancel.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        btnUpdate.setAttributedTitle(NSAttributedString(string: LocalizableKey.cancel.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1)]), for: .normal)
        btnUpdate.setAttributedTitle(NSAttributedString(string: LocalizableKey.update.showLanguage.uppercased(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]), for: .normal)
    }
}
