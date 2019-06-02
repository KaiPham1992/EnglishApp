//
//  RequireUpgradeCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class RequireUpgradeCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    
    var item: String? {
        didSet {
            guard let content = item else { return }
            lbTitle.text = content
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
