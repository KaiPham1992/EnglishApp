//
//  CellChoiceQuestionExercise.swift
//  EnglishApp
//
//  Created by Steve on 11/15/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellChoiceQuestionExercise: UITableViewCell {
    
    var indexPath: IndexPath!
    
    @IBOutlet weak var viewBackground: UIView!

    @IBOutlet weak var tvContent: UITextView!
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    var callbackOneTap : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        tvContent.contentInset = UIEdgeInsets.zero
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(handleTapDouble))
        tapDouble.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tapDouble)
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(handleTapOne))
        tapOne.numberOfTapsRequired = 1
        tvContent.addGestureRecognizer(tapOne)
    }
    
    @objc func handleTapOne(sender: UITapGestureRecognizer){
        self.callbackOneTap?()
    }
    
    
    @objc func handleTapDouble(sender: UITapGestureRecognizer){
        let point = sender.location(in: tvContent)
        let newPoint = tvContent.convert(point, to: self)
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
    
    func setupView(isChoice: Bool) {
        if isChoice {
            viewBackground.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.8039215686, blue: 1, alpha: 1)
        } else {
            viewBackground.backgroundColor = .white
        }
    }
    
    func setupView(isChoice: Bool, content: String) {
        tvContent.text = content
        if isChoice {
            viewBackground.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.8039215686, blue: 1, alpha: 1)
        } else {
            viewBackground.backgroundColor = .white
        }
    }
}
