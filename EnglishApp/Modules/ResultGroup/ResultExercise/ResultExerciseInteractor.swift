//
//  ResultExerciseInteractor.swift
//  EnglishApp
//
//  Created vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ResultExerciseInteractor: ResultExerciseInteractorInputProtocol {
    func reportQuestion(questionDetailId: Int, content: String) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.reportQuestion(question_details_id: questionDetailId, content: content, success: { (response) in
            ProgressView.shared.hide()
            self.presenter?.reportQuestionSuccessed()
        }) { (error) in
            ProgressView.shared.hide()
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

    weak var presenter: ResultExerciseInteractorOutputProtocol?
}
