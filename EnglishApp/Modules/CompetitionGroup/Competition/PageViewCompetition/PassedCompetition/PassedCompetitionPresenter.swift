//
//  PassedCompetitionPresenter.swift
//  EnglishApp
//
//  Created Steve on 12/10/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PassedCompetitionPresenter: PassedCompetitionPresenterProtocol, PassedCompetitionInteractorOutputProtocol {

    weak private var view: PassedCompetitionViewProtocol?
    var interactor: PassedCompetitionInteractorInputProtocol?
    private let router: PassedCompetitionWireframeProtocol

    init(interface: PassedCompetitionViewProtocol, interactor: PassedCompetitionInteractorInputProtocol?, router: PassedCompetitionWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getListFight(offset: Int) {
        Provider.shared.competitionAPIService.getListFightDone(offset: offset,success: { (collectionCompetition) in
            guard let competition = collectionCompetition else{return}
            self.view?.didGetList(competitionList: competition)
        }) { (_) in
        }
    }
}
