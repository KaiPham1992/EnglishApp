//
//  TableViewCell.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResult: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func setupData(isTrue: Bool){
        if isTrue{
            vBackground.backgroundColor = UIColor(red: 32/255, green: 191/255, blue: 85/255, alpha: 1)
            return
        }
        vBackground.backgroundColor = UIColor(red: 255/255, green: 48/255, blue: 48/255, alpha: 1)
    }
}
