//
//  DetailTeamPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailTeamPresenter: DetailTeamPresenterProtocol, DetailTeamInteractorOutputProtocol {

    weak private var view: DetailTeamViewProtocol?
    var interactor: DetailTeamInteractorInputProtocol?
    private let router: DetailTeamWireframeProtocol

    init(interface: DetailTeamViewProtocol, interactor: DetailTeamInteractorInputProtocol?, router: DetailTeamWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
