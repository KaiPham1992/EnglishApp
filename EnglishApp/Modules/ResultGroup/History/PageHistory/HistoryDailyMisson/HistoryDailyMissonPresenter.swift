//
//  HistoryDailyMissonPresenter.swift
//  EnglishApp
//
//  Created Steve on 7/19/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryDailyMissonPresenter: HistoryDailyMissonPresenterProtocol, HistoryDailyMissonInteractorOutputProtocol {

    weak private var view: HistoryDailyMissonViewProtocol?
    var interactor: HistoryDailyMissonInteractorInputProtocol?
    private let router: HistoryDailyMissonWireframeProtocol
    
    var listResultDailyMisson: [LessonCatelogy]?
    var isLoadmore: Bool = true

    init(interface: HistoryDailyMissonViewProtocol, interactor: HistoryDailyMissonInteractorInputProtocol?, router: HistoryDailyMissonWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    
    func getHistoryExercise(type: Int,date: String,offset:Int) {
        if isLoadmore {
            self.interactor?.getHistoryExercise(type: type,date: date, offset: offset)
        }
    }
    
    func getListLessonSuccessed(listLesson: [LessonCatelogy]) {
        if listLesson.count < limit{
            isLoadmore = false
        }
        self.listResultDailyMisson = listLesson
        self.view?.reloadView()
    }
}