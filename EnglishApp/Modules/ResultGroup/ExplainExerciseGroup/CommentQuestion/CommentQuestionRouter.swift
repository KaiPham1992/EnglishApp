//
//  CommentQuestionRouter.swift
//  EnglishApp
//
//  Created Steve on 8/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CommentQuestionRouter: CommentQuestionWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = CommentQuestionViewController(nibName: nil, bundle: nil)
        let interactor = CommentQuestionInteractor()
        let router = CommentQuestionRouter()
        let presenter = CommentQuestionPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(id_question: String) -> CommentQuestionViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = CommentQuestionViewController(nibName: nil, bundle: nil)
        view.idQuestion = id_question
        let interactor = CommentQuestionInteractor()
        let router = CommentQuestionRouter()
        let presenter = CommentQuestionPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}