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
        Provider.shared.competitionAPIService.getListFight(offset: offset,success: { (collectionCompetition) in
            guard let competition = collectionCompetition else{return}
            let listCompetition = competition.competitionEntity?.filter{$0.is_fight_joined == 1 && ($0.status == "START" || $0.status == "CAN_JOIN" || $0.status == "DOING")} ?? []
            if listCompetition.count > 0 {
                for item in (competition.competitionEntity ?? []) {
                    if (item.is_fight_joined ?? 0) == 0 && item.status == "CAN_JOIN" {
                        item.isHidden = true
                    }
                }
            }
            self.view?.didGetList(competitionList: competition)
        }) { (_) in
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
