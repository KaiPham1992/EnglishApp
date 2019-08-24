//
//  MonthCalendar.swift
//  EnglishApp
//
//  Created by Steve on 8/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

protocol MonthCalendarDelegate : class {
    func valueChanged(month: Int, year: Int)
}

class MonthCalendar : UIView {
    var pickerView : UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    var listYear : [Int] = []
    var listMonth : [String] = []
    var tempListMonth : [String] = []
    var month : Int = 0
    var year : Int = 0
    weak var delegate : MonthCalendarDelegate?
    
    private func setupView() {
        self.addSubview(pickerView)
        pickerView.fillSuperview()
        let currentyear = Date().year
        for item in currentyear - 5...currentyear {
            self.listYear.append(item)
        }
        self.tempListMonth = [LocalizableKey.january.showLanguage, LocalizableKey.february.showLanguage, LocalizableKey.march.showLanguage, LocalizableKey.april.showLanguage, LocalizableKey.may.showLanguage, LocalizableKey.june.showLanguage, LocalizableKey.july.showLanguage, LocalizableKey.august.showLanguage, LocalizableKey.september.showLanguage, LocalizableKey.october.showLanguage, LocalizableKey.november.showLanguage, LocalizableKey.december.showLanguage]
        listMonth = [LocalizableKey.january.showLanguage, LocalizableKey.february.showLanguage, LocalizableKey.march.showLanguage, LocalizableKey.april.showLanguage, LocalizableKey.may.showLanguage, LocalizableKey.june.showLanguage, LocalizableKey.july.showLanguage, LocalizableKey.august.showLanguage, LocalizableKey.september.showLanguage, LocalizableKey.october.showLanguage, LocalizableKey.november.showLanguage, LocalizableKey.december.showLanguage]
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func setupCalendar(month: Int, year: Int) {
        if year == Date().year {
            setupMonth(month: month)
        }
        self.pickerView.reloadComponent(0)
        self.month = month
        self.year = year
        var index = 0
        for item in self.listYear {
            if item == year {
                break
            }
            index += 1
        }
        self.pickerView.selectRow(month - 1, inComponent: 0, animated: false)
        self.pickerView.selectRow(index, inComponent: 1, animated: false)
    }
    
    private func setupMonth(month: Int) {
        var index = 0
        self.listMonth.removeAll()
        for item in tempListMonth {
            if index < month {
                self.listMonth.append(item)
                index += 1
            } else {
                break
            }
        }
    }
}

extension MonthCalendar : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return listMonth.count
        }
        return listYear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return listMonth[row]
        } else {
            return "\(listYear[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}

extension MonthCalendar : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            month = row + 1
        }
        if component == 1 {
            year = listYear[row]
            if year == Date().year {
                setupMonth(month: Date().month)
            } else {
                self.listMonth = self.tempListMonth
            }
            self.pickerView.reloadComponent(0)
        }
        delegate?.valueChanged(month: self.month, year: self.year)
    }
}
