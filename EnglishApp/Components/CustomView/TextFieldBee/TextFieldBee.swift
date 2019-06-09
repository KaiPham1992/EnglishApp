//
//  TextFieldBee.swift
//  EnglishApp
//
//  Created by vinova on 6/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class TextFieldBee: UITextField{
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
