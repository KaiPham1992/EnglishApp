//
//  CellResultChoice.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultChoice: UITableViewCell {


    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var viewBackground: UIView!
    var indexPath: IndexPath?
    
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        tvContent.contentInset = UIEdgeInsets.zero
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(handleTapDouble))
        tapDouble.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tapDouble)
    }
    
    @objc func handleTapDouble(sender: UITapGestureRecognizer){
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
    
    
    func setupCell(answer: AnswerResultProfileEntity){
        if let _ = answer.answer_id {
            if let status = answer.status {
                tvContent.text = answer.value& + ". " + answer.content&
                viewBackground.backgroundColor = status == "0" ? #colorLiteral(red: 0.9019607843, green: 0.1882352941, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            }
        }
    }
    func setupCell(option: OptionEntity, status: String, value: String){
        tvContent.text = option.value& + ". " + option.content&
        if value != "" && option.value == value {
            viewBackground.backgroundColor = status == "0" ? #colorLiteral(red: 0.9019607843, green: 0.1882352941, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
        } else {
            viewBackground.backgroundColor = UIColor.white
        }
    }
}
