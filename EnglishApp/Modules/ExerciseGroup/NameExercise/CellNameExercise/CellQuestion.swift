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
    func showMoreResult(result: String)
}

class CellQuestion: UITableViewCell {
    
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBAction func clickQuestion(_ sender: Any) {
        self.isShow = !self.isShow
        dropDown.show()
    }
    
    var dataSource  : [String] = []
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
        dropDown.dataSource = dataSource
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.isShow = !self.isShow
            self.lbAnswer.isHidden = false
            self.vQuestion.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
            self.lbAnswer.text = item
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.isShow = !self.isShow
        }
    }
    
    
    func setupData(title: String,isExercise: Bool){
        self.lbNumber.text = LocalizableKey.sentence.showLanguage + " \((indexPath?.row ?? 0) + 1)"
    }
}
