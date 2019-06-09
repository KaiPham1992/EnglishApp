//
//  TaskDateProtocols.swift
//  EnglishApp
//
//  Created vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol TaskDateWireframeProtocol: class {
    func gotoExplain()
}
//MARK: Presenter -
protocol TaskDatePresenterProtocol: class {

    var interactor: TaskDateInteractorInputProtocol? { get set }
    func gotoExplain()
}

//MARK: Interactor -
protocol TaskDateInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol TaskDateInteractorInputProtocol: class {

    var presenter: TaskDateInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol TaskDateViewProtocol: class {

    var presenter: TaskDatePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
