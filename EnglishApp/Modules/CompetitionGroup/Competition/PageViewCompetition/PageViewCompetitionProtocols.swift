//
//  PageViewCompetitionProtocols.swift
//  EnglishApp
//
//  Created Steve on 12/1/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol PageViewCompetitionWireframeProtocol: class {

}
//MARK: Presenter -
protocol PageViewCompetitionPresenterProtocol: class {

    var interactor: PageViewCompetitionInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol PageViewCompetitionInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol PageViewCompetitionInteractorInputProtocol: class {

    var presenter: PageViewCompetitionInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol PageViewCompetitionViewProtocol: class {

    var presenter: PageViewCompetitionPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
