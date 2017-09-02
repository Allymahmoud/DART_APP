//
//  LoginServiceDelegate.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Firebase

protocol LoginServiceDelegate {
    
    func didLoginSuccessfully(loggedInUser: DartUser)
    func failedToLogin(message: String)
    func emailNotVerified(user: Firebase.User)
    
}
