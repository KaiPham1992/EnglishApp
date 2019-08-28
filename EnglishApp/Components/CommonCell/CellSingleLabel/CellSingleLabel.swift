//
//  CellSingleLabel.swift
//  EnglishApp
//
//  Created by Steve on 7/29/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellSingleLabel: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(title: String){
        lblText.attributedText = NSAttributedString(string: title) 
    }
}
