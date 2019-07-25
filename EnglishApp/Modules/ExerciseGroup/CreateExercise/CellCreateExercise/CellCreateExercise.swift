//
//  CellCreateExercise.swift
//  EnglishApp
//
//  Created by vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import DropDown

protocol ChoiceType : class {
    func choiceDrop(view: UIView,indexPath: IndexPath?)
    func changeNumberQuestion(number: Int, indexPath: IndexPath?)
}

class CellCreateExercise: UITableViewCell {
    
    @IBAction func changedValueNumber(_ sender: Any) {
        if let number = Int(edNumber.text&) {
            delegate?.changeNumberQuestion(number: number, indexPath: indexPath)
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var edNumber: TextFieldLimitedCharacter!
    @IBOutlet weak var vType: UIView!
    @IBOutlet weak var lbType: UILabel!
    
    @IBAction func clickDrop(_ sender: Any) {
        rotateImage()
        delegate?.choiceDrop(view: sender as! UIView, indexPath: indexPath)
    }
    
    @IBOutlet weak var imgDown: UIImageView!
    weak var delegate : ChoiceType?
    var indexPath : IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        edNumber.setupNumberCharactor(number: 3)
    }
    
    func rotateImage(){
        UIView.animate(withDuration: 0.2) {
            self.imgDown.transform = self.imgDown.transform.rotated(by: CGFloat(Double.pi))
        }
    }
    
    func setupData(title: String){
        lblTitle.text = title
    }
    
    func setupTitle(title: String){
        lbType.text = title
        rotateImage()
    }
}
