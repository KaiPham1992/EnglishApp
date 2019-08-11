//
//  DetailLessonInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailLessonInteractor: DetailLessonInteractorInputProtocol {
    
    weak var presenter: DetailLessonInteractorOutputProtocol?
    
    func getLessonDetail(lesson_id: Int) {
        ProgressView.shared.show()
        Provider.shared.theoryAPIService.getLessonDetail(lesson_id: lesson_id, success: { (lessonDetail) in
            ProgressView.shared.hide()
            if let _lessonDetail = lessonDetail {
                self.presenter?.getLessonDetailSuccessed(lessonDetail: _lessonDetail)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func likeLesson(idLesson:Int,idWord: Int?, isFavorite: Int){
        Provider.shared.theoryAPIService.likeLesson(idLesson: idLesson, idWord: idWord,isFavorite: isFavorite, success: { (repsone) in
            
        }) { (error) in
            
        }
    }
}
