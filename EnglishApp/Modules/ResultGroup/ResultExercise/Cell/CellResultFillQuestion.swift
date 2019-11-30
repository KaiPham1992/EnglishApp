//
//  CellResultFillQuestion.swift
//  EnglishApp
//
//  Created by vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultFillQuestion: UITableViewCell {
    
    var indexPath: IndexPath?
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblAnswer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(answer: AnswerResultProfileEntity){
        let status = answer.status ?? "0"
        lblAnswer.text = answer.value&
        if status == "0" || status == "2" {
            lblAnswer.textColor = #colorLiteral(red: 1, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
            viewLine.backgroundColor = #colorLiteral(red: 1, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        } else {
            lblAnswer.textColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            viewLine.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
        }
    }
}
