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
}
//MARK: Presenter -
protocol NameExercisePresenterProtocol: class {

    var interactor: NameExerciseInteractorInputProtocol? { get set }
    func gotoDetailVocabulary()
}

//MARK: Interactor -
protocol NameExerciseInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol NameExerciseInteractorInputProtocol: class {

    var presenter: NameExerciseInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol NameExerciseViewProtocol: class {

    var presenter: NameExercisePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
