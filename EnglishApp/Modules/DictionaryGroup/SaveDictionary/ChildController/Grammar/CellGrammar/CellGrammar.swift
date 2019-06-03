//
//  CellGrammar.swift
//  EnglishApp
//
//  Created by vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellGrammar: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupTitle(title: String){
        lblTitle.text = title
    }
    
}
