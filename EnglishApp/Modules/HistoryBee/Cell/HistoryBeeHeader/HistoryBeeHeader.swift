//
//  HistoryBeeHeader.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HistoryBeeHeader: BaseViewXib {
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var heightOfButton: NSLayoutConstraint!

    func displayData(walletType: Int, total: Int){
        if walletType == 3{
            imgIcon.image = AppImage.imgHoney
            lbTotal.text = "\(total) \(LocalizableKey.boxHoneyTitle.showLanguage)"
            btnAdd.setTitle("\(LocalizableKey.addBee.showLanguage)", for: .normal)
            heightOfButton.constant = 44
//            btnAdd.isHidden = false
        }else{
            imgIcon.image = AppImage.imgDiamond
            lbTotal.text = "\(total) \(LocalizableKey.diamond.showLanguage)"
            heightOfButton.constant = 0
//            btnAdd.isHidden = true
        }
        
        
        
            
    }

}
