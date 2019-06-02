//
//  DetailPackCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class DetailPackCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    var item: DetailPackEntity? {
        didSet {
            guard let detail = item else { return }
            lbTitle.text = detail.title
            imgIcon.image = detail.canUse == true ? AppImage.imgTickGreen: AppImage.imgCloseRed
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
