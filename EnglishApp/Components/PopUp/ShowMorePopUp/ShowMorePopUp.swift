//
//  ShowMorePopUp.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ShowMorePopUp : BasePopUpView{
    let view : ViewShowMore = {
        let view = ViewShowMore()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func setupView() {
        super.setupView()
        self.vContent.addSubview(view)
        view.fillSuperview()
        view.btnClose.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
    }
    @objc func closePopUp(){
        hidePopUp()
    }
    
    func showPopUp(content: String){
        view.setupContent(content: content)
        self.showPopUp(width: UIScreen.main.bounds.width - 64,height: 400)
    }
}
