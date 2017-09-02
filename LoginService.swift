//
//  LoginService.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Firebase

class LoginService: AccessTokenServiceDelegate {
    var ref: DatabaseReference!
    var loginServiceDelegate: LoginServiceDelegate?
    var accessTokenService: AccessTokenService!
    var user: DartUser!
    
    init() {
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        print("initialized")
        accessTokenService = AccessTokenService()
        accessTokenService.accessTokenServiceDelegate = self
    }
    
    func login(loginRequest: LoginRequest) {
        // On success
        print("login| LoginService")
        
        Auth.auth().signIn(withEmail: loginRequest.email!, password: loginRequest.password!) { (user, error) in
            
            if error == nil {
                
                if let user = Auth.auth().currentUser {
                    if !user.isEmailVerified{
                        self.loginServiceDelegate?.emailNotVerified(user: user)
                        
                    } else {
                        
                        //Print into the console if successfully logged in
                        print ("Email verified. Signing in...")
                        
                        self.ref.child("DARTusers").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                            print("in 0")
                            
                            // Get user value
                            let value = snapshot.value as? NSDictionary
                            if value != nil {
                                print(value!)
                                
                                if self.getUserInfo(value: value!){
                                    self.accessTokenService.storeAccessToken(accessToken: user.uid)
                                    self.accessTokenService.isTokenValid()
                                    
                                }
      
                            }
                            else{
                                self.accessTokenIsInvalid(message: "no user information was found")
                            }
                            
                        }) { (error) in
                            self.accessTokenIsInvalid(message: error.localizedDescription)
                        }

                    }
                }
 
            } else {
                self.accessTokenIsInvalid(message: (error?.localizedDescription)!)
               
            }
        }
        
        
    }
    
    func accessTokenIsValid() {
        print("DART USER email:" + user.email!)
        loginServiceDelegate?.didLoginSuccessfully(loggedInUser: user) // TODO: Return a proper user instance...
    }
    
    func accessTokenIsInvalid(message: String) {
         self.loginServiceDelegate?.failedToLogin(message: message)
    }
    
    func getUserInfo(value: NSDictionary) -> Bool{
        self.user = DartUser.init(dictionary: value as! [String : AnyObject])
        return true
   
    }
    
    
  
    
    
}
