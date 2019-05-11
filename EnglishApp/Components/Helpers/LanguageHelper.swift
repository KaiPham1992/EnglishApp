//
//  File.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//


import Foundation


let APPLE_LANGUAGE_KEY = "AppleLanguages"

enum LanguageType: String {
    case vietname = "vi"
    case english = "en"
}

class LanguageHelper {
    
    //get current apple language
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        
        return currentWithoutLocale
    }
    
    class func changeLanguage() {
        if LanguageHelper.currentAppleLanguage() == "en" {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.vietname)
        } else {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.english)
        }
    }
    
    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    // set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: LanguageType) {
        let userdef = UserDefaults.standard
        userdef.set([lang.rawValue,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
        
        Bundle.setLanguage(lang.rawValue)
    }
    
    class func getCurrentBundle() -> Bundle {
        let currentLanguage = LanguageHelper.currentAppleLanguage()
        if let _path = Bundle.main.path(forResource: LanguageHelper.currentAppleLanguageFull(), ofType: "lproj") {
            return Bundle(path: _path)!
        } else
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                return Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                return  Bundle(path: _path)!
        }
    }
}
