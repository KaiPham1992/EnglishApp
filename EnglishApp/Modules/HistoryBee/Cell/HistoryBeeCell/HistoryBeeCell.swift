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
    @IBOutlet weak var iconBtn: UIButton!
    
    var walletLog: LogEntity?{
        didSet{
            guard let walletLog = self.walletLog else {return}
            lbContent.text = walletLog.description
            lbDate.text = walletLog.date?.toString(dateFormat: AppDateFormat.ddMMYYYY)
            
            if  walletLog.amount* < 0 {
                iconBtn.setImage(AppImage.imgDownPoint, for: .normal)
            }else{
                iconBtn.setImage(AppImage.imgUpPoint, for: .normal)
            }
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
