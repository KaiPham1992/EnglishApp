//
//  NameExerciseProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol NameExerciseWireframeProtocol: class {
    func gotoDetailVocabulary()
    func gotoResult(result: TestResultProfileEntity)
}
//MARK: Presenter -
protocol NameExercisePresenterProtocol: class {

    var interactor: NameExerciseInteractorInputProtocol? { get set }
    func gotoDetailVocabulary()
    func getViewExercise(id: String)
    func getViewEntranceTest()
    func getTime(index: Int) -> Int?
    func getNumber() -> Int?
    func getQuestion(indexPath: IndexPath) -> QuestionEntity?
    func getAllTime() -> [Int]?
    func getAllIdAndTimeQuestion() -> [(Int,Int)]?
    func getIDExercise() -> Int?
    func getTotalTime() -> Int?
    func submitExercise(param: SubmitExerciseParam)
}

//MARK: Interactor -
protocol NameExerciseInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func getExerciseSuccessed(respone: ViewExerciseEntity)
    func gotoResult(result: TestResultProfileEntity)
}

protocol NameExerciseInteractorInputProtocol: class {

    var presenter: NameExerciseInteractorOutputProtocol?  { get set }
    func getViewExercise(id: String)
    func getViewEntranceTest()
    func submitExercise(param: SubmitExerciseParam)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol NameExerciseViewProtocol: class {

    var presenter: NameExercisePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func reloadView()
}
