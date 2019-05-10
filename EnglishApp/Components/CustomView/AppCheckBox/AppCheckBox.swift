//
//  AppCheckBox.swift
//  Ipos
//
//  Created by Kai Pham on 5/8/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit
protocol AppCheckBoxDelegate: class {
    func changedSataus(isCheck: Bool)
}

class AppCheckBox: BaseViewXib {
    let imageCheck = AppImage.imgCheck
    let imageUnCheck = AppImage.imgUnCheck
    
    var isCheck: Bool = false {
        didSet {
            self.imgIcon.image = isCheck == true ? imageCheck: imageUnCheck
        }
    }
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    weak var delegate: AppCheckBoxDelegate?
    
    @IBAction func btnActionTapped() {
        self.isCheck = !isCheck
        delegate?.changedSataus(isCheck: isCheck)
    }
    
    func setTitle(title: String, isCheck: Bool = false) {
        self.isCheck = isCheck
        self.lbTitle.text = title
    }
}
