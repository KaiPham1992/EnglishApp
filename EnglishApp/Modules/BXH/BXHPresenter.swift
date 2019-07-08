//
//  BXHPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BXHPresenter: BXHPresenterProtocol, BXHInteractorOutputProtocol {

    weak private var view: BXHViewProtocol?
    var interactor: BXHInteractorInputProtocol?
    private let router: BXHWireframeProtocol

    init(interface: BXHViewProtocol, interactor: BXHInteractorInputProtocol?, router: BXHWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getListLeaderBoard(quarter: Int, year: Int) {
        ProgressView.shared.show()
        Provider.shared.homeAPIService.getListLeaderBoard(quarter: quarter, year: year, success: { (listLeaderBoard) in
            ProgressView.shared.hide()
            guard let listLeaderBoard = listLeaderBoard else {return}
            self.view?.didGetList(listLeaderBoard: listLeaderBoard)
            
        }) { (error) in
            ProgressView.shared.hide()
            guard let error = error else {return}
            self.view?.didGetList(error: error)
        }
    }
}
