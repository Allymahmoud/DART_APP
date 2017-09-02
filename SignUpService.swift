//
//  SignUpService.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import Firebase

class SignUpService{
    var ref: DatabaseReference!
    var SignUpServiceDelegate: SignUpServiceDelegate?
    
    init() {
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        print("initialized")
    }
    
    func signUp(newUser: DartUser){
    
        //send a verifictaion email
        Auth.auth().createUser(withEmail: newUser.email!, password: newUser.password!)
        { (user, error) in
            if error == nil {
                print("You have successfully signed up")
                
                //change the display name
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = newUser.name!
                
                changeRequest?.commitChanges { (error) in
                    if error != nil {
                        print("ERROR_CHANGE_REQUEST__SIGNUPVIEWCONTROLLER" + (error?.localizedDescription)!)
                        
                        self.SignUpServiceDelegate?.somethingWentWrong(message: (error?.localizedDescription)!)
                    }
                }
                
                
                
                //upload the client info to the database
                self.uploadUserInfoToDatabase(user: newUser)
                
                //send a verification email
                Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                    if error == nil{
                        print("sent verification email")
                    }
                    else{
                        print("failed to send verfication email")
                    }
                    
                })
      
            } else {
                self.SignUpServiceDelegate?.failedToSignUp(message: (error?.localizedDescription)!)
            }
        }
    }
    
    private func uploadUserInfoToDatabase(user: DartUser){
    
        stringUploadHelperFunction(parameterName: "name", stringParameter: user.name!)
        stringUploadHelperFunction(parameterName: "email", stringParameter: user.email!)
        stringUploadHelperFunction(parameterName: "password", stringParameter: user.password!)
        stringUploadHelperFunction(parameterName: "phoneNumber", stringParameter: user.phoneNumber!)
        stringUploadHelperFunction(parameterName: "houseNumber", stringParameter: user.houseNumber!)
        stringUploadHelperFunction(parameterName: "residence", stringParameter: user.residence!)
        stringUploadHelperFunction(parameterName: "region", stringParameter: user.region!)
        stringUploadHelperFunction(parameterName: "country", stringParameter: user.country!)
        stringUploadHelperFunction(parameterName: "dateJoined", stringParameter: user.dateJoined!)
        stringUploadHelperFunction(parameterName: "lastLoginTime", stringParameter: user.lastLoginTime!)
        stringUploadHelperFunction(parameterName: "dateOfBirth", stringParameter: user.dateOfBirth!)
        stringUploadHelperFunction(parameterName: "photoUrl", stringParameter: user.photoUrl!)
        stringUploadHelperFunction(parameterName: "countryOfOrigin", stringParameter: user.countryOfOrigin!)
        doubleUploadHelperFunction(parameterName: "balance", doubleParameter: user.balance!)
        
        let testtransaction = Transaction(agent: "ally", phoneNumber: "78346", initialBalance: 200, amountAdded: 300)
        let testTripInfo = TripInfo(station: "Mbezi", destination: "Kimaara", initialBalance: 1000, costOfTransaction: 650)
        dictUploadHelperFunction(parameterName: "transactionHistory", dictParameter: testtransaction.toDict())
        dictUploadHelperFunction(parameterName: "travelHistory", dictParameter: testTripInfo.toDict())
        
        self.SignUpServiceDelegate?.didSignUpSuccessfully()
        
    }
    
    func stringUploadHelperFunction(parameterName: String, stringParameter: String){
        let user = Auth.auth().currentUser
         self.ref.child("DARTusers").child((user?.uid)!).child(parameterName).setValue(stringParameter)
        
    }
    
    func doubleUploadHelperFunction(parameterName: String, doubleParameter: Double){
        let user = Auth.auth().currentUser
        self.ref.child("DARTusers").child((user?.uid)!).child(parameterName).setValue(doubleParameter)
        
    }
    func dictUploadHelperFunction(parameterName: String, dictParameter: [String: AnyObject]){
        let user = Auth.auth().currentUser
        self.ref.child("DARTusers").child((user?.uid)!).child(parameterName).childByAutoId().setValue(dictParameter)
    }

    
}
