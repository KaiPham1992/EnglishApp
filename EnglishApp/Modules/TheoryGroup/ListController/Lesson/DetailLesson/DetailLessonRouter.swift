//
//  DetailLessonRouter.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailLessonRouter: DetailLessonWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailLessonViewController(nibName: nil, bundle: nil)
        let interactor = DetailLessonInteractor()
        let router = DetailLessonRouter()
        let presenter = DetailLessonPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(lesson: ItemLesson?, type: DetailLessonVocabulary = .detailLesson) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailLessonViewController(nibName: nil, bundle: nil)
        view.lesson = lesson
        view.type = type
        let interactor = DetailLessonInteractor()
        let router = DetailLessonRouter()
        let presenter = DetailLessonPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    static func createModule(word: WordExplainEntity, type: DetailLessonVocabulary = .vocabulary) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailLessonViewController(nibName: nil, bundle: nil)
        view.vocabulary = word
        view.type = type
        let interactor = DetailLessonInteractor()
        let router = DetailLessonRouter()
        let presenter = DetailLessonPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    static func createModule(idLesson: String , type: DetailLessonVocabulary = .detailLesson) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailLessonViewController(nibName: nil, bundle: nil)
        view.idLesson = idLesson
        view.type = type
        let interactor = DetailLessonInteractor()
        let router = DetailLessonRouter()
        let presenter = DetailLessonPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
