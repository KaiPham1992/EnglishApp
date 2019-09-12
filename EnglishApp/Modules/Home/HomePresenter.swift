//
//  HomePresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {

    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    private let router: HomeWireframeProtocol
    var canLoadMore: Bool = false
    var listRecently: [Acitvity] = []
    
    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getHomeRecently() {
        canLoadMore = false
        if listRecently.count == 0 {
            ProgressView.shared.show()
        }
        
        Provider.shared.userAPIService.getHomeRecently(offset: listRecently.count, limit: 10, success: { active in
            ProgressView.shared.hide()
            guard let acti = active?.activities else { return }
            self.listRecently.append(contentsOf: acti)
            if acti.count == 10 {
                self.canLoadMore = true
            }
            self.view?.didGetActivities(activities: acti)
        }) { _ in
            ProgressView.shared.hide()
        }
    }
    
    func getTopThree() {
        Provider.shared.homeAPIService.getTopThree(success: { (collectionUserEntity) in
            UIApplication.shared.applicationIconBadgeNumber = collectionUserEntity?.count_notify ?? 0
            guard let userInfo = collectionUserEntity else { return }
            self.view?.didGetTopThree(collectionUserEntity: userInfo)
            guard let listTopThree = collectionUserEntity?.leader_boards else {return}
            self.view?.didGetTopThree(listTopThree: listTopThree)

        }) { (error) in
            guard let error = error else {return}
            self.view?.didGetTopThree(error: error)
        }
    }
    
    func getProfile() {
        interactor?.getProfile()
    }
    
    func didGetProfile(user: UserEntity) {
        view?.didGetProfile(user: user)
    }
}
