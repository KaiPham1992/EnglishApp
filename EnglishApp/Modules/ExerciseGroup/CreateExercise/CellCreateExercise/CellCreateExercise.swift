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
    @IBAction func numberChanged(_ sender: Any) {
        let number = edNumber.text == "" ? 0 : Int(edNumber.text ?? "0")!
        delegate?.changeNumberQuestion(number: number, indexPath: indexPath)
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var edNumber: UITextField!
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
