//
//  ExercisePresenter.swift
//  EnglishApp
//
//  Created vinova on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ExercisePresenter: ExercisePresenterProtocol, ExerciseInteractorOutputProtocol {
   
    
    
    weak private var view: ExerciseViewProtocol?
    var interactor: ExerciseInteractorInputProtocol?
    private let router: ExerciseWireframeProtocol

    init(interface: ExerciseViewProtocol, interactor: ExerciseInteractorInputProtocol?, router: ExerciseWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func gotoCreateExercise() {
        self.router.gotoCreateExercise()
    }
    
    func gotoLevelExercise() {
        self.router.gotoLevelExercise()
    }
    func gotoPracticeExercise() {
        self.router.gotoPracticeExercise()
    }
    
    func gotoAssignExercise() {
        self.router.gotoAssignExercise()
    }
    
    
    func gotoHistoryCreateExercise() {
        self.router.gotoHistoryCreateExercise()
    }
    
    func gotoHistoryLevelExercise() {
        self.router.gotoHistoryLevelExercise()
    }
    
    func gotoHistoryPracticeExercise() {
        self.router.gotoHistoryPracticeExercise()
    }
    
    func gotoHistoryAssignExercise() {
        self.router.gotoHistoryAssignExercise()
    }
    
}
