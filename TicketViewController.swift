//
//  TicketViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase


class TicketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var station: UIPickerView!
    @IBOutlet weak var destination: UIPickerView!
    
    
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var toDestination: UILabel!
    @IBOutlet weak var costOfTrip: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var purchaseTicket: UIButton!
    
    var user: DartUser = DartUser(name: "Ally", email: "dummy@dummy.com", password: "haha")
    var ref: DatabaseReference!
    var accessToken: AccessTokenService!
    var tripInfo: TripInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        self.updateUserInfo()
        
        self.station.tag = 0
        self.destination.tag = 1
        
        pickerData = ["Kimara Terminal",
            "Korogwe",
            "Bucha",
            "Baruti",
            "Kona",
            "Kibo",
            "Ubungo Maji",
            "Ubungo Terminal",
            "Shekilango",
            "Urafiki",
            "Manzese Tip Top",
            "Manzese",
            "Manzese Argentina",
            "Kagera",
            "Mwembe Chai",
            "Usalama",
            "Magomeni Mapipa",
            "Magomeni Hospitali",
            "Jangwani",
            "Kanisani",
            "Fire",
            "Mkwajuni",
            "Mwanamboka",
            "Msimbazi Police",
            "Kinondoni B",
            "Gerezani",
            "Morocco Terminal",
            "DIT",
            "Kisutu",
            "Nyerere Square",
            "Posta ya Zamani",
            "Kivukoni Terminal"]

        // Do any additional setup after loading the view.
        self.station.delegate = self
        self.station.dataSource = self
        
        
        
        self.destination.delegate = self
        self.destination.dataSource = self
        
    }
    func configureTripInfo(){
        self.tripInfo = TripInfo(station: from.text!, destination: toDestination.text!, initialBalance: 1000, costOfTransaction: 650)
        
    }
    
    func updateUserInfo(){
        if let user = Auth.auth().currentUser {
            self.ref.child("DARTusers").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                // Get user value
                let value = snapshot.value as? NSDictionary
                if value != nil {
                    self.user = DartUser.init(dictionary: value as! [String : AnyObject])
                    self.configureUI()
        
                }
                else{
                    print("value found nil")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        
    }

    

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            from.text = pickerData[row]
        }
        else if pickerView.tag == 1{
            toDestination.text = pickerData[row]
        }
        
        if from.text != "" && toDestination.text != "" {
            if !(from.text! == toDestination.text!){
                date.text = TimeUtil.timeStamp()
                purchaseTicket.isEnabled = true
                
            }
            else{
                self.present(AlertUtil.errorAlert(title: "Could Not Perform Transaction", message: "station and destination cannnot be the same"), animated: true, completion: nil)
                purchaseTicket.isEnabled = false
                
            }
            
        }

        
    }
    
   
    @IBAction func purchase(_ sender: Any) {
        
        if self.user.balance! < 650 {
            self.configureTripInfo()
            self.performSegue(withIdentifier: "navToTicket", sender: nil)
            
            
        }else{
            if let balance = self.user.balance{
                self.present(AlertUtil.errorAlert(title: "Could Not Perform Transaction", message: "Low balance of" + String(describing: balance) + " " + "Tshs"), animated: true, completion: nil)
                
            }
            
        }
        
    }
    func configureUI(){
        if let balance = self.user.balance{
            self.balance.text = String(describing: balance) + " " + "Tshs"
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass token
        
        //temporary implementation to pass the title
        let ticketDisplayViewController = segue.destination as! TicketDisplayViewController
        ticketDisplayViewController.title = "Ticket Info"
        ticketDisplayViewController.tripInfo = self.tripInfo
        ticketDisplayViewController.clientName = user.name!
        
    }

}
