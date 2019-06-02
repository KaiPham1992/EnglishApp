//
//  ChangeLanguageProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
enum KeyLanguage: String {
    case vn = "vn"
    case en = "en"
}

class LanguageEntity: BaseEntity {
    var isSelected: Bool?
    var name: String?
    var key =  KeyLanguage.vn
    
    
    convenience init(name: String, key: KeyLanguage) {
        self.init()
        self.name = name
        self.key = key
        self.isSelected = false
    }
    
    static func toArray() -> [LanguageEntity] {
        var listLanguage = [LanguageEntity]()
        listLanguage.append(LanguageEntity(name: "Vietnamese", key: KeyLanguage.vn))
        listLanguage.append(LanguageEntity(name: "English", key: KeyLanguage.en))
        
        return listLanguage
    }
}

//MARK: Wireframe -
protocol ChangeLanguageWireframeProtocol: class {

}
//MARK: Presenter -
protocol ChangeLanguagePresenterProtocol: class {

    var interactor: ChangeLanguageInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol ChangeLanguageInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol ChangeLanguageInteractorInputProtocol: class {

    var presenter: ChangeLanguageInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol ChangeLanguageViewProtocol: class {

    var presenter: ChangeLanguagePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
