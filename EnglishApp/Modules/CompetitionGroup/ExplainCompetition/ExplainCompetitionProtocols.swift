//
//  ExplainCompetitionProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ExplainCompetitionWireframeProtocol: class {

}
//MARK: Presenter -
protocol ExplainCompetitionPresenterProtocol: class {

    var interactor: ExplainCompetitionInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol ExplainCompetitionInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol ExplainCompetitionInteractorInputProtocol: class {

    var presenter: ExplainCompetitionInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol ExplainCompetitionViewProtocol: class {

    var presenter: ExplainCompetitionPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
