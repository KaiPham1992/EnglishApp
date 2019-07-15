//
//  HistoryBeeHeader.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
protocol HistoryBeeHeaderDelegate {
    func btnAddTapped()
}

class HistoryBeeHeader:  BaseViewXib {
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var heightOfButton: NSLayoutConstraint!
    
    var delegate: HistoryBeeHeaderDelegate?
    
    func displayData(walletType: Int, total: Int){
        if walletType == 3{
            imgIcon.image = AppImage.imgHoneyLarge
            lbTotal.text = "\(total) \(LocalizableKey.boxHoneyTitle.showLanguage)"
            btnAdd.setTitle("\(LocalizableKey.ADDBEE.showLanguage)", for: .normal)
            heightOfButton.constant = 44
            btnAdd.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        }else{
            imgIcon.image = AppImage.imgDiamond
            lbTotal.text = "\(total) \(LocalizableKey.diamond.showLanguage)"
            heightOfButton.constant = 0
        }
    }
    @objc func btnTapped(){
        self.delegate?.btnAddTapped()
    }

}
