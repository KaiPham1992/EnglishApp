//
//  ReportQuestionPopUp.swift
//  EnglishApp
//
//  Created by vinova on 6/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

class ReportQuestionPopUp : BasePopUpView{
    let view : ReportQuestionView = {
        let view = ReportQuestionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        self.vContent.addSubview(view)
        view.fillSuperview()
        view.cancel = {
            self.hidePopUp()
            self.completionNo?()
        }
        view.report = {
            self.hidePopUp()
            self.completionYes?()
        }
        
    }
    
    func showPopUp(cancel: CompletionClosure?, report: CompletionClosure?){
        self.completionNo = cancel
        self.completionYes = report
        self.showPopUp(height: 245)
    }
}
