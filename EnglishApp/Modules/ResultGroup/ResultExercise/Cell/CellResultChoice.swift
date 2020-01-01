//
//  CellResultChoice.swift
//  EnglishApp
//
//  Created by STEVE_MACBOOK on 7/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellResultChoice: UITableViewCell {


    @IBOutlet weak var tvContent: TextViewHandleTap!
    @IBOutlet weak var viewBackground: UIView!
    var indexPath: IndexPath?
    
    var callbackDoubleTap : ((_ word: String,_ position: CGPoint)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        tvContent.contentInset = UIEdgeInsets.zero
        tvContent.callbackDoubleTap = {[weak self] (position, word) in
            guard let self = self else {return}
            let newPoint = self.tvContent.convert(position, to: self)
            self.callbackDoubleTap?(word, newPoint)
        }
    }
    
    func setupCell(answer: AnswerResultProfileEntity){
        if let _ = answer.answer_id {
            if let status = answer.status {
                tvContent.text = answer.value& + ". " + answer.content&
                viewBackground.backgroundColor = status == "0" ? #colorLiteral(red: 0.9019607843, green: 0.1882352941, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
            }
        }
    }
    func setupCell(option: OptionEntity, status: String, value: String){
        tvContent.text = option.value& + ". " + option.content&
        if value != "" && option.value == value {
            viewBackground.backgroundColor = status == "0" ? #colorLiteral(red: 0.9019607843, green: 0.1882352941, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1)
        } else {
            viewBackground.backgroundColor = UIColor.white
        }
    }
}
