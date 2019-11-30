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
    @IBAction func chocieAnswer(_ sender: Any) {
        callbackSelectAnswer?(indexPath)
    }
    
    @IBOutlet weak var lblContent: UILabel!
    var callbackSelectAnswer : ((_ index: IndexPath)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupView(isChoice: Bool, content: String) {
        lblContent.text = content
        if isChoice {
            viewBackground.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.8039215686, blue: 1, alpha: 1)
        } else {
            viewBackground.backgroundColor = .white
        }
    }
}
