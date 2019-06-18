//
//  GrammarRouter.swift
//  EnglishApp
//
//  Created vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class GrammarRouter: GrammarWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = GrammarViewController(nibName: nil, bundle: nil)
        let interactor = GrammarInteractor()
        let router = GrammarRouter()
        let presenter = GrammarPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(type: TypeSave = .grammar) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = GrammarViewController(nibName: nil, bundle: nil)
        view.type = type
        let interactor = GrammarInteractor()
        let router = GrammarRouter()
        let presenter = GrammarPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func gotoNote(){
        let vc = SeeNoteRouter.createModule()
        self.viewController?.push(controller: vc,animated: true)
    }
    
    func gotoAddNote(){
        let vc = AddNoteRouter.createModule()
        self.viewController?.push(controller: vc,animated: true)
    }
    
    func gotoDetailVocabulary(){
        let vc = DetailLessonRouter.createModule()
        self.viewController?.push(controller: vc,animated: true)
    }
    
    func gotoDetailGrammar(){
        let vc = DetailLessonRouter.createModule()
        self.viewController?.push(controller: vc,animated: true)
    }
}
