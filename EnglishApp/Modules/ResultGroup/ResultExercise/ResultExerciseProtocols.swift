//
//  ResultExerciseProtocols.swift
//  EnglishApp
//
//  Created vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import UIKit

//MARK: Wireframe -
protocol ResultExerciseWireframeProtocol: class {
    func gotoDetailVocabulary(word: WordExplainEntity)
}
//MARK: Presenter -
protocol ResultExercisePresenterProtocol: class {

    var interactor: ResultExerciseInteractorInputProtocol? { get set }
    func getNumberAnswer() -> Int
    func getAnswer(indexPath: IndexPath) -> QuestionResultEntity
    func reportQuestion(questionDetailId: Int, content: String)
    func searchVocabulary(word: String,position: CGPoint,index: IndexPath)
    func gotoDetailVocabulary(word: WordExplainEntity)
}

//MARK: Interactor -
protocol ResultExerciseInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func reportQuestionSuccessed()
    func searchVocabularySuccessed(wordEntity: WordExplainEntity,position: CGPoint,index: IndexPath)
}

protocol ResultExerciseInteractorInputProtocol: class {

    var presenter: ResultExerciseInteractorOutputProtocol?  { get set }
    func reportQuestion(questionDetailId: Int, content: String)

    func searchVocabulary(word: String,position: CGPoint,index: IndexPath)
    /* Presenter -> Interactor */
}

//MARK: View -
protocol ResultExerciseViewProtocol: class {

    var presenter: ResultExercisePresenterProtocol?  { get set }
    func reportQuestionSuccessed()
    func searchVocabularySuccessed(wordEntity: WordExplainEntity,position: CGPoint,index: IndexPath)

    /* Presenter -> ViewController */
}
