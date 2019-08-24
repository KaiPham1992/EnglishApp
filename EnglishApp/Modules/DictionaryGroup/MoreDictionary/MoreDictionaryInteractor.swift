//
//  MoreDictionaryInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MoreDictionaryInteractor: MoreDictionaryInteractorInputProtocol {

    weak var presenter: MoreDictionaryInteractorOutputProtocol?
    
    func getListDictionary() {
        ProgressView.shared.show()
        Provider.shared.findAPIService.getListDictionary(success: { (response) in
            if let _response = response {
                let result = _response.dictionaries ?? []
                let id_user = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0") ?? 0
                let object = RealmDBManager.share.filter(objectType: LocalConfigDictionary.self, key: "id_user", value: id_user)
                if object.count > 0 {
                    let listId = object.map{$0.id}
                    var idDefault = 0
                    if let objectDefault = object.filter({$0.isDefault == 1}).first {
                        idDefault = objectDefault.id
                    }
                    if listId.count > 0 {
                        for (index,item) in result.enumerated() {
                            if listId.contains(item.id) {
                                result[index].isDownload = true
                            }
                            if item.id == idDefault {
                                result[index].isDefault = true
                            }
                        }
                    }
                }
                self.presenter?.getListDictionarySuccessed(listDictionary: result)
            }
            ProgressView.shared.hide()
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
