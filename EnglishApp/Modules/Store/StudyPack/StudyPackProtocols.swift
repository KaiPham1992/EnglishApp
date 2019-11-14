//
//  StudyPackProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol StudyPackWireframeProtocol: class {

}
//MARK: Presenter -
protocol StudyPackPresenterProtocol: class {

    var interactor: StudyPackInteractorInputProtocol? { get set }
    func getProduct()
    func exchangeGift(id: String, type: String)
    func sendRedeem(code: String)
    func getPackage()
    var canLoadMore: Bool { get set }
    var lisPackage: [Inventories] { get set }
}

//MARK: Interactor -
protocol StudyPackInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol StudyPackInteractorInputProtocol: class {

    var presenter: StudyPackInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol StudyPackViewProtocol: class {

    var presenter: StudyPackPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetProduct(product: ProductCollectionEntity)
    func didExchangeGift()
    func didGetError(error: APIError)
    func didGetPackage(package: [Inventories])
    func didSendRedeem()
    func didSendRedeem(error: APIError)
}
