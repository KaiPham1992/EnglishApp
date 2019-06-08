//
//  BeePackCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class BeePackCell: BaseTableCell {
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    
    var item: BeePackEntity? {
        didSet {
            guard let bee = item else { return }
            
            imgIcon.image = bee.image
            lbMoney.text = bee.money?.description&
            imgBackground.image = bee.background
            
        }
    }
}
