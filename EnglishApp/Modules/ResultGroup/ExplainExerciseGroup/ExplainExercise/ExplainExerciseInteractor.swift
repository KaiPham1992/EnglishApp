//
//  ExplainExerciseInteractor.swift
//  EnglishApp
//
//  Created Steve on 7/28/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ExplainExerciseInteractor: ExplainExerciseInteractorInputProtocol {

    weak var presenter: ExplainExerciseInteractorOutputProtocol?
    
    func getExplainQuestion(id: Int) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.explainExercise(id: id, success: { (response) in
            ProgressView.shared.hide()
            if let _response = response {
                self.presenter?.getExlainQuestionSuccessed(respone: _response)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func searchVocabulary(word: String, position: CGPoint) {
        if word != "" {
            Provider.shared.exerciseAPIService.searchVocabulary(word: word, id_dictionary: "1", success: { (response) in
                if let _response = response {
                    self.presenter?.searchVocabularySuccessed(wordEntity: _response, position: position)
                }
            }) { (error) in
                
            }
        }
    }
}
