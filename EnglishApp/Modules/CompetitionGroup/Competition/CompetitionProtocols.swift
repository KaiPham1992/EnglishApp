//
//  CompetitionProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol CompetitionWireframeProtocol: class {

}
//MARK: Presenter -
protocol CompetitionPresenterProtocol: class {

    var interactor: CompetitionInteractorInputProtocol? { get set }
    func getListFight(offset: Int)
    func getListResultFight(offset: Int, date: String)
    
}

//MARK: Interactor -
protocol CompetitionInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol CompetitionInteractorInputProtocol: class {

    var presenter: CompetitionInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol CompetitionViewProtocol: class {

    var presenter: CompetitionPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetList(competitionList: CollectionCompetitionEntity)
    func didGetResultFight(resultFight: CompetitionProfileEntity)
    func didGetList(error: Error)
}
