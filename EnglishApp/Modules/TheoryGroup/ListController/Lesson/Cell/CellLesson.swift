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
    @IBOutlet weak var viewBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupDataCell(dataCell: ItemLessonCategory){
        viewBackground.backgroundColor = UIColor(hexString: dataCell.color&)
        lblTitle.text = dataCell.name
    }
}
