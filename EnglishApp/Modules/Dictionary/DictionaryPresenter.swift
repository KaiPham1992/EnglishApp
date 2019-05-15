//
//  DictionaryPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DictionaryPresenter: DictionaryPresenterProtocol, DictionaryInteractorOutputProtocol {

    weak private var view: DictionaryViewProtocol?
    var interactor: DictionaryInteractorInputProtocol?
    private let router: DictionaryWireframeProtocol

    init(interface: DictionaryViewProtocol, interactor: DictionaryInteractorInputProtocol?, router: DictionaryWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
