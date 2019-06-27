//
//  LevelExerciseProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol LevelExerciseWireframeProtocol: class {
    func gotoExercise()
    func gotoTryHard()
    func gotoChoiceExercise()
}
//MARK: Presenter -
protocol LevelExercisePresenterProtocol: class {

    var interactor: LevelExerciseInteractorInputProtocol? { get set }
    func gotoExercise()
    func gotoTryHard()
    func gotoChoiceExercise()
    func getListExercise(category_id: Int,offset: Int)
    func getItemExercise(indexPath: IndexPath) -> ExerciseEntity?
    func getNumberRow() -> Int?
}

//MARK: Interactor -
protocol LevelExerciseInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func getListExerciseSuccessed(respone: ListExerciseEntity)
}

protocol LevelExerciseInteractorInputProtocol: class {

    var presenter: LevelExerciseInteractorOutputProtocol?  { get set }
    func getListExercise(category_id: Int,offset: Int)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol LevelExerciseViewProtocol: class {

    var presenter: LevelExercisePresenterProtocol?  { get set }
    func reloadView()

    /* Presenter -> ViewController */
}
