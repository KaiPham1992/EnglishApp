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

    weak private var view: SelectTeamViewProtocol?
    var interactor: SelectTeamInteractorInputProtocol?
    private let router: SelectTeamWireframeProtocol

    init(interface: SelectTeamViewProtocol, interactor: SelectTeamInteractorInputProtocol?, router: SelectTeamWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
