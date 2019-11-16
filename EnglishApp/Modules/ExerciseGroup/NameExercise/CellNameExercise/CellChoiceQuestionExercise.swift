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
            contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        } else {
            contentView.backgroundColor = .white
        }
    }
}
