//
//  LessonProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol LessonWireframeProtocol: class {
    func gotoLesson()
}
//MARK: Presenter -
protocol LessonPresenterProtocol: class {

    var interactor: LessonInteractorInputProtocol? { get set }
    func gotoLesson()
}

//MARK: Interactor -
protocol LessonInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol LessonInteractorInputProtocol: class {

    var presenter: LessonInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol LessonViewProtocol: class {

    var presenter: LessonPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
