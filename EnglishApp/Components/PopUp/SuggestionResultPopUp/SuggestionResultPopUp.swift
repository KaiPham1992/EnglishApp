//
//  ResultPopUp.swift
//  EnglishApp
//
//  Created by vinova on 5/29/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

class SuggestionResultPopUp : BasePopUpView{
    let view : SuggesstionView = {
        let view = SuggesstionView()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(view)
        view.fillSuperview()
        view.btnDiamond.addTarget(self, action: #selector(clickDiamond), for: .touchUpInside)
        view.btnMoney.addTarget(self, action: #selector(clickMoney), for: .touchUpInside)
    }
    
    @objc func clickDiamond(){
        hidePopUp()
        completionYes?()
    }
    
    @objc func clickMoney(){
        hidePopUp()
        completionNo?()
    }
    
    func showPopup(diamod: CompletionClosure?, money: CompletionClosure?){
        self.completionYes = diamod
        self.completionNo = money
        self.showPopUp(height: 80)
    }
}
