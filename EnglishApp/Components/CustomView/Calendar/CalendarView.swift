//
//  CalendarView.swift
//  EnglishApp
//
//  Created by vinova on 5/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class CalendarView : UIView{
    let monthView : MonthView = {
        let view = MonthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weekView : WeekView = {
        let view = WeekView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clvDate : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.allowsMultipleSelection = false
        return view
    }()
    
    var currentYear = 0
    var currentMonthIndex = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    var todayDate = 0
    var isLeft = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupData()
        setupView()
    }
    
    func setupData(){
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todayDate = Calendar.current.component(.day, from: Date())
        
        if currentMonthIndex == 2 && currentYear % 4 == 0{
            numOfDaysInMonth[currentMonthIndex - 1] = 29
        }
        
        firstWeekDayOfMonth = getFirstWeekDate()
    }
    
    func setupView(){
        self.addSubview(monthView)
        monthView.delegate = self
        monthView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        monthView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        monthView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        monthView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(weekView)
        weekView.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: 45).isActive = true
        weekView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 24).isActive = true
        weekView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24).isActive = true
        weekView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(clvDate)
        
        clvDate.topAnchor.constraint(equalTo: weekView.bottomAnchor, constant: 24).isActive = true
        clvDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        clvDate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        clvDate.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        clvDate.anchor(weekView.bottomAnchor, left: self.leadingAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, leftConstant: 14, rightConstant:14)
        
        
        clvDate.delegate = self
        clvDate.dataSource = self
        clvDate.registerXibCell(DateCell.self)
        let gesRight = UISwipeGestureRecognizer(target: self, action: #selector(slide))
        gesRight.direction = .right
        clvDate.addGestureRecognizer(gesRight)
        
        let gesLeft = UISwipeGestureRecognizer(target: self, action: #selector(slide))
        gesLeft.direction = .left
        clvDate.addGestureRecognizer(gesLeft)
    }
    
    @objc func slide(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .left:
            handleSwipe(isLeft: false)
        case .right:
            handleSwipe(isLeft: true)
        default:
            break
        }
    }
    
    func reloadView(isLeft: Bool){
        if isLeft {
            UIView.transition(with: clvDate, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.clvDate.reloadData()
            }, completion: nil)
        } else {
            UIView.transition(with: clvDate, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.clvDate.reloadData()
            }, completion: nil)
        }
    }
    
    func handleSwipe(isLeft: Bool){
        if let (month,year) = getSwiftMonthAndYear(isLeft: isLeft) as? (Int,Int) {
            self.currentMonthIndex = month
            self.currentYear = year
            monthView.setHandleSwipe(month: self.currentMonthIndex, year: self.currentYear)
            reloadView(isLeft: isLeft)
        } else {
            monthView.disableRight()
        }
    }
    
    func getSwiftMonthAndYear(isLeft: Bool) -> (Int?,Int?){
        if isLeft{
            currentMonthIndex -= 1
            self.isLeft = true
            if currentMonthIndex - 1 < 0 {
                currentMonthIndex = 12
                currentYear -= 1
            }
            return (currentMonthIndex,currentYear)
        } else {
            let month = Calendar.current.component(.month, from: Date())
            let year = Calendar.current.component(.year, from: Date())
            if currentMonthIndex == month && currentYear == year {
                return (nil,nil)
            } else {
                currentMonthIndex += 1
                self.isLeft = false
                if currentMonthIndex + 1 > 12 {
                    currentMonthIndex = 1
                    currentYear += 1
                    
                }
                return (currentMonthIndex,currentYear)
            }
        }
    }
    
    func getFirstWeekDate() -> Int{
        return ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDateInMonth.weekday) ?? 0
    }
}

extension CalendarView : DidChangeMonthDelegate{
    func didChangeMonth(month: Int, year: Int,isLeft : Bool) {
        self.currentYear = year
        self.currentMonthIndex = month + 1
        if month == 1 && year % 4 == 0{
            numOfDaysInMonth[month] = 29
        } else {
            numOfDaysInMonth[month] = 28
        }
        self.firstWeekDayOfMonth = getFirstWeekDate()
        reloadView(isLeft: self.isLeft)
    }
}

extension CalendarView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(DateCell.self, indexPath: indexPath)
        if indexPath.row <= firstWeekDayOfMonth - 2 {
            var numberOfMonthPresent = 0
            if currentMonthIndex - 2 < 0 {
                 numberOfMonthPresent = numOfDaysInMonth[11]
            } else {
                numberOfMonthPresent = numOfDaysInMonth[currentMonthIndex-2]
            }
            cell.disableCell(date: numberOfMonthPresent - firstWeekDayOfMonth + 1 + indexPath.row + 1)
        } else {
            let date = indexPath.row - firstWeekDayOfMonth + 2
            cell.enableCell(date: date)
        }
        
        return cell
    }
}
extension CalendarView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension CalendarView : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        cell.showDot()
    }
}
