//
//  DictionaryProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol DictionaryWireframeProtocol: class {

}
//MARK: Presenter -
protocol DictionaryPresenterProtocol: class {

    var interactor: DictionaryInteractorInputProtocol? { get set }
    var listDictionary: [SearchEntity] {get set}
    var listSearchVocabulary : [WordEntity] {get set}
    var detailVocabulary : WordExplainEntity? {get set}
    func searchVocabulary(text: String)
    func getDetailVocabulary(id: Int)
    func getListDictionary()
}

//MARK: Interactor -
protocol DictionaryInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func getListDictionarySuccessed(listDictionary: [SearchEntity])
}

protocol DictionaryInteractorInputProtocol: class {

    var presenter: DictionaryInteractorOutputProtocol?  { get set }
    func getListDictionary()

    /* Presenter -> Interactor */
}

//MARK: View -
protocol DictionaryViewProtocol: class {

    var presenter: DictionaryPresenterProtocol?  { get set }
    func searchVocabularySuccessed()
    func getDetailVocabularySuccessed()
    func reloadDictionary()
    /* Presenter -> ViewController */
}
