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

//    @IBOutlet weak var lblIndex: UILabel!
    
    var callbackExplainQuestion : ((_ section : Int)->())?
    var callbackRelatedGrammar: ((_ section: Int) -> ())?
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    
    var section : Int!
    
    @IBOutlet weak var tvContent: TextViewHandleTap!
    
    func setupCell(index: Int, content: String) {
        self.section = index - 1
//        lblIndex.text = "\(index). "
        tvContent.attributedText = content.convertToAttributedString()
    }
    
    func setupCell(content: String) {
//        lblIndex.isHidden = true
        tvContent.attributedText = content.convertToAttributedString()
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
