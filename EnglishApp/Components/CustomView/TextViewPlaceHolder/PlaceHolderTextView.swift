//
//  PlaceholderTextView.swift
//  EnglishApp
//
//  Created by Steve on 11/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PlaceHolderTextView : UITextView, UITextViewDelegate {
    
    @IBInspectable var placeholder : String? {
        didSet {
            self.text = placeholder
            self.textColor = placeholderColor
        }
    }
    
    var callbackTextChange: ((_ view: UITextView)->())?
    
    @IBInspectable var placeholderColor : UIColor = .gray {
        didSet {
            self.textColor = placeholderColor
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    private func setupView() {
        self.sizeToFit()
        self.textContainer.lineFragmentPadding = .zero
        self.textContainerInset = UIEdgeInsets.zero
        self.delegate = self
    }
    
    func getText() -> String {
        if self.textColor != placeholderColor {
            return self.text
        }
        return ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        callbackTextChange?(self)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text.isEmpty {
            self.textColor = placeholderColor
            self.text = placeholder
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textColor == placeholderColor {
            self.textColor = .black
            self.text = nil
        }
    }
}
