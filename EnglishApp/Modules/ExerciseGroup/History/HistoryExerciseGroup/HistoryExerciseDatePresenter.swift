//
//  HistoryExerciseDatePresenter.swift
//  EnglishApp
//
//  Created vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryExerciseDatePresenter: HistoryExerciseDatePresenterProtocol, HistoryExerciseDateInteractorOutputProtocol {

    weak private var view: HistoryExerciseDateViewProtocol?
    var interactor: HistoryExerciseDateInteractorInputProtocol?
    private let router: HistoryExerciseDateWireframeProtocol

    init(interface: HistoryExerciseDateViewProtocol, interactor: HistoryExerciseDateInteractorInputProtocol?, router: HistoryExerciseDateWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}