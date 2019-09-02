//
//  NameExercisePresenter.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NameExercisePresenter: NameExercisePresenterProtocol, NameExerciseInteractorOutputProtocol {
   
    weak private var view: NameExerciseViewProtocol?
    var interactor: NameExerciseInteractorInputProtocol?
    private let router: NameExerciseWireframeProtocol
    var exerciseEntity: ViewExerciseEntity?
    var type : TypeDoExercise = .assignExercise
    var indexPath: IndexPath?
    var indexQuestion: IndexPath?
    var error: APIError?
    var isOut = false

    init(interface: NameExerciseViewProtocol, interactor: NameExerciseInteractorInputProtocol?, router: NameExerciseWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getDailyMisson() {
        self.interactor?.getDailyMisson()
    }
    
    func gotoDetailVocabulary(idWord: Int) {
        self.router.gotoDetailVocabulary(idWord: idWord)
    }
    
    func submitExercise(param: SubmitExerciseParam,isOut: Bool) {
        self.isOut = isOut
        self.interactor?.submitExercise(param: param)
    }
    
    func gotoResult(result: TestResultProfileEntity) {
         self.router.gotoResult(result: result, type: self.type, isOut: isOut)
    }
    
    func getTime(index: Int) -> Int? {
        return Int(exerciseEntity?.questions?[index].question_time ?? "0")
    }
    
    func getQuestion(indexPath: IndexPath) -> QuestionEntity? {
        return exerciseEntity?.questions?[indexPath.row]
    }
    
    func getViewExercise(id: String) {
        if exerciseEntity == nil {
            self.interactor?.getViewExercise(id: id)
        } else {
            self.view?.reloadView()
        }
        
    }
    
    func getViewEntranceTest() {
        self.interactor?.getViewEntranceTest()
    }
    
    func getExerciseSuccessed(respone: ViewExerciseEntity) {
        self.exerciseEntity = respone
        self.view?.reloadView()
    }
    
    func getExerciseFailed(error: APIError) {
        self.view?.getExerciseFailed(error: error)
    }
    
    func exitSuccessed(respone: TestResultProfileEntity){
        self.router.gotoResult(result: respone, type: type, isOut: true)
        self.view?.exitSuccessed()
    }
    
    func exitExercise(id: Int) {
        self.interactor?.exitExercise(id: id)
    }
    
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath,isDiamond: Bool) {
        self.interactor?.suggestQuestion(id: id, isDiamond: isDiamond)
        self.indexPath = indexPath
        self.indexQuestion = indexQuestion
    }
    
    func suggestQuestionSuccessed(respone: [String], isDiamond: Bool) {
        self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].isShowSuggestQuestion = true
        let listOptions = self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options ?? []
        if listOptions.count == 2 || listOptions.count == 3 {
            if let first = respone.first {
                self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options = listOptions.filter{($0._id ?? "") != first}
            }
        } else {
            if listOptions.count == 4 {
                self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options = listOptions.filter{!respone.contains($0._id ?? "")}
            }
        }
        self.view?.suggesQuestionSuccessed(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0), indexQuestion: self.indexQuestion ?? IndexPath(row: 0, section: 0), isDiamond: isDiamond)
    }
    
    func suggestQuestionError(error: APIError) {
        self.error = error
        self.view?.suggestQuestionError()
    }
    
    func searchVocabulary(word: String, id_dictionary: String, position: CGPoint,index: IndexPath) {
        self.interactor?.searchVocabulary(word: word, id_dictionary: id_dictionary, position: position,index: index)
    }
    
    func searchVocabularySuccessed(wordEntity: WordExplainEntity, position: CGPoint,index: IndexPath) {
        self.view?.searchVocabularySuccessed(wordEntity: wordEntity, position: position,index:index)
    }
}
