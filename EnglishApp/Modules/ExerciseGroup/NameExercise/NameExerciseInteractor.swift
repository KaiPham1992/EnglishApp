//
//  NameExerciseInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NameExerciseInteractor: NameExerciseInteractorInputProtocol {
 
    weak var presenter: NameExerciseInteractorOutputProtocol?
    
    func getDailyMisson() {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getDailyMisson(success: { (respone) in
            if let _respone = respone {
                self.presenter?.getExerciseSuccessed(respone: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
            guard let _error = error else {
                return
            }
            self.presenter?.getExerciseFailed(error: _error)
        }
    }
    
    func getViewExercise(id: String) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getViewExercise(id: id, success: { (respone) in
            if let _respone = respone {
                self.presenter?.getExerciseSuccessed(respone: _respone)
            }
        }) { (error) in
            guard let _error = error else {
                return
            }
            self.presenter?.getExerciseFailed(error: _error)
        }
    }
    
    func submitExercise(param: SubmitExerciseParam) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.submitExercise(param: param, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.gotoResult(result: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getViewEntranceTest() {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getEntranceExercise(success: { (respone) in
            if let _respone = respone {
                self.presenter?.getExerciseSuccessed(respone: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
            guard let _error = error else {
                return
            }
            self.presenter?.getExerciseFailed(error: _error)
        }
    }
    
    func exitExercise(id : Int){
        Provider.shared.exerciseAPIService.exitExercise(id: id, success: { (respone) in
            if let _respone = respone {
                self.presenter?.exitSuccessed(respone: _respone)
            }
        }) { (error) in
            
        }
    }
    
    func suggestQuestion(id: String,isDiamond: Bool) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.suggestQuestion(id: id,isDiamond: isDiamond, success: { (response) in
            ProgressView.shared.hide()
            if let _response = response, let data = _response.data as? [String] {
                self.presenter?.suggestQuestionSuccessed(respone: data)
            }
        }) { (error) in
            ProgressView.shared.hide()
            guard let _error = error else {return}
            self.presenter?.suggestQuestionError(error: _error)
        }
    }
    
    func searchVocabulary(word: String, position: CGPoint,index: IndexPath) {
        if word != "" {
            Provider.shared.exerciseAPIService.searchVocabulary(word: word, success: { (response) in
                if let _response = response {
                    self.presenter?.searchVocabularySuccessed(wordEntity: _response, position: position,index: index)
                } else {
                    
                }
            }) { (error) in
                
            }
        }
    }
}
