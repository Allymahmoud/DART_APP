//
//  AccessTokenService.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

class AccessTokenService {
    var accessTokenServiceDelegate: AccessTokenServiceDelegate?
    
    func isTokenValid() {
        if let _ = self.retrieveAccessToken(){
            accessTokenServiceDelegate?.accessTokenIsValid()
        }else{
            accessTokenServiceDelegate?.accessTokenIsInvalid(message: "Invalid AccessToken")
        }
    }
    
    /// Stores the Access Token in User Defaults
    ///
    /// - parameter accessToken: The Access Token String
    func storeAccessToken(accessToken: String?) {
        let defaults = UserDefaults.standard
        defaults.set(accessToken, forKey: Constants.DefaultKeys.AccessToken)
        defaults.synchronize()
    }
    
    /// Returns the stored Access Token as an Optional
    ///
    /// - returns: The Access Token Optional
    func retrieveAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: Constants.DefaultKeys.AccessToken)
    }
    
    /// Delete the stored Access Token
    ///
    /// - parameter: none
    /// - returns: none
    func deleteAccessToken(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.DefaultKeys.AccessToken)
    }
    
    
}
