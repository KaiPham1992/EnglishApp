//
//  MothView.swift
//  EnglishApp
//
//  Created by vinova on 5/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

protocol DidChangeMonthDelegate: class {
    func didChangeMonth(month: Int,year: Int,isLeft: Bool)
}

class MonthView: UIView{
    let lblTitle: UILabel = {
        let view = UILabel()
        view.text = "text"
        view.textColor = .black
        view.font = AppFont.fontBold16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btRight : UIButton = {
        let view = UIButton()
        view.setBackgroundImage(#imageLiteral(resourceName: "tick"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("", for: .normal)
        return view
    }()
    let btLeft : UIButton = {
        let view = UIButton()
        view.setBackgroundImage(#imageLiteral(resourceName: "tick"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("", for: .normal)
        return view
    }()
    
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0{
        didSet{
            if tempCurrentMonth == currentMonthIndex && tempCurrentYear == currentYear {
                btRight.isUserInteractionEnabled = false
                btRight.alpha = 0.4
            } else{
                btRight.isUserInteractionEnabled = true
                btRight.alpha = 1
            }
        }
    }
    var currentYear: Int = 0
    var tempCurrentMonth = 0
    var tempCurrentYear = 0
    var isLeft = false
    weak var delegate : DidChangeMonthDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        self.addSubview(lblTitle)
        self.addSubview(btLeft)
        self.addSubview(btRight)
        
        lblTitle.centerXToSuperview()
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        btRight.heightAnchor.constraint(equalToConstant: 14).isActive = true
        btRight.widthAnchor.constraint(equalToConstant: 14).isActive = true
        btRight.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        btRight.centerYToSuperview()
        
        btLeft.heightAnchor.constraint(equalToConstant: 14).isActive = true
        btLeft.widthAnchor.constraint(equalToConstant: 14).isActive = true
        btLeft.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        btLeft.centerYToSuperview()
        btLeft.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        btRight.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }
    
    @objc func clickButton(sender: UIButton){
        if sender == btLeft{
            currentMonthIndex -= 1
            self.isLeft = true
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
                
            }
        }
        if sender == btRight{
            currentMonthIndex += 1
            self.isLeft = false
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
                
            }
           
        }
        lblTitle.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
        delegate?.didChangeMonth(month: currentMonthIndex, year: currentYear, isLeft: self.isLeft)
    }
    
    func setHandleSwipe(month: Int,year: Int){
        self.currentMonthIndex = month - 1
        self.currentYear = year
        lblTitle.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
    }
    
    func disableRight(){
        btRight.isUserInteractionEnabled = false
        btRight.alpha = 0.4
    }
    
    func setupData(){
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        lblTitle.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
        tempCurrentMonth = currentMonthIndex
        tempCurrentYear = currentYear
        btRight.isUserInteractionEnabled = false
        btRight.alpha = 0.4
    }
}
