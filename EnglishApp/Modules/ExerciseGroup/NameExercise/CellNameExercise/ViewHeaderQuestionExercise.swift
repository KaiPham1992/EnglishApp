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
    
    @IBOutlet weak var btnSuggestion: UIButton!
    @IBOutlet weak var lblContent: UILabel!
    
    func setupSuggestButton(isShow: Bool) {
        if isShow {
            btnSuggestion.isHidden = false
        } else {
            btnSuggestion.isHidden = true
        }
    }
    
    func setupCell(index: Int, content: String) {
        lblContent.text = "\(index). \(content)"
    }
    
    override func setUpViews() {
        
    }
}
