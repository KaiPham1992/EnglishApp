//
//  Strings.swift
//  Ipos
//
//  Created by edward on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

struct Strings {
    struct Stripe {
        static let card = "XXXX-XXXX-XXXX-XXXX"
        static let date = "MM/YY"
        static let confirm = "Confirm Pay"
    }
    
    struct Title {
        static let applicationPreview = "Application Preview"
        static let payment = "Payment"
        static let acknowledgement = "Acknowledgement"
        static let similarMarks = "Similar Marks"
        static let similarMarkSearch = "Similar Mark Search"
    }
}

struct Params {
    static let appId = "app_id"
    static let appName = "app_name"
    static let appVersion = "app_version"
    static let deviceId = "device_id"
    static let deviceName = "device_name"
    static let deviceVersion = "device_version"
    
    static let appleToken = "apple_token"
    static let firebaseToken = "firebase_token"
    static let phonecode = "phone_code"
    static let timezone = "timezone"
    
    static let lat = "lat"
    static let long = "long"
}
