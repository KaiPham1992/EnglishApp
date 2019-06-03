//
//  ListLessonPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListLessonPresenter: ListLessonPresenterProtocol, ListLessonInteractorOutputProtocol {

    weak private var view: ListLessonViewProtocol?
    var interactor: ListLessonInteractorInputProtocol?
    private let router: ListLessonWireframeProtocol
    
    var listLesson : [String] = [LocalizableKey.simple_present.showLanguage,LocalizableKey.present_perfect.showLanguage,LocalizableKey.present_countinous.showLanguage,LocalizableKey.past_simple.showLanguage]

    init(interface: ListLessonViewProtocol, interactor: ListLessonInteractorInputProtocol?, router: ListLessonWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    
    func numberLesson() -> Int {
        return listLesson.count
    }
    func getLessonIndexPath(indexPath: IndexPath) -> String{
        return listLesson[indexPath.row]
    }

}
