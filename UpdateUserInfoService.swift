//
//  UpdateUserInfoService.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

import Firebase

class UpdateUserInfoService{
    var ref: DatabaseReference!
    var updateUserInfoServiceDelegate: UpdateUserInfoServiceDelegate?
    
    init() {
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        print("initialized")
    }
    
    
    
    func updateUserName(name: String){
        stringUploadHelperFunction(parameterName: "name", stringParameter: name)
    }
    func updateUserEmail(email: String){
        stringUploadHelperFunction(parameterName: "email", stringParameter: email)
    }
    func updateUserPassword(password: String){
        stringUploadHelperFunction(parameterName: "password", stringParameter: password)
        
    }
    func updateUserPhoneNumber(phoneNumber: String){
         stringUploadHelperFunction(parameterName: "phoneNumber", stringParameter: phoneNumber)
    }
    func updateUserHouseNUmber(houseNumber: String){
        stringUploadHelperFunction(parameterName: "houseNumber", stringParameter: houseNumber)
    }
    func updateUserResidence(residence: String){
        stringUploadHelperFunction(parameterName: "residence", stringParameter: residence)
    }
    func updateUserRegion(region: String){
        stringUploadHelperFunction(parameterName: "region", stringParameter: region)
    }
    func updateUserCountry(country: String){
        stringUploadHelperFunction(parameterName: "country", stringParameter: country)
    }
    func updateUserDateJoined(dateJoined: String){
        stringUploadHelperFunction(parameterName: "dateJoined", stringParameter: dateJoined)
    }
    func updateUserLastLoginTime(lastLoginTime: String){
        stringUploadHelperFunction(parameterName: "lastLoginTime", stringParameter: lastLoginTime)
    }
    func updateUserDateOfBirth(dateOfBirth: String){
        stringUploadHelperFunction(parameterName: "dateOfBirth", stringParameter: dateOfBirth)
    }
    func updateUserPhotoUrl(photoUrl: String){
        stringUploadHelperFunction(parameterName: "photoUrl", stringParameter: photoUrl)
    }
    func updateUserCountryOfOrigin(countryOfOrigin: String){
        stringUploadHelperFunction(parameterName: "countryOfOrigin", stringParameter: countryOfOrigin)
    }
    func updateUserBalance(balance: Double){
        doubleUploadHelperFunction(parameterName: "balance", doubleParameter: balance)
    }
    func updateUserTransactionHistory(transaction: Transaction){
        dictUploadHelperFunction(parameterName: "transactionHistory", dictParameter: transaction.toDict())
    }
    
    func updateTravelHistory(tripInfo: TripInfo){
        dictUploadHelperFunction(parameterName: "travelHistory", dictParameter: tripInfo.toDict())

    }
    
    
    func changeUserName(name: String){
        
        //change the display name
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        
        changeRequest?.commitChanges { (error) in
            
            if error != nil {
                self.updateUserInfoServiceDelegate?.failedToUpdateUserInfo(message: (error?.localizedDescription)!)
            }
            else{
                //update name
                self.stringUploadHelperFunction(parameterName: "name", stringParameter: name)
            }
            
        }
        
    }
    func changeUserEmail(email: String){
        
        Auth.auth().currentUser?.updateEmail(to: email){ (error) in
            if error != nil {
                self.updateUserInfoServiceDelegate?.failedToUpdateUserInfo(message: (error?.localizedDescription)!)
            }
            else{
                //update email
                self.stringUploadHelperFunction(parameterName: "email", stringParameter: email)
            }
        }
        
        //send verification email
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            // ...
        }
        
    }
    func changeUserPassword(password: String){
        Auth.auth().currentUser?.updateEmail(to: password, completion: { (error) in
            if error != nil {
                self.updateUserInfoServiceDelegate?.failedToUpdateUserInfo(message: (error?.localizedDescription)!)
            }
            else{
                //change password
                self.stringUploadHelperFunction(parameterName: "password", stringParameter: password)
            }
        })
        
    }

    
    
    
    
    func stringUploadHelperFunction(parameterName: String, stringParameter: String){
        if let user = Auth.auth().currentUser{
            self.ref.child("DARTusers").child(user.uid).child(parameterName).setValue(stringParameter)
            self.updateUserInfoServiceDelegate?.didSuccesfullyUpdateUserInfo()
            
        }else{
            self.updateUserInfoServiceDelegate?.failedToUpdateUserInfo(message: "The user information could not be updated! Make sure your internet is working")
        }
        
    }
    
    func doubleUploadHelperFunction(parameterName: String, doubleParameter: Double){
        if let user = Auth.auth().currentUser{
            self.ref.child("DARTusers").child(user.uid).child(parameterName).setValue(doubleParameter)
            self.updateUserInfoServiceDelegate?.didSuccesfullyUpdateUserInfo()
            
        }else{
            self.updateUserInfoServiceDelegate?.failedToUpdateUserInfo(message: "The user information could not be updated! Make sure your internet is working")
        }
        
        
    }
    func dictUploadHelperFunction(parameterName: String, dictParameter: [String: AnyObject]){
        if let user = Auth.auth().currentUser{
            self.ref.child("DARTusers").child(user.uid).child(parameterName).childByAutoId().setValue(dictParameter)
            self.updateUserInfoServiceDelegate?.didSuccesfullyUpdateUserInfo()
        }
        else{
            self.updateUserInfoServiceDelegate?.failedToUpdateUserInfo(message: "The user information could not be updated! Make sure your internet is working")
        }
        
    }

}

