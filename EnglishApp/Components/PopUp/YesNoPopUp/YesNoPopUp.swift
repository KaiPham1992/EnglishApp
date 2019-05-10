//
//  YesNoPopUp.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class YesNoPopUp: BasePopUpView {
    
    let vYesNoContentView: YesNoContentView = {
        let view = YesNoContentView()

        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()

        vYesNoContentView.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        vYesNoContentView.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(message: String, completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        vYesNoContentView.lbTitle.text = message
        self.completionNo = completionNo
        self.completionYes = completionYes
        
        super.showPopUp(height: 180, type: .showFromBottom)
    }
    
    @objc func btnNoTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        completionYes?()
    }
}
