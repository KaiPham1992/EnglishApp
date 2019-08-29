//
//  CompetitionPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CompetitionPresenter: CompetitionPresenterProtocol, CompetitionInteractorOutputProtocol {
    func getListFight(offset: Int) {
        ProgressView.shared.show()
        Provider.shared.competitionAPIService.getListFight(offset: offset,success: { (collectionCompetition) in
            ProgressView.shared.hide()
            guard let competition = collectionCompetition else{return}
            self.view?.didGetList(competitionList: competition)
        }) { (error) in
            ProgressView.shared.hide()
            guard let _error = error else {return}
            self.view?.didGetList(error: _error)
        }
    }
    
    func getListResultFight(offset: Int) {
        Provider.shared.competitionAPIService.getListResultFight(offset: offset,success: { (respone) in
            if let _respone = respone{
                self.view?.didGetResultFight(resultFight: _respone)
            }
        }) { (error) in
            if let _error = error {
                self.view?.didGetList(error: _error)
            }
        }
    }
    
    weak private var view: CompetitionViewProtocol?
    var interactor: CompetitionInteractorInputProtocol?
    private let router: CompetitionWireframeProtocol

    init(interface: CompetitionViewProtocol, interactor: CompetitionInteractorInputProtocol?, router: CompetitionWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
