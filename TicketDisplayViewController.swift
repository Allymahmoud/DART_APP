//
//  TicketDisplayViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import QRCode

class TicketDisplayViewController: UIViewController {
    
    @IBOutlet weak var ticketValidity: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var toDestination: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var validFrom: UILabel!
    @IBOutlet weak var validTo: UILabel!
    
    @IBOutlet weak var qrImage: UIImageView!
    
    var clientName: String = String()
    var tripInfo: TripInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTiket()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    func configureTiket(){
        if tripInfo.destination != nil{
            self.from.text = tripInfo.station!
            self.toDestination.text = tripInfo.destination!
            self.validFrom.text = tripInfo.time!
            self.validTo.text = calculateTimeAfterSeconds(date: tripInfo.time!, seconds: 3600)
            self.name.text = self.clientName
            
            let qrCode = QRCode(tripInfo.time!)
            self.qrImage.image = qrCode?.image
            
            checkForTicketValidity()
            
        }
        
    }
    func checkForTicketValidity(){
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm:ss a"
        let oldDate = dateFormatter.date(from: self.validFrom.text!)
        
        let currentTime = TimeUtil.timeStamp()
        let currentDate = dateFormatter.date(from: currentTime)
        
        if let seconds = currentDate?.seconds(from: oldDate!){
            print ("seconds" + String(seconds))
            if seconds > 3600{
                ticketValidity.text = "Expired Ticket"
                ticketValidity.backgroundColor = UIColor.red
                
            }
            else{
                ticketValidity.text = "Valid Ticket"
                ticketValidity.backgroundColor = UIColor.blue
            }
            
        }
 
    }
    func calculateTimeAfterSeconds(date: String, seconds: Double) ->String {
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
