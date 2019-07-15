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
    
    var teamDetail : DetailTeamEntity?

    init(interface: DetailTeamViewProtocol, interactor: DetailTeamInteractorInputProtocol?, router: DetailTeamWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getDetailTeam(id: String) {
        if teamDetail == nil {
            self.interactor?.getDetailTeam(id: id)
        } else {
            self.view?.reloadView()
        }
    }
    
    func getNumberRow() -> Int?{
        return self.teamDetail?.members?.count
    }
    
    func getUserIndexPath(indexPath: IndexPath) -> UserEntity?{
        return teamDetail?.members?[indexPath.row]
    }
    
    func getTeamInfo() -> TeamEntity? {
        return teamDetail?.team_info
    }
    
    func getDetailTeamSuccessed(respone: DetailTeamEntity) {
        self.teamDetail = respone
        self.view?.reloadView()
    }
    
    func leaveTeam(id: String) {
        self.interactor?.leaveTeam(id: id)
    }
    
    func leaveTeamSuccessed() {
        self.view?.leaveTeamSuccessed()
    }

}
