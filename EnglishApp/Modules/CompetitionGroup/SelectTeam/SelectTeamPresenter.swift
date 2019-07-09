//
//  SelectTeamPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SelectTeamPresenter: SelectTeamPresenterProtocol, SelectTeamInteractorOutputProtocol {
    func getListFightTestTeam(competitionId: Int) {
        ProgressView.shared.show()
        Provider.shared.competitionAPIService.getListFightTestTeam(competitionId: competitionId, success: { (listTeam) in
            ProgressView.shared.hide()
            guard let listTeam = listTeam else {return}
            self.view?.didGetListFightTestTeam(collectionTeam: listTeam)
        }) { (error) in
            ProgressView.shared.hide()
            guard let error = error else {return}
            self.view?.didGetListFightTestTeam(error: error)
        }
    }
    

    weak private var view: SelectTeamViewProtocol?
    var interactor: SelectTeamInteractorInputProtocol?
    private let router: SelectTeamWireframeProtocol

    init(interface: SelectTeamViewProtocol, interactor: SelectTeamInteractorInputProtocol?, router: SelectTeamWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
