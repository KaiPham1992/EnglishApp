//
//  ResultProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ResultWireframeProtocol: class {
    func gotoResultQuestion(listAswer: [QuestionResultEntity], index: Int,isHistory: Bool)
}
//MARK: Presenter -
protocol ResultPresenterProtocol: class {

    var interactor: ResultInteractorInputProtocol? { get set }
    var testResultProfile: TestResultProfileEntity? {get set}
    func gotoResultQuestion(listAswer: [QuestionResultEntity], index: Int,isHistory: Bool)
    func getViewResult(id: String)
    func getImageProfile() -> String?
    func getAmountDiamond() -> String?
    func getAmoutRank() -> String?
    func getTotalTime() -> String
    func getTotalPoint() -> String
    func getPointQuestion(indexPath: IndexPath) -> Int?
    func getNumberQuestion() -> Int?
    func getListAnswer() -> [QuestionResultEntity]?
    func getViewResultUserCompetition(idCompetition: String)
}

//MARK: Interactor -
protocol ResultInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func getViewTestResultSuccessed(respone: TestResultProfileEntity)
}

protocol ResultInteractorInputProtocol: class {

    var presenter: ResultInteractorOutputProtocol?  { get set }
    func getViewResult(id: String)
    func getViewResultUserCompetition(idCompetition: String)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol ResultViewProtocol: class {

    var presenter: ResultPresenterProtocol?  { get set }
    func reloadView()

    /* Presenter -> ViewController */
}
