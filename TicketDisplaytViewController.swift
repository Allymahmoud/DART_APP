//
//  TicketDisplayViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import QRCode
class TicketDisplaytViewController: UIViewController {

    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var toDestination: UILabel!
    
    @IBOutlet weak var ticketCost: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var QrCodeImage: UIImageView!
    
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
            self.date.text = tripInfo.time!
                        
            let qrCode = QRCode(tripInfo.time!)
            self.QrCodeImage.image = qrCode?.image
            
        }
    
    }

    

}
