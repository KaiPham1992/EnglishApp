//
//  AssignExerciseInteractor.swift
//  EnglishApp
//
//  Created Steve on 7/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class AssignExerciseInteractor: AssignExerciseInteractorInputProtocol {

    weak var presenter: AssignExerciseInteractorOutputProtocol?
    
    func getListAssignExercise(offset: Int) {
        
        Provider.shared.exerciseAPIService.getListAssignExercise(offset: offset, success: { (respone) in
            
            if let _response = respone {
                self.presenter?.getListAssignExerciseSuccessed(respone: _response)
            }
        }) { (error) in
            
        }
    }
}
