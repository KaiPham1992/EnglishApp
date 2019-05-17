//
//  CustomTextfield.swift
//  Ipos
//
//  Created by Torres on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import Foundation
import UIKit

class CustomTextfield: UITextField {
    let padding = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        
    }
    
    private func setupLayout() {
        
    }
    
    internal func setPlaceHolder(withText text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x000000, alpha: 0.5)])
    }
}
