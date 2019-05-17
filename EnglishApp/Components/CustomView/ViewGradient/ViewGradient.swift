//
//  File.swift
//  EnglishApp
//
//  Created by vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewGradient : UIView{
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    func setupGradient(beginColor: UIColor,endColor: UIColor){
        gradient.colors = [beginColor.cgColor,endColor.cgColor]
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
