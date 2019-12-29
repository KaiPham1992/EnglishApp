//
//  ViewHeaderResultExercise.swift
//  EnglishApp
//
//  Created by Steve on 11/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewHeaderResultExercise : BaseViewXib {
    @IBAction func clickReading(_ sender: Any) {
        callbackExplainQuestion?(self.section)
    }
    
    @IBAction func clickLink(_ sender: Any) {
        callbackRelatedGrammar?(self.section)
    }

    @IBOutlet weak var lblIndex: UILabel!
    
    var callbackExplainQuestion : ((_ section : Int)->())?
    var callbackRelatedGrammar: ((_ section: Int) -> ())?
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    
    var section : Int!
    
    @IBOutlet weak var tvContent: UITextView!
    
    func setupCell(index: Int, content: String) {
        self.section = index - 1
        lblIndex.text = "\(index). "
        tvContent.attributedText = content.convertToAttributedString()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let point = sender.location(in: tvContent)
        let newPoint = tvContent.convert(point, from: self)
        if let detectedWord = getWordAtPosition(point){
            callbackDoubleTap?(detectedWord, newPoint)
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
