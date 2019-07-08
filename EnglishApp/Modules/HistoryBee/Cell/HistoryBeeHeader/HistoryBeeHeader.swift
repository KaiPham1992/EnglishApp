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

    func displayData(walletType: Int, total: Int){
        if walletType == 3{
            imgIcon.image = AppImage.imgHoney
            lbTotal.text = "\(total) \(LocalizableKey.boxHoneyTitle.showLanguage)"
            btnAdd.setTitle("\(LocalizableKey.addBee.showLanguage)", for: .normal)
            btnAdd.isHidden = false
        }else{
            imgIcon.image = AppImage.imgDiamond
            lbTotal.text = "\(total) \(LocalizableKey.diamond.showLanguage)"
            btnAdd.isHidden = true
        }
        
        
        
            
    }

}
