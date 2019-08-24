//
//  CellAssignExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellAssignExercise: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(dataCell: ExerciseEntity){
        lblName.attributedText = NSAttributedString(string: dataCell.name&)
        lblDeadline.attributedText = NSAttributedString(string: LocalizableKey.deadline.showLanguage + ": " + (dataCell.deadline?.toString(dateFormat: AppDateFormat.hhmmddmmyyy) ?? ""))
    }
}
