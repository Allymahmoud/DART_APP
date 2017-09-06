//
//  LogoutService.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Firebase

class LogoutService{
    var ref: DatabaseReference
    var logoutServiceDelegate: LogoutServiceDelegate?
    
    init() {
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        print("initialized")
    }
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.logoutServiceDelegate?.didLogoutSuccessfully()
        } catch let signOutError as NSError {
            self.logoutServiceDelegate?.failedToLogout(message: signOutError.localizedDescription)
        }
        
    }
    
}
