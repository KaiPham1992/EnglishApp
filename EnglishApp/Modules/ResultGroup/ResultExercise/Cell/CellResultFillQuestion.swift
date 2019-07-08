//
//  CellResultFillQuestion.swift
//  EnglishApp
//
//  Created by vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultFillQuestion: UITableViewCell {

    @IBAction func clickExclamation(_ sender: Any) {
    }
    
    @IBAction func clickLink(_ sender: Any) {
    }
    
    @IBAction func clickReading(_ sender: Any) {
    }
    var indexPath: IndexPath?
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblNumberAnswer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(answer: AnswerResultProfileEntity){
        lblNumberAnswer.text = LocalizableKey.sentence.showLanguage + " \((indexPath?.row ?? 0) + 1):"
        
        lblAnswer.text = answer.content ?? " "
        
        let status = answer.status ?? "0"
        
        if status == "0"{
            lblNumberAnswer.textColor = #colorLiteral(red: 1, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
            lblAnswer.textColor = #colorLiteral(red: 1, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
            viewLine.backgroundColor = #colorLiteral(red: 1, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        } else {
            lblNumberAnswer.textColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            lblAnswer.textColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            viewLine.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
        }
    }
}
