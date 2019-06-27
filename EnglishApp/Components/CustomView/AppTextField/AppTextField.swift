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
    @IBOutlet weak var lbPlaceHolder: UILabel!
    @IBOutlet weak var vLine: UIView!
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            self.lbPlaceHolder.text = placeHolder&
        }
    }
    
    
    func getText() -> String {
        return tfInput.text&
    }
    
    override func setUpViews() {
        super.setUpViews()
        tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.lbPlaceHolder.isHidden = !textField.text&.isEmpty
    }
}
