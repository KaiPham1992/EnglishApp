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
        self.isUserInteractionEnabled = false
        vBackGround.backgroundColor = .gray
        lblDate.text = "\(date)"
        lblDate.alpha = 0.6
    }
    
    func enableCell(date: Int){
        self.isUserInteractionEnabled = true
        vBackGround.backgroundColor = .white
        lblDate.alpha = 1
        lblDate.text = "\(date)"
    }
    
    func showDot(){
        vDot.isHidden = false
    }
}
