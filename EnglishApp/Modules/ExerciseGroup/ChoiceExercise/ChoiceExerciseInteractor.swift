//
//  ChoiceExerciseInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ChoiceExerciseInteractor: ChoiceExerciseInteractorInputProtocol {

    weak var presenter: ChoiceExerciseInteractorOutputProtocol?
    
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int, level: Int) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getViewChoiceExercise(typeTest: typeTest, catelogyId: catelogyId, level: level, success: { (response) in
            ProgressView.shared.hide()
            if let _response = response {
                self.presenter?.getViewChoiceExerciseSuccessed(respone: _response)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}