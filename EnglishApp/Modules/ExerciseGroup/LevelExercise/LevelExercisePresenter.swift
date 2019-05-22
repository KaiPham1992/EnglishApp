//
//  LevelExercisePresenter.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LevelExercisePresenter: LevelExercisePresenterProtocol, LevelExerciseInteractorOutputProtocol {

    weak private var view: LevelExerciseViewProtocol?
    var interactor: LevelExerciseInteractorInputProtocol?
    private let router: LevelExerciseWireframeProtocol

    init(interface: LevelExerciseViewProtocol, interactor: LevelExerciseInteractorInputProtocol?, router: LevelExerciseWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
