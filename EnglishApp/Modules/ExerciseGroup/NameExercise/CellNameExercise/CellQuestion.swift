//
//  CellQuestion.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol ClickQuestionDelegate: class {
    func clickQuestion(indexPath: IndexPath?,isSelect: Bool)
}

class CellQuestion: UITableViewCell {
    
    @IBOutlet weak var vBG: UIView!

    @IBAction func clickMore(_ sender: Any) {
        
    }
    @IBAction func clickQuestion(_ sender: Any) {
        self.isSelect = !self.isSelect
        delegate?.clickQuestion(indexPath: self.indexPath, isSelect: self.isSelect)
    }
    
    var isSelect : Bool = false {
        didSet{
            setSelect(isSelect: self.isSelect)
        }
    }
    var indexPath: IndexPath?
    weak var delegate: ClickQuestionDelegate?
    @IBOutlet weak var heightMore: NSLayoutConstraint!
    @IBOutlet weak var lbQuestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupData(title: String){
        lbQuestion.text = title
    }
    
    func setSelect(isSelect: Bool){
        if isSelect{
            vBG.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            heightMore.constant = 24
        } else {
            vBG.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            heightMore.constant = 0
        }
    }
}
