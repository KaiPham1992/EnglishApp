//
//  CellHistoryListExercise.swift
//  EnglishApp
//
//  Created by Steve on 7/26/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellHistoryListExercise: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var widthButton: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupDatacell(dataCell: TestResult){
        if let _level = dataCell.level {
            if _level == "1" {
                lblLevel.text = "Elementary"
            }
            if _level == "2" {
                lblLevel.text = "Intermediate"
            }
            if _level == "3" {
                lblLevel.text = "Advanced"
            }
        } else {
            lblLevel.text = ""
        }
        lblTitle.text = dataCell.exercise_name&
    }
    
    func hideWidthButton() {
        widthButton.constant = 0
    }
    
    func showWidthButton() {
        widthButton.constant = 24
    }
}
