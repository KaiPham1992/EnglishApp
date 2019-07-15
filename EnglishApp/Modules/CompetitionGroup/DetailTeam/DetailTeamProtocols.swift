//
//  DetailTeamProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol DetailTeamWireframeProtocol: class {

}
//MARK: Presenter -
protocol DetailTeamPresenterProtocol: class {

    var interactor: DetailTeamInteractorInputProtocol? { get set }
    func getDetailTeam(id: String)
    func getNumberRow() -> Int?
    func getUserIndexPath(indexPath: IndexPath) -> UserEntity?
    func getTeamInfo() -> TeamEntity?
    func leaveTeam(id: String)
}

//MARK: Interactor -
protocol DetailTeamInteractorOutputProtocol: class {

    func getDetailTeamSuccessed(respone: DetailTeamEntity)
    func leaveTeamSuccessed()
    /* Interactor -> Presenter */
}

protocol DetailTeamInteractorInputProtocol: class {

    var presenter: DetailTeamInteractorOutputProtocol?  { get set }
    func getDetailTeam(id: String)
    func leaveTeam(id: String)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol DetailTeamViewProtocol: class {

    var presenter: DetailTeamPresenterProtocol?  { get set }
    func reloadView()
    func leaveTeamSuccessed()

    /* Presenter -> ViewController */
}
