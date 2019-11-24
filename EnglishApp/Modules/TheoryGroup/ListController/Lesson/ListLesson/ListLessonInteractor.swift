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
        Provider.shared.theoryAPIService.getListLesson(lesson_category_id: Int(lesson_category_id) ?? 0, offset: offset, success: { (listLesson) in
            if let _response = listLesson {
                self.presenter?.getListLessonSuccessed(listLesson: _response)
            }
        }) { (error) in
        }
    }
}
