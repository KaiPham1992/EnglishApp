//
//  CellLesson.swift
//  EnglishApp
//
//  Created by Steve on 7/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellLesson: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBackground: ViewGradient!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupDataCell(dataCell: ItemLessonCategory){
        viewBackground.setupGradient(beginColor: UIColor(hexString: dataCell.color&), endColor: UIColor(hexString: dataCell.color&).withAlphaComponent(0.56))
        lblTitle.text = dataCell.name
    }
}
