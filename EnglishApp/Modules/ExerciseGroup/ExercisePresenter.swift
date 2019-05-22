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

}
