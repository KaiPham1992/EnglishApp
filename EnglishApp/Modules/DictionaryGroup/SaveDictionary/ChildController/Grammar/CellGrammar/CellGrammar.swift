//
//  CellGrammar.swift
//  EnglishApp
//
//  Created by vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellGrammar: UITableViewCell {

    @IBOutlet weak var btnRemove: RatioButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var actionClick : ((_ index: IndexPath)->())?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        btnRemove.imageChoice = #imageLiteral(resourceName: "ic_Checkbox_on_Yellow")
        btnRemove.imageNoChoice = #imageLiteral(resourceName: "ic_Checkbox_off_Yellow")
    }
    
    func setupDelete(){
        btnRemove.isChocie = false
        btnRemove.isHidden = false
        btnRemove.actionClick = clickButton
    }
    
    func setupNoDelete(){
        btnRemove.isChocie = false
        btnRemove.isHidden = true
    }
    
    func clickButton(isChoice: Bool){
        actionClick?(indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func setupTitle(title: String){
        lblTitle.text = title
    }
    
}
