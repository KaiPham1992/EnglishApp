//
//  VocabularyPresenter.swift
//  EnglishApp
//
//  Created Steve on 7/28/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class VocabularyPresenter: VocabularyPresenterProtocol, VocabularyInteractorOutputProtocol {

    weak private var view: VocabularyViewProtocol?
    var interactor: VocabularyInteractorInputProtocol?
    private let router: VocabularyWireframeProtocol

    init(interface: VocabularyViewProtocol, interactor: VocabularyInteractorInputProtocol?, router: VocabularyWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getListLikeVocab(offset: Int) {
        self.interactor?.getListLikeVocab(offset: offset)
    }

    func getListLikeVocabSuccessed(response: WordLikeResponse) {
        self.view?.reloadView(listResponse: response.likes)
    }
}
