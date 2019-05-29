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

    init(interface: NameExerciseViewProtocol, interactor: NameExerciseInteractorInputProtocol?, router: NameExerciseWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
