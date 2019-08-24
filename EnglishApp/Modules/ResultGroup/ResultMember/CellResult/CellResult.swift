//
//  TableViewCell.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResult: UITableViewCell {

    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblNumberQuestion: UILabel!
    @IBOutlet weak var vBackground: UIView!
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupData(isTrue: Bool, point: String){
        lblNumberQuestion.text = LocalizableKey.sentence.showLanguage + " " + (String((indexPath?.row ?? 0) + 1))
        lblPoint.attributedText = NSAttributedString(string: point + " " + LocalizableKey.point.showLanguage)
        if isTrue{
            vBackground.backgroundColor = UIColor(red: 32/255, green: 191/255, blue: 85/255, alpha: 1)
            return
        }
        vBackground.backgroundColor = UIColor(red: 255/255, green: 48/255, blue: 48/255, alpha: 1)
    }
    
    func setupDataDefault(point: String){
        lblPoint.textColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
        lblNumberQuestion.textColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
        vBackground.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        lblNumberQuestion.attributedText = NSAttributedString(string: LocalizableKey.sentence.showLanguage + " " + (String((indexPath?.row ?? 0) + 1)))
        lblPoint.attributedText = NSAttributedString(string: point + " " + LocalizableKey.point.showLanguage)
    }
}
