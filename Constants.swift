//
//  Constants.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        static let BaseUrl = "https://okomaz-ios.firebaseio.com/"
        static let ClientUrl = "https://okomaz-ios.firebaseio.com/clients.json"
        static let ChannelsUrl = "https://okomaz-ios.firebaseio.com/channels.json"
        static let DustbinCodeUrl = "https://okomaz-ios.firebaseio.com/dustbincode.json"
        static let LinersCodeUrl = "https://okomaz-ios.firebaseio.com/linerscode.json"
        
        static let SinchApplicationKey = "db76e2e7-6d9f-4da4-91bb-2000ee8bdc81"
    }
    
    struct HttpHeaderKeys {
        static let Authorization = "Authorization"
    }
    
    struct DefaultKeys {
        static let AccessToken = "AccessToken"
    }
    
}
