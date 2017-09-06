//
//  TicketViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase


class TicketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, RequestUserInfoDelegate, UpdateUserInfoServiceDelegate{
    
    var pickerData: [String] = [String]()
    var updateUserInfoService: UpdateUserInfoService!
    var requestUserInfo: RequestUserInfo!
    var numberOfUpdates: Int = 0
    
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var station: UIPickerView!
    @IBOutlet weak var destination: UIPickerView!
    
    
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var toDestination: UILabel!
    @IBOutlet weak var costOfTrip: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var purchaseTicket: UIButton!
    
    var user: DartUser = DartUser(name: "", email: "", password: "")
    var tripInfo: TripInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestUserInfo = RequestUserInfo()
        self.requestUserInfo.requestUserInfoDelegate = self
        
        self.updateUserInfoService = UpdateUserInfoService()
        self.updateUserInfoService.updateUserInfoServiceDelegate = self
        
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestUserInfo.requestUserInfo()
    }
    
    func configureTripInfo(){
        self.tripInfo = TripInfo(station: from.text!, destination: toDestination.text!, initialBalance: self.user.balance!, costOfTransaction: 650, timeToLive: 3600, qrCode: TimeUtil.timeStamp())
        
    }
    func didRecieveUserInfo(user: DartUser) {
        self.user = user
        self.configureUI()
    }
    func failedToRecieveUserInfo(message: String) {
        self.present(AlertUtil.errorAlert(title: "Could Not Fetch User Info", message: message), animated: true, completion: nil)
    }
    
    func didSuccesfullyUpdateUserInfo() {
        print("successfuly updated trip info and balance")
        self.numberOfUpdates += 1
        if numberOfUpdates == 2{
            self.performSegue(withIdentifier: "navToTicket", sender: nil)
        }
        
    }
    func failedToUpdateUserInfo(message: String) {
        self.present(AlertUtil.errorAlert(title: "Ooops! Something Went Wrong", message: message), animated: true, completion: nil)
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
        
        if self.user.balance! > 650 {
            self.configureTripInfo()
            self.updateUserInfoService.updateUserBalance(balance: (self.user.balance! - 650))
            self.updateUserInfoService.updateTravelHistory(tripInfo: self.tripInfo)
     
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
