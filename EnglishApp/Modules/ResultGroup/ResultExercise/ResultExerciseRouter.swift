//
//  ResultExerciseRouter.swift
//  EnglishApp
//
//  Created vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ResultExerciseRouter: ResultExerciseWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ResultExerciseViewController(nibName: nil, bundle: nil)
        let interactor = ResultExerciseInteractor()
        let router = ResultExerciseRouter()
        let presenter = ResultExercisePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(listAnswer: [QuestionResultEntity], index: Int) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ResultExerciseViewController(nibName: nil, bundle: nil)
        view.index = index
        let interactor = ResultExerciseInteractor()
        let router = ResultExerciseRouter()
        let presenter = ResultExercisePresenter(interface: view, interactor: interactor, router: router)
        presenter.listAnswer = listAnswer
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
