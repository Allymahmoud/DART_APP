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
        static let BaseUrl = "https://dartapp-8afdf.firebaseio.com/"
        static let ClientUrl = "https://dartapp-8afdf.firebaseio.com/users.json"
        static let ChannelsUrl = "https://okomaz-ios.firebaseio.com/channels.json"
        static let DustbinCodeUrl = "https://okomaz-ios.firebaseio.com/dustbincode.json"
        static let LinersCodeUrl = "https://okomaz-ios.firebaseio.com/linerscode.json"
        
    }
    
    struct HttpHeaderKeys {
        static let Authorization = "Authorization"
    }
    
    struct DefaultKeys {
        static let AccessToken = "AccessToken"
    }
    
}
