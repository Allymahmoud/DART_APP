//
//  DartUser.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

class DartUser {
    
    //core varibles
    var name: String?
    var phoneNumber: String?
    var email:String?
    var password: String?
    
    
    //address variables
    var houseNumber: String?
    var residence: String?
    var region: String?
    var country: String?
    
    //time variables
    var dateJoined: String?
    var lastLoginTime: String?
    
    //extra varibles
    var dateOfBirth: String?
    var photoUrl: String?
    var countryOfOrigin: String?
    
    var balance: Double?
    var travelHistory: [TripInfo]
    var transactionHistory: [Transaction]
    
    init(name: String, email: String, password: String){
        self.name = name
        self.email = email
        self.password = password
        self.dateJoined = TimeUtil.timeStamp()
        self.lastLoginTime = ""
        
        self.phoneNumber = ""
        self.houseNumber = ""
        self.region = ""
        self.residence = ""
        self.country = "Tanzania"
        
        self.dateOfBirth = ""
        self.countryOfOrigin = "Tanzania"
        self.photoUrl = ""
        
        self.balance = 0
        self.travelHistory = []
        self.transactionHistory = []
        
    }
    

}

class TripInfo {
    var station: String?
    var destination: String?
    var initialBalance: Double?
    var costOfTransaction: Double?
    var newBalance: Double?
    var time: String?
    var longitude: Double?
    var latitude: Double?
    
    init(station: String, destination: String, initialBalance: Double, costOfTransaction: Double){
        self.station = station
        self.initialBalance = initialBalance
        self.costOfTransaction = costOfTransaction
        self.newBalance = initialBalance - costOfTransaction
        self.time = TimeUtil.timeStamp()
        
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(station: String, destination: String, initialBalance: Double, costOfTransaction: Double, lat: Double, long: Double){
        self.station = station
        self.initialBalance = initialBalance
        self.costOfTransaction = costOfTransaction
        self.newBalance = initialBalance - costOfTransaction
        self.time = TimeUtil.timeStamp()
        
        self.latitude = lat
        self.longitude = long
    }
}

class Transaction{
    var initialBalance: Double?
    var amountAdded: Double?
    var newBalance: Double?
    var phoneNumber: String
    var time: String?
    var agent: String?
    
    init(agent: String, phoneNumber: String, initialBalance: Double, amountAdded: Double){

        self.initialBalance = initialBalance
        self.amountAdded = amountAdded
        self.phoneNumber = phoneNumber
        self.newBalance = initialBalance + amountAdded
        self.time = TimeUtil.timeStamp()
        
    }
    
    
}




