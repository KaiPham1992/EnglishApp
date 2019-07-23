//
//  ChoiceExerciseProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ChoiceExerciseWireframeProtocol: class {
    func gotoExercise(id: String)
}
//MARK: Presenter -
protocol ChoiceExercisePresenterProtocol: class {

    var exerciseChoiceEntity : ExerciseChoiceEntity? {get set}
    var interactor: ChoiceExerciseInteractorInputProtocol? { get set }
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int,level: Int,studyPackId: Int?)
    func gotoExercise(id: String)
}

//MARK: Interactor -
protocol ChoiceExerciseInteractorOutputProtocol: class {

    func getViewChoiceExerciseSuccessed(respone: ExerciseChoiceEntity)
    /* Interactor -> Presenter */
}

protocol ChoiceExerciseInteractorInputProtocol: class {

    var presenter: ChoiceExerciseInteractorOutputProtocol?  { get set }
    func getViewChoiceExercise(typeTest: Int, catelogyId: Int,level: Int,studyPackId: Int?)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol ChoiceExerciseViewProtocol: class {

    var presenter: ChoiceExercisePresenterProtocol?  { get set }
    func reloadView()

    /* Presenter -> ViewController */
}
