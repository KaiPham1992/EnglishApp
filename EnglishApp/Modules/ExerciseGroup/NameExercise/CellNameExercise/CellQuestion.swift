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
    func clickQuestion(indexPath: IndexPath?,isSelect: Bool)
    func showMoreResult(result: String)
}

class CellQuestion: UITableViewCell {
    
    @IBAction func clickQuestion(_ sender: Any) {
        dropDown.show()
    }
    
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbAnswer: UILabel!
    @IBOutlet weak var vQuestion: UIView!
    var indexPath: IndexPath?
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
        dropDown.anchorView = vQuestion
        dropDown.bottomOffset = CGPoint(x: 0, y: (vQuestion.frame.height + 5))
        dropDown.backgroundColor = .white
        dropDown.cellNib = UINib(nibName: "CellDropDownQuestion", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? CellDropDownQuestion else { return }
            
            // Setup your custom UI components
            cell.lbAnswer.text = item
            
        }
        dropDown.width = vQuestion.frame.width
        dropDown.setupCornerRadius(2)
        dropDown.dataSource = ["A","B","C","D"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lbAnswer.text = item
        }
    }
    
    
    func setupData(title: String,isExercise: Bool){
        self.lbNumber.text = LocalizableKey.sentence.showLanguage + " \((indexPath?.row ?? 0) + 1)"
    }
}
