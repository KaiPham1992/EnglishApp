//
//  SeeNotePresenter.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SeeNotePresenter: SeeNotePresenterProtocol, SeeNoteInteractorOutputProtocol {

    weak private var view: SeeNoteViewProtocol?
    var interactor: SeeNoteInteractorInputProtocol?
    private let router: SeeNoteWireframeProtocol

    init(interface: SeeNoteViewProtocol, interactor: SeeNoteInteractorInputProtocol?, router: SeeNoteWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}