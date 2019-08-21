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
        actionReportQuestion?(self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    @IBAction func clickLink(_ sender: Any) {
        actionRelatedGrammar?(self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    @IBAction func clickReading(_ sender: Any) {
        actionExplainQuestion?(self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    var actionExplainQuestion : ((_ index : IndexPath)->())?
    var actionRelatedGrammar: ((_ index: IndexPath) -> ())?
    var actionReportQuestion: ((_ index: IndexPath) -> ())?
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
//
//        lblAnswer.text = answer.content ?? " "
        let content = answer.content ?? ""
        let status = answer.status ?? "0"
        if content == "" {
            lblAnswer.text = " "
            viewLine.backgroundColor = #colorLiteral(red: 1, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        } else {
            lblAnswer.text = answer.value&
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
}
