//
//  LogoutServiceDelegate.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

protocol LogoutServiceDelegate {
    
    func didLogoutSuccessfully()
    func failedToLogout(message: String)
    
    
}
