//
//  TimeUtil.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

struct TimeUtil {
    
    
    static func timeStamp() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm:ss a"
        
        return dateFormatter.string(from: currentDate)
    }
    static func returnDate(stringDate: String) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm:ss a"
        let date = dateFormatter.date(from: stringDate)
        
        return date!
        
    }
    static func isValidTicket(oldDateString: String,  timeToLive: Double) -> Bool{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm:ss a"
        let oldDate = dateFormatter.date(from: oldDateString)
        
        let currentTime = self.timeStamp()
        let currentDate = dateFormatter.date(from: currentTime)
        
        if let seconds = currentDate?.seconds(from: oldDate!){
            print ("seconds" + String(seconds))
            if Double(seconds) > timeToLive{
                return false
                
            }
            else{
                return true
            }
            
        }else{
            return false
        }

        
    }
    
    static func calculateTimeAfterSeconds(date: String, seconds: Double) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm:ss a"
        let oldDate = dateFormatter.date(from: date)
        
        
        let newDate = oldDate?.addingTimeInterval(seconds)
        let newDateString = dateFormatter.string(from: newDate!)
        return newDateString
        
    }

    
    
}
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
}
