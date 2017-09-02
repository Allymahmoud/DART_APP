//
//  LoginRequest.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

struct LoginRequest {
    
    let email: String?
    let password: String?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
