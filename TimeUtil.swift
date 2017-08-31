//
//  TimeUtil.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

struct TimeUtil {
    
    static func timeStamp() -> String{
        let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium) as String
        
        return currentTime
    }
}
