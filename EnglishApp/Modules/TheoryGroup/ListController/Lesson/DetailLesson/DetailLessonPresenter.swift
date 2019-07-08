//
//  DetailLessonPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailLessonPresenter: DetailLessonPresenterProtocol, DetailLessonInteractorOutputProtocol {
   
    weak private var view: DetailLessonViewProtocol?
    var interactor: DetailLessonInteractorInputProtocol?
    private let router: DetailLessonWireframeProtocol
    var lessonDetail: LessonCatelogyDetail?

    init(interface: DetailLessonViewProtocol, interactor: DetailLessonInteractorInputProtocol?, router: DetailLessonWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getLessonDetail(lesson_id: Int) {
        self.interactor?.getLessonDetail(lesson_id: lesson_id)
    }
    
    func getContentLesson() -> NSAttributedString? {
        if let content = self.lessonDetail?.content {
            return content.htmlToAttributedString
        }
        return nil
    }
    
    func getLessonDetailSuccessed(lessonDetail: LessonCatelogyDetail) {
        self.lessonDetail = lessonDetail
        self.view?.reloadView()
    }
    
    func getTitle() -> String?{
        return self.lessonDetail?.name
    }
    
    func getNumberComment() -> Int? {
        return lessonDetail?.unread_comments
    }
    
    func likeLesson(idLesson: Int, isFavorite: Int) {
        self.interactor?.likeLesson(idLesson: idLesson, isFavorite: isFavorite)
    }
    
    func getToggleLike() -> Int?{
        return lessonDetail?.is_favorite
    }

}
