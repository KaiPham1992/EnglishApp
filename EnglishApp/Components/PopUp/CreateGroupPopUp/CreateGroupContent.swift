//
//  CreateGroupContent.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CreateGroupContent: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: AppTextField!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var heightError: NSLayoutConstraint!
    
    override func setUpViews() {
        super.setUpViews()
        lblError.text = LocalizableKey.enter_name_group.showLanguage
    }
}
