//
//  ResultExercisePresenter.swift
//  EnglishApp
//
//  Created vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ResultExercisePresenter: ResultExercisePresenterProtocol, ResultExerciseInteractorOutputProtocol {
    func reportQuestion(questionDetailId: Int, content: String) {
        self.interactor?.reportQuestion(questionDetailId: questionDetailId, content: content)
    }
    
    func reportQuestionSuccessed() {
        self.view?.reportQuestionSuccessed()
    }
    

    weak private var view: ResultExerciseViewProtocol?
    var interactor: ResultExerciseInteractorInputProtocol?
    private let router: ResultExerciseWireframeProtocol
    var listAnswer: [QuestionResultEntity] = []

    init(interface: ResultExerciseViewProtocol, interactor: ResultExerciseInteractorInputProtocol?, router: ResultExerciseWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getNumberAnswer() -> Int{
        return listAnswer.count
    }
    
    func getAnswer(indexPath: IndexPath) -> QuestionResultEntity{
        return listAnswer[indexPath.row]
    }
}
