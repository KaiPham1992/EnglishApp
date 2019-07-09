//
//  ResultRouter.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

enum TypeResult: String {
    case result
    case resultCompetion
    case resultExercise
}

class ResultRouter: ResultWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ResultViewController.initFromNib()
        let interactor = ResultInteractor()
        let router = ResultRouter()
        let presenter = ResultPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(type: TypeResult = .result,result: TestResultProfileEntity) -> ResultViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ResultViewController(nibName: nil, bundle: nil)
        view.type = type
        let interactor = ResultInteractor()
        let router = ResultRouter()
        let presenter = ResultPresenter(interface: view, interactor: interactor, router: router)
        presenter.testResultProfile = result
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    static func createModule(type: TypeResult = .result,id: String) -> ResultViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ResultViewController(nibName: nil, bundle: nil)
        view.type = type
        view.id = id
        let interactor = ResultInteractor()
        let router = ResultRouter()
        let presenter = ResultPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func gotoResultQuestion(listAswer: [QuestionResultEntity], index: Int){
        let vc = ResultExerciseRouter.createModule(listAnswer: listAswer, index: index)
        self.viewController?.push(controller: vc,animated: true)
    }
}
