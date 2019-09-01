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
        Provider.shared.findAPIService.getListDictionary(success: { (response) in
            if let _response = response {
                let result = _response.dictionaries ?? []
                let id_user = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0") ?? 0
                let object = RealmDBManager.share.filter(objectType: LocalConfigDictionary.self, key: "id_user", value: id_user)
                if object.count > 0 {
                    let listId = object.map{$0.id_dictionary}
                    var idDefault = 0
                    if let objectDefault = object.filter({$0.isDefault == 1}).first {
                        idDefault = objectDefault.id_dictionary
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
                if LiveData.listDownloading.count > 0 {
                    for item in result {
                        if LiveData.listDownloading.contains(item.id) {
                            item.isDownloading = true
                        }
                    }
                }
                self.presenter?.getListDictionarySuccessed(listDictionary: result)
            }
        }) { (error) in
        }
    }
}
