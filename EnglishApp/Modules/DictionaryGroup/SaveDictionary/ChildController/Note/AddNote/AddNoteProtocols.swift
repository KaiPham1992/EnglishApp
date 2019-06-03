//
//  AddNoteProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol AddNoteWireframeProtocol: class {

}
//MARK: Presenter -
protocol AddNotePresenterProtocol: class {

    var interactor: AddNoteInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol AddNoteInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol AddNoteInteractorInputProtocol: class {

    var presenter: AddNoteInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol AddNoteViewProtocol: class {

    var presenter: AddNotePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}