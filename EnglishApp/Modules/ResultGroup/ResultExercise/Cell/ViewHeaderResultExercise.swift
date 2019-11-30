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
    
    var section : Int!
    
    @IBOutlet weak var lblContent: UILabel!
    
    func setupCell(index: Int, content: String) {
        self.section = index - 1
        lblIndex.text = "\(index). "
        lblContent.attributedText = content.attributedString()
    }
    
    override func setUpViews() {
        
    }
}
