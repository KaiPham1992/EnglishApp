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
    var listSearchVocabulary : [WordEntity] = []
    var detailVocabulary : WordExplainEntity?
    var listDictionary: [SearchEntity] = []
    
    init(interface: DictionaryViewProtocol, interactor: DictionaryInteractorInputProtocol?, router: DictionaryWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func searchVocabulary(text: String) {
        self.listSearchVocabulary = RealmDBManager.share.filter(objectType: WordEntity.self, key: "word", value: text)
        self.view?.searchVocabularySuccessed()
    }
    
    func getDetailVocabulary(id: Int) {
        if let detail = RealmDBManager.share.filter(objectType: WordExplainEntity.self, key: "id", value: id).first {
            self.detailVocabulary = detail
            self.view?.getDetailVocabularySuccessed()
        }
    }
    func getListDictionary() {
        self.interactor?.getListDictionary()
    }
    
    func getListDictionarySuccessed(listDictionary: [SearchEntity]) {
        self.listDictionary = listDictionary
        self.view?.reloadDictionary()
    }
    
    func lookWordOnline(dictionary_id: Int, word: String) {
        self.interactor?.lookWordOnline(dictionary_id: dictionary_id, word: word)
    }
    
    func lookupWordOnlineSuccessed(response: WordExplainEntity) {
        self.detailVocabulary = response
        self.view?.getDetailVocabularySuccessed()
    }
}
