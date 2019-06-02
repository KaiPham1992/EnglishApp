//
//  RewardPopUp.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class RewardPopUp: BasePopUpView {
    let view : RewardPopUpContent = {
        let view = RewardPopUpContent()
        return view
    }()
    override func setupView() {
        super.setupView()
        vContent.addSubview(view)
        view.fillSuperview()
        
        view.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    @objc func clickConfirm() {
        hidePopUp()
        completionYes?()
    }
    
    func showPopup(diamond: Int, completionYes: CompletionClosure?){
        view.lbMessage.text = "Thưởng từ cuộc thi\n+ \(diamond) kim cương"
        self.completionYes = completionYes
        self.showPopUp(height: 320)
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        
        completionYes?()
    }
}
