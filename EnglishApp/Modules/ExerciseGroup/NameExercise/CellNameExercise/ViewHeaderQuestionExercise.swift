//
//  ViewHeaderQuestionExercise.swift
//  EnglishApp
//
//  Created by Steve on 11/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewHeaderQuestionExercise : BaseViewXib {
    @IBAction func suggestionQuestion(_ sender: Any) {
        callbackSugestionQuestion?()
    }
    
    var callbackSugestionQuestion : (()->())?
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    
//    @IBOutlet weak var lblIndex: UILabel!
    @IBOutlet weak var btnSuggestion: UIButton!
    @IBOutlet weak var tvContent: TextViewHandleTap!
    
    func setupSuggestButton(isShow: Bool) {
        if isShow {
            btnSuggestion.isHidden = false
        } else {
            btnSuggestion.isHidden = true
        }
    }
    
    func setupCell(index: Int, content: String) {
//        lblIndex.text = "\(index)."
        tvContent.attributedText = content.attributedString()
    }

    override func setUpViews() {
        tvContent.contentInset = UIEdgeInsets.zero
        tvContent.callbackDoubleTap = {[weak self] (position, word) in
            guard let self = self else {return}
            let newPoint = self.tvContent.convert(position, to: self)
            self.callbackDoubleTap?(word, newPoint)
        }
    }
}
