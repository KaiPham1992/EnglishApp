//
//  NoteProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol NoteWireframeProtocol: class {

}
//MARK: Presenter -
protocol NotePresenterProtocol: class {

    var interactor: NoteInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol NoteInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol NoteInteractorInputProtocol: class {

    var presenter: NoteInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol NoteViewProtocol: class {

    var presenter: NotePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
