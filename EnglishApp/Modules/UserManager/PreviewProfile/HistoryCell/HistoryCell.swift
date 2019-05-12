//
//  HistoryCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import SDWebImage

class HistoryCell: BaseTableCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    var history: HistoryEntity? {
        didSet {
            guard let history = history else { return }
            lbTime.text = history.title
            lbTime.text = history.date?.toString(dateFormat: AppDateFormat.hhmmddmmyyy)
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
