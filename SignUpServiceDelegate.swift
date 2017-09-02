//
//  SignUpServiceDelegate.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

protocol SignUpServiceDelegate {
    
    func didSignUpSuccessfully()
    func failedToSignUp(message: String)
    func somethingWentWrong(message: String)
}
