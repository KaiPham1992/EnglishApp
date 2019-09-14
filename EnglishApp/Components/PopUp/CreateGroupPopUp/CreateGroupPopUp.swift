//
//  CreateGroupPopUp.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CreateGroupPopUp: BasePopUpView {
    
    let vYesNoContentView: CreateGroupContent = {
        let view = CreateGroupContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        self.addObserverKeyboard()
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()
        
        vYesNoContentView.tfInput.vLine.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        vYesNoContentView.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        vYesNoContentView.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(titlePopUp: String, titleInput: String, placeHolderInput: String, titleNo: String, titleYes: String, completionNo: CompletionClosure?, completionYes: CompletionMessage?) {
        
        vYesNoContentView.lbTitle.text = titlePopUp
        vYesNoContentView.tfInput.setTitleAndPlaceHolder(title: titleInput, placeHolder: placeHolderInput)
        vYesNoContentView.lblError.text = LocalizableKey.enter_name_group.showLanguage
        vYesNoContentView.btnNo.setTitle(titleNo, for: .normal)
        vYesNoContentView.btnYes.setTitle(titleYes, for: .normal)
        
        
        self.completionNo = completionNo
        self.completionMessage = completionYes
        
        super.showPopUp(height: 180)
    }
    
    @objc func btnNoTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnYesTapped() {
        let message = (vYesNoContentView.tfInput.tfInput.text ?? "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if message != "" {
            hidePopUp()
            completionMessage?(message)
        } else {
            vYesNoContentView.heightError.constant = 21
            vYesNoContentView.layoutIfNeeded()
            updateNewHeight(height: 210)
        }
    }
}
