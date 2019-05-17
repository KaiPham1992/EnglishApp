//
//  AppTextField.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class AppTextField: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vLine: UIView!
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            self.tfInput.attributedPlaceholder = placeHolder&.toAttributedString(color: AppColor.black.withAlphaComponent(0.5), font: AppFont.fontRegular14, isUnderLine: false)
        }
    }
    
    
    func getText() -> String {
        return tfInput.text&
    }
    
    override func setUpViews() {
        super.setUpViews()
        
//        lbTitle.font = AppFont.fontBold18
        
//        tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
//        textField.attributedText = textField.text&.toAttributedString(color: .black, font: AppFont.fontRegular14, isUnderLine: false)
//        if !textField.text&.isEmpty {
//            vContain.backgroundColor = AppColor.f1f1f1
//        } else {
//            vContain.backgroundColor = .white
//        }
    }
}
