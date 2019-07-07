//
//  HistoryBeeCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HistoryBeeCell: UITableViewCell {
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbDate: UILabel!

    var walletLog: LogEntity?{
        didSet{
            lbContent.text = walletLog?.description
            lbDate.text = walletLog?.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
