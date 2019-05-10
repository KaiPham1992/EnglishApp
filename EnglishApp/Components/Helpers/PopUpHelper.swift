//
//  PopUpHelper.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import Foundation

class PopUpHelper {
    static let shared = PopUpHelper()
    
    func showYesNo(message: String, completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.showPopUp(message: message, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showNotification(message: String, completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: message, completion: completionYes)
    }
    
}
