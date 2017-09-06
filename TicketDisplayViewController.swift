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
            self.validFrom.text = tripInfo.validFrom!
            self.validTo.text = tripInfo.validTo!
            self.name.text = self.clientName
            if tripInfo.qrCode != nil {
                let qrCode = QRCode(tripInfo.qrCode!)
                self.qrImage.image = qrCode?.image
                
            }

            checkForTicketValidity()
        }
        
    }
    func checkForTicketValidity(){
        
        if TimeUtil.isValidTicket(oldDateString: tripInfo.validFrom!, timeToLive: tripInfo.ttl!){
            ticketValidity.text = "Valid Ticket"
            ticketValidity.backgroundColor = UIColor.blue
        }
        else{
            ticketValidity.text = "Expired Ticket"
            ticketValidity.backgroundColor = UIColor.red
        }

    }


}

