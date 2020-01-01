//
//  TextViewHandleTap.swift
//  EnglishApp
//
//  Created by Steve on 1/1/20.
//  Copyright © 2020 demo. All rights reserved.
//

import UIKit

class TextViewHandleTap : UITextView {
    
    var callbackDoubleTap : ((_ position: CGPoint, _ text: String) -> ())?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let point = sender.location(in: self)
        if let detectedWord = getWordAtPosition(point){
            self.callbackDoubleTap?(point, detectedWord)
        }
    }
    
    private func getWordAtPosition(_ point: CGPoint) -> String?{
        if let textPosition = self.closestPosition(to: point) {
            if let range = self.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1)) {
                return self.text(in: range)
            }
        }
        return nil
    }
}
