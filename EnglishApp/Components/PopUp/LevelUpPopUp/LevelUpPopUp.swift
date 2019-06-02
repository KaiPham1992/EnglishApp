//
//  ThanksReportPopUp.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class LevelUpPopUp: BasePopUpView {
    
    let thanksReportContent: LevelUpContent = {
        let view = LevelUpContent()
        
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(thanksReportContent)
        thanksReportContent.fillSuperview()
        thanksReportContent.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(completionYes: CompletionClosure?) {
        self.completionYes = completionYes
        
        super.showPopUp(height: 250)
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        completionYes?()
    }
}
