//
//  ExerciseProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ExerciseWireframeProtocol: class {
    func gotoCreateExercise()
    func gotoLevelExercise()
}
//MARK: Presenter -
protocol ExercisePresenterProtocol: class {

    var interactor: ExerciseInteractorInputProtocol? { get set }
    func gotoCreateExercise()
    func gotoLevelExercise()
}

//MARK: Interactor -
protocol ExerciseInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol ExerciseInteractorInputProtocol: class {

    var presenter: ExerciseInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol ExerciseViewProtocol: class {

    var presenter: ExercisePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
