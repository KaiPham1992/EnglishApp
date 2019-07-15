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
        
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()
        
        vYesNoContentView.tfInput.vLine.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        vYesNoContentView.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        vYesNoContentView.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(titlePopUp: String, titleInput: String, placeHolderInput: String, titleNo: String, titleYes: String, completionNo: CompletionClosure?, completionYes: CompletionMessage?) {
        
        vYesNoContentView.lbTitle.text = titlePopUp
        vYesNoContentView.tfInput.setTitleAndPlaceHolder(title: titleInput, placeHolder: placeHolderInput)
        
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
        hidePopUp()
        completionMessage?(vYesNoContentView.tfInput.tfInput.text)
    }
}
