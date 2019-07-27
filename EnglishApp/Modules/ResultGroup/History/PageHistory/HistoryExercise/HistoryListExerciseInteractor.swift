//
//  HistoryListExerciseInteractor.swift
//  EnglishApp
//
//  Created Steve on 7/26/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryListExerciseInteractor: HistoryListExerciseInteractorInputProtocol {
    
    weak var presenter: HistoryListExerciseInteractorOutputProtocol?
    
    func getListHistoryExercise(type: Int, offset: Int, date: String) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getHistoryExercise(type: type,date: date, offset: offset, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getListHistoryExerciseSuccessed(response: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}