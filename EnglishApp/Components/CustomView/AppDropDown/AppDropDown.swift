//
//  AppTextField.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//


// Fix me
class TagEntity {
    var name: String?
    
    init(name: String) {
        self.name = name
    }
}

//

import UIKit
import DropDown

protocol AppTextFieldDropDownDelegate: class {
    func didChangedValue(sender: AppDropDown, item: Any)
}

class AppDropDown: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    
    let dropDown = DropDown()
    var selectedItem: Any?
    weak var delegateDropDown: AppTextFieldDropDownDelegate?
    
    var listItem = [Any]() {
        didSet {
            setUpDropDown()
            if let tag = listItem as? [TagEntity] {
                dropDown.dataSource = tag.map {$0.name&}
            }
            
            if let tag = listItem as? [NationalEntity] {
                dropDown.dataSource = tag.map {$0.name&}
            }
        }
    }
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
            tfInput.placeHolderColor = .black
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
    }
    
    @IBAction func btnActionTapped() {
        dropDown.width = tfInput.frame.width
        dropDown.show()
    }
    
    func setUpDropDown() {
        dropDown.anchorView = tfInput
        dropDown.backgroundColor = .white
        dropDown.width = tfInput.frame.width
        
        dropDown.cellNib = UINib(nibName: "AppDropDownCell", bundle:  nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                        guard let cell = cell as? AppDropDownCell else { return }
            
            cell.lbContent.text = item
            return
        }
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfInput.text = item

            self.selectedItem = self.listItem[index]
            self.delegateDropDown?.didChangedValue(sender: self, item: self.selectedItem)
        }
    }
}
