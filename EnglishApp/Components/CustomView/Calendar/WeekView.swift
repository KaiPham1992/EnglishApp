//
//  WeekView.swift
//  EnglishApp
//
//  Created by vinova on 5/31/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class WeekView: UIView{
    
    let stackView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution =  UIStackView.Distribution.fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.addSubview(stackView)
        stackView.fillSuperview()
        var daysArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i]
            lbl.textColor = .black
            lbl.font = AppFont.fontBold14
            lbl.textAlignment = .center
            stackView.addArrangedSubview(lbl)
        }
    }
}
