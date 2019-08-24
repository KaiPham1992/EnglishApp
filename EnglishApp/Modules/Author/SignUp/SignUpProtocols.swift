//
//  SignUpProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

//MARK: Wireframe -
protocol SignUpWireframeProtocol: class {

}
//MARK: Presenter -
protocol SignUpPresenterProtocol: class {

    var interactor: SignUpInteractorInputProtocol? { get set }
    func getCaptcha()
    func signUp(param: SignUpParam)
}

//MARK: Interactor -
protocol SignUpInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func successCaptcha(image: UIImage)
    func signUpSuccess(user: UserEntity?)
    func signUpError(error: APIError)
    
}

protocol SignUpInteractorInputProtocol: class {

    var presenter: SignUpInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getCaptcha()
    func signUp(param: SignUpParam)
    func updateAvatar(image: UIImage)
}

//MARK: View -
protocol SignUpViewProtocol: class {

    var presenter: SignUpPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func successCaptcha(image: UIImage)
    func signUpSuccess(user: UserEntity?)
    func signUpError(error: APIError)
}
