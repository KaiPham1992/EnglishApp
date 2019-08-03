//
//  ReportQuestionView.swift
//  EnglishApp
//
//  Created by vinova on 6/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ReportQuestionView: BaseViewXib{
    
    var cancel : (() -> ())?
    var report: ((_ message: String) -> ())?
    
    @IBAction func clickCancel(_ sender: Any) {
        cancel?()
    }
    
    @IBAction func clickReport(_ sender: Any) {
        report?(tfEnterContent.text ?? "")
    }
    
    @IBOutlet weak var tfEnterContent: UITextField!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    
    override func setUpViews() {
        super.setUpViews()
        tfEnterContent.placeholder = LocalizableKey.enter_content.showLanguage
        lblDescription.text = LocalizableKey.description.showLanguage
        btnCancel.setTitle(LocalizableKey.cancel_upper.showLanguage, for: .normal)
        btnReport.setTitle(LocalizableKey.report.showLanguage, for: .normal)
        lblTitle.text = LocalizableKey.report.showLanguage
    }
}
