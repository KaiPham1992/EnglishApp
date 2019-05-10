//
//  UserAPIService.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/10/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import UIKit

protocol UserAPIServiceProtocol {
    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func forgotPassword(email: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func checkLogin(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func getCaptcha(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func logout(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    
    func loginGmail(param: LoginSocialParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func loginFacebook(fbEntity: FacebookEntity, phone: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func changePassword(current: String, new: String, success: @escaping SuccessHandler<BaseResponseString>.object, failure: @escaping RequestFailure)
    
    func verifyPhone(code: String, phone: String, phonCode: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func signUp(param: SignUpParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func updateProfile(param: UpdateProfileParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func updateProfileSocial(param: UpdateProfileSocial, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func uploadAvatar(image: UIImage, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
}


class UserAPIService: UserAPIServiceProtocol {
   
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.login(email: email, password: password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func forgotPassword(email: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = UserEndPoint.fogotPassword(email: email)
        network.requestData(endPoint: endpoint, success: MapperData.mapNoData(success), failure: failure)
    }
    func checkLogin(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.checkLogin
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCaptcha(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getCaptcha
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    func logout(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.logout
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    func loginGmail(param: LoginSocialParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.loginGmail(loginSocialParam: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loginFacebook(fbEntity: FacebookEntity, phone: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.loginFacebook(fbEntity: fbEntity, phone: phone)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func signUp(param: SignUpParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.signUp(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changePassword(current: String, new: String, success: @escaping SuccessHandler<BaseResponseString>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.changePassword(current: current, new: new)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    func updateProfile(param: UpdateProfileParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.updateProfile(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func verifyPhone(code: String, phone: String, phonCode: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.verifyPhone(code: code, phone: phone, phoneCode: phonCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateProfileSocial(param: UpdateProfileSocial, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.updateProfileSocial(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func uploadAvatar(image: UIImage, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.uploadAvatar
        network.uploadAvatar(image: image, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    func getProfileUser(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getProfileUser
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
}


