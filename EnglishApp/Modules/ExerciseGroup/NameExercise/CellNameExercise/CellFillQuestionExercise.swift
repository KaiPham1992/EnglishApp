//
//  CellFillQuestionExercise.swift
//  EnglishApp
//
//  Created by Steve on 11/15/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellFillQuestionExercise: UITableViewCell {

    @IBOutlet weak var heightTextView: NSLayoutConstraint!
    @IBOutlet weak var tvContent: PlaceHolderTextView!
    var callbackChangeHeight: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        heightTextView.constant = 17
        tvContent.callbackTextChange = {[unowned self] (_) in
            let oldHeight = self.tvContent.frame.height
            let newHeight = self.tvContent.sizeThatFits(CGSize(width: self.tvContent.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
            if newHeight != oldHeight {
                self.heightTextView.constant = newHeight
                self.layoutIfNeeded()
                self.callbackChangeHeight?()
            }
        }
    }
    
    func setupCell(text: String) {
        if text != "" {
            tvContent.text = text
            tvContent.textColor = .black
        } else {
            tvContent.placeholder = "Enter answer"
        }
    }
}
