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
    
    @IBOutlet weak var lblIndex: UILabel!
    @IBOutlet weak var btnSuggestion: UIButton!
    @IBOutlet weak var tvContent: UITextView!
    
    func setupSuggestButton(isShow: Bool) {
        if isShow {
            btnSuggestion.isHidden = false
        } else {
            btnSuggestion.isHidden = true
        }
    }
    
    func setupCell(index: Int, content: String) {
        lblIndex.text = "\(index)."
        tvContent.attributedText = content.attributedString()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let point = sender.location(in: tvContent)
        if let detectedWord = getWordAtPosition(point){
            callbackDoubleTap?(detectedWord, point)
        }
    }
    
    private func getWordAtPosition(_ point: CGPoint) -> String?{
        if let textPosition = tvContent.closestPosition(to: point) {
            if let range = tvContent.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1)) {
                return tvContent.text(in: range)
            }
        }
        return nil
    }
    
    override func setUpViews() {
        tvContent.contentInset = UIEdgeInsets.zero
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tap)
    }
}
