//
//  CellChoiceExercise.swift
//  EnglishApp
//
//  Created by vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellChoiceExercise: UITableViewCell {

    @IBOutlet weak var lblLevelExercise: UILabel!
    @IBOutlet weak var lblNameExercise: UILabel!
    var level = 1 {
        didSet{
            setLevel()
        }
    }
    
    var name = "" {
        didSet{
            lblNameExercise.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    private func setLevel(){
        if level == 1 {
            lblLevelExercise.text = "Elementary"
        }
        if level == 2{
            lblLevelExercise.text = "Intermediate"
        }
        if level == 3 {
            lblLevelExercise.text = "Advanced"
        }
    }
    
}
