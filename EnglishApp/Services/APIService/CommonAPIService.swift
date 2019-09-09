//
//  CommonAPIService.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

protocol CommonAPIServiceProtocol {
    func uploadImage(image: UIImage, success: @escaping SuccessHandler<PhotoEntity>.object, failure: @escaping RequestFailure)
    func getNationals( success: @escaping SuccessHandler<NationalEntity>.array, failure: @escaping RequestFailure)
    func changeLanguageCode(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    
}

class CommonAPIService: CommonAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func changeLanguageCode(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure){
        let endpoint = CommonEndPoint.changeLanguageCode
        network.requestData(endPoint: endpoint, success: success, failure: failure)
    }
    
    func uploadImage(image: UIImage, success: @escaping SuccessHandler<PhotoEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = CommonEndPoint.uploadImages(image: image)
        network.uploadImages(image: image, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getNationals(success: @escaping SuccessHandler<NationalEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = CommonEndPoint.getNationals
        
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
}
