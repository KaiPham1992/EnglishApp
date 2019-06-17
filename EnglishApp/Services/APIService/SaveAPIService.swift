//
//  SaveAPIService.swift
//  EnglishApp
//
//  Created by vinova on 6/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol SaveAPIServiceProtocol {
    func getListNote(success: @escaping SuccessHandler<NoteRespone>.array, failed: @escaping RequestFailure)
}

class SaveAPIService : SaveAPIServiceProtocol {
    
   
    let network : APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    func getListNote(success: @escaping SuccessHandler<NoteRespone>.array, failed: @escaping RequestFailure) {
        let endpoint = 
    }
}
