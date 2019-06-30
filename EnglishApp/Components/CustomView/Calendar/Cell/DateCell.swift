//
//  DateCell.swift
//  EnglishApp
//
//  Created by vinova on 5/31/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vDot: UIView!
    @IBOutlet weak var vBackGround: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vDot.isHidden = true
    }
    
    func disableCell(date: Int){
        vDot.isHidden = true
        self.isUserInteractionEnabled = false
        vBackGround.backgroundColor = UIColor(red: 237/255, green: 242/255, blue: 245/255, alpha: 1)
        lblDate.text = "\(date)"
        lblDate.alpha = 0.6
    }
    
    func enableCell(date: Int){
        vDot.isHidden = true
        self.isUserInteractionEnabled = true
        vBackGround.backgroundColor = .white
        lblDate.alpha = 1
        lblDate.text = "\(date)"
    }
    
    func showDot(){
        vDot.isHidden = false
    }
}
