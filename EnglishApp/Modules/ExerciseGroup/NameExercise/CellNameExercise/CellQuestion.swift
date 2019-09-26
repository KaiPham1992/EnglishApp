//
//  CellQuestion.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import DropDown

protocol ClickQuestionDelegate: class {
    func changeAnswer(index: Int,indexPath: IndexPath?)
    func suggestQuestion(index: IndexPath)
}

class CellQuestion: UITableViewCell {
    
    @IBOutlet weak var widthButtonSuggestion: NSLayoutConstraint!
    @IBAction func suggestQuestion(_ sender: Any) {
        delegate?.suggestQuestion(index: self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBAction func clickQuestion(_ sender: Any) {
        self.isShow = !self.isShow
        dropDown.show()
    }
    
    var dataSource  : [String] = [] {
        didSet{
            dropDown.dataSource = dataSource
        }
    }
    
    var answer : String = "" {
        didSet {
            if answer == "" {
                self.lbAnswer.isHidden = true
                self.vQuestion.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
                imgDropDown.tintColor = .gray
                self.lbAnswer.text = ""
            } else {
                self.lbAnswer.isHidden = false
                self.vQuestion.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
                self.lbAnswer.text = answer
                imgDropDown.tintColor = .white
            }
        }
    }
    
//    override func prepareForReuse() {
//        answer = ""
//        idOption = []
//        dataSource = []
//    }
    
    var idOption : [Int] = []
    var isShow = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                 self.imgDropDown.transform = self.imgDropDown.transform.rotated(by: CGFloat(Double.pi))
            }
        }
    }
    
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbAnswer: UILabel!
    @IBOutlet weak var vQuestion: UIView!
    var indexPath: IndexPath? {
        didSet {
            self.lbNumber.text = "\((indexPath?.row ?? 0) + 1):"
        }
    }
    weak var delegate: ClickQuestionDelegate?
    let dropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.setupDropDown()
        }
    }
    
    func setupDropDown(){
        if answer == "" {
            imgDropDown.tintColor = .gray
        } else {
            imgDropDown.tintColor = .white
        }
        dropDown.anchorView = vQuestion
        dropDown.bottomOffset = CGPoint(x: 0, y: (vQuestion.frame.height + 5))
        dropDown.backgroundColor = .white
        dropDown.cellNib = UINib(nibName: "CellDropDownQuestion", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? CellDropDownQuestion else { return }
            cell.lbAnswer.text = item
        }
        
        dropDown.width = vQuestion.frame.width
        dropDown.setupCornerRadius(2)
        dropDown.dataSource = dataSource
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.imgDropDown.tintColor = .white
            self.isShow = !self.isShow
            self.lbAnswer.isHidden = false
            self.vQuestion.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            self.lbAnswer.text = item
            self.delegate?.changeAnswer(index: index, indexPath: self.indexPath)
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.isShow = !self.isShow
        }
    }
    
    func setupButtonSuggestion(isShow: Bool){
        if isShow {
            widthButtonSuggestion.constant = 32
        } else {
            widthButtonSuggestion.constant = 0
        }
    }
}
