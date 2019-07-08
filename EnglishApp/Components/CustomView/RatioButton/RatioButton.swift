//
//  RatioButton.swift
//  EnglishApp
//
//  Created by vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class RatioButton : UIButton{
    var isChocie: Bool = false {
        didSet{
            setButton()
        }
    }
    var imageChoice = UIImage(named:"ic_Radio_button_on_yellow")
    var imageNoChoice = UIImage(named:"Material_Dark_Radio_button_off"){
        didSet{
            self.setBackgroundImage(imageNoChoice, for: .normal)
        }
    }
    
    var actionClick : ((_ isChoice: Bool) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        self.setTitle("", for: .normal)
        self.setBackgroundImage(imageNoChoice, for: .normal)
        self.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }
    
    func setButton(){
        if isChocie {
            self.setBackgroundImage(imageChoice, for: .normal)
        } else {
            self.setBackgroundImage(imageNoChoice, for: .normal)
        }
    }
    
    @objc func clickButton(){
        self.isChocie = !self.isChocie
        actionClick?(isChocie)
    }
}
