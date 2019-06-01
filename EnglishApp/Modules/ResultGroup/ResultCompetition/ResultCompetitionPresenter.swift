//
//  ResultCompetitionPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ResultCompetitionPresenter: ResultCompetitionPresenterProtocol, ResultCompetitionInteractorOutputProtocol {

    weak private var view: ResultCompetitionViewProtocol?
    var interactor: ResultCompetitionInteractorInputProtocol?
    private let router: ResultCompetitionWireframeProtocol

    init(interface: ResultCompetitionViewProtocol, interactor: ResultCompetitionInteractorInputProtocol?, router: ResultCompetitionWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}