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
}

//

import UIKit
import DropDown

protocol AppTextFieldDropDownDelegate: class {
    func didChangedValue(sender: AppDropDown, item: Any)
}

class AppDropDown: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: CustomTextfield!
    @IBOutlet weak var vContain: UIView!
    
    let dropDown = DropDown()
    var selectedItem: Any?
    weak var delegateDropDown: AppTextFieldDropDownDelegate?
    
    var listItem = [Any]() {
        didSet {
            setUpDropDown()
            if let tag = listItem as? [TagEntity] {
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
        
        tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        vContain.setBorder(borderWidth: 1, borderColor: AppColor.d5d5d5Color, cornerRadius: 5)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if !textField.text&.isEmpty {
            vContain.backgroundColor = AppColor.f1f1f1
        } else {
            vContain.backgroundColor = .white
        }
    }
    
    @IBAction func btnActionTapped() {
        dropDown.show()
    }
    
    func setUpDropDown() {
        dropDown.anchorView = vContain
        dropDown.backgroundColor = .white
        dropDown.width = tfInput.frame.width
        
        dropDown.cellNib = UINib(nibName: "AppDropDownCell", bundle:  nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            //            guard let cell = cell as? AppDropDownCell else { return }
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
