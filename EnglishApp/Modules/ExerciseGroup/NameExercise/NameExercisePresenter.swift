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

    init(interface: NameExerciseViewProtocol, interactor: NameExerciseInteractorInputProtocol?, router: NameExerciseWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getDailyMisson() {
        self.interactor?.getDailyMisson()
    }
    
    func getNameExercise() -> String? {
        return exerciseEntity?.name
    }
    
    
    func gotoDetailVocabulary() {
        self.router.gotoDetailVocabulary()
    }
    
    func getNumber() -> Int? {
        return exerciseEntity?.questions?.count
    }
    
    func getIDExercise() -> Int?{
        return Int(exerciseEntity?._id ?? "0")
    }
    
    func getAllTime() -> [Int]? {
        return exerciseEntity?.questions?.map{$0.question_time}.compactMap{Int($0 ?? "0")}
    }
    
    func submitExercise(param: SubmitExerciseParam) {
        self.interactor?.submitExercise(param: param)
    }
    
    func getTotalTime() -> Int?{
        return exerciseEntity?.total_times
    }
    
    func gotoResult(result: TestResultProfileEntity) {
        self.router.gotoResult(result: result, type: self.type)
    }
    
    func getAllIdAndTimeQuestion() -> [(Int,Int)]?{
        return exerciseEntity?.questions?.map{(Int($0._id ?? "0") ?? 0,Int($0.question_time ?? "0") ?? 0)}
    }
    
    func getAllTime() -> Int? {
        return exerciseEntity?.total_times
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
        self.router.gotoResult(result: respone, type: .levelExercise)
        self.view?.exitSuccessed()
    }
    
    func exitExercise(id: Int) {
        self.interactor?.exitExercise(id: id)
    }
    
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
        self.interactor?.suggestQuestion(id: id)
        self.indexPath = indexPath
        self.indexQuestion = indexQuestion
    }
    
    func suggestQuestionSuccessed(respone: [String]) {
        let options = self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options.filter{!respone.contains($0._id ?? "")} ?? []
        self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options = options
        self.view?.suggesQuestionSuccessed(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0), indexQuestion: self.indexQuestion ?? IndexPath(row: 0, section: 0))
    }
}
