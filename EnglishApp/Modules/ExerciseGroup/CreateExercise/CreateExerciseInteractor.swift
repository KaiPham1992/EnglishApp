//
//  CreateExerciseInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CreateExerciseInteractor: CreateExerciseInteractorInputProtocol {
   
    weak var presenter: CreateExerciseInteractorOutputProtocol?
    
    func getListQuestionCatelogy(offset: Int) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getListQuestionCatelogy(offset: offset, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getListCatelogySuccessed(respone: _respone.categories )
            }
        }) { (error) in
            ProgressView.shared.hide()
            
        }
    }
    
    func gotoCreateExercise(param: CreateExerciseParam) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.createExercise(param: param, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.createExerciseSuccessed(respone: _respone)
            }
        }) { (error) in
             ProgressView.shared.hide()
             guard let _error = error else {return}
             self.presenter?.upgradeAccount()
        }
    }
}
