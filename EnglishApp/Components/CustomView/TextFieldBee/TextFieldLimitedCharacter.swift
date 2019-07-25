//
//  TextFieldLimitedCharacter.swift
//  EnglishApp
//
//  Created by Steve on 7/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class TextFieldLimitedCharacter: UITextField {
    private var numberCharacter: Int = 10
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupNumberCharactor(number: Int){
        self.numberCharacter = number
    }
    
    func setupView(){
        self.delegate = self
    }
}

extension TextFieldLimitedCharacter: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let rangeCharacter = Range(range, in: text) else {
            return false
        }
        let subStringToReplace = text[rangeCharacter]
        let count = text.count - subStringToReplace.count + string.count
        return count <= numberCharacter
    }
}
