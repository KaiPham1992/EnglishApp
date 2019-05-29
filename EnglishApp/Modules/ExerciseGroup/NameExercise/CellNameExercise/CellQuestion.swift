//
//  CellQuestion.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellQuestion: UITableViewCell {

    @IBOutlet weak var lbQuestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(title: String){
        lbQuestion.text = title
    }
}
