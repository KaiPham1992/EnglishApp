//
//  FindProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 6/8/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol FindWireframeProtocol: class {
    func gotoTheoryDetail(idLesson: String)
}
//MARK: Presenter -
protocol FindPresenterProtocol: class {

    var interactor: FindInteractorInputProtocol? { get set }
    func search(type: TypeViewSearch, text: String, offset: Int)
    func gotoTheoryDetail(idLesson: String)
//    func checkAmountSearchExercise()
}

//MARK: Interactor -
protocol FindInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didSearchSuccessed(respone: [Any])
//    func checkAmountSearchExerciseSuccessed()
}

protocol FindInteractorInputProtocol: class {

    var presenter: FindInteractorOutputProtocol?  { get set }
    func search(type: TypeViewSearch, text: String, offset: Int)
//    func checkAmountSearchExercise()
    /* Presenter -> Interactor */
}

//MARK: View -
protocol FindViewProtocol: class {

    var presenter: FindPresenterProtocol?  { get set }
    func reloadView(data: [Any])
//    func checkAmountSearchExerciseSuccessed()

    /* Presenter -> ViewController */
}
