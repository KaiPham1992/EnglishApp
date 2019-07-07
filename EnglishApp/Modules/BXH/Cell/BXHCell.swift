//
//  BXHCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class BXHCell: BaseTableCell {
    
    @IBOutlet weak var viewBXH: BXHView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
