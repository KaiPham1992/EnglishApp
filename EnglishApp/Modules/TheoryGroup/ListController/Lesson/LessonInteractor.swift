//
//  LessonInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LessonInteractor: LessonInteractorInputProtocol {

    weak var presenter: LessonInteractorOutputProtocol?
    
    func getLessonRecipe(type: Int, offset: Int) {
        Provider.shared.theoryAPIService.getLessonRecipe(type: type, offset: offset, success: { (respone) in
            if let _response = respone {
                self.presenter?.getLessonRecipeSuccessed(respone: _response)
            }
        }) { (error) in
        }
    }
}
