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
//    var listDictionary: [ItemDictionaryResponse] {get set}
    var listSearchVocabulary : [WordEntity] {get set}
    var detailVocabulary : WordExplainEntity? {get set}
    func searchVocabulary(text: String)
    func getDetailVocabulary(id: Int)
//    func getListDictionary()
    func lookWordOnline(dictionary_id: Int,word: String)
    func getDetailWord(text: String)
}

//MARK: Interactor -
protocol DictionaryInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
//    func getListDictionarySuccessed(listDictionary: [ItemDictionaryResponse])
    func lookupWordOnlineSuccessed(response: WordExplainEntity)
    func lookupWordOnlineFailed()
}

protocol DictionaryInteractorInputProtocol: class {

    var presenter: DictionaryInteractorOutputProtocol?  { get set }
//    func getListDictionary()
    func lookWordOnline(dictionary_id: Int,word: String)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol DictionaryViewProtocol: class {

    var presenter: DictionaryPresenterProtocol?  { get set }
    func searchVocabularySuccessed()
    func getDetailVocabularySuccessed()
//    func reloadDictionary()
    /* Presenter -> ViewController */
}
