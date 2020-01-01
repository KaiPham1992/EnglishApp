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

    @IBOutlet weak var tvContent: TextViewHandleTap!
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    var callbackOneTap : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        tvContent.contentInset = UIEdgeInsets.zero
        tvContent.callbackDoubleTap = {[weak self] (position, word) in
            guard let self = self else {return}
            let newPoint = self.tvContent.convert(position, to: self)
            self.callbackDoubleTap?(word, newPoint)
        }
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(handleTapOne))
        tapOne.numberOfTapsRequired = 1
        tvContent.addGestureRecognizer(tapOne)
    }
    
    @objc func handleTapOne(sender: UITapGestureRecognizer){
        self.callbackOneTap?()
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
