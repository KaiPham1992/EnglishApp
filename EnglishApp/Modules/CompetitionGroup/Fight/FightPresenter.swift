//
//  FightPresenter.swift
//  EnglishApp
//
//  Created Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FightPresenter: FightPresenterProtocol, FightInteractorOutputProtocol {
    
    weak private var view: FightViewProtocol?
    var interactor: FightInteractorInputProtocol?
    private let router: FightWireframeProtocol
    
    var exerciseEntity: ViewExerciseEntity?
    var indexPath: IndexPath?
    var indexQuestion: IndexPath?
    var error: APIError?
    var listRank : [RankTeamEntity] = []
    
    func submitAnswer(param: SubmitCompetitionQuestionResponse) {
        self.interactor?.submitAnswer(param: param)
    }

    init(interface: FightViewProtocol, interactor: FightInteractorInputProtocol?, router: FightWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getViewFightCompetition(id: String) {
        self.interactor?.getViewFightCompetition(id: id)
    }
    
    
    func gotoDetailVocabulary() {
        self.router.gotoDetailVocabulary()
    }
    
    func gotoResult(result: TestResultProfileEntity) {
        self.router.gotoResult(result: result, type: .assignExercise)
    }

    func getExerciseSuccessed(respone: ViewExerciseEntity) {
        self.exerciseEntity = respone
        self.view?.reloadView()
    }
    
    func getExerciseFailed(error: APIError) {
        self.view?.getExerciseFailed(error: error)
    }
    
    func exitSuccessed(respone: TestResultProfileEntity){
        self.router.gotoResult(result: respone, type: .dailyMissonExercise)
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
    
    func suggestQuestionSuccessed(respone: [String]) {
        let options = self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options.filter{!respone.contains($0._id ?? "")} ?? []
        self.exerciseEntity?.questions?[indexPath?.row ?? 0].answers?[indexQuestion?.row ?? 0].options = options
        self.view?.suggesQuestionSuccessed(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0), indexQuestion: self.indexQuestion ?? IndexPath(row: 0, section: 0))
    }
    func suggestQuestionError(error: APIError) {
        self.error = error
        self.view?.suggestQuestionError()
    }
    
    func submitCompetitionSuccessed(listRank: [RankTeamEntity]) {
        self.listRank = listRank
        self.view?.submitCompetitionSuccessed()
    }
}
