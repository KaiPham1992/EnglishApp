//
//  Utils.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
import Alamofire

class Utils {
    class func estimateHeight(_ width: CGFloat, customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: customFont], context: nil)
        return estimateFrame.height
    }

    class func estimateWidth(_ height: CGFloat, customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: 1000, height: height)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: customFont], context: nil)
        return estimateFrame.width
    }

    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension Utils {
//    class func getMinimumWidthHeight() -> CGFloat {
//        return CGFloat.minimum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
//    }
//
//    class func getMaximumWidthHeight() -> CGFloat {
//        return CGFloat.maximum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
//    }
//
    class func isIphoneXOrLater() -> Bool {
        if UIDevice.current.isIphone4Inch() || UIDevice.current.isIphone4_7Inch() || UIDevice.current.isIphone5_5Inch() {
            return false
        }

        return true
    }
//
//    class func checkIncreaseTabbar() -> Bool {
//        return !UIDevice.current.isIphone5_8Inch()
//    }
//
//    class func isLandscape() -> Bool {
//        return UIScreen.main.bounds.width > UIScreen.main.bounds.height
//    }
//
//    class func showAlert(title: String, message: String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        alert.show()
//    }
//
//    class func setColorStatusBar(color: UIColor) {
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
//        statusBar.backgroundColor = color
//        statusBar.tintColor = color
//    }
}

extension Utils {
    class func getTimeZone() -> String {
        return TimeZone.current.identifier
    }
}
