//
//  LevelExerciseInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LevelExerciseInteractor: LevelExerciseInteractorInputProtocol {
    

    weak var presenter: LevelExerciseInteractorOutputProtocol?
    
    func getListExercise(category_id: Int,offset: Int) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getListExercise(type_test: 5, category_id: category_id, level: 1, offset: offset, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getListExerciseSuccessed(respone: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getListCatelogy() {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getListExerciseCatelogy(success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getListCatelogySuccessed(respone: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getLevelExercise(type_test: Int,offset: Int) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getLevelExercise(type_test: type_test, offset: offset, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getListLevelExerciseSuccessed(respone: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
}
