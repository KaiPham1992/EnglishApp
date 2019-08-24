//
//  HomeNoResultFound.swift
//  EnglishApp
//
//  Created by Henry on 8/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class HomeNoResultCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbTitle.text = "\(LocalizableKey.lbNoData.showLanguage)"
    }
    
}
