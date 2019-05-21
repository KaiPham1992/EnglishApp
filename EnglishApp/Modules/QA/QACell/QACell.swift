//
//  QACell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class QACell: BaseTableCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var qa: QAEntity? {
        didSet {
            guard let qa = qa else { return }
            
            lbTitle.text = qa.title
            lbContent.text = qa.content
            lbTime.text =  qa.date?.toString(dateFormat: AppDateFormat.hhmmddmmyyy)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
