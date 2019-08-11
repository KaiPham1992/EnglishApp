//
//  FightInteractor.swift
//  EnglishApp
//
//  Created Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FightInteractor: FightInteractorInputProtocol {
   
    func getViewFightCompetition(id: String) {
        ProgressView.shared.showLoadingCompetition()
        Provider.shared.competitionAPIService.getViewFightCompetition(id: id, success: { (response) in
            if let _response = response {
                self.presenter?.getExerciseSuccessed(respone: _response)
            }
        }) { (error) in
            ProgressView.shared.hideLoadingCompetition()
        }
    }
    
    weak var presenter: FightInteractorOutputProtocol?
    
    func exitExercise(id : Int){
        Provider.shared.exerciseAPIService.exitExercise(id: id, success: { (respone) in
            if let _respone = respone {
                self.presenter?.exitSuccessed(respone: _respone)
            }
        }) { (error) in
            
        }
    }
    
    func submitAnswer(param: SubmitCompetitionQuestionResponse) {
        ProgressView.shared.show()
        Provider.shared.competitionAPIService.submitCompetition(param: param, success: { (listRank) in
            ProgressView.shared.hide()
            self.presenter?.submitCompetitionSuccessed(listRank: listRank)
        }) { (error) in
            ProgressView.shared.hide()
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
}