//
//  CellResultChoice.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultChoice: UITableViewCell {
    
    @IBAction func clickReading(_ sender: Any) {
        actionExplainQuestion?(self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    @IBAction func clickLink(_ sender: Any) {
        actionRelatedGrammar?(self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    @IBAction func clickExclamation(_ sender: Any) {
        actionReportQuestion?(self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    var actionExplainQuestion : ((_ index : IndexPath)->())?
    var actionRelatedGrammar: ((_ index: IndexPath) -> ())?
    var actionReportQuestion: ((_ index: IndexPath) -> ())?
    @IBOutlet weak var viewAnswer: UIView!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblNumberQuestion: UILabel!
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCell(answer: AnswerResultProfileEntity){
        lblNumberQuestion.text = "\((indexPath?.row ?? 0) + 1):"
        lblAnswer.text = ""
        viewAnswer.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        if let _ = answer.answer_id {
            if let status = answer.status {
                lblAnswer.text = answer.value
                viewAnswer.backgroundColor = status == "0" ? #colorLiteral(red: 0.9019607843, green: 0.1882352941, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            }
        }
    }
}
