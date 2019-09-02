//
//  UIApplication+Extension.swift
//  EnglishApp
//
//  Created by Steve on 9/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
