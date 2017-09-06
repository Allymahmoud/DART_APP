//
//  RequestUserInfo.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Firebase

class RequestUserInfo{
    var ref: DatabaseReference!
    var requestUserInfoDelegate: RequestUserInfoDelegate?
    
    init() {
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        print("initialized")
    }
    
    func requestUserInfo(){
        if let user = Auth.auth().currentUser {
            self.ref.child("DARTusers").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                // Get user value
                let value = snapshot.value as? NSDictionary
                if value != nil {
                    let user = DartUser.init(dictionary: value as! [String : AnyObject])
                    self.requestUserInfoDelegate?.didRecieveUserInfo(user: user)
                    
                }
                else{
                    self.requestUserInfoDelegate?.failedToRecieveUserInfo(message: "Could not retrieve user information")
                }
                
            }) { (error) in
                self.requestUserInfoDelegate?.failedToRecieveUserInfo(message: error.localizedDescription)
                
            }
            
        }
    }
}
