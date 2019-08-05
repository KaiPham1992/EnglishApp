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
        view.report = { [unowned self](message) in
            self.hidePopUp()
            self.completionMessage?(message)
        }
        
    }
    
    func showPopUp(cancel: CompletionClosure?, report: CompletionMessage?){
        self.completionNo = cancel
        self.completionMessage = report
        self.showPopUp(height: 245)
    }
}
