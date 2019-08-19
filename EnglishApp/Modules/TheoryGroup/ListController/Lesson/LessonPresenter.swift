//
//  LessonPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LessonPresenter: LessonPresenterProtocol, LessonInteractorOutputProtocol {

    weak private var view: LessonViewProtocol?
    var interactor: LessonInteractorInputProtocol?
    private let router: LessonWireframeProtocol
    var isLoadMore = true
    var lessonEntity: LessonCategoryEntity?

    init(interface: LessonViewProtocol, interactor: LessonInteractorInputProtocol?, router: LessonWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getLessonRecipe(type: Int, offset: Int) {
        if isLoadMore {
            self.interactor?.getLessonRecipe(type: type, offset: offset)
        }
    }
    
    func getLessonRecipeSuccessed(respone: LessonCategoryEntity) {
        if respone.categories.count < limit {
            isLoadMore = false
        }
        if self.lessonEntity == nil {
            self.lessonEntity = respone
        } else {
            self.lessonEntity?.categories += respone.categories
        }
        self.view?.reloadView()
    }
    func gotoListLesson(id: String,type: TheoryType){
        self.router.gotoListLesson(id: id,type: type)
    }
    
}
