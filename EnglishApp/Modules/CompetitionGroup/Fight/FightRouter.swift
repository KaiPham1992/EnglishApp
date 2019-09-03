//
//  FightRouter.swift
//  EnglishApp
//
//  Created Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FightRouter: FightWireframeProtocol {
   
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = FightViewController(nibName: nil, bundle: nil)
        let interactor = FightInteractor()
        let router = FightRouter()
        let presenter = FightPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(completion_id: Int, team_id: Int, startDate : Date ) -> FightViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = FightViewController(nibName: nil, bundle: nil)
        let interactor = FightInteractor()
        let router = FightRouter()
        let presenter = FightPresenter(interface: view, interactor: interactor, router: router)
        view.completion_id = completion_id
        view.team_id = team_id
        view.startDate = startDate
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func gotoDetailVocabulary(word: WordExplainEntity){
        let vc = DetailLessonRouter.createModule(word: word)
        self.viewController?.push(controller: vc,animated: true)
    }
    
    func gotoResult(result: TestResultProfileEntity, type: TypeDoExercise) {
        
    }
}
