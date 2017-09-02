//
//  AccessTokenServiceDelegate .swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

protocol AccessTokenServiceDelegate {
    func accessTokenIsValid()
    func accessTokenIsInvalid(message: String)
    
}
