//
//  ResultProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ResultWireframeProtocol: class {
    func gotoResultQuestion(title: String)
}
//MARK: Presenter -
protocol ResultPresenterProtocol: class {

    var interactor: ResultInteractorInputProtocol? { get set }
    func gotoResultQuestion(title: String)
}

//MARK: Interactor -
protocol ResultInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol ResultInteractorInputProtocol: class {

    var presenter: ResultInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol ResultViewProtocol: class {

    var presenter: ResultPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
