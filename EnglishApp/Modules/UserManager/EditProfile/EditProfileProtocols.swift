//
//  EditProfileProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

//MARK: Wireframe -
protocol EditProfileWireframeProtocol: class {

}
//MARK: Presenter -
protocol EditProfilePresenterProtocol: class {

    var interactor: EditProfileInteractorInputProtocol? { get set }
    func updateProfile(userInfo: UpdateProfileParam)
    func updateAvatar(image: UIImage)
}

//MARK: Interactor -
protocol EditProfileInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didSuccessUpdateProfile(user: UserEntity?)
    func didErrorUpdateProfile(error: APIError?)
}

protocol EditProfileInteractorInputProtocol: class {

    var presenter: EditProfileInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func updateProfile(userInfo: UpdateProfileParam)
    func updateAvatar(image: UIImage)
}

//MARK: View -
protocol EditProfileViewProtocol: class {

    var presenter: EditProfilePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didSuccessUpdateProfile(user: UserEntity?)
    func didErrorUpdateProfile(error: APIError?)
}
