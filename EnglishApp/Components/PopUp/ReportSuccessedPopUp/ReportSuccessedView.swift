//
//  ReportSuccessedView.swift
//  EnglishApp
//
//  Created by vinova on 6/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ReportSuccessedView : BaseViewXib{
    
    var complete: (()->())?
    
    @IBAction func complete(_ sender: Any) {
        complete?()
    }
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnComplete: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        lblTitle.text = LocalizableKey.report.showLanguage
        btnComplete.setTitle(LocalizableKey.complete_upper.showLanguage, for: .normal)
    }
}
