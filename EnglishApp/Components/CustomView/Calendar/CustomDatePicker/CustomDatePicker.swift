//
//  CustomDatePicker.swift
//  EnglishApp
//
//  Created by Steve on 8/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

protocol CustomDatePickerDelegate: class {
    func cancelDatePicker()
    func doneDatePicker(month: Int, year: Int)
}

class CustomDatePicker : UIView {
    
    weak var delegate : CustomDatePickerDelegate?
    
    let buttonDone : UIButton = {
        let view : UIButton = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(LocalizableKey.done.showLanguage, for: .normal)
        view.titleLabel?.font = AppFont.fontRegular14
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    let buttonCancel : UIButton = {
        let view : UIButton = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(LocalizableKey.cancel.showLanguage, for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = AppFont.fontRegular14
        view.clipsToBounds = true
        return view
    }()
    let datePicker : MonthCalendar = {
        let view = MonthCalendar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var month : Int = 0
    private var year : Int = 0
    private var currentMonth : Int = 0
    private var currentyear : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupTimer(month: Int, year: Int) {
        self.currentMonth = month
        self.currentyear = year
        self.month = month
        self.year = year
        datePicker.setupCalendar(month: month, year: year)
    }
    
    private func setupView(){
//        self.clipsToBounds = true
        self.addSubview(datePicker)
        datePicker.delegate = self
        datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        self.addSubview(buttonDone)
        buttonDone.addTarget(self, action: #selector(clickDone), for: .touchUpInside)
        buttonDone.heightAnchor.constraint(equalToConstant: 20).isActive = true
        buttonDone.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonDone.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        buttonDone.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        self.addSubview(buttonCancel)
        buttonCancel.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        buttonCancel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        buttonCancel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonCancel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        buttonCancel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
    }
    
    @objc func clickDone() {
        if month != currentMonth || year != currentyear {
            delegate?.doneDatePicker(month: month, year: year)
        } else {
            delegate?.cancelDatePicker()
        }
    }
    
    @objc func clickCancel() {
        delegate?.cancelDatePicker()
    }
}

extension CustomDatePicker : MonthCalendarDelegate {
    func valueChanged(month: Int, year: Int) {
        self.month = month
        self.year = year
    }
}
