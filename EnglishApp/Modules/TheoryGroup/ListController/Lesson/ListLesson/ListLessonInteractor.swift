//
//  ListLessonInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListLessonInteractor: ListLessonInteractorInputProtocol {
    
    weak var presenter: ListLessonInteractorOutputProtocol?
    
    func getListLesson(lesson_category_id: String,offset: Int) {
        ProgressView.shared.show()
        Provider.shared.theoryAPIService.getListLesson(lesson_category_id: Int(lesson_category_id) ?? 0, offset: offset, success: { (listLesson) in
            ProgressView.shared.hide()
            self.presenter?.getListLessonSuccessed(listLesson: listLesson)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getTaskEveryDate(date: String,offset: Int) {
        ProgressView.shared.show()
        Provider.shared.exerciseAPIService.getTestResult(date: date, offset: offset, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getListLessonSuccessed(listLesson: _respone.self_created_test?.compactMap{LessonCatelogy(selfCreatedTestEntity: $0)} ?? [])
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
