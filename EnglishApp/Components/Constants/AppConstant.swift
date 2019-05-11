//
//  AppConstant.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/10/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

struct AppConstant {
    #if APPSTORE
    static let appAdmobId = "ca-app-pub-9353872959466378~7688554039"
    static let admobBanner = "ca-app-pub-9353872959466378/2624132214"
    
    #else
    static let appAdmobId = "ca-app-pub-8064036299806325~8781055145"
    static let admobNativeAds = "ca-app-pub-3940256099942544/3986624511"
    static let admobBanner = "ca-app-pub-3940256099942544/2934735716"
    #endif
}
