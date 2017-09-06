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
    init(dictionary: [String: AnyObject]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.dateJoined = dictionary["dateJoined"] as? String
        self.lastLoginTime = dictionary["lastLoginTime "] as? String
        
        self.phoneNumber = dictionary["phoneNumber"] as? String
        self.houseNumber = dictionary["houseNumber"] as? String
        self.region = dictionary["region"] as? String
        self.residence = dictionary["residence"] as? String
        self.country = dictionary["country"] as? String
        
        self.dateOfBirth = dictionary["dateOfBirth"] as? String
        self.countryOfOrigin = dictionary["countryOfOrigin"] as? String
        self.photoUrl = dictionary["photoUrl"] as? String
        
        self.balance = dictionary["balance"] as? Double
        self.travelHistory = []
        self.transactionHistory = []
        
        if let transactionDictionary = dictionary["transactionHistory"] as? [String: AnyObject] {
            var allTransaction : [Transaction] = []
            for (_,value) in transactionDictionary{
                let transactionInfo = Transaction.init(dictionary: value as! [String : AnyObject])
                allTransaction.append(transactionInfo)
            }
            self.transactionHistory = allTransaction
            
        }
        
        if let tripDictionary = dictionary["travelHistory"] as? [String: AnyObject] {
            var allTrips : [TripInfo] = []
            for (_,value) in tripDictionary{
                let tripInfo = TripInfo.init(dictionary: value as! [String : AnyObject])
                allTrips.append(tripInfo)
            }
            self.travelHistory = allTrips
            
        }

    }
    

}

class TripInfo {
    var station: String?
    var destination: String?
    var initialBalance: Double?
    var costOfTransaction: Double?
    var newBalance: Double?
    var validFrom: String?
    var validTo: String?
    var ttl: Double?
    var qrCode: String?
    var longitude: Double?
    var latitude: Double?
    
    
    init(station: String, destination: String, initialBalance: Double, costOfTransaction: Double, timeToLive: Double, qrCode: String){
        self.station = station
        self.destination = destination
        self.initialBalance = initialBalance
        self.costOfTransaction = costOfTransaction
        self.newBalance = initialBalance - costOfTransaction
        
        self.ttl = timeToLive
        self.validFrom = TimeUtil.timeStamp()
        self.validTo = TimeUtil.calculateTimeAfterSeconds(date: TimeUtil.timeStamp(), seconds: timeToLive)
        
        self.qrCode = qrCode
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(station: String, destination: String, initialBalance: Double, costOfTransaction: Double, lat: Double, long: Double, timeToLive: Double, qrCode: String){
        self.station = station
        self.destination = destination
        
        self.initialBalance = initialBalance
        self.costOfTransaction = costOfTransaction
        self.newBalance = initialBalance - costOfTransaction
        
        self.ttl = timeToLive
        self.validFrom = TimeUtil.timeStamp()
        self.validTo = TimeUtil.calculateTimeAfterSeconds(date: self.validFrom!, seconds: timeToLive)
        self.qrCode = qrCode
        
        self.latitude = lat
        self.longitude = long
    }
    
    init(dictionary: [String: AnyObject]) {
        
        self.station = dictionary["station"] as? String
        self.destination = dictionary["destination"] as? String
        self.initialBalance = dictionary["initialBalance"] as? Double
        self.costOfTransaction = dictionary["costOfTransaction"] as? Double
        self.newBalance = dictionary["newbalance"] as? Double
        
        self.validFrom = dictionary["validFrom"] as? String
        self.validTo = dictionary["validTo"] as? String
        self.ttl = dictionary["ttl"] as? Double
        self.qrCode = dictionary["qrCode"] as? String
        
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
       
    }
    
    func toDict() -> [String: AnyObject]{
        
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        
        dictionary["station"] = self.station! as AnyObject
        dictionary["destination"] = self.destination! as AnyObject
        dictionary["initialBalance"] = self.initialBalance! as AnyObject
        dictionary["costOfTransaction"] = self.costOfTransaction! as AnyObject
        dictionary["newBalance"] = self.newBalance! as AnyObject
        
        
        dictionary["validFrom"] = self.validFrom as AnyObject
        dictionary["validTo"] = self.validTo as AnyObject
        dictionary["ttl"] = self.ttl as AnyObject
        dictionary["qrCode"] = self.qrCode as AnyObject
        
        dictionary["latitude"] = self.latitude! as AnyObject
        dictionary["longitude"] = self.longitude! as AnyObject
        
        return dictionary
    }
}

class Transaction{
    var initialBalance: Double?
    var amountAdded: Double?
    var newBalance: Double?
    var phoneNumber: String?
    var time: String?
    var agent: String?
    
    init(agent: String, phoneNumber: String, initialBalance: Double, amountAdded: Double){

        self.initialBalance = initialBalance
        self.amountAdded = amountAdded
        self.phoneNumber = phoneNumber
        self.newBalance = initialBalance + amountAdded
        self.time = TimeUtil.timeStamp()
        self.agent = agent
        self.phoneNumber = phoneNumber
        
    }
    
    init(dictionary: [String: AnyObject]) {
        self.initialBalance = dictionary["initialBalance"] as? Double
        self.amountAdded = dictionary["amountAdded"] as? Double
        self.newBalance = dictionary["newbalance"] as? Double
        self.time = dictionary["time"] as? String
        self.agent = dictionary["agent"] as? String
        self.phoneNumber = dictionary["phoneNumber"] as? String
    }
    
    func toDict() -> [String: AnyObject]{
        
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        
        dictionary["initialBalance"] = self.initialBalance! as AnyObject
        dictionary["amountAdded"] = self.amountAdded! as AnyObject
        dictionary["newBalance"] = self.newBalance! as AnyObject
        dictionary["time"] = self.time! as AnyObject
        dictionary["agent"] = self.agent! as AnyObject
        dictionary["phoneNumber"] = self.phoneNumber! as AnyObject
        
        return dictionary
    }

    
    
}




